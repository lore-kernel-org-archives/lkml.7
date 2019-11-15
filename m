Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1ABC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73932073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfKOIEy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:04:54 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36083 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfKOIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:04:54 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 63C8FCED16;
        Fri, 15 Nov 2019 09:13:58 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v5 4/4] Bluetooth: hci_bcm: Support pcm params in dts
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191114180959.v5.4.I3e900de9478b68e5e4475e747d1c46fdd28313fa@changeid>
Date:   Fri, 15 Nov 2019 09:04:52 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <139C4D84-3A51-4890-BD2F-995B4A6D57FC@holtmann.org>
References: <20191115021008.32926-1-abhishekpandit@chromium.org>
 <20191114180959.v5.4.I3e900de9478b68e5e4475e747d1c46fdd28313fa@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> BCM chips may require configuration of PCM to operate correctly and
> there is a vendor specific HCI command to do this. Add support in the
> hci_bcm driver to parse this from devicetree and configure the chip.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> Looks like hcitool cmd 0x3f 0x001d will read back the PCM parameters so
> I experimented with different values for sco_routing, interface_rate and
> other values.
> 
> The hardware doesn't care about frame_type, sync_mode or clock_mode (I
> put them all as 0, all as 1, etc). Only the sco_routing seems to have
> a discernable effect on the hardware.
> 
> To avoid complicating this, I opted not to read PCM settings and then
> write back to it. Let the user decide what to write themselves. I've
> opted to add a comment explaining that 0x001d is the read opcode if they
> want to verify it themselves.

actually I would really do it like this:

	1) read params
	2) overwrite values from DT
	2) write params (if transport mode is different)

The advantage with this is that when you have to debug things, then the btmon trace will contain the default values the firmware has. So it is in all trace files all the time. We do that with other parameters as for exactly that reason.

That also means you can drop has_pcm_params variable.

Regards

Marcel

