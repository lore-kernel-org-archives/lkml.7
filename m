Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95651FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8F221925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571262979;
	bh=1+1fyWTqgaYeBWPbe4DGTlwrzehJQTZxrXvSRxP2qjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=14+CvAwKsT1Oz7rqd3bQFfvXtWPsDV0QQfSbMzYQyl1F0+A+COEmJnePpTIUvUZTm
	 9Op6mEwPpEDIxkEMMqd12H83sCd6h00MHHZWv1Z8wctC4pQlO6e5BDMy9SsbdLCrZQ
	 P+DNBM1Czfh+wMO+bJXFqk0AMTtAL4y12sUK9TJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406618AbfJPV4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437908AbfJPV4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:56:06 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BBF8218DE;
        Wed, 16 Oct 2019 21:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262965;
        bh=1+1fyWTqgaYeBWPbe4DGTlwrzehJQTZxrXvSRxP2qjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1UEU2iJr/Zj7aNiXsNuH9aIMzy0UJeXGArJCVLgDoPWaTX6l2Yqw1uUlgg3y8K/ZF
         gEVELSi3R09M8M02XneqboVYk1zLqS42Zs8d5pnpzER7B83drzpBce6g2ypEmimZmq
         l38caT93ySSgou0QbH0A3h0VNj741kw9MfZljFvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 4.14 32/65] usb: renesas_usbhs: gadget: Do not discard queues in usb_ep_set_{halt,wedge}()
Date:   Wed, 16 Oct 2019 14:50:46 -0700
Message-Id: <20191016214826.472670219@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214756.457746573@linuxfoundation.org>
References: <20191016214756.457746573@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 1aae1394294cb71c6aa0bc904a94a7f2f1e75936 upstream.

The commit 97664a207bc2 ("usb: renesas_usbhs: shrink spin lock area")
had added a usbhsg_pipe_disable() calling into
__usbhsg_ep_set_halt_wedge() accidentally. But, this driver should
not call the usbhsg_pipe_disable() because the function discards
all queues. So, this patch removes it.

Fixes: 97664a207bc2 ("usb: renesas_usbhs: shrink spin lock area")
Cc: <stable@vger.kernel.org> # v3.1+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/1569924633-322-2-git-send-email-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/renesas_usbhs/mod_gadget.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -730,8 +730,6 @@ static int __usbhsg_ep_set_halt_wedge(st
 	struct device *dev = usbhsg_gpriv_to_dev(gpriv);
 	unsigned long flags;
 
-	usbhsg_pipe_disable(uep);
-
 	dev_dbg(dev, "set halt %d (pipe %d)\n",
 		halt, usbhs_pipe_number(pipe));
 


