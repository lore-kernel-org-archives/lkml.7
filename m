Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB85CA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634C320650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME8AeDt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbfJWAVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:21:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38742 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJWAVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:21:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id v186so3034332oie.5;
        Tue, 22 Oct 2019 17:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qkST9yhwhwu10AHBsdYDPDVaDucJkRuGL9XsMxO/Jus=;
        b=ME8AeDt8lrDNr6sdt0nQbp3m0YrKt09TY+Q9IcIyd0LERSAE4nud3tI2pB/Rv3BX8C
         h7BQ50s2Z/hiLZ1nXPToZ49oSle/vfbVspSaHod0K4eX78YalSsxKzV8ozki+HttScgd
         C0yrhsUm1BwEGc94A5r9eD3JHpsFrzBAD2hdYNxq7mzgbSmcfg3GPeXoR0GFEVJWhPvd
         586/veeV52ejEmBLHASChNDK70dMGPPwWPX5GBAVn5jP/hu17mwYASU3pNa07IaXOouo
         ewrkz/0J2eCGzyKsQP40c+CxXZypTpl8aRYv97fCr8Oe7AyFtd61mBlgpZNhXlNJTNL/
         CygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qkST9yhwhwu10AHBsdYDPDVaDucJkRuGL9XsMxO/Jus=;
        b=QPloE48mrqzkl+uTzrOS24BJXYLINfW3sI9MeyYWjqu6sUCCbNjQP2A4YXq6wnMmwL
         zeAo9AcMHg7XjtnAS09+8HDtU2600vyoXFbp7epMHf0O4J3xxz9OZbxyhy38RDsR20HW
         t5mxerq5R36lRAbc20CNwF9nUCzKXtZYzeHlQrgMrf2LHXmp6mZ+E6TflCyqzYw40IpK
         w11DpmX8iab/AwE+VCc8KoL1Mj6/40QPAHmw85/zDSrVf5y3SNzg7uv41Gg4bMxph0l+
         N4IBUGI2IUVYkrfOdxGZhFwvc9Eit6KbFbiLtJ6zg/qyvklsbtTfRH66sod0v+LOoDTA
         7nYg==
X-Gm-Message-State: APjAAAUmZRV41P8xHFlycc7baTydmHNBJvhwkLQRpAWC4tm+G4+4Nmt0
        Ek1qCKGIpxfBdaWEevdcFCChuy0+Guk=
X-Google-Smtp-Source: APXvYqxr/KAWWKDTvz/rOExJ/s20dCk+w4jw1dGVEhtXOsldTSeDqYqV0IT7fReqQBgvwT5Pbi2b3g==
X-Received: by 2002:aca:3b84:: with SMTP id i126mr3720122oia.28.1571790110917;
        Tue, 22 Oct 2019 17:21:50 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id n4sm901229oic.2.2019.10.22.17.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 17:21:50 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Ashwini Pahuja <ashwini.linux@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] usb: gadget: udc: bdc: Remove unnecessary NULL checks in bdc_req_complete
Date:   Tue, 22 Oct 2019 17:20:15 -0700
Message-Id: <20191023002014.22571-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang + -Wtautological-pointer-compare:

drivers/usb/gadget/udc/bdc/bdc_ep.c:543:28: warning: comparison of
address of 'req->queue' equal to a null pointer is always false
[-Wtautological-pointer-compare]
        if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
                             ~~~~~^~~~~    ~~~~
drivers/usb/gadget/udc/bdc/bdc_ep.c:543:51: warning: comparison of
address of 'req->usb_req' equal to a null pointer is always false
[-Wtautological-pointer-compare]
        if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
                                                    ~~~~~^~~~~~~    ~~~~
2 warnings generated.

As it notes, these statements will always evaluate to false so remove
them.

Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3.0 device controller IP BDC")
Link: https://github.com/ClangBuiltLinux/linux/issues/749
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Note: I am not sure if these checks were intended to check if the
contents of these arrays were NULL or if there should be some other
checks in lieu of these; I am not familiar with the USB subsystem to
answer this but I will happily respin the patch if this is not correct.

 drivers/usb/gadget/udc/bdc/bdc_ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
index a4d9b5e1e50e..d49c6dc1082d 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -540,7 +540,7 @@ static void bdc_req_complete(struct bdc_ep *ep, struct bdc_req *req,
 {
 	struct bdc *bdc = ep->bdc;
 
-	if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
+	if (req == NULL)
 		return;
 
 	dev_dbg(bdc->dev, "%s ep:%s status:%d\n", __func__, ep->name, status);
-- 
2.23.0

