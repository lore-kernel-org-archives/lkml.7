Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501C4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E99B2070B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfHYNNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 09:13:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:58574 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbfHYNNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 09:13:37 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1i1sKn-00055E-KC; Sun, 25 Aug 2019 14:13:30 +0100
Date:   Sun, 25 Aug 2019 14:13:29 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <20190825131329.naqzd5kwg7mw5d3f@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fkxixsfrlh324d26"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [RFC PATCH] tools/perf: pmu-events: Fix reproducibility
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fkxixsfrlh324d26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

jevents.c uses nftw() to enumerate files and outputs the corresponding
C structs in the order they are found.  This makes it sensitive to
directory ordering, so that the perf executable is not reproducible.

To avoid this, store all the files and directories found and then sort
them by their (relative) path.  (This maintains the parent-first
ordering that nftw() promises.)  Then apply the existing callbacks to
them in the sorted order.

Don't both storing the stat buffers as we don't need them.

References: https://tests.reproducible-builds.org/debian/dbdtxt/bullseye/i3=
86/linux_4.19.37-6.diffoscope.txt.gz
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -50,6 +50,12 @@
 #include "json.h"
 #include "jevents.h"
=20
+struct found_file {
+	const char	*fpath;
+	int		typeflag;
+	struct FTW	ftwbuf;
+};
+
 int verbose;
 char *prog;
=20
@@ -865,6 +871,44 @@ static int get_maxfds(void)
  * nftw() doesn't let us pass an argument to the processing function,
  * so use a global variables.
  */
+static struct found_file *found_files;
+static size_t n_found_files;
+static size_t max_found_files;
+
+static int add_one_file(const char *fpath, const struct stat *sb,
+			int typeflag, struct FTW *ftwbuf)
+{
+	struct found_file *file;
+
+	if (ftwbuf->level =3D=3D 0 || ftwbuf->level > 3)
+		return 0;
+
+	/* Grow array if necessary */
+	if (n_found_files >=3D max_found_files) {
+		if (max_found_files =3D=3D 0)
+			max_found_files =3D 16;
+		else
+			max_found_files *=3D 2;
+		found_files =3D realloc(found_files,
+				      max_found_files * sizeof(*found_files));
+	}
+
+	file =3D &found_files[n_found_files++];
+	file->fpath =3D strdup(fpath);
+	file->typeflag =3D typeflag;
+	file->ftwbuf =3D *ftwbuf;
+
+	return 0;
+}
+
+static int compare_files(const void *left, const void *right)
+{
+	const struct found_file *left_file =3D left;
+	const struct found_file *right_file =3D right;
+
+	return strcmp(left_file->fpath, right_file->fpath);
+}
+
 static FILE *eventsfp;
 static char *mapfile;
=20
@@ -919,19 +963,19 @@ static int is_json_file(const char *name
 	return 0;
 }
