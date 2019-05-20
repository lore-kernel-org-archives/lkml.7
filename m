Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BBBC46460
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA4720656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfETIOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:14:43 -0400
Received: from ns.iliad.fr ([212.27.33.1]:60906 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730549AbfETIOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:14:43 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 4DCA520B5F;
        Mon, 20 May 2019 10:14:41 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 3973020AC3;
        Mon, 20 May 2019 10:14:41 +0200 (CEST)
Subject: Re: [PATCH] clk: qcom: gdsc: WARN when failing to toggle
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190504001736.8598-1-bjorn.andersson@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <68b73077-9fff-9b4c-bf6a-8aca24a814d7@free.fr>
Date:   Mon, 20 May 2019 10:14:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504001736.8598-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon May 20 10:14:41 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2019 02:17, Bjorn Andersson wrote:

> Failing to toggle a GDSC as the driver core is attaching the
> power-domain to a device will cause a silent probe deferral. Provide an
> explicit warning to the developer, in order to reduce the amount of time
> it take to debug this.

"it takes"

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/clk/qcom/gdsc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index dd63aa36b092..6a8a4996dde3 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -149,7 +149,9 @@ static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status)
>  		udelay(1);
>  	}
>  
> -	return gdsc_poll_status(sc, status);
> +	ret = gdsc_poll_status(sc, status);
> +	WARN(ret, "%s status stuck at 'o%s'", sc->pd.name, status ? "ff" : "n");
> +	return ret;

In my opinion, the minor obfuscation of "o%s", foo ? "ff" : "n"
does not justify the tiny space savings.

I'd spell it out: "%s", foo ? "off" : "on"

In any event:

Reviewed-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Regards.
