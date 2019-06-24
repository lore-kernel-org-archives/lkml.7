Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B77C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CA12133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370370;
	bh=6g+BXHLJZ+tzue6Mqf2BwDRwE3tkWzWC/AvmyVLte5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MTgkXeycggemOXeeIdaxdVlr6Fl6J2diCensbaHxWQbFVnDjystTgNFgrpJxUb3OF
	 evEjtjaXScc0JdC2H6xzncllM/8kHzSeKqtN2fObHI1Bm8rzTbaxFxOpj5glfu/3b7
	 mANpcQZNXW5n6YDKXcgUotb0ObVmzaVbTBkTJYOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfFXJ73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbfFXJ71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:59:27 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF65A21743;
        Mon, 24 Jun 2019 09:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370366;
        bh=6g+BXHLJZ+tzue6Mqf2BwDRwE3tkWzWC/AvmyVLte5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASWTey1ov78jZo8FAQ4FpxSFZB/aS5VUtE5/RPZBUz99gx/zeh4KMzk6GAzK5+SMZ
         kCZboJE4iIU1gg+cHupwP7V0S8e0JM3fd5DsY3/M30/Uw9fsktUTIxQrwc7IXLX8KW
         Oib8ZZHWeOa38t7jhsaE+rRD8M4mp3KwuSLTgPcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.14 47/51] SMB3: retry on STATUS_INSUFFICIENT_RESOURCES instead of failing write
Date:   Mon, 24 Jun 2019 17:57:05 +0800
Message-Id: <20190624092311.273502308@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092305.919204959@linuxfoundation.org>
References: <20190624092305.919204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

commit 8d526d62db907e786fd88948c75d1833d82bd80e upstream.

Some servers such as Windows 10 will return STATUS_INSUFFICIENT_RESOURCES
as the number of simultaneous SMB3 requests grows (even though the client
has sufficient credits).  Return EAGAIN on STATUS_INSUFFICIENT_RESOURCES
so that we can retry writes which fail with this status code.

This (for example) fixes large file copies to Windows 10 on fast networks.

Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2maperror.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/smb2maperror.c
+++ b/fs/cifs/smb2maperror.c
@@ -456,7 +456,7 @@ static const struct status_to_posix_erro
 	{STATUS_FILE_INVALID, -EIO, "STATUS_FILE_INVALID"},
 	{STATUS_ALLOTTED_SPACE_EXCEEDED, -EIO,
 	"STATUS_ALLOTTED_SPACE_EXCEEDED"},
-	{STATUS_INSUFFICIENT_RESOURCES, -EREMOTEIO,
+	{STATUS_INSUFFICIENT_RESOURCES, -EAGAIN,
 				"STATUS_INSUFFICIENT_RESOURCES"},
 	{STATUS_DFS_EXIT_PATH_FOUND, -EIO, "STATUS_DFS_EXIT_PATH_FOUND"},
 	{STATUS_DEVICE_DATA_ERROR, -EIO, "STATUS_DEVICE_DATA_ERROR"},


