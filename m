Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47304C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109C82133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igrS5HgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbfB1XMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:33 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:39942 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387619AbfB1XM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:26 -0500
Received: by mail-qk1-f202.google.com with SMTP id 203so17198338qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tidnH0SwpTHfWgiR4IAR+/7Oaon7P2ll4DVIIUwAK1A=;
        b=igrS5HgB6YoQ6TPI8HVmjgJSBGpxMZDjnongg0RDlIULoSoIBEWheX+KyE784QzsOc
         UIRZuYFKM7JHDXbOddtqKM80DdSv7MPgMll/F1ZFqrW1Pp2ZlBLUHK9RLz4by0hYv1z/
         aSdRD9d1RIke2hei05b9KoVmbaSVc/qb6h6f9T3Zyd/MZt+xEdiF0o4izzAiknNAP4EM
         8qHLUMmsAJQ/o6uDLspeXOcce9hPfZ+qB9KYGarrFSWP/SZcwpgOM1ZgWckg0K+oQjoL
         XFXPNP2bpa/FRZ6857TPx1ZtwNTVQLoiEw0KoHdBQvdKwNM0TS1tpJKGx0Pt2cN72RI2
         Fnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tidnH0SwpTHfWgiR4IAR+/7Oaon7P2ll4DVIIUwAK1A=;
        b=n0Y41d4FIm2YUBjXyWlm7nZ+SbR7Z+MVvgcHtcRZrawMP//m2XGemAaawUj4Rc+fUb
         gGTWALwW9KPMGO7DHM0t90jlcgO/DoublzELAbftBiQ0JPCGxWiPi0H6DWHZdt7aFfsB
         xQ/ex3tNxj6zSB7f4yQ/By6zV4F2JCHaXc6GonGRRWA8nbOk+XrjiQgHl1VXKrBlagFg
         AKOlm7BucinOzbNZX1N/sFu187hh/6sNR9aJBjCc9DlxEJ9Mg2IFEfl5+EFx22pYuJOO
         frsxr1Kb7FCC4oyLt2XIYaO+OTlolfCPKRb6VbDgAGXzWiceQnSVqSpUeyZFmO8EZa1i
         SqXg==
X-Gm-Message-State: APjAAAUYgL+DXWiMs8ZIgUtO4CNpWAWEZM45xNX6oiQY4P+rAAyVcYAB
        4MtL77XPznfZmF+26Gaj0nXYxOsph1smgdyEZiSyOA==
X-Google-Smtp-Source: APXvYqxxh4UKFzo0o0AatfkgMLGjfdiyDrhWhba8RfpyN7BBOY9rHrdV/RINtiBM3Olzir4oUoZC+bWEwdQSMny+julvFw==
X-Received: by 2002:ac8:2539:: with SMTP id 54mr1091576qtm.45.1551395544912;
 Thu, 28 Feb 2019 15:12:24 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:44 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 08/27] kexec_file: Restrict at runtime if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Bohac <jbohac@suse.cz>

When KEXEC_SIG is not enabled, kernel should not load images through
kexec_file systemcall if the kernel is locked down unless IMA can be used
to validate the image.

[Modified by David Howells to fit with modifications to the previous patch
 and to return -EPERM if the kernel is locked down for consistency with
 other lockdowns]

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
cc: Chun-Yi Lee <jlee@suse.com>
cc: kexec@lists.infradead.org
---
 include/linux/ima.h | 6 ++++++
 kernel/kexec_file.c | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index b5e16b8c50b7..b35ed0725a05 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -127,4 +127,10 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
 	return 0;
 }
 #endif /* CONFIG_IMA_APPRAISE */
+
+static inline bool is_ima_kexec_appraise_enabled(void)
+{
+	return IS_ENABLED(CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS);
+}
+
 #endif /* _LINUX_IMA_H */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 67f3a866eabe..b4e938dff4be 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -239,6 +239,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		}
 
 		ret = 0;
+		if (is_ima_kexec_appraise_enabled())
+			break;
+
+		if (kernel_is_locked_down(reason)) {
+			ret = -EPERM;
+			goto out;
+		}
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
-- 
2.21.0.352.gf09ad66450-goog

