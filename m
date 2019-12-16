Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7870AC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5E321739
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519300;
	bh=eSh5pE4Q3RAtck0PQkjrW+PH3c7RITGsXb2IGj4X9eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z3FdybArrgqEmPxhagm8tzK+HEZAai9JdYWKgE1+5+M0lN4huELILD5bNwxc49oZw
	 Wqlhnr9HaC0ipAGv6XsU+rwJHsi+3o2KwINduXrHAA6uqTKBYx9mleqIpB6PmZOVDd
	 HjPyIwRmjdGO6cvzmnEIOSx77IJ7i5dQwA8jtOY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfLPSBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729184AbfLPSBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:01:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2772320726;
        Mon, 16 Dec 2019 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519296;
        bh=eSh5pE4Q3RAtck0PQkjrW+PH3c7RITGsXb2IGj4X9eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+igfSQJnDVNyGaD6FYnhrtPe/NpjDWfViWmsM+Pa4UcXRC1iF2pmXnffCGOJb//r
         k0iqyT8WbMZ42L1Mxnvcu3CaFDsyFWObODu1etXFPYs8t0V03jEuWB0w5kiPeZPaSu
         D2ljhzpJgbsnB+V0MYypBxwF9EGEePIRmKbjOwfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 4.19 001/140] usb: gadget: configfs: Fix missing spin_lock_init()
Date:   Mon, 16 Dec 2019 18:47:49 +0100
Message-Id: <20191216174747.808397958@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 093edc2baad2c258b1f55d1ab9c63c2b5ae67e42 upstream.

The driver allocates the spinlock but not initialize it.
Use spin_lock_init() on it to initialize it correctly.

This is detected by Coccinelle semantic patch.

Fixes: 1a1c851bbd70 ("usb: gadget: configfs: fix concurrent issue between composite APIs")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Link: https://lore.kernel.org/r/20191030034046.188808-1-weiyongjun1@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/configfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1544,6 +1544,7 @@ static struct config_group *gadgets_make
 	gi->composite.resume = NULL;
 	gi->composite.max_speed = USB_SPEED_SUPER;
 
+	spin_lock_init(&gi->spinlock);
 	mutex_init(&gi->lock);
 	INIT_LIST_HEAD(&gi->string_list);
 	INIT_LIST_HEAD(&gi->available_func);


