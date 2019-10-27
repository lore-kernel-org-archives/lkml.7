Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65894CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3727421848
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211493;
	bh=N+kWJLwgSsVt7OHRx66ZKiIwoYg4+RuJ2BmXw6eqNzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NHjjB+4+lMBdC2RlMxlAvsVnaZZyko6ODVEdJNghoX0cU64NBVDEN7f2/DuqZDeU+
	 Q856stos/uHu4fJNpzRKYTmeBQK9lIm1GaPTwYanKajJ1pbwspELlklxj0xS2qVPbD
	 WHI2lrDZY1L8U/qQbvbS6EkxQJinByR4lCbQ5mcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbfJ0VYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732602AbfJ0VYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:24:48 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C3DD21726;
        Sun, 27 Oct 2019 21:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211487;
        bh=N+kWJLwgSsVt7OHRx66ZKiIwoYg4+RuJ2BmXw6eqNzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRYxCCpyXerg9uVUzbaHHtbxx8TOwoCCbuqU2ubrQH0RiJZVTnJErKkFlKDKO0Gw+
         iFQ542MwxbK7xn/CbfIIOx3gE6OeEnxgcCvqjr8ut1xnxBpUfJkRCm5HuI/nD6xEiF
         Vio6CNPjNOtE2epNBG4tfzO60kZezmiBcLoQ3x+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 5.3 168/197] cifs: Fix missed free operations
Date:   Sun, 27 Oct 2019 22:01:26 +0100
Message-Id: <20191027203403.449576521@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

commit 783bf7b8b641167fb6f3f4f787f60ae62bad41b3 upstream.

cifs_setattr_nounix has two paths which miss free operations
for xid and fullpath.
Use goto cifs_setattr_exit like other paths to fix them.

CC: Stable <stable@vger.kernel.org>
Fixes: aa081859b10c ("cifs: flush before set-info if we have writeable handles")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/inode.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2465,9 +2465,9 @@ cifs_setattr_nounix(struct dentry *diren
 			rc = tcon->ses->server->ops->flush(xid, tcon, &wfile->fid);
 			cifsFileInfo_put(wfile);
 			if (rc)
-				return rc;
+				goto cifs_setattr_exit;
 		} else if (rc != -EBADF)
-			return rc;
+			goto cifs_setattr_exit;
 		else
 			rc = 0;
 	}


