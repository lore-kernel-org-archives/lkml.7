Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AAECA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CB921D71
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905320;
	bh=vWTVDALXfSb8OlxqgO4QbpSm+6M4srS+UggdwZfZEgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oI/zHxRgxOhB2sPyw7zHce8y4KpAEaRH39KZTK+Nkl2+vcs8jsNTAKjtT8hdQw4K5
	 EIdboB7a89PZHxwsNEB/oYq9TB5BBmTWtkMAE6CHeNL5caBQIcCPFNY1S6Rs0WJqzi
	 fqPLTBiOCSS6mOHQPMOy5rQWkm+l17qfmIr7zER8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389397AbfKDWIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390244AbfKDWIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:08:35 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97CE2214D8;
        Mon,  4 Nov 2019 22:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905315;
        bh=vWTVDALXfSb8OlxqgO4QbpSm+6M4srS+UggdwZfZEgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qr9pUkFh25B2TrnYxWhSd/YMTkhk/h50vX36iUVWHGyQaGgzJluZ2jQ05fUsz8Ksl
         RTe/SbMnhu/8AoMtKCeGyfzKlc76ts9jA2Yx0/7OSjxOQ9XfM03kME9Vmxk290fe3P
         sii7/jI/AabyP6Vjo2tTe2Su3EFMdoWA+cmXkPIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        syzbot+8ab8bf161038a8768553@syzkaller.appspotmail.com
Subject: [PATCH 5.3 104/163] USB: gadget: Reject endpoints with 0 maxpacket value
Date:   Mon,  4 Nov 2019 22:44:54 +0100
Message-Id: <20191104212147.614146677@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit 54f83b8c8ea9b22082a496deadf90447a326954e upstream.

Endpoints with a maxpacket length of 0 are probably useless.  They
can't transfer any data, and it's not at all unlikely that a UDC will
crash or hang when trying to handle a non-zero-length usb_request for
such an endpoint.  Indeed, dummy-hcd gets a divide error when trying
to calculate the remainder of a transfer length by the maxpacket
value, as discovered by the syzbot fuzzer.

Currently the gadget core does not check for endpoints having a
maxpacket value of 0.  This patch adds a check to usb_ep_enable(),
preventing such endpoints from being used.

As far as I know, none of the gadget drivers in the kernel tries to
create an endpoint with maxpacket = 0, but until now there has been
nothing to prevent userspace programs under gadgetfs or configfs from
doing it.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: syzbot+8ab8bf161038a8768553@syzkaller.appspotmail.com
CC: <stable@vger.kernel.org>
Acked-by: Felipe Balbi <balbi@kernel.org>
Link: https://lore.kernel.org/r/Pine.LNX.4.44L0.1910281052370.1485-100000@iolanthe.rowland.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/core.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -98,6 +98,17 @@ int usb_ep_enable(struct usb_ep *ep)
 	if (ep->enabled)
 		goto out;
 
+	/* UDC drivers can't handle endpoints with maxpacket size 0 */
+	if (usb_endpoint_maxp(ep->desc) == 0) {
+		/*
+		 * We should log an error message here, but we can't call
+		 * dev_err() because there's no way to find the gadget
+		 * given only ep.
+		 */
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = ep->ops->enable(ep, ep->desc);
 	if (ret)
 		goto out;


