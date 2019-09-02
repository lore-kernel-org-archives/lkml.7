Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE40C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA6621744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="P43FNnVV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M4O7CtZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfIBD6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 23:58:34 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39043 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729262AbfIBD6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:58:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 55F68450;
        Sun,  1 Sep 2019 23:58:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 01 Sep 2019 23:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=VOhxFTWTuM9H7gkE9KIxVk25DQ
        HvnKDRBG22VpBaBTk=; b=P43FNnVVOEKNv88pzmb3bOZUHWeyQoYdI1AoKBjVdB
        TdxNrnGwYGYbduKGDI9SIWCgaDdBPB4KG9jO0JEcrnRCvQGk7kSOQGvcLnLk4XaQ
        icv7rsibFF/uCFB2ZCElaHJwSmCTVrGtC8SnM8TjuASdG5vy0efTdNH/qQznoXxj
        yd+Z4vYnFWujXCxPV8D6yd2M7vjgDU/kPBsJ3PAFdrb9XlALhhLSPxZ1rOpxehwM
        KG6XAOCt1MxhTu+2NvpKnal3TI6FpVFVKup5N4djy+aFhUlBagrLfU4R15+uq+po
        /WDZyR0MC9u3XKEQbrkC41t9id+NvjimqproakzhudzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=VOhxFTWTuM9H7gkE9
        KIxVk25DQHvnKDRBG22VpBaBTk=; b=M4O7CtZgl7CiZ1eZxNunF1QDxcoK+NCco
        zZ31zPogfbN4hWLaj+giE676uz5QE9ofB/qOCWZx/0DIVtkOWeC4ACXtY7YENYWb
        OrfQrc65w3PyOD4sE3bV0AiNQfEWccvhxHaqKwqWLBnmnj5NeXBF/06PjzhLhZQY
        fiFVgchuUAOJKcLqgxoHcZm+AIkdvEqnVYIfjSR89yGStBFEkmZlQHmymDkDYn7w
        cqE3afsKqULm6zb/I2/0UBE7DrJT6TBMmj6inl53YQTd/ExF9SC8bomceixDaMT4
        dhTP2U3xP/oUv5PkhiAGgEuma3Lk21MDonGUSJ1j70ikXu7iWTooA==
X-ME-Sender: <xms:ZpNsXc4-9rPpjL6EU5z5fM45aUfJygf5eFZrZaeAtTnDV8Z7udLvnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeiledgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkphepvddtfedrhe
    ejrddvudehrddujeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
    rdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ZpNsXUDWXAHMsiHghKSHf4TvOXSJaV_VJ_JdZf5SomVEAeBnqFwdCg>
    <xmx:ZpNsXRBhwKpdfpWPt1XJqB26YT9qLR-uDNqHQGzsYKri78hwGYw1ww>
    <xmx:ZpNsXUhRAyye0gQ4KbJleMGzGaYTqq-M1uwg00YUWXWrlseoy8EMvg>
    <xmx:Z5NsXTICKl4Q4SRnUGTLlqTnK6mziYfelRGIwxdMsuiN5g71zRzytQ>
Received: from localhost.localdomain (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F85CD60068;
        Sun,  1 Sep 2019 23:58:26 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, joel@jms.id.au, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] mmc: sdhci-of-aspeed: Fixes for AST2600 eMMC support
Date:   Mon,  2 Sep 2019 13:28:38 +0930
Message-Id: <20190902035842.2747-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've added a couple of patches since v1 of this series. The horizon has
broadened slightly with a fix for SPARC builds as well in patch 1/4. Ulf
suggested a minor cleanup on v1 with respect to handling of the current clock
value, so that's now patch 2/4. Patches 3/4 and 4/4 are as they were in v1.

The v1 series can be found here:

https://patchwork.ozlabs.org/cover/1155757/

Please review!

Andrew

Andrew Jeffery (4):
  mmc: sdhci-of-aspeed: Fix link failure for SPARC
  mmc: sdhci-of-aspeed: Drop redundant assignment to host->clock
  mmc: sdhci-of-aspeed: Uphold clocks-on post-condition of set_clock()
  mmc: sdhci-of-aspeed: Allow max-frequency limitation of SDCLK

 drivers/mmc/host/sdhci-of-aspeed.c | 62 ++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 20 deletions(-)

-- 
2.20.1

