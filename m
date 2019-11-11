Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19667C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DC821783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498063;
	bh=+17ehECNh07udlERtfUPO5OuTbHalhbftKl0CqacctQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SPYTmtHz9eYVZ3tCXMixyfjadzz8tbfNAI13Wn5OAIQ2fZQjmpnSB8LgbU0YpLdKS
	 2kx3oof/XlSMaqX5I+g/+Cdolv+Z/S9drTFSQdk2zFf0FeACg4DdUZ8J/jvye6v9Sv
	 haSroGUuIO7GUnYHTCG1tOrDsnTOz+bBcr+Kx/Ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfKKSrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729701AbfKKSrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:47:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8716F21783;
        Mon, 11 Nov 2019 18:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498055;
        bh=+17ehECNh07udlERtfUPO5OuTbHalhbftKl0CqacctQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m1Ie5PD0oQJbHrRMtm8lG/k5+KK65epV+EyUe1xmOxAPughH/Vg7b3dP5RYYCqFQa
         xN8wUv4cnzK5E+VDAx8feePt56MJlyQlgqmaIyH3rZwno59oLbMSZINCtEyLWjYbI5
         zcHAtQM4FvHSZ9+spws6u1Eecx/eCjSaV/QjXLOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 010/193] nfc: netlink: fix double device reference drop
Date:   Mon, 11 Nov 2019 19:26:32 +0100
Message-Id: <20191111181500.678797788@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 025ec40b81d785a98f76b8bdb509ac10773b4f12 ]

The function nfc_put_device(dev) is called twice to drop the reference
to dev when there is no associated local llcp. Remove one of them to fix
the bug.

Fixes: 52feb444a903 ("NFC: Extend netlink interface for LTO, RW, and MIUX parameters support")
Fixes: d9b8d8e19b07 ("NFC: llcp: Service Name Lookup netlink interface")
Signed-off-by: Pan Bian <bianpan2016@163.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/netlink.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -1099,7 +1099,6 @@ static int nfc_genl_llc_set_params(struc
 
 	local = nfc_llcp_find_local(dev);
 	if (!local) {
-		nfc_put_device(dev);
 		rc = -ENODEV;
 		goto exit;
 	}
@@ -1159,7 +1158,6 @@ static int nfc_genl_llc_sdreq(struct sk_
 
 	local = nfc_llcp_find_local(dev);
 	if (!local) {
-		nfc_put_device(dev);
 		rc = -ENODEV;
 		goto exit;
 	}


