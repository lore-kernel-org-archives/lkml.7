Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9268BC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6C720644
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Nj95LxDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfHAJhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:37:33 -0400
Received: from onstation.org ([52.200.56.107]:49252 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHAJhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:37:33 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id AEA9D3E910;
        Thu,  1 Aug 2019 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1564652252;
        bh=bSREQHe0K6R3ACsHI8onhePS75HmOgPd/6TZve63MgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nj95LxDaFriwiQaSAsOJb7M1D+sCBezKlRMBw0ZBe3WQ1vgmtEF6M1lVy5yBF385X
         NThk1/24wo/YdDGOnvl2OnZ67NcOi7SsYZcJqDrH3ZNUo0UofDMgAYJC0vq9YvIoA3
         8ZZhEZ7KfNsuLfSx6EeRvavP5EE2Rlobb1uijBro=
Date:   Thu, 1 Aug 2019 05:37:31 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] iio: tsl2772: Use devm_add_action_or_reset
Message-ID: <20190801093731.GC27653@onstation.org>
References: <20190801073557.9578-1-hslester96@gmail.com>
 <20190801093347.GA27653@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801093347.GA27653@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 05:33:47AM -0400, Brian Masney wrote:
> On Thu, Aug 01, 2019 at 03:35:57PM +0800, Chuhong Yuan wrote:
> > Use devm_add_action_or_reset to remove the call to
> > tsl2772_disable_regulators_action to simplify the error path.
> > 
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> 
> For the whole series:
> 
> Reviewed-by: Brian Masney <masneyb@onstation.org>

Oops, I forgot to add this as well:

Tested-by: Brian Masney <masneyb@onstation.org>

I tested this on a Nexus 5 phone.

Brian


> 
> I forgot to mention this before, but next time please use a cover letter
> if you're sending more than one patch: git format-patch --cover-letter.
> 
> Brian
> 
> 
> > ---
> > Changes in v4:
> >   - Split v3 into three patches.
> >   - Revise description to make it more precise.
> > 
> >  drivers/iio/light/tsl2772.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > index 83cece921843..29cfd8ae2700 100644
> > --- a/drivers/iio/light/tsl2772.c
> > +++ b/drivers/iio/light/tsl2772.c
> > @@ -1807,10 +1807,10 @@ static int tsl2772_probe(struct i2c_client *clientp,
> >  		return PTR_ERR(chip->vdd_supply);
> >  	}
> >  
> > -	ret = devm_add_action(&clientp->dev, tsl2772_disable_regulators_action,
> > -			      chip);
> > +	ret = devm_add_action_or_reset(&clientp->dev,
> > +					tsl2772_disable_regulators_action,
> > +					chip);
> >  	if (ret < 0) {
> > -		tsl2772_disable_regulators_action(chip);
> >  		dev_err(&clientp->dev, "Failed to setup regulator cleanup action %d\n",
> >  			ret);
> >  		return ret;
> > -- 
> > 2.20.1
