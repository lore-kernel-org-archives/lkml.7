Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D189C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14216208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140449;
	bh=HqNiaNWi6NosAgS4pOhhKM607uAGDrKPYneAD6RSTq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MiZF9KfRoEDFIKBB/mM4WK794FyQuB38W2JQyGQ5D0bUvhtZ7MSBbGxohXaGoQeKJ
	 GpKkWSRTPAMbJPDTZ1WXOklWBqwIBsllMY5SiLEbFcImJdikhdsvcUmAIxn7fg5x3A
	 4kRssE5LGm+MxCJCHhIeeod+HW9Gsw7ouZDDrfWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbfDARks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388382AbfDARjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:39:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2B8D2070B;
        Mon,  1 Apr 2019 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140339;
        bh=HqNiaNWi6NosAgS4pOhhKM607uAGDrKPYneAD6RSTq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvQC+Jt1dgAIEvcpiDcQ5e1GWQVVPODoli9qfQNodcQkfr+vevvs4yvxNnIJsxddY
         PYonFOW+Z3++rQhK/3cYzSp7mvyGbGA0aU8OTPyLKape7sF3kWYy+ZqjZ39a2FJZrS
         UXJ5608m/ehez9L8wQsxA1kDG3BxAjktNFuqbilg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lin Yi <teroincn@163.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3.18 43/50] USB: serial: mos7720: fix mos_parport refcount imbalance on error path
Date:   Mon,  1 Apr 2019 19:03:26 +0200
Message-Id: <20190401170045.812476827@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -369,8 +369,6 @@ static int write_parport_reg_nonblock(st
 	if (!urbtrack)
 		return -ENOMEM;
 
-	kref_get(&mos_parport->ref_count);
-	urbtrack->mos_parport = mos_parport;
 	urbtrack->urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urbtrack->urb) {
 		kfree(urbtrack);
@@ -391,6 +389,8 @@ static int write_parport_reg_nonblock(st
 			     usb_sndctrlpipe(usbdev, 0),
 			     (unsigned char *)urbtrack->setup,
 			     NULL, 0, async_complete, urbtrack);
+	kref_get(&mos_parport->ref_count);
+	urbtrack->mos_parport = mos_parport;
 	kref_init(&urbtrack->ref_count);
 	INIT_LIST_HEAD(&urbtrack->urblist_entry);
 


