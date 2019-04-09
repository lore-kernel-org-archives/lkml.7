Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347D9C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC4220818
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="niuIzjc6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AtJNHvog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfDIKgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:36:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfDIKgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:36:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 38DE460F37; Tue,  9 Apr 2019 10:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554806204;
        bh=OZfI1a7JpaNy0NlOh+4S8ilRPffe+4gMJwOHIphPbXo=;
        h=From:To:Cc:Subject:Date:From;
        b=niuIzjc6EYSWATE4qAuvPuyDgOdY2qvSCS5I3TS9sFFPowVKaO4ZkE5/yJRhBGKZI
         ht4rvwU1ym3ROvAaw1ul8duiX48kDa9zL6HbzsB53BiuYvhqBXwGRXKmK6PRA6dUiK
         eTtm5Uo+BkbfNPlY8VOjRc8eYAEDx44yj71Y7wSE=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E8F960131;
        Tue,  9 Apr 2019 10:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554806201;
        bh=OZfI1a7JpaNy0NlOh+4S8ilRPffe+4gMJwOHIphPbXo=;
        h=From:To:Cc:Subject:Date:From;
        b=AtJNHvogNucucuUZaWvMa+xBz+RDzcho2kgKu9FJq3XDtGt0bwh9NbRoyrzBAbsUI
         0pfN7k9PyYVvPD5s3RHSWptyfcGUTJrRX2OJ4hf6NOSygoQGaVFBRXAFUhJuwwx+6i
         XvbFrTJcd5oa8S6yzoaPSCbILzVNizmbk7Xb20G8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E8F960131
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] f2fs: add F2FS_IOC_RESIZE_FROM_END for compat_ioctl
Date:   Tue,  9 Apr 2019 16:06:15 +0530
Message-Id: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add F2FS_IOC_RESIZE_FROM_END for f2fs_compat_ioctl() as well.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 42adfc2..0514935 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3159,6 +3159,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GET_PIN_FILE:
 	case F2FS_IOC_SET_PIN_FILE:
 	case F2FS_IOC_PRECACHE_EXTENTS:
+	case F2FS_IOC_RESIZE_FROM_END:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

