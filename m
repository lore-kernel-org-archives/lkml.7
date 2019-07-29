Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBD1C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC032070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Dw6PonkA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oj2LF3sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfG2F4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 01:56:23 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:57201 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbfG2F4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:56:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 59A6C128B;
        Mon, 29 Jul 2019 01:56:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Jul 2019 01:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=HZcia/IfVzkvd
        lkvnb5LKV31CBZHUGSpuuBvYoxo1kk=; b=Dw6PonkAQzMpPGOlYMlzy6fMIWPO7
        NELN9tBaFrE/4vuMZoeuTXrYhxFVhRDnU+GFTUZrpMrCwHeaSdCoDkiiH59nmakZ
        1/1xMrSQ8kOyDdbVqiSpsIFwZiaglSu9mkKD99jPprOapaEGAaKiieSJ3BcDuj7i
        HTAi62HC7gzZC/tev582lmkc8QrwGtOWdqRO0VzNXmIkutKR4BMFiihAN7MZMi1E
        bUMn+ocPwSTG7vq/fvr9ZYQctNnaqgufhSAp58046F4W8DhvgPkC0D7YaA6CqZCv
        Iq+mQBiFJHYimvillMTtaCFTHUyLo+JpAQGtokI7vZXsiEWMxnaGTKPkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=HZcia/IfVzkvdlkvnb5LKV31CBZHUGSpuuBvYoxo1kk=; b=Oj2LF3sh
        4eXv9FGk77JYK9ecw4TdDwMcY07FVd/1XQ/hg1KC0vg3YIYsBo1p3Ce/XaYjW9Tr
        N2TU9llPZNRfmIEj9jhGONdUrEfqkjsJVPnygHCz+7cZPB+b9gs4LDchZ+je9mmf
        hJbLBfjAlo+QZ8d1a9I3gFMnNpVfREsHwh+ubUx5fLz5nMPw++IqRTay6GZitvI8
        TcRWpQ5d2uGoyAuD6wdl4YqKOSstVK1G2rK2kW9jXn92k31OsIdyJjwpCjyxwJd7
        a9zD9h1VnuzxyZXqYlZDIT73qGUM1sysXfcWJkdPkND5LddUYvtiNoQBjBtTL8Bt
        n8q4SfkfMaxgAg==
X-ME-Sender: <xms:hYo-XbWC8Zawu7lwSu9fOZAjwO3uC1ibYGUcOGF64JfuW6bYec2L9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrledtgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecukfhppedvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrg
    hilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigv
    peef
X-ME-Proxy: <xmx:hYo-XRiO-dyPOXd2LHbsXvBR-E-PzMkPl5q9PEtXWXlcO0lqVYL-LQ>
    <xmx:hYo-Xe-N0QP6WER8tuq5aieHNppmoUYFWW86TpcSAGayTZl6r8Ctsw>
    <xmx:hYo-XTAUqp09CWwdx5x72Wv6NoYGMEnI_GS0rfgCRIAhzBq8KVA8Gg>
    <xmx:hYo-XWtGUQ13A45zMMTOV49YyjjWmLEuksPLZNpNZ7rsfz6K3w_5vw>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6CD7B80060;
        Mon, 29 Jul 2019 01:56:17 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-gpio@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        ryanchen.aspeed@gmail.com, johnny_huang@aspeedtech.com,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] pinctrl: aspeed: Add SIG_DESC_CLEAR() helper
Date:   Mon, 29 Jul 2019 15:26:03 +0930
Message-Id: <20190729055604.13239-6-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190729055604.13239-1-andrew@aj.id.au>
References: <20190729055604.13239-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The complement of SIG_DESC_SET().

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinmux-aspeed.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.h b/drivers/pinctrl/aspeed/pinmux-aspeed.h
index 474820df6263..c59e936a7dde 100644
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
@@ -508,6 +508,7 @@ struct aspeed_pin_desc {
  * @idx: The bit index in the register
  */
 #define SIG_DESC_SET(reg, idx) SIG_DESC_IP_BIT(ASPEED_IP_SCU, reg, idx, 1)
+#define SIG_DESC_CLEAR(reg, idx) SIG_DESC_IP_BIT(ASPEED_IP_SCU, reg, idx, 0)
 
 #define SIG_DESC_LIST_SYM(sig, group) sig_descs_ ## sig ## _ ## group
 #define SIG_DESC_LIST_DECL(sig, group, ...) \
-- 
2.20.1

