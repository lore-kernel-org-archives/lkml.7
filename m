Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D40C5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 09:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A72521670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 09:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfGFJFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 05:05:32 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:51896 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfGFJFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 05:05:32 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jul 2019 05:05:32 EDT
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 2ED7F6069;
        Sat,  6 Jul 2019 11:00:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4_8_IRcTvWRm; Sat,  6 Jul 2019 11:00:20 +0200 (CEST)
Received: from function (dhcp-64-231.ens-lyon.fr [140.77.64.231])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 73E6A6063;
        Sat,  6 Jul 2019 11:00:20 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1hjgYN-0004Wq-Jw; Sat, 06 Jul 2019 11:00:19 +0200
Date:   Sat, 6 Jul 2019 11:00:19 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        Bhagyashri Dighole <digholebhagyashri@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kirk Reiser <kirk@reisers.ca>,
        Okash Khawaja <okash.khawaja@gmail.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: One function call less in
 speakup_win_enable()
Message-ID: <20190706090019.rivposzrqesodhso@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Markus Elfring <Markus.Elfring@web.de>, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org,
        Bhagyashri Dighole <digholebhagyashri@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kirk Reiser <kirk@reisers.ca>,
        Okash Khawaja <okash.khawaja@gmail.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <11f79333-25c3-1ad9-4975-58c64821f3fe@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11f79333-25c3-1ad9-4975-58c64821f3fe@web.de>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Elfring, le sam. 06 juil. 2019 10:15:30 +0200, a ecrit:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 6 Jul 2019 10:03:56 +0200
> 
> Avoid an extra function call by using a ternary operator instead of
> a conditional statement.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/staging/speakup/main.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/speakup/main.c b/drivers/staging/speakup/main.c
> index 488f2539aa9a..03bbc9a4dbb3 100644
> --- a/drivers/staging/speakup/main.c
> +++ b/drivers/staging/speakup/main.c
> @@ -1917,10 +1917,9 @@ static void speakup_win_enable(struct vc_data *vc)
>  		return;
>  	}
>  	win_enabled ^= 1;
> -	if (win_enabled)
> -		synth_printf("%s\n", spk_msg_get(MSG_WINDOW_SILENCED));
> -	else
> -		synth_printf("%s\n", spk_msg_get(MSG_WINDOW_SILENCE_DISABLED));
> +	synth_printf("%s\n", spk_msg_get(win_enabled
> +					 ? MSG_WINDOW_SILENCED
> +					 : MSG_WINDOW_SILENCE_DISABLED));
>  }
> 
>  static void speakup_bits(struct vc_data *vc)
> --
> 2.22.0
> 

-- 
Samuel
--- christ gives channel operator status to Dieu
 -+- #ens-mim and hell -+-
