Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A53FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA401218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2dQs5JS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbfB1XNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:13:04 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:35897 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbfB1XNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:13:02 -0500
Received: by mail-pl1-f201.google.com with SMTP id f65so12037524plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1Fd13wAoeAlJDZDMn5wRTcmN7nj+iFwc6tEPzGSBE4U=;
        b=h2dQs5JSnAG5Wy4W0iJMttDO7lKtCKoinJmTMo41kH6xI6qAI/Rq9vmuNe3Ff+fio5
         LuvzOvPbhTpyh34gr9zrOE5mA1Y5t0ifI7DWi4CcqVkoc8uMRf9HfZV8LAEXrmOcPxJD
         HPzwxav8T+gSYUt7jFe2FK6xBbwCBCxFQ8o7gYEQ3UklvUjo3FtFW+yxeESQH9iowvh1
         97xDBgCWJvCFr9mig2BOszoMYCp/5BCz6gIE+Hss9v4IdxSkmMYoZOSBOW/RDtxVP0jD
         7PU+J/oherZ/xNZSWdJ8dLmULlg5bDB3PE1jpql9FajhQLT0wu4uFj6RoxqsbWteM0Vk
         CSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1Fd13wAoeAlJDZDMn5wRTcmN7nj+iFwc6tEPzGSBE4U=;
        b=NsDdk2Fbl63SJC61hh54z1eyRvYFM3EO1HUI+Ma1O+5g8Zdd7sEqNbtwc6ReWSguSY
         GQ+ArvFEVzmB/9Ogux9vIkq2/lrQDsfKHh/fRsG113COrthAabxj7CSy7CACpZsWil8B
         GZArKn+PWhYgNkywQ+SdfSdl6HSAwiK3WhYq9oUrsJ875bqU8AbYIqIJnuidIcqQ/jNZ
         mfdOIrSUo4AU9uZ/nULSUycpFYxILNMqUrxzqMyLl7AyrZSQMhWV/amN4s/KNnueJlA0
         yOT/mMCaZSmL9c5dKPUk3h2yx+fBEyZKydrYpBQvjJCMLQ3rQ22tmDi4RceDD+mSdB8+
         VMFg==
X-Gm-Message-State: AHQUAua7F/WEqu06rIfevk8zyU8B+OWdjBukRbeBEttX5zLdx2TTsjXD
        IRZ6tH6DTJhlBdbuNKMEdvcetA0psh4e7k6r0oh/wQ==
X-Google-Smtp-Source: AHgI3IbPb2bAkGu7mbtq3dNBtqEavh+uoz2l0tI4DokDL5Yk3RfeUuSVrpg8fxfLlyNRX+BVqb6qkCQm79o4/aJYuKCGxA==
X-Received: by 2002:aa7:8699:: with SMTP id d25mr975489pfo.22.1551395581516;
 Thu, 28 Feb 2019 15:13:01 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:58 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 22/27] Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow access to /proc/kcore when the kernel is locked down to prevent
access to cryptographic data.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
---
 fs/proc/kcore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index bbcc185062bb..d50ebfbf3dbb 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -518,6 +518,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 static int open_kcore(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/proc/kcore"))
+		return -EPERM;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
-- 
2.21.0.352.gf09ad66450-goog

