Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE14C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F141B20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139833;
	bh=B7Vavaj4UgWMi1yricBuHqKZyPEVxHCxBxAt8Cvw6nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tksD24nDbfsrILXH1eQujgQKUttA7N6w1GNc9sdYgNN4JZXG+bUkeCqWsL4bHc7MM
	 5HQ8z1E2GdvJI3BqQw5E52K17hD3gV0xK8xgMNfitdh6WfaZH4gwGmFkF6ewFu6+iG
	 2rOZYE08ViB+SdhI3SoZUml0sSLwOx0AFkyRTs68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbfDARac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbfDARaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2348020856;
        Mon,  1 Apr 2019 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139829;
        bh=B7Vavaj4UgWMi1yricBuHqKZyPEVxHCxBxAt8Cvw6nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QV9aMJMw9nhHIntCiJy/C04afVSGMktSM2bPaJ9bB+zrfEWVw4qBTpY3juH9wYwBC
         nEVG59r58BSvx9hBZ3pFpwrXVhEXA70hW3U6pkeqe8m1UXUT1TdT/EZ6Rdb+RicmU8
         XznhtcZ1FUJGgkyPBwLP4o4xFVUYaQ2zpLum8128=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 026/131] usb: gadget: composite: fix dereference after null check coverify warning
Date:   Mon,  1 Apr 2019 19:01:36 +0200
Message-Id: <20190401170054.221283336@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Chen <peter.chen@nxp.com>

commit c526c62d565ea5a5bba9433f28756079734f430d upstream.

cdev->config is checked for null pointer at above code, so cdev->config
might be null, fix it by adding null pointer check.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/composite.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1819,6 +1819,8 @@ unknown:
 			break;
 
 		case USB_RECIP_ENDPOINT:
+			if (!cdev->config)
+				break;
 			endp = ((w_index & 0x80) >> 3) | (w_index & 0x0f);
 			list_for_each_entry(f, &cdev->config->functions, list) {
 				if (test_bit(endp, f->endpoints))


