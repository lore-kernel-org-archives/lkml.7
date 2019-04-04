Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836C1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B4A2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfDDTrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:47:35 -0400
Received: from gofer.mess.org ([88.97.38.141]:51055 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfDDTrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:47:35 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 1AA0360366; Thu,  4 Apr 2019 20:47:33 +0100 (BST)
Date:   Thu, 4 Apr 2019 20:47:33 +0100
From:   Sean Young <sean@mess.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: stv090x: add missed checks for STV090x_WRITE_DEMOD
Message-ID: <20190404194733.pt7w5qyfs2blq6k3@gofer.mess.org>
References: <20190323024614.14883-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323024614.14883-1-kjlu@umn.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 09:46:13PM -0500, Kangjie Lu wrote:
> Conservatively check return value of STV090x_WRITE_DEMOD in case
> it fails.

This can introduce regressions. It is very possible that the return value
was not checked for a reason. So, this has to be tested on hardware.


Sean

> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/media/dvb-frontends/stv090x.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/stv090x.c b/drivers/media/dvb-frontends/stv090x.c
> index a0622bb71803..3e2af3969e16 100644
> --- a/drivers/media/dvb-frontends/stv090x.c
> +++ b/drivers/media/dvb-frontends/stv090x.c
> @@ -1446,14 +1446,17 @@ static int stv090x_start_search(struct stv090x_state *state)
>  		/* >= Cut 3 */
>  		if (state->srate <= 5000000) {
>  			/* enlarge the timing bandwidth for Low SR */
> -			STV090x_WRITE_DEMOD(state, RTCS2, 0x68);
> +			if (STV090x_WRITE_DEMOD(state, RTCS2, 0x68) < 0)
> +				goto err;
>  		} else {
>  			/* reduce timing bandwidth for high SR */
> -			STV090x_WRITE_DEMOD(state, RTCS2, 0x44);
> +			if (STV090x_WRITE_DEMOD(state, RTCS2, 0x44) < 0)
> +				goto err;
>  		}
>  
>  		/* Set CFR min and max to manual mode */
> -		STV090x_WRITE_DEMOD(state, CARCFG, 0x46);
> +		if (STV090x_WRITE_DEMOD(state, CARCFG, 0x46) < 0)
> +			goto err;
>  
>  		if (state->algo == STV090x_WARM_SEARCH) {
>  			/* WARM Start
> @@ -2604,7 +2607,8 @@ static enum stv090x_signal_state stv090x_get_sig_params(struct stv090x_state *st
>  
>  	if (state->algo == STV090x_BLIND_SEARCH) {
>  		tmg = STV090x_READ_DEMOD(state, TMGREG2);
> -		STV090x_WRITE_DEMOD(state, SFRSTEP, 0x5c);
> +		if (STV090x_WRITE_DEMOD(state, SFRSTEP, 0x5c) < 0)
> +			goto err;
>  		while ((i <= 50) && (tmg != 0) && (tmg != 0xff)) {
>  			tmg = STV090x_READ_DEMOD(state, TMGREG2);
>  			msleep(5);
> @@ -2910,7 +2914,9 @@ static int stv090x_optimize_track(struct stv090x_state *state)
>  			pilots = STV090x_GETFIELD_Px(reg, DEMOD_TYPE_FIELD) & 0x01;
>  			aclc = stv090x_optimize_carloop(state, modcod, pilots);
>  			if (modcod <= STV090x_QPSK_910) {
> -				STV090x_WRITE_DEMOD(state, ACLC2S2Q, aclc);
> +				if (STV090x_WRITE_DEMOD(state, ACLC2S2Q, aclc)
> +						< 0)
> +					goto err;
>  			} else if (modcod <= STV090x_8PSK_910) {
>  				if (STV090x_WRITE_DEMOD(state, ACLC2S2Q, 0x2a) < 0)
>  					goto err;
> @@ -2972,7 +2978,8 @@ static int stv090x_optimize_track(struct stv090x_state *state)
>  	reg = STV090x_READ_DEMOD(state, TMGOBS);
>  
>  	if (state->algo == STV090x_BLIND_SEARCH) {
> -		STV090x_WRITE_DEMOD(state, SFRSTEP, 0x00);
> +		if (STV090x_WRITE_DEMOD(state, SFRSTEP, 0x00) < 0)
> +			goto err;
>  		reg = STV090x_READ_DEMOD(state, DMDCFGMD);
>  		STV090x_SETFIELD_Px(reg, SCAN_ENABLE_FIELD, 0x00);
>  		STV090x_SETFIELD_Px(reg, CFR_AUTOSCAN_FIELD, 0x00);
> -- 
> 2.17.1
