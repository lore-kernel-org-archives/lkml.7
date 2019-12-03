Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7F4C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC53206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="mvRcSmjJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BKeODkHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLCMCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:02:47 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45143 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbfLCMCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:02:47 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id DD154D04;
        Tue,  3 Dec 2019 07:02:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=ztq7FLHlrns5zu/XcOJ2JlDLPY
        qZhl4Q876ZoCQ+iMU=; b=mvRcSmjJQh0CRMvAcEkW9kerL29X7umeGBKg/+gbPu
        2LoTDXE79vt69JFJbwznqTXvEc7fsEWMmtQAS4KV1ME094Z+gQoBy4oBJ76Qdd7l
        RpzIrgWbLI8ogu6UqBDkAoOqt55DkxOvI2blo8WIWT20GfEsWJ9UopeMd6WaOhG2
        bpbRoiDd2Fay8bbe7wEztgU6z5JIYOC6KRg+7IkfXxN4mfW/ku0LjgtrwfI/KqfK
        Xz4w2IDJa+PPVv4DUFycF7+2HXRR90+/HvRf0xPR1PasF9ypO6ZV8Sf4skCCGwqq
        J2kjnNTyYwjAuO0MMtUKSbtQ9oB0n7aRuN+2+uR1pkDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ztq7FLHlrns5zu/Xc
        OJ2JlDLPYqZhl4Q876ZoCQ+iMU=; b=BKeODkHb4W0FDe04Sxq6J57Op9FbaHVGp
        3FAQX6K5SH+qqo7dNp/xenvGryg8yB7isLaaPXJczEET9KJejDdGyy8qBWCCZNQU
        0jXEBswKRW2Ta41C6Y48NiwyTuULRbfTkOJf0Su/F4/vM1e0eNd8iK+y2GtAhtag
        Jj+grfGA1KJBvUVtXmFEi0PoR+TnA9u8uq9gsaO7w4PI6098oLwpnzkYhPyW00jk
        4WBEP3U55pEbo+6UbQy84nlY+7MleTuSgsK4tTJjGY2PdYTmYsuLGmyOhWc+uxLN
        /Uh2JioCG1Dv5puImHWf+sgNRsezI1ayvQMoaPWyYaeLdnBgkXmdw==
X-ME-Sender: <xms:407mXWaFPcTpZik5e3BkQWVrt8snnAJJrRNX-g_hggdEG8OZV3dxeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddukedrvd
    duuddrledvrddufeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:407mXaXuS35u7D7UWegYnTOzGj9sNKYYUmSsryisssIRuo7Ufnrs1g>
    <xmx:407mXRTghfOJ0UqP0hKAv_PzLbm2Dz4kcgpn6weMCcdgfoW9TTdqeA>
    <xmx:407mXXEqRI_xwvbFpt3JiRbJqP_dtAab5HKNdXWH_zcWMwy4CQfMkw>
    <xmx:5U7mXe_N_BAFOfuorW227HAYtguJjMdZltqXMAzzltXw98SN-bgYbw>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id BF15730600AA;
        Tue,  3 Dec 2019 07:02:36 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, a.filippov@yadro.com,
        anoo@us.ibm.com, chen.kenyy@inventec.com,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        sschaeck@cisco.com, taoren@fb.com, venture@google.com,
        wangzqbj@inspur.com, xow@google.com, yang.brianc.w@inventec.com,
        yao.yuan@linaro.org
Subject: [PATCH 00/14] ARM: dts: aspeed: Cleanup dtc warnings
Date:   Tue,  3 Dec 2019 22:34:01 +1030
Message-Id: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is based on an RFC-ish series I sent quite some time ago to which I
have only just been able to circle back. The previous discussion can be found
here:

https://lore.kernel.org/lkml/20190726053959.2003-1-andrew@aj.id.au/

I've split, shuffled and rebased the series a little, with at least one extra
cleanup for the g6 dtsi. This series is just the devicetree changes, the IPMI
KCS changes will be posted separately shortly.

Combined with the KCS changes we achieve similar stats to the RFC series,
reducing 264 warnings to 6.

I've added each patches' tags from last time, but please glance over them
again.

Cheers,

Andrew

Andrew Jeffery (14):
  dt-bindings: pinctrl: aspeed: Add reg property as a hint
  dt-bindings: misc: Document reg for aspeed,p2a-ctrl nodes
  ARM: dts: aspeed-g5: Move EDAC node to APB
  ARM: dts: aspeed-g5: Use recommended generic node name for SDMC
  ARM: dts: aspeed-g5: Fix aspeed,external-nodes description
  ARM: dts: vesnin: Add unit address for memory node
  ARM: dts: fp5280g2: Cleanup gpio-keys-polled properties
  ARM: dts: swift: Cleanup gpio-keys-polled properties
  ARM: dts: witherspoon: Cleanup gpio-keys-polled properties
  ARM: dts: aspeed: Cleanup lpc-ctrl and snoop regs
  ARM: dts: aspeed: Add reg hints to syscon children
  ARM: dts: aspeed-g5: Sort LPC child nodes by unit address
  ARM: dts: aspeed-g6: Cleanup watchdog unit address
  ARM: dts: ibm-power9-dual: Add a unit address for OCC nodes

 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt            |  1 +
 Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml |  3 +++
 Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml |  3 +++
 arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts                  |  4 ----
 arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts              |  4 ----
 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts                      | 11 +++++++----
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts                        |  4 ----
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts                          |  4 ----
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts                          |  4 ----
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts                            |  6 ------
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts                           |  2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts                      |  6 ------
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts                            |  2 --
 arch/arm/boot/dts/aspeed-g4.dtsi                                      | 21 ++++++++++++---------
 arch/arm/boot/dts/aspeed-g5.dtsi                                      | 49 ++++++++++++++++++++++++++-----------------------
 arch/arm/boot/dts/aspeed-g6.dtsi                                      |  2 +-
 arch/arm/boot/dts/ibm-power9-dual.dtsi                                |  4 ++--
 17 files changed, 56 insertions(+), 74 deletions(-)

base-commit: 3eca037f2dfce07a31da0a837ac35d6d846614b0
-- 
git-series 0.9.1
