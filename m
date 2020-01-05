Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC6CC32767
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 01:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64087215A4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 01:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Yz/15x6b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nhkAjP3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgAEBZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 20:25:01 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38875 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbgAEBYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 20:24:18 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4A79C21B6A;
        Sat,  4 Jan 2020 20:24:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 04 Jan 2020 20:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=GKK6wqE4U1lTliVglqZDNGDO+1
        0THmTKZg0GRYtue70=; b=Yz/15x6bvTrs+8MyRAf6WIx/31jwMPNCmSpJv+UFxI
        O1VQsQW22vxWmN1dVGOPYf2cztd0iMQUqDYp2cMUldC7bys7IgDUb/pE5VZdpdAh
        dOs11XzoLpL2ews0EuE4kMEF+cjZEsG22YJpeyUAS1Gx7w13u4jtotVOxJjPFyej
        cKh5YV80Li8isHROhBxv5g0v5K105YYjS1fL4SyN8uiPV9Z+MipsPHXMqQMYGGaW
        SiPk4JS7jpWztSqyploZBPDfraxQmDBUHDMkc0r3YQphGuhyUiiI5s4gaXi7LuCK
        8O4GTg9gFz0vA15rV0G2AWFn0490N6VzSnN9LMsrin7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=GKK6wqE4U1lTliVgl
        qZDNGDO+10THmTKZg0GRYtue70=; b=nhkAjP3WTI3+wuu1os8CTZAxHbz9OqDDK
        Igi9BZlfz/V5q43owWwXZPpYahvBfyopwkRry6vpC0MjTtYj1o086ScHoHHvLOsT
        uJhLn5RRGHsLWkqJxW3b0aZ5bPRgqm+kXCHHfKmc7JoXNeoS2bUoJOnOPZeLgWuJ
        EWTptDNTSYZkRu0PX72+AFp5EmeU9ntzKEzH1i0KuXBr+EsiBmh+AkGz7BEjHRS3
        0qzbRy0KHGEOL8T3yzOyUQAJEKjESPhOPJP/qcEkLZKZyQOYIz3L+N/gEot9Olg6
        55llBVraOll/ZTuN5MPxKwg5ChjpkyhbHWLKtD/Uxr+p6bGn455gA==
X-ME-Sender: <xms:wDoRXv3MPrtKB6dgPteitwwoMHHxvvSmsNIEGaoZITAjjcLGIQcv-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkphepje
    dtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgv
    lhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:wDoRXhAeDaGg_SDgRU--beqAwqvd0BZrLJBeQExgckxmzBmxh1loAQ>
    <xmx:wDoRXmped2Wrg1Pzl_um9F5bhsBREE9f4DSW3HQgcnQ_Ic0zkaZ7Kg>
    <xmx:wDoRXu_rOFhwIz1f8_hxs0orq7KM4u6xwEHbpDbsBBJB1VnKY8PTaQ>
    <xmx:wToRXlvCI7zTeQTxhlv-uSfv2bESCx2gxbnFgIe1T94OTNe7-4KxNg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id AE0438005C;
        Sat,  4 Jan 2020 20:24:15 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 0/9] X-Powers Power Supply Improvements
Date:   Sat,  4 Jan 2020 19:24:07 -0600
Message-Id: <20200105012416.23296-1-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds some improvements to the axp20x* power supply drivers
to better support suspend/resume and use on mobile devices.

The first two patches fix bugs I found while testing the ONLINE control
added in later patches.

Patches 3 and 7 allow userspace to take the power supplies offline.
Patches 4 and 8 allow userspace to control the wakeup behavior.

Patch 9 avoids polling USB VBUS presence when possible. While working on
the RSB driver, I was seeing ~50 transfers per second, while idle and
tracked it down to this VBUS polling (20 reads/second). The polling
often caused the CPU to clock up and back down, which triggered the
remaining transfers (changes to the CPU voltage).

Unfortunately, I don't see a way to avoid the polling when running on
battery (where it matters most), other than to move the polling back to
the USB PHY driver.

Changes since v1:
 - Add patches 1-2
 - Shift value properly in calls to regmap_update_bits (3, 7)
 - Use #ifdef instead of #if to avoid -Wundef warnings (4, 8)
 - Poll once after an IRQ, instead of setting power->online in the IRQ (9)
 - Poll once on resume, in case the state changed during suspend (9)

Samuel Holland (9):
  mfd: axp20x: Mark AXP20X_VBUS_IPSOUT_MGMT as volatile
  power: supply: axp20x_ac_power: Fix reporting online status
  power: supply: axp20x_ac_power: Allow offlining
  power: supply: axp20x_ac_power: Add wakeup control
  power: supply: axp20x_usb_power: Remove unused device_node
  power: supply: axp20x_usb_power: Use a match structure
  power: supply: axp20x_usb_power: Allow offlining
  power: supply: axp20x_usb_power: Add wakeup control
  power: supply: axp20x_usb_power: Only poll while offline

 drivers/mfd/axp20x.c                    |   2 +-
 drivers/power/supply/axp20x_ac_power.c  | 131 +++++++++++---
 drivers/power/supply/axp20x_usb_power.c | 220 ++++++++++++++++++------
 3 files changed, 276 insertions(+), 77 deletions(-)

-- 
2.23.0

