Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33C9C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B313421E73
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbfHGNgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:36:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36547 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388185AbfHGNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:36:15 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hvM6t-0004Mp-Kl; Wed, 07 Aug 2019 15:36:11 +0200
Message-ID: <1565184971.5048.8.camel@pengutronix.de>
Subject: Re: [PATCH] firmware: arm_scmi: Use {get,put}_unaligned_le32
 accessors
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 07 Aug 2019 15:36:11 +0200
In-Reply-To: <20190807130038.26878-1-sudeep.holla@arm.com>
References: <20190807130038.26878-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Wed, 2019-08-07 at 14:00 +0100, Sudeep Holla wrote:
> Instead of type-casting the {tx,rx}.buf all over the place while
> accessing them to read/write __le32 from/to the firmware, let's use
> the nice existing {get,put}_unaligned_le32 accessors to hide all the
> type cast ugliness.
> 
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/base.c    |  2 +-
>  drivers/firmware/arm_scmi/clock.c   | 10 ++++------
>  drivers/firmware/arm_scmi/common.h  |  2 ++
>  drivers/firmware/arm_scmi/perf.c    |  8 ++++----
>  drivers/firmware/arm_scmi/power.c   |  6 +++---
>  drivers/firmware/arm_scmi/reset.c   |  2 +-
>  drivers/firmware/arm_scmi/sensors.c | 12 +++++-------
>  7 files changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> index 204390297f4b..f804e8af6521 100644
> --- a/drivers/firmware/arm_scmi/base.c
> +++ b/drivers/firmware/arm_scmi/base.c
[...]
> @@ -204,14 +204,12 @@ scmi_clock_rate_get(const struct scmi_handle *handle, u32 clk_id, u64 *value)
>  	if (ret)
>  		return ret;
>  
> -	*(__le32 *)t->tx.buf = cpu_to_le32(clk_id);
> +	put_unaligned_le32(clk_id, t->tx.buf);
>  
>  	ret = scmi_do_xfer(handle, t);
>  	if (!ret) {
> -		__le32 *pval = t->rx.buf;
> -
> -		*value = le32_to_cpu(*pval);
> -		*value |= (u64)le32_to_cpu(*(pval + 1)) << 32;
> +		*value = get_unaligned_le32(t->rx.buf);
> +		*value |= (u64)get_unaligned_le32(t->rx.buf + 1) << 32;

Isn't t->rx.buf a void pointer? If I am not mistaken, you'd either have
to keep the pval local variables, or cast to (__le32 *) before doing
pointer arithmetic.

regards
Philipp
