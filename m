Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B243C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA5721655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573499405;
	bh=foS21jyDG7+AiNiYalDNGoY+ubZ8bYGRS1cP3+yOoZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GS+ywGuNvQe+WX43f44k/U9jHS9DCUy0BkHoInL3K0k9f4mSSxj6ixXpZK2/BRhZI
	 ZZ6GfWze4T5D/ktmMrtO/X0Uyrh9BHTnBVUbnxZBCRm/w3A8mgzw+MwG9h8PvRK7pH
	 4vUDCatSRtZO256c0BtIB7HJhg5S/n2oQfKFkxB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfKKSc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:32:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfKKScx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:32:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CAAB20674;
        Mon, 11 Nov 2019 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497172;
        bh=foS21jyDG7+AiNiYalDNGoY+ubZ8bYGRS1cP3+yOoZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbcIsA1VAfQR+ycg9PQQfpgBUZEGbh34YVJgHaHHpFbY2JtGchbCRuvgDEYBDMbqD
         OETS6pblHM2WRC4Xjtmv7WRn4+uMkju/fmdMHh55UVJLJoPW3oHuNDaQPzw3qk6kHH
         WvDK4yKFbUSwSsC+CMOax72IWVHVFraXsi8kxxZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.9 27/65] configfs: Fix bool initialization/comparison
Date:   Mon, 11 Nov 2019 19:28:27 +0100
Message-Id: <20191111181346.107117626@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181331.917659011@linuxfoundation.org>
References: <20191111181331.917659011@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Meyer <thomas@m3y3r.de>

commit 3f6928c347707a65cee10a9f54b85ad5fb078b3f upstream.

Bool initializations should use true and false. Bool tests don't need
comparisons.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/configfs/file.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -166,7 +166,7 @@ configfs_read_bin_file(struct file *file
 		retval = -ETXTBSY;
 		goto out;
 	}
-	buffer->read_in_progress = 1;
+	buffer->read_in_progress = true;
 
 	if (buffer->needs_read_fill) {
 		/* perform first read with buf == NULL to get extent */
@@ -325,7 +325,7 @@ configfs_write_bin_file(struct file *fil
 		len = -ETXTBSY;
 		goto out;
 	}
-	buffer->write_in_progress = 1;
+	buffer->write_in_progress = true;
 
 	/* buffer grows? */
 	if (*ppos + count > buffer->bin_buffer_size) {
@@ -429,8 +429,8 @@ static int check_perm(struct inode * ino
 	}
 	mutex_init(&buffer->mutex);
 	buffer->needs_read_fill = 1;
-	buffer->read_in_progress = 0;
-	buffer->write_in_progress = 0;
+	buffer->read_in_progress = false;
+	buffer->write_in_progress = false;
 	buffer->ops = ops;
 	file->private_data = buffer;
 	goto Done;
@@ -488,10 +488,10 @@ static int configfs_release_bin_file(str
 	ssize_t len = 0;
 	int ret;
 
-	buffer->read_in_progress = 0;
+	buffer->read_in_progress = false;
 
 	if (buffer->write_in_progress) {
-		buffer->write_in_progress = 0;
+		buffer->write_in_progress = false;
 
 		len = bin_attr->write(item, buffer->bin_buffer,
 				buffer->bin_buffer_size);


