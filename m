Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57536C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229B520828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="sA/qvg4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfIHNji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:39:38 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:38911 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbfIHNji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:39:38 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46RC645Zncz1x;
        Sun,  8 Sep 2019 15:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1567949871; bh=8fLQi36Tz+m6T1IGU2o99fMZH+S8E20nfr7PHNk8hXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sA/qvg4jwPtwyQevGJ8HoBbpqi6V3OlDj9+oyTk9ViTFrt42rElsXZe0ZB0KW4Nc2
         F3fjS2Uspan+uk8Kw8qkd9onZTTqRZfnnTC0au7b58hCo21ZZ/GEpi1YP+RG2fnhtw
         z/txiLBQu53JlibSkErrOOifSnY/fxY52OYA+T8h5KrYNVNVu0b9sX45Cgegjfojx7
         34MQ062JrKzcrUVDf42VKcU6B8+yMx9PFEApJdmnCy+awabU9gYKPDdX8YGds0p1ug
         Zf90m1KfXWyWPbu3uoT+S2Gwi66n3HaKQPSZrRR+9TrGqVZmtmidYOInOGW9hUTt6x
         817f0v4Vx3H9A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sun, 8 Sep 2019 15:39:30 +0200
From:   mirq-linux@rere.qmqm.pl
To:     Codrin.Ciubotariu@microchip.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        alexandre.belloni@bootlin.com, arnd@arndb.de, 3chas3@gmail.com,
        gregkh@linuxfoundation.org, perex@perex.cz, lgirdwood@gmail.com,
        Ludovic.Desroches@microchip.com, broonie@kernel.org,
        mark.rutland@arm.com, Nicolas.Ferre@microchip.com,
        robh-dt@kernel.org, tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] ASoC: atmel_ssc_dai: Enable shared FSYNC source
 in frame-slave mode
Message-ID: <20190908133929.GA32003@qmqm.qmqm.pl>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
 <b56ebac96ad232e2d9871067b13654eb9223f28f.1566677788.git.mirq-linux@rere.qmqm.pl>
 <a42ede6e-4cc9-6dbf-4c58-71d2298fd3d5@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a42ede6e-4cc9-6dbf-4c58-71d2298fd3d5@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 03:05:06PM +0000, Codrin.Ciubotariu@microchip.com wrote:
> On 24.08.2019 23:26, Micha³ Miros³aw wrote:
> > SSC driver allows only synchronous TX and RX. In slave mode for BCLK
> > it uses only one of TK or RK pin, but for LRCLK it configured separate
> > inputs from TF and RF pins. Allow configuration with common FS signal.
> > 
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > 
> > ---
> >   v2: use alternate DT binding
> >       split DT and drivers/misc changes
> > 
> > ---
> >   sound/soc/atmel/atmel_ssc_dai.c | 26 ++++++++++++++++++++++----
> >   1 file changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> > index 48e9eef34c0f..035d4da58f2b 100644
> > --- a/sound/soc/atmel/atmel_ssc_dai.c
> > +++ b/sound/soc/atmel/atmel_ssc_dai.c
> > @@ -605,14 +605,32 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
> >   		return -EINVAL;
> >   	}
> >   
> > -	if (!atmel_ssc_cfs(ssc_p)) {
> > +	if (atmel_ssc_cfs(ssc_p)) {
> > +		/*
> > +		 * SSC provides LRCLK
> > +		 *
> > +		 * Both TF and RF are generated, so use them directly.
> > +		 */
> > +		rcmr |=	  SSC_BF(RCMR_START, fs_edge);
> > +		tcmr |=	  SSC_BF(TCMR_START, fs_edge);
> 
> Hmm, how would this work if capture and playback start/run at the same time?

Same as it did before this patch: as there is only one bi-directional link
between SSC and codec, whichever stream starts first defines the rate.

> > +	} else {
> >   		fslen = fslen_ext = 0;
> >   		rcmr_period = tcmr_period = 0;
> >   		fs_osync = SSC_FSOS_NONE;
> > -	}
> >   
> > -	rcmr |=	  SSC_BF(RCMR_START, fs_edge);
> > -	tcmr |=	  SSC_BF(TCMR_START, fs_edge);
> > +		if (ssc->lrclk_from_tf_pin) {
> > +			rcmr |=	  SSC_BF(RCMR_START, SSC_START_TX_RX);
> > +			tcmr |=	  SSC_BF(TCMR_START, fs_edge);
> > +		} else if (ssc->lrclk_from_rf_pin) {
> > +			/* assume RF is to be used when RK is used as BCLK input */
> 
> This comment is not longer true...

Removed for next version.

> 
> > +			/* Note: won't work correctly on SAMA5D2 due to errata */
> > +			rcmr |=	  SSC_BF(RCMR_START, fs_edge);
> > +			tcmr |=	  SSC_BF(TCMR_START, SSC_START_TX_RX);
> > +		} else {
> > +			rcmr |=	  SSC_BF(RCMR_START, fs_edge);
> > +			tcmr |=	  SSC_BF(TCMR_START, fs_edge);
> > +		}
> > +	}
> >   
> >   	if (atmel_ssc_cbs(ssc_p)) {
> >   		/*
> > 
> 
> Thanks and best regards,
> Codrin

Best Regards,
Micha³ Miros³aw
