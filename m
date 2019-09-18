Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37545C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FC321897
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtWy2WBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfIRJor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:44:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36805 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfIRJoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:44:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so6181800wrd.3;
        Wed, 18 Sep 2019 02:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7dhk1Hk3Bb6XgUyVTseaXPBZDZxG8PQ8XpSkQyIOCo0=;
        b=qtWy2WBpQiLo8F9ybCLRuGnYHVz28bNy44jl+In8YdnSQ8ESQO29s8H+Ypaihuj2G5
         DyW8K4ryLMB4eeMG9eCRriuF7F1k9Lh5jM2NxmJG/9XHhAdRlMBudExa+MAnRq8dGu4z
         3an6AiplykmLL8Sn2WX6ulD2GlfJosliHhp4m1mMO8QD4Gc9BrUcR6FRhMz8bG5zZcmj
         MchthaETjDAQ6pe7mw1uXPYBJDhdyv6la+H6+qlxUZzkyVegwOqlX/EyfaYaT3BKObIL
         UEf1+x90REz4RFMCGs0Nglsp1x5X7ebN3wUM7tRPnaQvnTwkRLRT5+8pQTRwd5+5X55T
         bgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7dhk1Hk3Bb6XgUyVTseaXPBZDZxG8PQ8XpSkQyIOCo0=;
        b=IqzwwmPZDBpnE1jQWSej+SV7PhJfjHzZlZsUSw9fJhr+tT+0OUULDtbF+Vlr+/CAE2
         wSbGBd1MDLvrMEexe7dYEvr13qnljZEwV8G+GrLB4b6dj6Nmwi2FPsfRmekWlEr/JLCR
         fAX4q6TEJe5lAKAJxD5VfqpTxyzZN+h0spx3pbh7yY5o74zIJtgZ1iPWDblk4Q2NMMt3
         IAKzaRqL9zrIYsWdBsQtBhw1tCEbNczsIZz0CYiueu290NNJp/H1cOAD5QaVC2gfbGn7
         vs3od4VfXiy2vOroT8nwWcwdxGN8Pr3zpFIVCwZZhd7imMSxq6BTD4kGC+h5CWmvDHFl
         4XMw==
X-Gm-Message-State: APjAAAU12T8tbJ16BOC9rY9njR7t3zcvX8yTPXpZaakLBmEOyoofWDIr
        jdXWc2+ef+Qkwt46ZsY7f3k=
X-Google-Smtp-Source: APXvYqzfeqyKc1+jQ9M83xOoL9jagvt1g/uBzVKp88aflH/TR4CW88j1AamydaExEx+Rr/1sL+uQBQ==
X-Received: by 2002:adf:ec91:: with SMTP id z17mr2425218wrn.346.1568799883545;
        Wed, 18 Sep 2019 02:44:43 -0700 (PDT)
Received: from t1700.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id t8sm3776341wrx.76.2019.09.18.02.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 02:44:43 -0700 (PDT)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     Erwan Velu <e.velu@criteo.com>, Jean Delvare <jdelvare@suse.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Mattias Jacobsson <2pi@mok.nu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 2/3] firmware/dmi: Report DMI Bios release
Date:   Wed, 18 Sep 2019 11:43:20 +0200
Message-Id: <20190918094323.17515-2-e.velu@criteo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918094323.17515-1-e.velu@criteo.com>
References: <20190918094323.17515-1-e.velu@criteo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some vendors like HPe or Dell, encodes the release version of their BIOS
in the "System BIOS {Major|Minor} Release" fields of Type 0.

This information is useful to know which release of the bios is actually running.
It could be used for some quirks, debugging sessions or inventory tasks.

This patch extract these 2 fields in DMI_BIOS_MAJOR_RELEASE & DMI_BIOS_MINOR_RELEASE.

A typical output for a Dell system running the 65.27 bios is :

	[root@t1700 ~]# cat /sys/devices/virtual/dmi/id/bios_release_major
	65
	[root@t1700 ~]# cat /sys/devices/virtual/dmi/id/bios_release_minor
	27
	[root@t1700 ~]#

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/firmware/dmi-id.c       | 6 ++++++
 drivers/firmware/dmi_scan.c     | 2 ++
 include/linux/mod_devicetable.h | 2 ++
 scripts/mod/file2alias.c        | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index ff39f64f2aae..3248c2837a4d 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -42,6 +42,8 @@ DEFINE_DMI_ATTR_WITH_SHOW(bios_vendor,		0444, DMI_BIOS_VENDOR);
 DEFINE_DMI_ATTR_WITH_SHOW(bios_version,		0444, DMI_BIOS_VERSION);
 DEFINE_DMI_ATTR_WITH_SHOW(bios_date,		0444, DMI_BIOS_DATE);
 DEFINE_DMI_ATTR_WITH_SHOW(sys_vendor,		0444, DMI_SYS_VENDOR);
