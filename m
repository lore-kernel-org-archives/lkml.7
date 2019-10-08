Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E50C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06C92190F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="OXOEf1pI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NFbew7aN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfJHLe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:34:26 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35871 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730450AbfJHLeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:34:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6DA6C20C8D;
        Tue,  8 Oct 2019 07:34:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 08 Oct 2019 07:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=POMHwN73ao1VX1XVvng87eUIHu
        egEN2mJo0ATUF+SyY=; b=OXOEf1pIx5XZ0ox5FfAl5t+OYKHLONEym8sqHCQxJ6
        Vo0oe30Ejx09yZwPsas7W9SqOb8oliFwwoVbWhq+pYt439X3uY3uJwvpbLGfUSxb
        ta0z4DcQbl6FqenkmpLZ1cskDxIrpxosWLAo2u6R7FNLVdm0a5Ow2evcdK7WRifu
        SjA1UOXuSm646fZ4jicKeILwaH7fwrD4005YWfhRNRUqFN8ayXObB6dKe4DFTeDF
        9pxp/AsnBTQf6WUJmNOvWHfrl/lkbWApPd0l3GZXv/1GkCVwegOuckvhMzz2Ap1c
        6krOWgtGtX4vSVOYJRImd9RtOwB/4XPvI50bivyEyNgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=POMHwN73ao1VX1XVv
        ng87eUIHuegEN2mJo0ATUF+SyY=; b=NFbew7aNCP9NXA76QE4YKLrHIat/7qMna
        3Bl7XmoCuC8RuOugY2EfJ8q1JKXOJuajWtRoZX8Cy9Dl3GnmOoSi0CMwYi2FuH7i
        pIYMGRn/jcsqS92XFaUqnZ669+hmutHQVUyYRBledc3XvyXd//Est6mIfDdtMsO1
        ECTBampCoEQ+vGo7D8+kdFlqTSu2xAKBnajrPzf+702AlIsQr759IKWg+KvRWWRZ
        P7vLiyTXUbGO2KI7nQ5BRvE3ljX/yc6gN5qIgd8xMPDDDsO0Ww2CpQrfhIETYZik
        VqF5vQHbwv9bajYuMjIiJb12AuvKs3n/Zzs/v0qiCccGSIHr5g4Mg==
X-ME-Sender: <xms:P3ScXTKx9szxQfYf8k00yQS_d5JWZFBaRQufZzxcl9uxnsRDvZn_KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheelgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
    ugdrrghuqeenucfkphepvddtfedrheejrddvudehrddujeeknecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgep
    td
X-ME-Proxy: <xmx:P3ScXZ-iU2Yieq3etzQ-OntBIonjhalisjdnWTwiadUFjNYIU58fCA>
    <xmx:P3ScXXLxOxTvyDiPHqHN2GT1pYlxbFRzWS7D1iocQ3kd4RTvDz5BGQ>
    <xmx:P3ScXX_g8RG_akPyo9xQLnqLi30tDmpkf6eBwEfw0DR1NQySwhWRAg>
    <xmx:QHScXbSDaCra_m8nRs_5Ton2b0jljcgYvhxmGAsJzSorXwzt-vAmvA>
Received: from mistburn.lan (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id 811BBD6005D;
        Tue,  8 Oct 2019 07:34:19 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] clk: aspeed: Expose RMII RCLK gate for MACs 1-2 on AST2500
Date:   Tue,  8 Oct 2019 22:05:21 +1030
Message-Id: <20191008113523.13601-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is two small changes enable kernel support for controlling the RMII
RCLK gate on AST2500-based systems. Previously the kernel has assumed u-boot
has ungated RCLK for networking to function.

RMII is commonly used for NCSI, which itself is commonly used for BMC-based
designs to reduce cabling requirements for the platform.

Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: clock: Add AST2500 RMII RCLK definitions
  clk: aspeed: Add RMII RCLK gates for both AST2500 MACs

 drivers/clk/clk-aspeed.c                 | 27 +++++++++++++++++++++++-
 include/dt-bindings/clock/aspeed-clock.h |  2 ++
 2 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.20.1

