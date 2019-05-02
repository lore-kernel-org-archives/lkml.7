Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22CDC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED2E216FD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810632;
	bh=XIszzMle7hH7QFFSNuriAhew6Fm075CM15HW1boiOTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KqsWlIxJ6+tpS/ZaWWkerxsGAjGBtbErMXtqQBAdsuFwV5ZLYVezWmwDGE9BcV/TQ
	 ezDaYJsk1BJKmhfHRIpUw0DxTsae1GSCbpHRUr3IS1/w4Bc9774lbCIWE4Rjgvg/lj
	 0KEVcZcwOQas4vutx5UIR+iP5PWEs7UDFUcLCcbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfEBPXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfEBPXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:23:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 755FA20B7C;
        Thu,  2 May 2019 15:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810627;
        bh=XIszzMle7hH7QFFSNuriAhew6Fm075CM15HW1boiOTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wIahi+cOajvqvJcfMXa0cW0odYEuTDpI/n1INpGyA9ozA61CsxfaBLCEkXqBQBaTh
         CZznZCGdULifrfMG4auj7ninUTT89nHH+59bzNEe2n7e5FE4dBfTu/wO4H45SCZnx4
         GsAAjgCzRiY+QpzueZP7EakmItLNvHx5Pi2qnqu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Guido Kiener <guido.kiener@rohde-schwarz.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.14 19/49] usb: gadget: net2272: Fix net2272_dequeue()
Date:   Thu,  2 May 2019 17:20:56 +0200
Message-Id: <20190502143326.478456131@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143323.397051088@linuxfoundation.org>
References: <20190502143323.397051088@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 091dacc3cc10979ab0422f0a9f7fcc27eee97e69 ]

Restore the status of ep->stopped in function net2272_dequeue().

When the given request is not found in the endpoint queue
the function returns -EINVAL without restoring the state of
ep->stopped. Thus the endpoint keeps blocked and does not transfer
any data anymore.

This fix is only compile-tested, since we do not have a
corresponding hardware. An analogous fix was tested in the sibling
driver. See "usb: gadget: net2280: Fix net2280_dequeue()"

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Guido Kiener <guido.kiener@rohde-schwarz.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/usb/gadget/udc/net2272.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index e0759a826b60..7fb31a3b53e6 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -958,6 +958,7 @@ net2272_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 			break;
 	}
 	if (&req->req != _req) {
+		ep->stopped = stopped;
 		spin_unlock_irqrestore(&ep->dev->lock, flags);
 		return -EINVAL;
 	}
-- 
2.19.1



