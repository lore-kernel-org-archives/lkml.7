Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE8BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232502087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ldxpNgax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfCYWK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:58 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:54892 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbfCYWKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:54 -0400
Received: by mail-qk1-f201.google.com with SMTP id v2so9914742qkf.21
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PrJR0RaRgSbOBZwUzeo3I5hhwuXL6aA00K5kUeXQKiA=;
        b=ldxpNgaxH/YHCoW1sAkKWCMk2rgkoIUCtZL9a3pHP1mgnuQGeHZOc2Hb8QqN9V/vhm
         nwU9NE1Y9sBqrUedzaF+jEQRCmfrzLWhJhZpAhWJfkX7TRIC2hTXiF19DrpYCo2BovDm
         iQRcbzBQsxO7oY7WniRiSxdW6DFqLI79Z3k0SkVIgYoLlVlbBPLclFAG4RtQ/oNUBp7t
         CxNo8cyMyHiyiMM6FwJdS5EuDvNKTU6uEHB1PxHs+RFl/d5mu8kzoILCb//teVE+zVlz
         ws+ZRmX5w82F56rt7M41HYV41JtsVSNrO0vBivx7Ax4wLryQaFJ5ZTpkh2Rqwh8Av9ZD
         dMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PrJR0RaRgSbOBZwUzeo3I5hhwuXL6aA00K5kUeXQKiA=;
        b=saMcsO8/AeizJ4aInXhfrmPjnixTQdGlzW37zahRCNXaRJ6VahVkZcAWpRUbkU4Dsm
         9cgEms3INV3rHjI/u7X6vwCnh3MaDXfA+DOKCB/Qf4+4E+etWP1cKuJCPZ33aT9DttPK
         FufzqboayUez4CoD1Xad1+aQI7mXNUT7mxgaYObt4sHms5C2v1PfHHo3LeFkkdI9oJzr
         iLdU0OrRdkHXiy/6nWadbNH+lhi3x4zInldu857jlOZBnxGwulMZCcV/D1HpeCrJkVBb
         CdCPuZ2zK8jXsd4wCIquMgqgx0RMj+X/QmR/o+ogzRCRNtjjjDPgUDkB7CZdWSFROwUW
         J0KA==
X-Gm-Message-State: APjAAAVOyHVIviwEnTCm3qTLW/qr566cOHo4wa+s5iWoRIjA5kz2cnhK
        FaXwMObu+aBmdpSgnFqiC2VVY/5S5k7hf8Moah+ECw==
X-Google-Smtp-Source: APXvYqyhMiEOX1rNfbi57TmOLS1KVwin8O8ieaW59rgI7j+7wNTl/HVDzf7gLUtBzf7Ww6FBHOSzd/qAlS2//YdqFdSo5A==
X-Received: by 2002:a37:b444:: with SMTP id d65mr20940708qkf.125.1553551853273;
 Mon, 25 Mar 2019 15:10:53 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:48 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 21/27] Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        James Morris <james.l.morris@oracle.com>,
        Matthew Garrett <matthewgarrett@google.com>
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
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
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
2.21.0.392.gf8f6787159e-goog

