Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A59C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21807206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Gu15yB4S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JiOOrFvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfLCMCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:02:54 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34011 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbfLCMCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:02:51 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 426612238E;
        Tue,  3 Dec 2019 07:02:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=dBjUWt2kgJuEQ
        ixLajR6K5ymul+LldyLVlWi+jU9gCE=; b=Gu15yB4Sy7GB58K1q3i0PMJWpnqoX
        Xi51bwbSGnkCkl1ygTCcBzhO/obbzcJ40UZbYyU2PF3tdSRwUA/5wqIUXR0VJXTV
        FQOhSDtJ6h8Tk2F70XNHChTe1oto3vasDK1CqtaIyu0nbbNosTWgmfd7edRpnpZ7
        jV4gcyIm+Seq1MQs8ArlCh7s6kHWbDnAysG5BBILTOVri7I1HvEAxccYqkP4aBEO
        nN5QHVBeUvBJDkct9zysisxpwSSQnSVCpxzq8mfqtfNWSBG4ZgFxk0NmPverMaKp
        GwLg4F+BOWaBe9llDmDRi+ZmUrFOLWxpWiViL/7YUs3jo69bn9NdC1bkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=dBjUWt2kgJuEQixLajR6K5ymul+LldyLVlWi+jU9gCE=; b=JiOOrFvL
        ib0zt0MfG8kUMKe8CRjg0Y3zOhJWup6vzRlGlfsShrf16lvyxm6ynVyt3YKVFDqs
        D6Ke8IwOc8bGLe3hsEugGJuV0NR2vpg868djMauzH1E5rtM2rguwD0BJGHUIIsjW
        5+HmBRSBX0R9OQzbVtQCIsTK7lJRCF4YdX2/UhKIvUyQh0XOo9w0X7mcJsbf5KuR
        JUooZoXjSWieax3cYsOb2A0EGtriZPiEB2HqO5TDH53RaLgrTSty8wx+k4DGvHHS
        regUm3qltUY9u1o3ZQzJ4snQhxwqLSRqQslUbL9AYjIIhv+aNYAolTZIdXn0nGRJ
        3i2a2jSMUKgxLw==
X-ME-Sender: <xms:607mXRj3jPDC45uNbtSTaYhh4VYwwcKUzVtby0NyZvACzqvFU0ds3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgv
    ficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfkphepudduke
    drvdduuddrledvrddufeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
    jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:607mXaRhH3rIYT__z_RYfofT-puBbiEWW5Gv151FJfncRwHUSkagMA>
    <xmx:607mXUrelm7Fff-hX0olrUnEKuvB0sliP6RFh7JcVPE74RMvNmI71w>
    <xmx:607mXVYyVxIm1WIDU655V6HgP2t1JrUtI053gvP5AdM9e0YX_xs0zw>
    <xmx:607mXaAOcyKA6KazU9jplqMkGy7aV4YB8KeI6NxrjEJL-TT5IE-rVw>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9A811306010D;
        Tue,  3 Dec 2019 07:02:47 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Patrick Venture <venture@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/14] dt-bindings: misc: Document reg for aspeed,p2a-ctrl nodes
Date:   Tue,  3 Dec 2019 22:34:03 +1030
Message-Id: <17ccbf7c6f9f7b81543eabee06d81e137c8759c6.1575369656.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The P2A controller node sits under a syscon device, and can assume
offsets from the base of the syscon based on the compatible. However,
for devicetree correctness allow a reg property to be specified, which
an associated driver may choose to use to discover associated resources.

Cc: Patrick Venture <venture@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
index 0e1fa5bc6a30..f2e2e28b317c 100644
--- a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
+++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
@@ -18,6 +18,7 @@ Required properties:
 Optional properties:
 ===================
 
+- reg: A hint for the memory regions associated with the P2A controller
 - memory-region: A phandle to a reserved_memory region to be used for the PCI
 		to AHB mapping
 
-- 
git-series 0.9.1
