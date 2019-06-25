Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF162C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4AF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfFYMEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:04:13 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58629 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfFYMEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:04:13 -0400
X-Originating-IP: 90.88.16.156
Received: from bootlin.com (aaubervilliers-681-1-41-156.w90-88.abo.wanadoo.fr [90.88.16.156])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 107BA60011;
        Tue, 25 Jun 2019 12:04:02 +0000 (UTC)
Date:   Tue, 25 Jun 2019 14:04:12 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com,
        Alan Winkowski <walan@marvell.com>
Subject: Re: [PATCH net v2] net: mvpp2: prs: Don't override the sign bit in
 SRAM parser shift
Message-ID: <20190625140412.7e8c84c4@bootlin.com>
In-Reply-To: <20190620094245.10501-1-maxime.chevallier@bootlin.com>
References: <20190620094245.10501-1-maxime.chevallier@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Thu, 20 Jun 2019 11:42:45 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

>The Header Parser allows identifying various fields in the packet
>headers, used for various kind of filtering and classification
>steps.
>
>This is a re-entrant process, where the offset in the packet header
>depends on the previous lookup results. This offset is represented in
>the SRAM results of the TCAM, as a shift to be operated.
>
>This shift can be negative in some cases, such as in IPv6 parsing.
>
>This commit prevents overriding the sign bit when setting the shift
>value, which could cause instabilities when parsing IPv6 flows.
>
>Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
>Suggested-by: Alan Winkowski <walan@marvell.com>
>Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>---
>V2 : Fix a typo in the commit log, reported by Sergei.

I see that this patch was set as "Accepted" on patchwork, but hasn't
made it to -net, I was wondering if this patch slipped through the
cracks :)

https://patchwork.ozlabs.org/patch/1119311/

Thanks,

Maxime

