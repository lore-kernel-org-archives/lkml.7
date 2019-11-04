Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82078CA9ED4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B42521655
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904122;
	bh=r7I7Ejrdfpo/PUppM//zRRCS8J4yVK7fBNePuGo0bGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lXeY4vQmhFsvNxcWL9hygLBs6s30ihYb2ObTGz91rc8xMDNKTXDsTm+hQE1xX0S19
	 KYThcWf0jGdkfX/uK20HcPUI+do8Vn2VI1sKAc6bUjbCnc90HuQrlvBs5iJT/azSfD
	 7beFrYHMG4mtYI62WKUuHFJlbTyukmTLVOIEtab8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfKDVsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbfKDVsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:48:38 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFF8C20B7C;
        Mon,  4 Nov 2019 21:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904118;
        bh=r7I7Ejrdfpo/PUppM//zRRCS8J4yVK7fBNePuGo0bGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVEZ0C3u2a39N2Bj9OcS99eEfUfhnXGgCG6EglaEP2OxXgd1LIgEryEBx/aRVUwnb
         WMzyqNoO26f5pUMf6DyYh0pK0AChz+RVtcxHqQwywljVBIFV0iLUh3jrWiQvPV/quX
         T/J7qOju5AcqApDLJRCKKWvJ3s70SoXp9L3rBVlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        syzbot+8ab8bf161038a8768553@syzkaller.appspotmail.com
Subject: [PATCH 4.4 29/46] USB: gadget: Reject endpoints with 0 maxpacket value
Date:   Mon,  4 Nov 2019 22:45:00 +0100
Message-Id: <20191104211902.213280126@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211830.912265604@linuxfoundation.org>
References: <20191104211830.912265604@linuxfoundation.org>
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
 include/linux/usb/gadget.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -270,6 +270,16 @@ static inline int usb_ep_enable(struct u
 	if (ep->enabled)
 		return 0;
 
+	/* UDC drivers can't handle endpoints with maxpacket size 0 */
+	if (usb_endpoint_maxp(ep->desc) == 0) {
+		/*
+		 * We should log an error message here, but we can't call
+		 * dev_err() because there's no way to find the gadget
+		 * given only ep.
+		 */
+		return -EINVAL;
+	}
+
 	ret = ep->ops->enable(ep, ep->desc);
 	if (ret)
 		return ret;