+DEFINE_DMI_ATTR_WITH_SHOW(bios_release_major, 0444, DMI_BIOS_MAJOR_RELEASE);
+DEFINE_DMI_ATTR_WITH_SHOW(bios_release_minor, 0444, DMI_BIOS_MINOR_RELEASE);
 DEFINE_DMI_ATTR_WITH_SHOW(product_name,		0444, DMI_PRODUCT_NAME);
 DEFINE_DMI_ATTR_WITH_SHOW(product_version,	0444, DMI_PRODUCT_VERSION);
 DEFINE_DMI_ATTR_WITH_SHOW(product_serial,	0400, DMI_PRODUCT_SERIAL);
@@ -78,6 +80,8 @@ static ssize_t get_modalias(char *buffer, size_t buffer_size)
 		{ "bvn", DMI_BIOS_VENDOR },
 		{ "bvr", DMI_BIOS_VERSION },
 		{ "bd",  DMI_BIOS_DATE },
+		{ "bjr", DMI_BIOS_MAJOR_RELEASE },
+		{ "bmr", DMI_BIOS_MINOR_RELEASE },
 		{ "svn", DMI_SYS_VENDOR },
 		{ "pn",  DMI_PRODUCT_NAME },
 		{ "pvr", DMI_PRODUCT_VERSION },
@@ -187,6 +191,8 @@ static void __init dmi_id_init_attr_table(void)
 	ADD_DMI_ATTR(bios_vendor,       DMI_BIOS_VENDOR);
 	ADD_DMI_ATTR(bios_version,      DMI_BIOS_VERSION);
 	ADD_DMI_ATTR(bios_date,         DMI_BIOS_DATE);
+	ADD_DMI_ATTR(bios_release_major, DMI_BIOS_MAJOR_RELEASE);
+	ADD_DMI_ATTR(bios_release_minor, DMI_BIOS_MINOR_RELEASE);
 	ADD_DMI_ATTR(sys_vendor,        DMI_SYS_VENDOR);
 	ADD_DMI_ATTR(product_name,      DMI_PRODUCT_NAME);
 	ADD_DMI_ATTR(product_version,   DMI_PRODUCT_VERSION);
diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 202bd2c69d0f..886ace54e527 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -464,6 +464,8 @@ static void __init dmi_decode(const struct dmi_header *dm, void *dummy)
 		dmi_save_ident(dm, DMI_BIOS_VENDOR, 4);
 		dmi_save_ident(dm, DMI_BIOS_VERSION, 5);
 		dmi_save_ident(dm, DMI_BIOS_DATE, 8);
+		dmi_save_release(dm, DMI_BIOS_MAJOR_RELEASE, 20);
+		dmi_save_release(dm, DMI_BIOS_MINOR_RELEASE, 21);
 		break;
 	case 1:		/* System Information */
 		dmi_save_ident(dm, DMI_SYS_VENDOR, 4);
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 5714fd35a83c..2471de601bd6 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -532,6 +532,8 @@ enum dmi_field {
 	DMI_BIOS_VENDOR,
 	DMI_BIOS_VERSION,
 	DMI_BIOS_DATE,
+	DMI_BIOS_MAJOR_RELEASE,
+	DMI_BIOS_MINOR_RELEASE,
 	DMI_SYS_VENDOR,
 	DMI_PRODUCT_NAME,
 	DMI_PRODUCT_VERSION,
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index e17a29ae2e97..1b4f9bc3b06c 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -931,6 +931,8 @@ static const struct dmifield {
 	{ "bvn", DMI_BIOS_VENDOR },
 	{ "bvr", DMI_BIOS_VERSION },
 	{ "bd",  DMI_BIOS_DATE },
+	{ "bjr", DMI_BIOS_MAJOR_RELEASE },
+	{ "bmr", DMI_BIOS_MINOR_RELEASE },
 	{ "svn", DMI_SYS_VENDOR },
 	{ "pn",  DMI_PRODUCT_NAME },
 	{ "pvr", DMI_PRODUCT_VERSION },
-- 
2.21.0

