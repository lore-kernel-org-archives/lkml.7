Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D36C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7982077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KlKZj3AJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfKGNpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:45:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:34823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfKGNpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573134326;
        bh=s00K1OOu0aaQsQbtK0UBknbyKhQQRQtn+2TeWxy/ryE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KlKZj3AJSJ7e83rhZmtGlKwV7413nvG7hcWkQ5txgMhHU1RppqzDijtXJk+ZpFqJM
         6h98Q/fA9PhAjIt6L9W+pY57taPuRw2eNuAYEcVmeHNi3QHF7Hwv7zIX3z8qNBrVJB
         XPeRE1NEfQjXX4xgqHKJnrV2B21Gsa4bSmcTT4r4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.54.163]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1iSQaI3QmN-0020GY; Thu, 07
 Nov 2019 14:45:25 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/kernel-doc: Add support for named variable macro arguments
Date:   Thu,  7 Nov 2019 14:41:33 +0100
Message-Id: <20191107134133.14690-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RPtxoPYDoRNPEEEsoABZlK6tUN+SI8PtlbkTIJcv9PqIRBBQIBT
 ADbGulVNTBMQC45gRADoHR3KewaKXWZwELTfzYOLjiSQNcsZof3WaNgRi1MbmZffjNtqxx9
 jsw4jA1JHUAkBiW0+rzlU2yC5+cOS1owwUcc+DDdyHwTt0x0NHk9AZkjc7esKr9NjZbClC4
 pdlkrFvTHjYDTTYrtSoAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HBIKmeHj6tI=:CJ/0RubdzvprzW/+50mXDe
 pD4U91q8fDY0k+kfYlsyjts5ufP4BQqig4Anp2lLKs05bEazrn4jQfJtVW4RXQ+kQLrRPF/8r
 R+RBLSZCqjC/1mVq1foETEWFXOAmS42LYk9EshI+0GxVqFyLfIOKOdnZWO1q7upI1nfzXNgry
 6irGF7YfotV5qz1U6cTKNEjjVZxEbHghaT1R2/izt0B1+50BPTW5IReP8zrlMjJDuZthnEGoL
 k3PrrgvTshWP70mz9I/yUZbxNFg6niCA+FSDKWtoWf+stDhWy9ZVXYS6i8cDnPRZl4o1NqmPI
 qNDgxBAZQOeYVTBr1nrQ4btDMM5rNcGASJZ1RPzSg7a+o6w4nXUJN8+XUvx0nwAAHqYei3woi
 MMyw/FjvkCyTJtS6ht79PrmEmJLSTMz0lzGyo/rPVtFGD8ovKWkrW8dtEFZfaui2bStJVr2Eu
 qKeq5xkWd+MUHJXVfxkwKk7UwRQ9Q4cv1LXhk+0yILooct7j6NySANOGpU3Cslb+yblxxB3gm
 rq2US/NVNqafqMjJrHMWASZfjzIDP2XZMc9thJdaLPk693br+0/LkfreJMkdXv6i0Q6lOQzGM
 Rw4tgNj0NGBKtLz3V5g9BJVq3JTIiMQq5BNqHHyZVPNnKJ5HnxjX6Krc53BsZn5TG4n1ipA0y
 P//lTluqC7dySA2nP0sIADV4wpmbXJxXWdm2h+g3dpTtnGRq8as91DS2s2qX9D9OR5sUGaZCx
 ZIdEFR2FwQj/sOcrZPjatHJReHFxNWAjAgJcL9zM4qzTSS1xYHZAzARIoTndDdZAW65OC6ixy
 iffXZKnw1IGSD0WtnG1pQ06m3fWWThAK9O0yLZFs3QkT4SGdp6KR6/v7Ie0UyTYIEi0VcqFDz
 wjxmw8SrOo2IGmn13TqxZ1qA43jHYVxfMK6ZSFQA0QbCikYPNbrK47FIwh19ME0m835+7romH
 0/PlzIVqV9tL7RnZ9tdNCLwcdGTr+Q5dGMrwvn3laTun1X49oQwz66QUIdr2rTrSzNGayrJgX
 On+rzlr/DPZqufhKMTkLsMVMwqGasLyOQJzspOE03df5VTcs/Bwq5YrehVblU109rntA4bDgM
 mLGPZp6+X7i16QeSA6jmAxjGSL6DYf7j+g3fflFNiZwi9bgNSF1+Z4b/E2zdVhhmCCRYh004u
 J3AIYyak1HNTBCIjuhefiQ/hit5nua5DMozXmeDN9YreW/4w0dAv5OjrWRkXSXvz5ZPqpeYTo
 /k9LVfZ3hviQWIxGuia5q+S84aGdEMib2Py+jMZE+pbm1IHsShte7EKkrWdA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when kernel-doc encounters a macro with a named variable
argument[1], such as this:

   #define hlist_for_each_entry_rcu(pos, head, member, cond...)

... it expects the variable argument to be documented as `cond...`,
rather than `cond`. This is semantically wrong, because the name (as
used in the macro body) is actually `cond`.

With this patch, kernel-doc will accept the name without dots (`cond`
in the example above) in doc comments, and warn if the name with dots
(`cond...`) is used and verbose mode[2] is enabled.

The support for the `cond...` syntax can be removed later, when the
documentation of all such macros has been switched to the new syntax.

Testing this patch on top of v5.4-rc6, `make htmldocs` shows a few
changes in log output and HTML output:

 1) The following warnings[3] are eliminated:

   ./include/linux/rculist.h:374: warning:
        Excess function parameter 'cond' description in 'list_for_each_ent=
ry_rcu'
   ./include/linux/rculist.h:651: warning:
        Excess function parameter 'cond' description in 'hlist_for_each_en=
try_rcu'

 2) For list_for_each_entry_rcu and hlist_for_each_entry_rcu, the
    correct description is shown

 3) Named variable arguments are shown without dots


[1]: https://gcc.gnu.org/onlinedocs/cpp/Variadic-Macros.html
[2]: scripts/kernel-doc -v
[3]: See also https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linu=
x-rcu.git/commit/?h=3Ddev&id=3D5bc4bc0d6153617eabde275285b7b5a8137fdf3c

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Cc: Paul E. McKenney <paulmck@kernel.org>
=2D--
 scripts/kernel-doc | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 81dc91760b23..48696391eccb 100755
=2D-- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1449,6 +1449,10 @@ sub push_parameter($$$$) {
 	      # handles unnamed variable parameters
 	      $param =3D "...";
 	    }
+	    elsif ($param =3D~ /\w\.\.\.$/) {
+	      # for named variable parameters of the form `x...`, remove the dot=
s
+	      $param =3D~ s/\.\.\.$//;
+	    }
 	    if (!defined $parameterdescs{$param} || $parameterdescs{$param} eq "=
") {
 		$parameterdescs{$param} =3D "variable arguments";
 	    }
@@ -1936,6 +1940,18 @@ sub process_name($$) {
 sub process_body($$) {
     my $file =3D shift;

+    # Until all named variable macro parameters are
+    # documented using the bare name (`x`) rather than with
+    # dots (`x...`), strip the dots:
+    if ($section =3D~ /\w\.\.\.$/) {
+	$section =3D~ s/\.\.\.$//;
+
+	if ($verbose) {
+	    print STDERR "${file}:$.: warning: Variable macro arguments should b=
e documented without dots\n";
+	    ++$warnings;
+	}
+    }
+
     if (/$doc_sect/i) { # case insensitive for supported section names
 	$newsection =3D $1;
 	$newcontents =3D $2;
=2D-
2.20.1

