Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C19C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175AF20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139033;
	bh=gRNKUdHSmJ5qFY9axlxVYghT1TUStAWLdnIJjAg5ZAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JK5D8dCASY20E15B30dfSdJxswMjLEDUATSTdnlP+nb2CRqfvkrY2chjzSkkh4Udj
	 77CZDlALL9EfGO5IPA5cODUMQ9KB+vRnNBvDtaDcygKyUgbCce8Qw+rnDiJdMZKw3m
	 oxvc3cYgb9jxIKde8BdRwovMMfYizgiYLHP0b6U0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbfDARRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730425AbfDARRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:17:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B298C206C0;
        Mon,  1 Apr 2019 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139028;
        bh=gRNKUdHSmJ5qFY9axlxVYghT1TUStAWLdnIJjAg5ZAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=it20+sj1/x5T+e0U0qldYHg7tay3VqKQFi5JUcG/MBAq8MZTWGWdpDqpKh7P5I+qH
         av6iXhV8DIhQBd3Qd/TyQYKFd3setcGDkcl0EK88XYspx7a8rH9xm2thsCIM4BLsyH
         2TUqKtF1gsDwRvGH+4ivbxqgV02hcQiXwoL+ELaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lin Yi <teroincn@163.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 091/134] USB: serial: mos7720: fix mos_parport refcount imbalance on error path
Date:   Mon,  1 Apr 2019 19:02:07 +0200
Message-Id: <20190401170052.772147186@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Yi <teroincn@163.com>

commit 2908b076f5198d231de62713cb2b633a3a4b95ac upstream.

The write_parport_reg_nonblock() helper takes a reference to the struct
mos_parport, but failed to release it in a couple of error paths after
allocation failures, leading to a memory leak.

Johan said that move the kref_get() and mos_parport assignment to the
end of urbtrack initialisation is a better way, so move it. and
mos_parport do not used until urbtrack initialisation.

Signed-off-by: Lin Yi <teroincn@163.com>
Fixes: b69578df7e98 ("USB: usbserial: mos7720: add support for parallel port on moschip 7715")
Cc: stable <stable@vger.kernel.org>     # 2.6.35
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/mos7720.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -366,8 +366,6 @@ static int write_parport_reg_nonblock(st
 	if (!urbtrack)
 		return -ENOMEM;
 
-	kref_get(&mos_parport->ref_count);
-	urbtrack->mos_parport = mos_parport;
 	urbtrack->urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urbtrack->urb) {
 		kfree(urbtrack);
@@ -388,6 +386,8 @@ static int write_parport_reg_nonblock(st
 			     usb_sndctrlpipe(usbdev, 0),
 			     (unsigned char *)urbtrack->setup,
 			     NULL, 0, async_complete, urbtrack);
+	kref_get(&mos_parport->ref_count);
+	urbtrack->mos_parport = mos_parport;
 	kref_init(&urbtrack->ref_count);
 	INIT_LIST_HEAD(&urbtrack->urblist_entry);
 


