Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116C5C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74892624E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fo0gHtHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE3WBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 18:01:20 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38303 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbfE3WBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 18:01:19 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id A8A7012D0;
        Thu, 30 May 2019 17:41:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 30 May 2019 17:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=d2+Dp3Qj0fsXCsX5yZVzFRkNZR9Uw
        yiUPVU/PPpFWZI=; b=fo0gHtHVQapoYdcUhltjWTs73KQxPdaIakt1qX2Twmhq+
        LZpep/Zmza7sACdDxAQVgQVjPpNQCjrA17lpTwnSfNfC/1Cec6hYsk8tV//ftZ5d
        tCb6UUwJtpDnLHH3C66UJ1dLpqrxvpStrFXy08SD7qmjKKbsqTiF92o5MjxhvN7F
        v7F1I4KgceDFUwmCg/b9J6YERiJ8hbkILKq3hJ2HUuJR1nqWnmpLCm3+SBONL8hU
        gLIExno4lV9DpKRZMTDXN8ZhPeF3WcjMPXTIMBwh/iY/6RqrIVv6y3J/mObHpT5D
        9aKBi7Vy377SYRyPVGmGkiPXulWsOgYoJY3LZPxMg==
X-ME-Sender: <xms:IE7wXBwAC0Hwwx1tvjP_xySIPi-O9fJ19bNllvz_zJsyIbKOyA8Saw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeftddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfggtggusehttdertddttddvnecuhfhrohhmpeeuvghnjhgrmhhi
    nhcuufhhvghrmhgrnhcuoegsvghnjhgrmhhinhessggvnhhshhgvrhhmrghnrdhioheqne
    cukfhppeduvdekrdduudefrddujedruddvvdenucfrrghrrghmpehmrghilhhfrhhomhep
    sggvnhhjrghmihhnsegsvghnshhhvghrmhgrnhdrihhonecuvehluhhsthgvrhfuihiivg
    eptd
X-ME-Proxy: <xmx:IE7wXJh-FWTMkWKWc94swp4aTI2IRRTcWfokEWfTdIwWZXloHdraSw>
    <xmx:IE7wXBPH4G7yvXDy-vg60rb24bHrfpQeSjVm6bQfk02KKIKAXiFKcg>
    <xmx:IE7wXFPxbaPb7rYjAPA4mLfnChsnJLVaLFLlit4lUHrmqtlC6mjZTA>
    <xmx:IE7wXMWLuaK3oRas4RdLqpjU-8bDnip1bnDGUKwcZxN3PRCaCF1tRfgVQs4>
Received: from valkyrie-prime.rpi (el-tovar-33.dynamic2.rpi.edu [128.113.17.122])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1507A8005B;
        Thu, 30 May 2019 17:41:52 -0400 (EDT)
Date:   Thu, 30 May 2019 21:41:43 +0000
From:   Benjamin Sherman <benjamin@bensherman.io>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-dma: sizeof via pointer dereference
Message-ID: <20190530214142.cna6mgdhqgxgaczw@valkyrie-prime.rpi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the size of a struct into kzalloc by pointer dereference.  This
complies with the Linux kernel coding style and removes the possibility
for a bug when the pointer's type is changed.

Signed-off-by: Benjamin Sherman <benjamin@bensherman.io>
---
This is my first patch, so please forgive any seemingly obvious
mistakes.  I apologize if this is the incorrect mailing list.
---
 drivers/staging/mt7621-dma/mtk-hsdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
index a58725dd2611..60db06768c8a 100644
--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -468,7 +468,7 @@ static struct dma_async_tx_descriptor *mtk_hsdma_prep_dma_memcpy(
 	if (len <= 0)
 		return NULL;
 
-	desc = kzalloc(sizeof(struct mtk_hsdma_desc), GFP_ATOMIC);
+	desc = kzalloc(sizeof(*desc), GFP_ATOMIC);
 	if (!desc) {
 		dev_err(c->device->dev, "alloc memcpy decs error\n");
 		return NULL;
-- 
2.21.0

