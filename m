Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60E6C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2492077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077882;
	bh=V9iFbAEEh/ISObvSLThdcNRuyHPmWRB7uxhJV2IbNc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QsyH+mTF/habMexo44AG/lFTntxnY2yFgYd4Sktmn0HxoG0/AjCYCEXRCFwX6Ikby
	 +sj20QjU4QZKLwe2lvYd7A31f7mZ2raxzFQEecxoLRV8iIIhtxi2FEWigxg4yl07SO
	 k6lpCpjA9/TKZalPJP0Um+gCFAbP6NyS0wX9vtz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbfLKPYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:24:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732866AbfLKPYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:24:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DBA82077B;
        Wed, 11 Dec 2019 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077878;
        bh=V9iFbAEEh/ISObvSLThdcNRuyHPmWRB7uxhJV2IbNc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lr2A/KzGmDy6po2nIz8a9sVaHRDYTajzwNMa6SOB5qqsKGm/Rua9skCHYr/bmt3kb
         JAhtmy2p4TXzu4u6woAzgt/eYSqNB1u24TPadb7UUy/Rk+IJLjUPP+iI3vJCtK7Jcl
         isU/WxQdryvaibhC7djHn6reZI58Vw1fYmytsXMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 206/243] Input: synaptics-rmi4 - dont increment rmiaddr for SMBus transfers
Date:   Wed, 11 Dec 2019 16:06:08 +0100
Message-Id: <20191211150353.088399161@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit a284e11c371e446371675668d8c8120a27227339 upstream.

This increment of rmi_smbus in rmi_smb_read/write_block() causes
garbage to be read/written.

The first read of SMB_MAX_COUNT bytes is fine, but after that
it is nonsense. Trial-and-error showed that by dropping the
increment of rmiaddr everything is fine and the F54 function
properly works.

I tried a hack with rmi_smb_write_block() as well (writing to the
same F54 touchpad data area, then reading it back), and that
suggests that there too the rmiaddr increment has to be dropped.
It makes sense that if it has to be dropped for read, then it has
to be dropped for write as well.

It looks like the initial work with F54 was done using i2c, not smbus,
and it seems nobody ever tested F54 with smbus. The other functions
all read/write less than SMB_MAX_COUNT as far as I can tell, so this
issue was never noticed with non-F54 functions.

With this change I can read out the touchpad data correctly on my
Lenovo X1 Carbon 6th Gen laptop.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Link: https://lore.kernel.org/r/8dd22e21-4933-8e9c-a696-d281872c8de7@xs4all.nl
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/rmi4/rmi_smbus.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -166,7 +166,6 @@ static int rmi_smb_write_block(struct rm
 		/* prepare to write next block of bytes */
 		cur_len -= SMB_MAX_COUNT;
 		databuff += SMB_MAX_COUNT;
-		rmiaddr += SMB_MAX_COUNT;
 	}
 exit:
 	mutex_unlock(&rmi_smb->page_mutex);
@@ -218,7 +217,6 @@ static int rmi_smb_read_block(struct rmi
 		/* prepare to read next block of bytes */
 		cur_len -= SMB_MAX_COUNT;
 		databuff += SMB_MAX_COUNT;
-		rmiaddr += SMB_MAX_COUNT;
 	}
 
 	retval = 0;


