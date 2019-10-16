Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FFDECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD334207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264174;
	bh=MtMGiH1G0XKLabeSTO8c9Lk4TLaGXAQt/nU9VQmTvOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cfQ33tjnb3mcicedN09mTYXw3W1Wf8Jb/R9cRMp0xePQ3vjiq4L/oYPhdWvhoEEqm
	 VMr8WmPlxN7EJAbU2GC3DRc/Lz95E7OWHJ3I361EMhzIw5xDEHrj49BPgrHXCBsq1s
	 jPlF3T2RV13EIsPzu1x9peKc/PEMXeBs7EBVbnhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407454AbfJPWQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437720AbfJPVzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:55:13 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 867E7218DE;
        Wed, 16 Oct 2019 21:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262912;
        bh=MtMGiH1G0XKLabeSTO8c9Lk4TLaGXAQt/nU9VQmTvOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtIDieVkTAj9JMLWLZaPiFSak380oMrFwLORWSOMqSs0yfqIcsWCTWZqnnzLuQtKw
         5mN1Y4K2ujzC22o6sU4CWL8TRRnlx/wQh4vUBIj/iK6Jl5X397sGKJvc/TkXI6dhJl
         /QYHJ/7TyDrowes2aq9S/dCHj7O3/l/nMIwm0zAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 72/92] USB: legousbtower: fix use-after-free on release
Date:   Wed, 16 Oct 2019 14:50:45 -0700
Message-Id: <20191016214844.418325456@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 726b55d0e22ca72c69c947af87785c830289ddbc upstream.

The driver was accessing its struct usb_device in its release()
callback without holding a reference. This would lead to a
use-after-free whenever the device was disconnected while the character
device was still open.

Fixes: fef526cae700 ("USB: legousbtower: remove custom debug macro")
Cc: stable <stable@vger.kernel.org>     # 3.12
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191009153848.8664-5-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/legousbtower.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/misc/legousbtower.c
+++ b/drivers/usb/misc/legousbtower.c
@@ -302,6 +302,7 @@ static inline void tower_delete (struct
 	kfree (dev->read_buffer);
 	kfree (dev->interrupt_in_buffer);
 	kfree (dev->interrupt_out_buffer);
+	usb_put_dev(dev->udev);
 	kfree (dev);
 }
 
@@ -818,7 +819,7 @@ static int tower_probe (struct usb_inter
 
 	mutex_init(&dev->lock);
 
-	dev->udev = udev;
+	dev->udev = usb_get_dev(udev);
 	dev->open_count = 0;
 	dev->disconnected = 0;
 


