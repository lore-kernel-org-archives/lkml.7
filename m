Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F3C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D22206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520284;
	bh=Yg1EZxh1vdL3Nuet+CAmg4++HU631afGWtZUgpRty20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gGOdLzsDBXwPmyMVuJ+bfJoPUbvrhVRC+lfuz8pjMKsEHGY8KYnm5W70Hci6m1DCg
	 uKU9n+hQw8svc+nHUBr8GyQdbj39fmkFSBTfuSRT7Ua0AlO/P/oeLQjbLCQhsYgMtc
	 FJ1gLVE2zfckrec3G4GOH7papulGw/5SOKosi20E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfLPSSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:18:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731368AbfLPSRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:17:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C1920717;
        Mon, 16 Dec 2019 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520274;
        bh=Yg1EZxh1vdL3Nuet+CAmg4++HU631afGWtZUgpRty20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fmi5J+lYRpUBGOYbDV/hkhxz5HXw/wnh3o9yJVU3YBk4DBPf1a8DBblRB+apvxULE
         hQCTqCxxGTD+HNN4l5UQK/YMbqD0AaNPdnPZzTwVQAMkvym5mJjC8krCyflRq2Wacy
         o/Y72P8WpTugZ+XaJETAhbS4L1uVN20LRk9zdeTo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wenyang@linux.alibaba.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Peter Chen <peter.chen@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 5.4 047/177] usb: roles: fix a potential use after free
Date:   Mon, 16 Dec 2019 18:48:23 +0100
Message-Id: <20191216174830.065264932@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang@linux.alibaba.com>

commit 1848a543191ae32e558bb0a5974ae7c38ebd86fc upstream.

Free the sw structure only after we are done using it.
This patch just moves the put_device() down a bit to avoid the
use after free.

Fixes: 5c54fcac9a9d ("usb: roles: Take care of driver module reference counting")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Cc: stable <stable@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/20191124142236.25671-1-wenyang@linux.alibaba.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/roles/class.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -169,8 +169,8 @@ EXPORT_SYMBOL_GPL(fwnode_usb_role_switch
 void usb_role_switch_put(struct usb_role_switch *sw)
 {
 	if (!IS_ERR_OR_NULL(sw)) {
-		put_device(&sw->dev);
 		module_put(sw->dev.parent->driver->owner);
+		put_device(&sw->dev);
 	}
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_put);


