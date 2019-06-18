Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E17C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B642080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbfFRXGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:06:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34625 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730908AbfFRXGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 19:06:39 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=lindsey)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1hdNAS-0003iA-Kq; Tue, 18 Jun 2019 23:05:33 +0000
Date:   Tue, 18 Jun 2019 18:05:28 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Gen Zhang <blackgod016574@gmail.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, wen.yang99@zte.com.cn,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wcd9335: fix a incorrect use of kstrndup()
Message-ID: <20190618230527.GE6248@lindsey>
References: <20190529015305.GA4700@zhanggen-UX430UQ>
 <7573d8ce-7160-39b1-8901-be9155c451a1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7573d8ce-7160-39b1-8901-be9155c451a1@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-05 06:57:02, Jiri Slaby wrote:
> On 29. 05. 19, 3:53, Gen Zhang wrote:
> > In wcd9335_codec_enable_dec(), 'widget_name' is allocated by kstrndup().
> > However, according to doc: "Note: Use kmemdup_nul() instead if the size
> > is known exactly."
> 
> Except the size is not known exactly. It is at most 15, not 15. Right?

That's my understanding, as well. This change looks incorrect/misguided
to me.

CVE-2019-12454 was assigned for this but I've requested that MITRE
reject it as there doesn't seem to be any security impact and possibly
no reason at all for this change.

Tyler

> 
> > So we should use kmemdup_nul() here instead of
> > kstrndup().
> > 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > ---
> > diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> > index a04a7ce..85737fe 100644
> > --- a/sound/soc/codecs/wcd9335.c
> > +++ b/sound/soc/codecs/wcd9335.c
> > @@ -2734,7 +2734,7 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
> >  	char *dec;
> >  	u8 hpf_coff_freq;
> >  
> > -	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
> > +	widget_name = kmemdup_nul(w->name, 15, GFP_KERNEL);
> >  	if (!widget_name)
> >  		return -ENOMEM;
> >  
> 
> thanks,
> -- 
> js
> suse labs
