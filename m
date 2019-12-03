Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B76BC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CF52068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="GaEpkJws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xFPyLaDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLCMgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:36:46 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57873 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbfLCMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:36:45 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9E1836C3C;
        Tue,  3 Dec 2019 07:36:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=SOZUq2rJD0QJ8mJKAc7oPLyCtR
        nzRzApgEKAYYPVX5g=; b=GaEpkJwswsN6B+BGMOIDa5Y6tqbkL7hfWZU0irBbo6
        KG7zMnNrZiKbtXUzRio3ugQJH0Mc8PtKOBg9L2Q8MTDBI94egRoQJYQRgWAfZI38
        QPm94qCHFqNHdh1ijPsAqPMmsD4PGZDea6kbqHqURcKfojeuhpG1DTe452JoCzwd
        UIJZy5ugYhfrRJPnGr5Y3cuA5vZnKUFhps63+HxcNlgXOL6uvUfHK2ML1bPKJq9D
        AZ7HmMaVQypnu6Nno37etiafDus0S/3FMC9WFiixik3hm27Yp5EYU6RP27LaKEGy
        5mC3MX8p5f3AzN1/SktTJpkTlS4x84qn1DoZn3/7Cmlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=SOZUq2rJD0QJ8mJKA
        c7oPLyCtRnzRzApgEKAYYPVX5g=; b=xFPyLaDoMhBRQSvKGkUUA6EiRHXRfh3Zj
        zVnkyYOFS87Q8NUOnirCTnkRn0DCd+vuF2AZO+EncBWI6h/rTVkanfFUQoO9ur2f
        nvLEuOSahNShxbVLUTHd6GD/k58prnFj4VmjtZlLA1HlPOSsSHZ/Qz75TKjuwT0E
        GRHVTMecdCCO6uXxA+u0912m4q9IpCysrr6wC22UOjOQ8WD3EG0bjEN7dfROSll6
        yoGA2e9mDcjOuzpLhMlsEXI58WTGN+ChMX5BXIEY9ybgOJRZTne7oFqtXGvq24W3
        sWejt/OyRnMh3a9NBeyn8wkgxJh40K6bBMVAhx34+mraxSZ0TXVFQ==
X-ME-Sender: <xms:2lbmXS5ZXg7wiN3SZzGBlY9uTCy7VzlWXnir2E-XQkH4LJAtT6DCWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddukedrvd
    duuddrledvrddufeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:2lbmXQAgd4zEB8DN8VWm1DnXLPqX67BYXO7D7CcrvPVy3l1ZKI5LLA>
    <xmx:2lbmXdBfqZgbkxOogcYRNi8dXTx-6YZg5nleIKJN72ruCi4Tm7Hpfw>
    <xmx:2lbmXRYv-WHhjjXQRna92ewaKh7nE9_y4RRpU1NJjpVLi-CdTw0g8Q>
    <xmx:3FbmXZ0J4rAA31er-T2wgfz3nONrmvnaA0EuEKbC8cdyf1hiuyqxmw>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0E6363060158;
        Tue,  3 Dec 2019 07:36:37 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net
Cc:     minyard@acm.org, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ipmi: kcs-bmc: Rework bindings to clean up DT warnings
Date:   Tue,  3 Dec 2019 23:08:22 +1030
Message-Id: <cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a short series reworking the devicetree binding and driver for the
ASPEED BMC KCS devices. With the number of supported ASPEED BMC devicetrees the
changes enable removal of more than 100 lines of warning output from dtc.

These changes are extracted from an RFC series posted previously, which can be
found here:

https://lore.kernel.org/lkml/20190726053959.2003-1-andrew@aj.id.au/

Haiyue has already reviewed the driver patches in that thread so the re-posting
carries his tags. Since the original series the patches have been rebased on
top of char-misc/master with no further changes. However, please take a look to
make sure the patches are still sane.

Cheers,

Andrew

Andrew Jeffery (3):
  dt-bindings: ipmi: aspeed: Introduce a v2 binding for KCS
  ipmi: kcs: Finish configuring ASPEED KCS device before enable
  ipmi: kcs: aspeed: Implement v2 bindings

 Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt |  20 +-
 drivers/char/ipmi/kcs_bmc_aspeed.c                        | 151 +++++--
 2 files changed, 139 insertions(+), 32 deletions(-)

base-commit: 937d6eefc716a9071f0e3bada19200de1bb9d048
-- 
git-series 0.9.1
