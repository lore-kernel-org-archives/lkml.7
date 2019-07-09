Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6341FC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390DE21707
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dh+GnIu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfGIE0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:26:15 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:42176 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfGIEZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:25:42 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x694OqVs009969;
        Tue, 9 Jul 2019 13:25:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x694OqVs009969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562646300;
        bh=m+NQODuw2GuTBAmV1RxTAD4JOmrs8n7px1scpZ29taI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dh+GnIu1b/TBiCwMYEhgrklCBP52Q9+Ap9CPN5Jyy50CjdDRM7/Jjqfyxp7FUzYS9
         N/8kh6iArciwy3i65Rz9EjJvOrZte6JolvXo2wDMMHyaD/sDZvwsSqBdTtWb3b3ZjC
         n1wdjjmlTuQBLdX0LENZgAdJY0kX5jcN/u/U3au6vQp3mXcXr40E/ayF8lB+w8LRKP
         X3V3idUo80N+u/0lVAJd15CTyz7IUuveau7jPrcpZr9yXFfpqiihGjMlcoxXUPBOca
         oh77A6aZ4lBOoau8+ePQOdSFzn/e/9G1xldNU/wVUcNBz5TqKWKi9tkzyzn/1PfWd/
         2W8IWkjphMvCw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nicolas Pitre <nico@fluxnic.net>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] kbuild: remove the first line of *.mod files
Date:   Tue,  9 Jul 2019 13:24:13 +0900
Message-Id: <20190709042416.27554-10-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709042416.27554-1-yamada.masahiro@socionext.com>
References: <20190709042416.27554-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current format of *.mod is like this:

  line 1: directory path to the .ko file
  line 2: a list of objects linked into this module
  line 3: unresolved symbols (only when CONFIG_TRIM_UNSED_SYMBOLS=y)

Now that *.mod and *.ko are created in the same directory, the line 1
provides no valuable information. It can be derived by replacing the
extension .mod with .ko.

Cut the first line.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build      | 4 ++--
 scripts/adjust_autoksyms.sh | 2 +-
 scripts/mod/sumversion.c    | 9 ++-------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 1d01324455d1..f34f941c3b9b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -281,7 +281,7 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
 $(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
-	@{ echo $(@:.o=.ko); echo $@; \
+	@{ echo $@; \
 	   $(cmd_undef_syms); } > $(patsubst %.o,%.mod,$@)
 
 quiet_cmd_cc_lst_c = MKLST   $@
@@ -463,7 +463,7 @@ cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^) $(cmd_secanalysis
 
 $(multi-used-m): FORCE
 	$(call if_changed,link_multi-m)
-	@{ echo $(@:.o=.ko); echo $(filter %.o,$^); \
+	@{ echo $(filter %.o,$^); \
 	   $(cmd_undef_syms); } > $(patsubst %.o,%.mod,$@)
 $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
 
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index d3561ff4089c..147de8908797 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -48,7 +48,7 @@ cat > "$new_ksyms_file" << EOT
 
 EOT
 sed 's/ko$/mod/' modules.order |
-xargs -r -n1 sed -n -e '3{s/ /\n/g;/^$/!p;}' |
+xargs -r -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' |
 sort -u |
 sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$new_ksyms_file"
 
diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index 166f3fa247a9..63062024ce0e 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -398,7 +398,7 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen)
 	char *sources, *end, *fname;
 	char filelist[PATH_MAX + 1];
 
-	/* objects for a module are listed in the second line of *.mod file. */
+	/* objects for a module are listed in the first line of *.mod file. */
 	snprintf(filelist, sizeof(filelist), "%.*smod",
 		 (int)strlen(modname) - 1, modname);
 
@@ -407,13 +407,8 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen)
 		/* not a module or .mod file missing - ignore */
 		return;
 
-	sources = strchr(file, '\n');
-	if (!sources) {
-		warn("malformed versions file for %s\n", modname);
-		goto release;
-	}
+	sources = file;
 
-	sources++;
 	end = strchr(sources, '\n');
 	if (!end) {
 		warn("bad ending versions file for %s\n", modname);
-- 
2.17.1

