Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D64C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4E120673
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="babhKa+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfKHROR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:14:17 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:33763 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKHROR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:14:17 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6F442232FE;
        Fri,  8 Nov 2019 18:14:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
        s=mail2016061301; t=1573233255;
        bh=xz7VneuhDNhyAxfNOVJ8pZ6Cwxs/reD73VEhmpLDF3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=babhKa+HTcaMZkgBuuNaR3ZSqe/1/lPEH1pezi5o5Z4QQeJcF0IiBA/fbsFPsFHC9
         paTz4ex+4+eodTwv5AOP1XhGaJ7nNbfys2LItBQVK72GWq0xbOSiZynvO8B01NLG+u
         a2Afb4Mag8fthrFsoaqk/f1PUdgNK2aD4NCV5HRU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 Nov 2019 18:14:15 +0100
From:   Michael Walle <michael@walle.cc>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: wm8904: configure sysclk/FLL automatically
In-Reply-To: <20191108160704.GA10439@ediswmail.ad.cirrus.com>
References: <20191107231548.17454-1-michael@walle.cc>
 <20191108160704.GA10439@ediswmail.ad.cirrus.com>
Message-ID: <1ce127111686a80fe1461d49bac50f86@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.2.3
X-Virus-Scanned: clamav-milter 0.101.4 at web
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2019-11-08 17:07, schrieb Charles Keepax:
> On Fri, Nov 08, 2019 at 12:15:48AM +0100, Michael Walle wrote:
>> This adds a new mode WM8904_CLK_AUTO which automatically enables the 
>> FLL
>> if a frequency different than the MCLK is set.
>> 
>> These additions make the codec work with the simple-card driver in
>> general and especially in systems where the MCLK doesn't match the
>> requested clock.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> +static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>> +			     unsigned int freq, int dir)
>> +{
>> +	struct snd_soc_component *component = dai->component;
>> +	struct wm8904_priv *priv = snd_soc_component_get_drvdata(component);
>> +	unsigned long mclk_freq;
>> +	int ret;
>> +
>> +	switch (clk_id) {
>> +	case WM8904_CLK_AUTO:
>> +		mclk_freq = clk_get_rate(priv->mclk);
>> +		/* enable FLL if a different sysclk is desired */
>> +		if (mclk_freq != freq) {
>> +			priv->sysclk_src = WM8904_CLK_FLL;
>> +			ret = wm8904_set_fll(dai, WM8904_FLL_MCLK,
>> +					     WM8904_FLL_MCLK,
>> +					     clk_get_rate(priv->mclk), freq);
> 
> minor nit, might as well use mclk_freq rather than calling
> clk_get_rate again, other than that though I think this looks
> good.

whoops, I was too tired then. That was the whole intention of using the 
mclk_freq variable.. so yes, I'll fix that.

-michael
