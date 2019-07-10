Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1A0C73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52692081C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8NM9kgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGJCCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:02:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37411 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfGJCCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:02:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so279574pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 19:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ozlntHdL+bOtNT4Ao+TnnUuHHmNF6lXl3Z50ffu07w=;
        b=W8NM9kgbB7xliKIJEKnoVM053v5lDWkRfoaMeuHpmAd6ZCrXem052uVY+7963In31Z
         IBFu0UUcNMZaqsrQ28XjPseQlb0Fq0euCjm68QyY82ha87aMzOs4TjuM/0rvxAPO/+Yq
         Kgv5/tsvBb6X+JUDOBv/zD3a5Xqs/WhtvSdFEoKqX144BxgQD+G3pEGIvxKgor0+7xiF
         0KYpLqJcZ0KFAWryEyauCFsWodJybldYm3+k0nkucj2zLJiK42CtFcTP/4HiXXxqoVz5
         sPv8IxdAWi9dtmVquthytM65LXfhPVZSbzCUaAqORxDIJ6clB2jIumBGY5F2K8kX+ocd
         oJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ozlntHdL+bOtNT4Ao+TnnUuHHmNF6lXl3Z50ffu07w=;
        b=aatKDOzOJpYWFiz0PFJDg5fhxK9fzHRWLcbpg+iXQIO91jrMKcCKS5z1QMmi0N5bWe
         4Dz5cAAw+uTFdsLJOvm4MnP3eAAKJvlz4cu3Uwdw/W0ze5wkkqcLx4QiXLBcbHesCTyN
         rw6Bdi8BGYso1M4utIbHyZqyy4Bb94Gyd/l+zWEGlV2Xnti6Y2DaEiKqkQNA6DM9yVW7
         vS3fb1uEIx2zAjIrZIFlr/ffydiLpxw7jEuDICa2i9chyunlzZUaSGbO9iQr92AKVafW
         ikkvFfGIjVnadOu7F410bCtUbllPbov9xYl+tHO89WSANx3Qk2rkKMcQMRvRSHOrR4ob
         Sh2A==
X-Gm-Message-State: APjAAAXoQ2DNhnIBsRiCvMbeH9jXcuFIi8h+aJAfzDLp1wIPX7QYq0+q
        +f7diFBa33W7ihQ+GsmQ2dE=
X-Google-Smtp-Source: APXvYqyH4iuaZb9I1WmMrypxp2AoldTXAmkmzDe2l43UsFMsM5aA6WPD309XzD6oHM7J1itC5SK4nw==
X-Received: by 2002:a63:f346:: with SMTP id t6mr35149751pgj.203.1562724136460;
        Tue, 09 Jul 2019 19:02:16 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id k22sm337387pfk.157.2019.07.09.19.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 19:02:15 -0700 (PDT)
Date:   Wed, 10 Jul 2019 07:32:08 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Ladislav Michl <ladis@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gen Zhang <blackgod016574@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] sound: soc: codecs: wcd9335: add irqflag
 IRQF_ONESHOT flag
Message-ID: <20190710020208.GA12600@hari-Inspiron-1545>
References: <20190704191026.GA20732@hari-Inspiron-1545>
 <20190705201006.GA22085@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705201006.GA22085@lenoch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 10:10:06PM +0200, Ladislav Michl wrote:
> On Fri, Jul 05, 2019 at 12:40:26AM +0530, Hariprasad Kelam wrote:
> > Add IRQF_ONESHOT to ensure "Interrupt is not reenabled after the hardirq
> > handler finished".
> > 
> > fixes below issue reported by coccicheck
> > 
> > sound/soc/codecs/wcd9335.c:4068:8-33: ERROR: Threaded IRQ with no
> > primary handler requested without IRQF_ONESHOT
> > 
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > ---
> >  sound/soc/codecs/wcd9335.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> > index 85737fe..7ab9bf6f 100644
> > --- a/sound/soc/codecs/wcd9335.c
> > +++ b/sound/soc/codecs/wcd9335.c
> > @@ -4056,6 +4056,9 @@ static struct wcd9335_irq wcd9335_irqs[] = {
> >  static int wcd9335_setup_irqs(struct wcd9335_codec *wcd)
> >  {
> >  	int irq, ret, i;
> > +	unsigned long irqflags;
> > +
> > +	irqflags = IRQF_TRIGGER_RISING | IRQF_ONESHOT;
> 
> Why does this change trigger adding a variable?
Yes variable is not required. Will resend the patch without variable.
> 
> >  	for (i = 0; i < ARRAY_SIZE(wcd9335_irqs); i++) {
> >  		irq = regmap_irq_get_virq(wcd->irq_data, wcd9335_irqs[i].irq);
> > @@ -4067,7 +4070,7 @@ static int wcd9335_setup_irqs(struct wcd9335_codec *wcd)
> >  
> >  		ret = devm_request_threaded_irq(wcd->dev, irq, NULL,
> >  						wcd9335_irqs[i].handler,
> > -						IRQF_TRIGGER_RISING,
> > +						irqflags,
> >  						wcd9335_irqs[i].name, wcd);
> >  		if (ret) {
> >  			dev_err(wcd->dev, "Failed to request %s\n",
> > -- 
> > 2.7.4
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
