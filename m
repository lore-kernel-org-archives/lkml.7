Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84D7CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888FA20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfKDNys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:54:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:35614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727838AbfKDNys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:54:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8BC7BAC5F;
        Mon,  4 Nov 2019 13:54:46 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: Fix CMA/crashkernel reservation
Date:   Mon,  4 Nov 2019 14:54:10 +0100
Message-Id: <20191104135412.32118-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by Qian Cai[1] the series enabling ZONE_DMA in arm64
breaks CMA/crashkernel reservations on large devices, as it changed its
default placement. After discussing it with Catalin Marinas we're
restoring the old behavior.

The Raspberry Pi 4, being the only device that needs CMA and crashkernel
in ZONE_DMA will explicitly do so trough it's device tree.

[1] https://lkml.org/lkml/2019/10/21/725

---

Nicolas Saenz Julienne (2):
  ARM: dts: bcm2711: force CMA into first GB of memory
  arm64: mm: reserve CMA and crashkernel in ZONE_DMA32

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 19 +++++++++++++++++++
 arch/arm64/mm/init.c                  |  4 ++--
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.23.0

