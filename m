Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B689EC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869CA21655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573499148;
	bh=6BoxzKJfoTLRXFSyM632xFz5OUUPUolpB2hF7Y4yUR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CBE7EqOw+uzGLFOokgSV54GcL+xo6Ll9LbGJrEkoy3zLT31FtD4IS1ueLzCj5o+ps
	 Am/MzMbD0eFPgfewEG3A0z/TB08Af831RWKkMH8EN8/gJpf3vLUwG9oV9Mzbqpi7WB
	 p7pqQRvpvjCzdLNUfQKxdQ4PA6Vd0jchblOghY3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfKKTFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:05:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbfKKSje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:39:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F8E3204FD;
        Mon, 11 Nov 2019 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497573;
        bh=6BoxzKJfoTLRXFSyM632xFz5OUUPUolpB2hF7Y4yUR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laPJSurAMMyajXt235KpEnRWZS0dx+X3WKdtMA7aPbZMqm2X5hIIy+xUSJ3MXeLI5
         FGRBsSD+vRw7L+9CA6SISDsQA0NBd71ULTUFfKpVcaQD8t5DvH+IVO+Y/uPVkkyQcH
         9wnzkQe93XGzwgx9ExxUHaLUDriBrYTreVyXysxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 084/105] usb: gadget: composite: Fix possible double free memory bug
Date:   Mon, 11 Nov 2019 19:28:54 +0100
Message-Id: <20191111181447.248454698@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181421.390326245@linuxfoundation.org>
References: <20191111181421.390326245@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>

[ Upstream commit 1c20c89b0421b52b2417bb0f62a611bc669eda1d ]

composite_dev_cleanup call from the failure of configfs_composite_bind
frees up the cdev->os_desc_req and cdev->req. If the previous calls of
bind and unbind is successful these will carry stale values.

Consider the below sequence of function calls:
configfs_composite_bind()
        composite_dev_prepare()
                - Allocate cdev->req, cdev->req->buf
        composite_os_desc_req_prepare()
                - Allocate cdev->os_desc_req, cdev->os_desc_req->buf
configfs_composite_unbind()
        composite_dev_cleanup()
                - free the cdev->os_desc_req->buf and cdev->req->buf
Next composition switch
configfs_composite_bind()
        - If it fails goto err_comp_cleanup will call the
	  composite_dev_cleanup() function
        composite_dev_cleanup()
	        - calls kfree up with the stale values of cdev->req->buf and
		  cdev->os_desc_req from the previous configfs_composite_bind
		  call. The free call on these stale values leads to double free.

Hence, Fix this issue by setting request and buffer pointer to NULL after
kfree.

Signed-off-by: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/composite.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 75c42393b64ba..b29cd3979391e 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2187,14 +2187,18 @@ void composite_dev_cleanup(struct usb_composite_dev *cdev)
 			usb_ep_dequeue(cdev->gadget->ep0, cdev->os_desc_req);
 
 		kfree(cdev->os_desc_req->buf);
+		cdev->os_desc_req->buf = NULL;
 		usb_ep_free_request(cdev->gadget->ep0, cdev->os_desc_req);
+		cdev->os_desc_req = NULL;
 	}
 	if (cdev->req) {
 		if (cdev->setup_pending)
 			usb_ep_dequeue(cdev->gadget->ep0, cdev->req);
 
 		kfree(cdev->req->buf);
+		cdev->req->buf = NULL;
 		usb_ep_free_request(cdev->gadget->ep0, cdev->req);
+		cdev->req = NULL;
 	}
 	cdev->next_string_id = 0;
 	device_remove_file(&cdev->gadget->dev, &dev_attr_suspended);
-- 
2.20.1



