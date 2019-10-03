Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52698C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE8E20673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122450;
	bh=1/khuy4O3zZHpw9LAei40BNaPZ3LL9+GHfckPbkNiRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nevKPl60VKxFd09C/yoX/VN2SQWv15Oc5E/hslCKthwqHTXnkS68Qj0KpYpgvoyct
	 woKQ6QLm+VEq8l+SR+/H0BaY/nxePASCeyxHxeyO7qVukXeGtbKQFvkNlfGpM8LruF
	 Vh9XdM8t8eGZyQqt9E+XeJsUCNuOl4ip0s5ki7rI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393406AbfJCRH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404445AbfJCQgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:36:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C41D92133F;
        Thu,  3 Oct 2019 16:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120597;
        bh=1/khuy4O3zZHpw9LAei40BNaPZ3LL9+GHfckPbkNiRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Gc/bclxCzp/rOOf6On8di02KCoUAxT6Yk9055nXaUhNIoTc9IyZQtE9VL8nBB3K2
         UvqKUL4CJjXJSFMAeuDI95UvwBzqrgOKQFDyw5VfH/hHFDP3OJKh5oyFSzsdQPBNoL
         EaVoizOgVI6jQ7Iqvxr5QsB1YHOZFD65LUa9QmVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.2 280/313] ovl: Fix dereferencing possible ERR_PTR()
Date:   Thu,  3 Oct 2019 17:54:18 +0200
Message-Id: <20191003154600.644755235@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ding Xiang <dingxiang@cmss.chinamobile.com>

commit 97f024b9171e74c4443bbe8a8dce31b917f97ac5 upstream.

if ovl_encode_real_fh() fails, no memory was allocated
and the error in the error-valued pointer should be returned.

Fixes: 9b6faee07470 ("ovl: check ERR_PTR() return value from ovl_encode_fh()")
Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc: <stable@vger.kernel.org> # v4.16+
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/export.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -227,9 +227,8 @@ static int ovl_d_to_fh(struct dentry *de
 	/* Encode an upper or lower file handle */
 	fh = ovl_encode_real_fh(enc_lower ? ovl_dentry_lower(dentry) :
 				ovl_dentry_upper(dentry), !enc_lower);
-	err = PTR_ERR(fh);
 	if (IS_ERR(fh))
-		goto fail;
+		return PTR_ERR(fh);
 
 	err = -EOVERFLOW;
 	if (fh->len > buflen)


