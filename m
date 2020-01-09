Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC68C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996F5206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n930WMFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgAIJcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:32:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36031 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgAIJcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:32:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so2961186pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IUptMHJL+9Tl4nhOhJMfCKeT/r8B8a7YJnYcaAk5T+4=;
        b=n930WMFzeCmP5ttP1TldocO/9JwvUJXTCdFgxCpyoVU14UEuckw3pi5GhVnTrxel8y
         qXH2mO5pl0DD05POWU6NQBkhrrKF+96Jomuv48OJdpEG3VbrIbSrBqxOV4Q7UUGN36iI
         pS2t/PuBonQ12GJk2MRiL4QjBN8Z+bwun2A3bl1NmvodbF1Q/Xbd5vc/g6bOtzOjW630
         S71ZUbs7tevnBWY/4PJO3TK87CeVVPOw1rJINrfPPgELpO4mRKnsbeq6wIeHN2n1b5Fh
         rYy3lSe7o2TENXT94FZrTiPCEinaAiVmgYZLEg44liGVMH60IgJTHZ9PgGkbOKTRZu7X
         LQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IUptMHJL+9Tl4nhOhJMfCKeT/r8B8a7YJnYcaAk5T+4=;
        b=h9K3MHrcDrIb6Y2bv2RSG0ss7F6COklcilEAosl/AbI1HTZR/0E8r4JCHzBV6Ib8fz
         9EOqSvBd0GC5AC2GSomSm2gXWLZXhh56H08QRsNld1OOEIJo0jVlcFpLjiYR+lScLOwe
         t4cuHfurXvxpAxVcOyVRF+GhKMSaFv6O0pjyjSlmj0p7842VI0pmzuzwLadJ1I9q/Nvj
         9b/FgpdMhYQyo3F+cnxXJ9PN/kvPOzvLRbh/qcYY78ya1USb6EnMO+7Fy08mGEx3f7QV
         qvpNLzyqsYiKa1e4w5IJcu7fQUZEoxqH5J2uA7nF8PD60gRQ7Rssmk1UYaecpKqnmZ8N
         Hemw==
X-Gm-Message-State: APjAAAWR545EPauwpqdPUuoqjH2rUUTHsB4JiaZECssI28+zj80CUHAS
        D1yryIC7rCgvbhCiv+9yojA=
X-Google-Smtp-Source: APXvYqyPNuEcV6edJfxPLDzBxOyLVXgzbP+dnUJvCZ/+azkjXlXkF1dASRQjsluZjmvJDYVIzuH93g==
X-Received: by 2002:a63:904c:: with SMTP id a73mr10267285pge.335.1578562358385;
        Thu, 09 Jan 2020 01:32:38 -0800 (PST)
Received: from xp-OptiPlex-7050.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id m128sm6963746pfm.183.2020.01.09.01.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jan 2020 01:32:38 -0800 (PST)
From:   ping xiong <xp1982.06.06@gmail.com>
To:     yuchao0@huawei.com
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, xiongping1 <xiongping1@xiaomi.com>
Subject: [f2fs-dev][PATCH] resize.f2fs: add option for large_nat_bitmap feature
Date:   Thu,  9 Jan 2020 17:32:29 +0800
Message-Id: <1578562349-842-1-git-send-email-xp1982.06.06@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiongping1 <xiongping1@xiaomi.com>

resize.f2fs has already supported large_nat_bitmap feature, but has no
option to turn on it.

This change add a new '-i' option to control turning on/off it.

Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
---
 fsck/main.c   | 6 +++++-
 fsck/resize.c | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index 9a7d499..e7e3dfc 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -104,6 +104,7 @@ void resize_usage()
 	MSG(0, "\nUsage: resize.f2fs [options] device\n");
 	MSG(0, "[options]:\n");
 	MSG(0, "  -d debug level [default:0]\n");
+	MSG(0, "  -i extended node bitmap, node ratio is 20%% by default\n");
 	MSG(0, "  -s safe resize (Does not resize metadata)");
 	MSG(0, "  -t target sectors [default: device size]\n");
 	MSG(0, "  -V print the version number and exit\n");
@@ -449,7 +450,7 @@ void f2fs_parse_options(int argc, char *argv[])
 				break;
 		}
 	} else if (!strcmp("resize.f2fs", prog)) {
-		const char *option_string = "d:st:V";
+		const char *option_string = "d:st:iV";
 
 		c.func = RESIZE;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
@@ -476,6 +477,9 @@ void f2fs_parse_options(int argc, char *argv[])
 					ret = sscanf(optarg, "%"PRIx64"",
 							&c.target_sectors);
 				break;
+			case 'i':
+				c.large_nat_bitmap = 1;
+				break;
 			case 'V':
 				show_version(prog);
 				exit(0);
diff --git a/fsck/resize.c b/fsck/resize.c
index fc563f2..88e063e 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -519,6 +519,11 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 	else
 		set_cp(checksum_offset, CP_CHKSUM_OFFSET);
 
+	if (c.large_nat_bitmap) {
+		set_cp(checksum_offset, CP_MIN_CHKSUM_OFFSET);
+		flags |= CP_LARGE_NAT_BITMAP_FLAG;
+	}
+
 	set_cp(ckpt_flags, flags);
 
 	memcpy(new_cp, cp, (unsigned char *)cp->sit_nat_version_bitmap -
-- 
2.7.4

