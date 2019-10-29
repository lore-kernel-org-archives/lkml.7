Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60204CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F3820679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbfJ2SRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:17:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbfJ2SRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:17:18 -0400
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADD5C87638
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:17:17 +0000 (UTC)
Received: by mail-yb1-f200.google.com with SMTP id 63so11155707ybv.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 11:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pSPCRP5KhBuHaPqDT4xlggRtohHjOrWiMoN28gbXXPY=;
        b=cNhJrrCowH6054OB/lgNu2xd/BrKcBoLgjwgm7iMjo9fUudDelP6Dwe5e+mXqglD/R
         g2FpfY5ie7AvE+fAOXJR1TdoNFCYJ8dkVCZJVNWy2UsPsz0rh6wogQXPs2oo4lS/pCSi
         AvyMmhnSmVBNvd5SCsaU1zaPLJE1VJPVAl/OWSLzE0093tN2hOh7XlTFNzTlDmy5/zIe
         j0RhExF5T5XFHtnxTuXdfUZ/gLBwFRYTNJqU94lV2D6L54qCvjldMXIp+QBDhupc2OIr
         A665ppVbm0a4FBDnFrW/f9RpJRZQxrDystHkSe3tAdOJF+//wFkY9SGD1WX875kLZdbi
         HYPw==
X-Gm-Message-State: APjAAAUVTfhyOo15Z7oNA4133rO+J5nx2fMhuah8ZqFzVK+kk2nF1nfK
        3hr5y09Egc7406Dy1L2BbyCM2m0Gbbfb4zXWEtN54LqQ/HGLwLQh8+jP4t7t3Wm4zQLD0WNDnEa
        e9YsLN6sDRbwKzyW3/Ueq6zjV
X-Received: by 2002:a25:cfc4:: with SMTP id f187mr20583217ybg.496.1572373036875;
        Tue, 29 Oct 2019 11:17:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzEsmP4QaGFt68Y9OfWI8X1RtudXuSG270aSNTPDOkIfwOpRINoRdtD8cssOMB4mTjwKTWKaQ==
X-Received: by 2002:a25:cfc4:: with SMTP id f187mr20583169ybg.496.1572373036358;
        Tue, 29 Oct 2019 11:17:16 -0700 (PDT)
Received: from labbott-redhat.redhat.com (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id r67sm8628696ywr.48.2019.10.29.11.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 11:17:15 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcline@redhat.com, dzickus@redhat.com
Subject: [RFC PATCH] kconfig: Add option to get the full help text with listnewconfig
Date:   Tue, 29 Oct 2019 14:17:02 -0400
Message-Id: <20191029181702.21460-1-labbott@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make listnewconfig will list the individual options that need to be set.
This is useful but there's no easy way to get the help text associated
with the options at the same time. Introduce a new targe
'make extendedlistnewconfig' which lists the full help text of all the
new options as well. This makes it easier to automatically generate
changes that are easy for humans to review. This command also adds
markers between each option for easier parsing.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
Red Hat has been relying on some external libraries that have a tendency
to break to get the help text for all new config options. I'd really
like an in tree way to get the help text so we can automatically
generate patches for people to reveiw new config options. I'm open to
other approaches that let us script getting the help text as well.
---
 scripts/kconfig/Makefile |  5 ++++-
 scripts/kconfig/conf.c   | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index ef2f2336c469..aaaf1f62300c 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -66,7 +66,9 @@ localyesconfig localmodconfig: $(obj)/conf
 #  syncconfig has become an internal implementation detail and is now
 #  deprecated for external use
 simple-targets := oldconfig allnoconfig allyesconfig allmodconfig \
-	alldefconfig randconfig listnewconfig olddefconfig syncconfig
+	alldefconfig randconfig listnewconfig olddefconfig syncconfig \
+	extendedlistnewconfig
+
 PHONY += $(simple-targets)
 
 $(simple-targets): $(obj)/conf
@@ -134,6 +136,7 @@ help:
 	@echo  '  alldefconfig    - New config with all symbols set to default'
 	@echo  '  randconfig	  - New config with random answer to all options'
 	@echo  '  listnewconfig   - List new options'
+	@echo  '  extendedlistnewconfig   - List new options'
 	@echo  '  olddefconfig	  - Same as oldconfig but sets new symbols to their'
 	@echo  '                    default value without prompting'
 	@echo  '  kvmconfig	  - Enable additional options for kvm guest kernel support'
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 40e16e871ae2..7aeb77374d9a 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -32,6 +32,7 @@ enum input_mode {
 	defconfig,
 	savedefconfig,
 	listnewconfig,
+	extendedlistnewconfig,
 	olddefconfig,
 };
 static enum input_mode input_mode = oldaskconfig;
@@ -434,6 +435,11 @@ static void check_conf(struct menu *menu)
 						printf("%s%s=%s\n", CONFIG_, sym->name, str);
 					}
 				}
+			} else if (input_mode == extendedlistnewconfig) {
+				printf("-----\n");
+				print_help(menu);
+				printf("-----\n");
+
 			} else {
 				if (!conf_cnt++)
 					printf("*\n* Restart config...\n*\n");
@@ -459,6 +465,7 @@ static struct option long_opts[] = {
 	{"alldefconfig",    no_argument,       NULL, alldefconfig},
 	{"randconfig",      no_argument,       NULL, randconfig},
 	{"listnewconfig",   no_argument,       NULL, listnewconfig},
+	{"extendedlistnewconfig",   no_argument,       NULL, extendedlistnewconfig},
 	{"olddefconfig",    no_argument,       NULL, olddefconfig},
 	{NULL, 0, NULL, 0}
 };
@@ -469,6 +476,7 @@ static void conf_usage(const char *progname)
 	printf("Usage: %s [-s] [option] <kconfig-file>\n", progname);
 	printf("[option] is _one_ of the following:\n");
 	printf("  --listnewconfig         List new options\n");
+	printf("  --extendedlistnewconfig List new options and help text\n");
 	printf("  --oldaskconfig          Start a new configuration using a line-oriented program\n");
 	printf("  --oldconfig             Update a configuration using a provided .config as base\n");
 	printf("  --syncconfig            Similar to oldconfig but generates configuration in\n"
@@ -543,6 +551,7 @@ int main(int ac, char **av)
 		case allmodconfig:
 		case alldefconfig:
 		case listnewconfig:
+		case extendedlistnewconfig:
 		case olddefconfig:
 			break;
 		case '?':
@@ -576,6 +585,7 @@ int main(int ac, char **av)
 	case oldaskconfig:
 	case oldconfig:
 	case listnewconfig:
+	case extendedlistnewconfig:
 	case olddefconfig:
 		conf_read(NULL);
 		break;
@@ -657,6 +667,7 @@ int main(int ac, char **av)
 		/* fall through */
 	case oldconfig:
 	case listnewconfig:
+	case extendedlistnewconfig:
 	case syncconfig:
 		/* Update until a loop caused no more changes */
 		do {
@@ -675,7 +686,7 @@ int main(int ac, char **av)
 				defconfig_file);
 			return 1;
 		}
-	} else if (input_mode != listnewconfig) {
+	} else if (input_mode != listnewconfig && input_mode != extendedlistnewconfig) {
 		if (!no_conf_write && conf_write(NULL)) {
 			fprintf(stderr, "\n*** Error during writing of the configuration.\n\n");
 			exit(1);
-- 
2.21.0

