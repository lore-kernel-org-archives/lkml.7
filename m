Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F67C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5EC217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738423;
	bh=IL+AhAqkgbbrsuckFqFDp5Nf/7BzwpvJH1iwvwBAI3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UFnE4fJRJzZQnjPbMEAOezmOXgk0Zj+UkNSFKmKcBhqCN8hxgeaPj7vnoMEowPqC+
	 ruCc4K060lm1GTeZIdEwFnGxaMTrRRxer7fAxaJMU95mduMD5Zv8t5c5PoEIWOKXtF
	 IFAjUlqaW9easiIHZizqEgptlxr7XT+UK60dZ9cQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391335AbfHBJdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:32978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390432AbfHBJdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:33:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 745822184B;
        Fri,  2 Aug 2019 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738413;
        bh=IL+AhAqkgbbrsuckFqFDp5Nf/7BzwpvJH1iwvwBAI3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fbPrJTNbfMR15d9Qpv+i8cvjo73N4UiuMeIUouN/ZOdHWLQnOsOmEhjig3snPpY6e
         jZnPq5qYxi2EDqESDqPoxbmd3Orjky+tD5HCud/wcy2qvg4tgYHtRIbGFaq/1pUPp9
         K45IzNtppMPjF4pa0gRCFOK+5goSByjS27l2u3xc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 4.4 077/158] gpu: ipu-v3: ipu-ic: Fix saturation bit offset in TPMEM
Date:   Fri,  2 Aug 2019 11:28:18 +0200
Message-Id: <20190802092219.694924228@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Longerbeam <slongerbeam@gmail.com>

commit 3d1f62c686acdedf5ed9642b763f3808d6a47d1e upstream.

The saturation bit was being set at bit 9 in the second 32-bit word
of the TPMEM CSC. This isn't correct, the saturation bit is bit 42,
which is bit 10 of the second word.

Fixes: 1aa8ea0d2bd5d ("gpu: ipu-v3: Add Image Converter unit")

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/ipu-v3/ipu-ic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/ipu-v3/ipu-ic.c
+++ b/drivers/gpu/ipu-v3/ipu-ic.c
@@ -255,7 +255,7 @@ static int init_csc(struct ipu_ic *ic,
 	writel(param, base++);
 
 	param = ((a[0] & 0x1fe0) >> 5) | (params->scale << 8) |
-		(params->sat << 9);
+		(params->sat << 10);
 	writel(param, base++);
 
 	param = ((a[1] & 0x1f) << 27) | ((c[0][1] & 0x1ff) << 18) |


