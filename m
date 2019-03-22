Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5337C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3F821917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfCVAV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 20:21:28 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:55792 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVAV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 20:21:27 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-115-194-nat.elisa-mobile.fi [85.76.115.194])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 3168220072;
        Fri, 22 Mar 2019 02:21:26 +0200 (EET)
Date:   Fri, 22 Mar 2019 02:21:26 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BISECTED, REGRESSION] Broken networking on MIPS/OCTEON EdgeRouter
 Lite
Message-ID: <20190322002125.GD7872@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When booting v5.1-rc1 on EdgeRouter Lite (MIPS/OCTEON), with at803x phy
driver enabled, networking no longer works - I even need to go physically
power cycle the board before getting networking to work again (otherwise
bootloader cannot tftp an older working image).

Bisected to:

	commit 6d4cd041f0af5b4c8fc742b4a68eac22e420e28c
	Author: Vinod Koul <vkoul@kernel.org>
	Date:   Thu Feb 21 15:53:15 2019 +0530

	    net: phy: at803x: disable delay only for RGMII mode

Booting v5.1-rc1 with this commit reverted makes networking to work
fine again.

A.
