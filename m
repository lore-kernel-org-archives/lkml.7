Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE6DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47E020896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140912;
	bh=PNFazyxEjwb7Gdp52eZKFEcjJtDugp3KrofG+yv+/gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UJpkv2pPP74vvLNosW8fk3XMEs/ExvNsKR/3cw94vOyA3ADaSdgRsRAl6M3Glhy0o
	 zVa0ldd+PgC/QoiHwUeb+v3zqjkyEj6lqTa1VPR/2/omhpgvF32Qp/+0Jsg5ZsTkYu
	 Fy5/DX/Cu6rKl0PiHCqZdmRpqjGr1r/ZsM3aQ3ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfDARa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732784AbfDARay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 890AF2070B;
        Mon,  1 Apr 2019 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139854;
        bh=PNFazyxEjwb7Gdp52eZKFEcjJtDugp3KrofG+yv+/gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2HqnSMcJZTzF9SS6K4ghJK2u4AVAaC4B36Y7rOtajtsMbbbiwgB9VM57oySFASqsD
         CrLVyeGd6Ru2eAwmX8ba7SWlfR0G+RiebBX307qc5HXvHJFq9PCSXd2wsGijR04cyR
         NXZcStq1TIFFYxzO2qFQFwbN9bcyMDgbxupwrzLo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.4 032/131] usb: renesas_usbhs: gadget: fix unused-but-set-variable warning
Date:   Mon,  1 Apr 2019 19:01:42 +0200
Message-Id: <20190401170054.777398553@linuxfoundation.org>
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

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit b7d44c36a6f6d956e1539e0dd42f98b26e5a4684 upstream.

The commit b8b9c974afee ("usb: renesas_usbhs: gadget: disable all eps
when the driver stops") causes the unused-but-set-variable warning.
But, if the usbhsg_ep_disable() will return non-zero value, udc/core.c
doesn't clear the ep->enabled flag. So, this driver should not return
non-zero value, if the pipe is zero because this means the pipe is
already disabled. Otherwise, the ep->enabled flag is never cleared
when the usbhsg_ep_disable() is called by the renesas_usbhs driver first.

Fixes: b8b9c974afee ("usb: renesas_usbhs: gadget: disable all eps when the driver stops")
Fixes: 11432050f070 ("usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/renesas_usbhs/mod_gadget.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -641,14 +641,11 @@ static int usbhsg_ep_disable(struct usb_
 	struct usbhsg_uep *uep = usbhsg_ep_to_uep(ep);
 	struct usbhs_pipe *pipe;
 	unsigned long flags;
-	int ret = 0;
 
 	spin_lock_irqsave(&uep->lock, flags);
 	pipe = usbhsg_uep_to_pipe(uep);
-	if (!pipe) {
-		ret = -EINVAL;
+	if (!pipe)
 		goto out;
-	}
 
 	usbhsg_pipe_disable(uep);
 	usbhs_pipe_free(pipe);


