Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FB1C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AC9206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NfH2O+lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfLJVVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:21:37 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:40373 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfLJVVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:21:35 -0500
Received: by mail-pj1-f74.google.com with SMTP id x16so10445284pjq.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 13:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lYWJU9mvbN8ZZQpV5vaQjJWA70IiddBps1EyTVgkqkw=;
        b=NfH2O+lryCV2AegD49JGcu6PkPoGlRhKASnh0FYIZV8uRkL7ubtmdT+H8B5kdISW0i
         15kPrDgWYFbv2pVFrkCR6iEYgJ6ggyFR6I74zpZ00YE1JkZYw5TUN7nT12CKzKpUkbu1
         Z9H1VaO+v28ZJH4Q5NsiYvWwwrN7UHm0oF7KvptbH/DNMDYLme3MhPBB/DF1vFYyOxDO
         PbXpjlPOngLIafacL67+0yc9eAHPcQlMzgNsPh5segouTJOFE60sEK+wyZH3t8vhKe4p
         Teo0fUTgeXBZMMqpBklZryfrVj02Dv/YBmWlCCTNEFrQcOvDwrzWwXVKMiNrF1QoOEuD
         z3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lYWJU9mvbN8ZZQpV5vaQjJWA70IiddBps1EyTVgkqkw=;
        b=ktpIwri5Ri4xhJ5X6kaalVlBO/sARSXoWDzNdG24in+GPtv7G+7YFsn7OK6qH2hnes
         Bjk/YCcpI3HylbBIhzb7xdOTH4IEK8wJMyhQ7bNHjIcBLFA0fzNvgtVCMgrquwyGJRhE
         WqkLMqmKwVPhSQjMKPX1LKGPJS52WEdvPUQL+J3T54eLrPJqIEXWRC0br+9Dd4A2iKxr
         Q9a3oj2LwQJGyKABdv7qpcdiiV787VfyXRe0nZgMLsDEB32W9znTcH9SebWU1YOQz4az
         CuRO4kLjlxazynn2JEXlTnc2Dfa1cw91D0GuCI7FjTgIrfnw1Qtt2wkLHOZmWSNEMUIv
         pKgA==
X-Gm-Message-State: APjAAAVWsWJfmIF2M8sL7JfxdMHvnNGl89tUUM2jUxHxWA7s3XOhQtJd
        bm6bCVfeD3gNFA/EFpYA5sfqVDffWva/7Xsh2rsEXw==
X-Google-Smtp-Source: APXvYqxvcAlmugwFUoHQj5y95SwQMNbPwznXe1OSMy95bIkfqfMmVov6bZ97VOQQ0xZzCtGkz7j6YZCmoaxW0K4PakU7yQ==
X-Received: by 2002:a63:fd43:: with SMTP id m3mr192307pgj.164.1576012894761;
 Tue, 10 Dec 2019 13:21:34 -0800 (PST)
Date:   Tue, 10 Dec 2019 13:21:08 -0800
Message-Id: <20191210212108.222514-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v1] uml: make CONFIG_STATIC_LINK actually static
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     johannes.berg@intel.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, davidgow@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
UML_NET_PCAP; this is because glibc tries to load NSS which does not
support being statically linked. So make CONFIG_STATIC_LINK depend on
!UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.

Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 2a6d04fcb3e91..1ddc8745123f2 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -63,6 +63,7 @@ source "arch/$(HEADER_ARCH)/um/Kconfig"
 
 config STATIC_LINK
 	bool "Force a static link"
+	depends on !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP
 	default n
 	help
 	  This option gives you the ability to force a static link of UML.
@@ -72,6 +73,9 @@ config STATIC_LINK
 	  Additionally, this option enables using higher memory spaces (up to
 	  2.75G) for UML.
 
+	  NOTE: This option is incompatible with some networking features which
+	  depend on features that require being dynamically loaded (like NSS).
+
 config LD_SCRIPT_STATIC
 	bool
 	default y
-- 
2.24.0.525.g8f36a354ae-goog

