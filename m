Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83592C33C9A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5552E206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="GGvhoydV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f8bekuom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLCMDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:03:09 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43379 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbfLCMDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:03:08 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D465223F2;
        Tue,  3 Dec 2019 07:03:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=7tglTbsrzj15B
        FYdwtCNlMSUTM/CZ/wbtl0qCFh3E+0=; b=GGvhoydVUQlN4HGmCxhiL2YtAsL9h
        y6Dq1zMIjxR2CBPg9wCnoRmNLZ8zGprdX41nDxFWaMK8CGcgd7xf8JsGbwjj+Qa9
        1j/rfgvu0KXkD1h9+mf3xppWzfscljlHx4KxWKJN6D0YA1d4Qgsf6viz6O0/jqdk
        4We6S68LN1QI9gcVOKqDvxiuHCIdjZYZjvYfvP+NwdZr6KxcqveQmy7h9kTANje4
        dBzOHMqZZzeSU4T0hcGRcIUFXf6Zv1uwRL+2G68/HRXH0U7STzMi4XxJO5hnapQr
        VwhLOJ3GhJpGOOvogDjZyg8k5gi5NSxjf673boBiMWzoCw7GU2DB8Kvxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=7tglTbsrzj15BFYdwtCNlMSUTM/CZ/wbtl0qCFh3E+0=; b=f8bekuom
        KnsH3MnC4rVm+vWVIp2F0mRuE7fC3DKJhwBGyg3Lsfxbbfs0njAKaSqxYjapVT2z
        nP/S6wK0L7eA5Gh8sdz3cBjh504qBOQS7EGBmWBSILRb7A+sMMVm+NPbcmkak8l/
        DHYqhHOP3jC/f2F0xloFoiGT/WiuPjTC1OIo/DR5NK6JdXyEdQMIp1XNRzHbaC10
        qDkpEnZsWpFjWgJmyosbcJPzNmP6A9W41Z7iXteS/UNqwRt8jIzfbtxunG8LT0Yr
        J64c8XY426w+nfAJzX9BT+JcZINQNp2kTSHJ63LJxe98EwRU4x4wM5gl7aRuKSYl
        OhMrMcAHxUJENQ==
X-ME-Sender: <xms:-07mXTYq7A3QCVF_gcYOC1XYtyuKRs03NnwuB6eJWHhv5RqDU_kzRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgv
    ficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfkphepudduke
    drvdduuddrledvrddufeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
    jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpeeh
X-ME-Proxy: <xmx:-07mXWfA9jEhiNCLRTW9ZDBw8K0wXlO3gwsBsAHgMTBtqNyUt9eRcQ>
    <xmx:-07mXXFbKR50YClm5Ber4YI8gMxD91yvxyYQM9uHA23t-Hh_qnioww>
    <xmx:-07mXTDT12r7upPIc8QFCoKC35KKk2Pr0f4mlzWdHsycdUR2w9_ODA>
    <xmx:-07mXVmWdDtKyOBN_9n3szeI6c3j6HChFNtV4htDM910RSS3WF8OkQ>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4177A30600D2;
        Tue,  3 Dec 2019 07:03:03 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexander Filippov <a.filippov@yadro.com>
Subject: [PATCH 06/14] ARM: dts: vesnin: Add unit address for memory node
Date:   Tue,  3 Dec 2019 22:34:07 +1030
Message-Id: <5542cc20633c5d185262e3acc1ff6a81a6327a34.1575369656.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings:

    arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dt.yaml: /: memory: False schema does not allow {'reg': [[1073741824, 536870912]]}
    arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dt.yaml: memory: 'device_type' is a required property

Cc: Alexander Filippov <a.filippov@yadro.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Alexander Filippov <a.filippov@yadro.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
index affd2c8743b1..c46aec4baec9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
@@ -14,7 +14,7 @@
 		bootargs = "console=ttyS4,115200 earlyprintk";
 	};
 
-	memory {
+	memory@40000000 {
 		reg = <0x40000000 0x20000000>;
 	};
 
-- 
git-series 0.9.1