=20
-static int preprocess_arch_std_files(const char *fpath, const struct stat =
*sb,
+static int preprocess_arch_std_files(const char *fpath,
 				int typeflag, struct FTW *ftwbuf)
 {
 	int level =3D ftwbuf->level;
 	int is_file =3D typeflag =3D=3D FTW_F;
=20
 	if (level =3D=3D 1 && is_file && is_json_file(fpath))
-		return json_events(fpath, save_arch_std_events, (void *)sb);
+		return json_events(fpath, save_arch_std_events, NULL);
=20
 	return 0;
 }
=20
-static int process_one_file(const char *fpath, const struct stat *sb,
+static int process_one_file(const char *fpath,
 			    int typeflag, struct FTW *ftwbuf)
 {
 	char *tblname, *bname;
@@ -956,9 +1000,9 @@ static int process_one_file(const char *
 	} else
 		bname =3D (char *) fpath + ftwbuf->base;
=20
-	pr_debug("%s %d %7jd %-20s %s\n",
+	pr_debug("%s %d %-20s %s\n",
 		 is_file ? "f" : is_dir ? "d" : "x",
-		 level, sb->st_size, bname, fpath);
+		 level, bname, fpath);
=20
 	/* base dir or too deep */
 	if (level =3D=3D 0 || level > 3)
@@ -1070,6 +1114,7 @@ int main(int argc, char *argv[])
 	const char *output_file;
 	const char *start_dirname;
 	struct stat stbuf;
+	size_t i;
=20
 	prog =3D basename(argv[0]);
 	if (argc < 4) {
@@ -1113,8 +1158,26 @@ int main(int argc, char *argv[])
 	 */
=20
 	maxfds =3D get_maxfds();
+	rc =3D nftw(ldirname, add_one_file, maxfds, 0);
+	if (rc < 0) {
+		/* Make build fail */
+		free_arch_std_events();
+		return 1;
+	} else if (rc) {
+		goto empty_map;
+	}
+
+	/* Sort file names to ensure reproduciblity */
+	qsort(found_files, n_found_files, sizeof(*found_files), compare_files);
+
 	mapfile =3D NULL;
-	rc =3D nftw(ldirname, preprocess_arch_std_files, maxfds, 0);
+	for (i =3D 0; i < n_found_files; i++) {
+		rc =3D preprocess_arch_std_files(found_files[i].fpath,
+					       found_files[i].typeflag,
+					       &found_files[i].ftwbuf);
+		if (rc)
+			break;
+	}
 	if (rc && verbose) {
 		pr_info("%s: Error preprocessing arch standard files %s\n",
 			prog, ldirname);
@@ -1127,7 +1190,13 @@ int main(int argc, char *argv[])
 		goto empty_map;
 	}
=20
-	rc =3D nftw(ldirname, process_one_file, maxfds, 0);
+	for (i =3D 0; i < n_found_files; i++) {
+		rc =3D process_one_file(found_files[i].fpath,
+				      found_files[i].typeflag,
+				      &found_files[i].ftwbuf);
+		if (rc)
+			break;
+	}
 	if (rc && verbose) {
 		pr_info("%s: Error walking file tree %s\n", prog, ldirname);
 		goto empty_map;

--fkxixsfrlh324d26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl1iiXQACgkQ57/I7JWG
EQlIFhAAhAXf97wBfIFEWREk8shysDdnxwZpkUtnVsFSlOAso9sIip65vRYSR2Y/
W2WwVQmKWHF7LVN1t9r7pfLxWfzNLfyWzpuhzoKEzR85rZbtSYiSS5DtKm+Bz6cT
rdwlEKbyhCiFKdVQ5ACIEpHV/K0RtIiKxISRYAHX2IaSCcPFUVLcZOCkY85I3EDc
TOAQD0M44UwpfESP8awqahJqMhAoYpjPdms9CmrP6RwZGm6GsrS2k4jHY1kIfQbI
ubvKWijmOpLZbX6oSOqPhGJH/tGIrzknNKg9Lw44W9zYmSfgTeVxUb8LXRatXDgf
J5m5QkYW8DUH4RrUs6qX1wm4ROIoQhr/5A+cWcotgeneXFweP4ti/G2PK8h9Ad78
SjGzUoCF1ephyVlJnzTHTQ3jG8GXGo62V7SDylSerj/jjeLbXWx3sXf7ZsczT3Ig
RbVf2VHU8V/eVDZO1LKekluWzpKJACLkyRU00yoIltbLB89L2/Uxcq2eLB1N8REa
Ob4pnKgj9WwQzKeS4vPWgH3nRu3YXQrVZONlr1rgpbsicouC13rcYRAyerHCz6EQ
gLHhNSZcw9wA6DxMQgXvQ7EiQXJ3a2QhP8pdVTDB/sauJsTeS8aaS9OGV1vRfRjt
V8IYwp+tN6zMwxuodUSM7To+RBVB9jv9s6h4sEWbJoDl0y0eusw=
=g13I
-----END PGP SIGNATURE-----

--fkxixsfrlh324d26--
