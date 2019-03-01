Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CD4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA26520851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbfCAPEQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:04:16 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:54752 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387861AbfCAPEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:04:11 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 3267615632; Fri,  1 Mar 2019 15:04:09 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Jeroen Hofstee <jhofstee@victronenergy.com>
Cc:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: ti_hecc: fix close when napi poll is active
References: <1523132500-26070-1-git-send-email-jhofstee@victronenergy.com>
Date:   Fri, 01 Mar 2019 15:04:09 +0000
In-Reply-To: <1523132500-26070-1-git-send-email-jhofstee@victronenergy.com>
        (Jeroen Hofstee's message of "Sat, 7 Apr 2018 22:21:39 +0200")
Message-ID: <yw1xef7q63h2.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeroen Hofstee <jhofstee@victronenergy.com> writes:

> When closing this CAN interface while napi poll is active, for example with:
> `ip link set can0 down` several interfaces freeze. This seemed to be caused
> by napi_disable called from ti_hecc_close expecting the scheduled probe to
> either return quota or call napi_complete. Since the poll functions has a
> check for netif_running it returns 0 and doesn't call napi_complete and hence
> violates the napi its expectation.
>
> So remove this check, so either napi_complete is called or quota is returned.
>
> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
> ---
>  drivers/net/can/ti_hecc.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
> index db6ea93..42813d3 100644
> --- a/drivers/net/can/ti_hecc.c
> +++ b/drivers/net/can/ti_hecc.c
> @@ -603,9 +603,6 @@ static int ti_hecc_rx_poll(struct napi_struct *napi, int quota)
>  	u32 mbx_mask;
>  	unsigned long pending_pkts, flags;
>
> -	if (!netif_running(ndev))
> -		return 0;
> -
>  	while ((pending_pkts = hecc_read(priv, HECC_CANRMP)) &&
>  		num_pkts < quota) {
>  		mbx_mask = BIT(priv->rx_next); /* next rx mailbox to process */
> -- 
> 2.7.4

This seems to have been lost or forgotten.

-- 
Måns Rullgård
