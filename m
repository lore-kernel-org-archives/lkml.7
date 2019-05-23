Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCACC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B18C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640100;
	bh=4wgxF1YFp5FyaQGTZ3L+A80LKvSHjmr7i8d7XrTzsD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V+lJsNfSoOzx6UuFyWRzRexQhoAi64vAaYg7Lt58rmNrLR7MU2rQmNRq3lXz5InHy
	 jVfQmBdsWdWvan85VAyvktlN9Lm9cuHO75/iyHPCwmG4+iFXO9J5tXHHb15k9RqgPr
	 25OwcDdUD5DeywlbC8d8lktoMOfYEF001nMrRnOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391914AbfEWTe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391153AbfEWT1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:27:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF84F2186A;
        Thu, 23 May 2019 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639640;
        bh=4wgxF1YFp5FyaQGTZ3L+A80LKvSHjmr7i8d7XrTzsD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wyZFv3yTRbZKX+TwM+fC9Qx4A+nQS08R77wgGBvGPdy8INBiy377o0IWPlFOWqBmi
         k3/jKZC+tYmVgul2wKR4XHiUBi2V4kR2Q9OwJeiYGudlvnWs7KRuBD4x8X8Sk6RabC
         a33WdY3hyV+Rk3Xjwpw+neIBiWAJwGBXZyX4HD54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 5.1 040/122] md: add a missing endianness conversion in check_sb_changes
Date:   Thu, 23 May 2019 21:06:02 +0200
Message-Id: <20190523181710.068992771@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit ed4d0a4ea11e19863952ac6a7cea3bbb27ccd452 upstream.

The on-disk value is little endian and we need to convert it to
native endian before storing the value in the in-core structure.

Fixes: 7564beda19b36 ("md-cluster/raid10: support add disk under grow mode")
Cc: <stable@vger.kernel.org> # 4.20+
Acked-by: Guoqing Jiang <gqjiang@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/md.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9229,7 +9229,7 @@ static void check_sb_changes(struct mdde
 		 * reshape is happening in the remote node, we need to
 		 * update reshape_position and call start_reshape.
 		 */
-		mddev->reshape_position = sb->reshape_position;
+		mddev->reshape_position = le64_to_cpu(sb->reshape_position);
 		if (mddev->pers->update_reshape_pos)
 			mddev->pers->update_reshape_pos(mddev);
 		if (mddev->pers->start_reshape)


