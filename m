Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6020C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF629207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520208;
	bh=ftMvWzn4IjXn9M6Ibkiy56/cS0YEF3UtTIygOj+2RrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dw6pHbqpV9hjyQe0Gvj0XZ0HsUFSBA1ncFWHLHHdGrNewWZrjJxwsYoDD5ZyDkM52
	 /tbXP5/RYGz5z3J+feExjNnqPC9GbpZ5xZ6K2lkWLXen8txIbc3+3PgpdvalVI0q+R
	 uAPlT+3m+PwqJ+kB1/9nnCcKKXvhJz3Qir9jqP3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfLPSQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:16:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731400AbfLPSQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:16:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D395206E0;
        Mon, 16 Dec 2019 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520205;
        bh=ftMvWzn4IjXn9M6Ibkiy56/cS0YEF3UtTIygOj+2RrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZxJuLcdW4K41F3V86ZiY9G1rSCUvT1DQMVcD2o3WdIeexJax0WlIJXgWCzAIvYp3O
         iC6hFYbxGl90p7OW/1nBbp9W9tCcubwmljwbYqGlGhKK2e5NaAxOdu50lJoyAQBaZ+
         QjOYcxy/S5AQcY63IVZeIOAM9oIR+ATvJ1XrRWe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejas Joglekar <joglekar@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.4 060/177] usb: dwc3: gadget: Fix logical condition
Date:   Mon, 16 Dec 2019 18:48:36 +0100
Message-Id: <20191216174831.445399812@linuxfoundation.org>
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

From: Tejas Joglekar <Tejas.Joglekar@synopsys.com>

commit 8c7d4b7b3d43c54c0b8c1e4adb917a151c754196 upstream.

This patch corrects the condition to kick the transfer without
giving back the requests when either request has remaining data
or when there are pending SGs. The && check was introduced during
spliting up the dwc3_gadget_ep_cleanup_completed_requests() function.

Fixes: f38e35dd84e2 ("usb: dwc3: gadget: split dwc3_gadget_ep_cleanup_completed_requests()")

Cc: stable@vger.kernel.org
Signed-off-by: Tejas Joglekar <joglekar@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2491,7 +2491,7 @@ static int dwc3_gadget_ep_cleanup_comple
 
 	req->request.actual = req->request.length - req->remaining;
 
-	if (!dwc3_gadget_ep_request_completed(req) &&
+	if (!dwc3_gadget_ep_request_completed(req) ||
 			req->num_pending_sgs) {
 		__dwc3_gadget_kick_transfer(dep);
 		goto out;


