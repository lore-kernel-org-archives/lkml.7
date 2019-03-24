Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B66EC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285D820830
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553441695;
	bh=cccPEguq+b3oVK+zLsXA1UWNF/mDbmO2UY1N0UrtLxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ubxepKk6q03SOhNZFjaVegJGy1/5Rn+5+Mj1pAdL5VY47SFY/hsuyAxoWS66v+BYU
	 07p5xQkpq0YqyMhW4Vhn42tClmlPuHLY6Gtvtsy9nwuXshdYPoMKbvbXvqNP2jjR4q
	 XTZr6gutAIFpYojJWw7flCb0/qaHRGWuwwxR7Sj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfCXPex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfCXPex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 11:34:53 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E15E2082C;
        Sun, 24 Mar 2019 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553441691;
        bh=cccPEguq+b3oVK+zLsXA1UWNF/mDbmO2UY1N0UrtLxs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JgiX1poMnisuYlkU/h5zQpL5bd1Ui950W9XpbIpdYJytqjRlKcrc2o8wjvgO8KmSu
         7/Z9w4MPdPZXxWftVJ7eiYleAp0ohaxI5ckrS6Jr1zzEPlS2ISjfdZJn8NFw6lqpPb
         1daYtsjgpCih4ioFBqj/mmw1poIVTQLiQGpKLqm0=
Date:   Sun, 24 Mar 2019 15:34:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ssp_sensors: avoid uninitialized variable usage
Message-ID: <20190324153446.7947ef01@archlinux>
In-Reply-To: <20190322150119.GC6521@archlinux-ryzen>
References: <20190322140937.341976-1-arnd@arndb.de>
        <20190322150119.GC6521@archlinux-ryzen>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 08:01:19 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> On Fri, Mar 22, 2019 at 03:09:22PM +0100, Arnd Bergmann wrote:
> > clang points out that 'calculated_time' is only sometimes
> > initialized here, which leads to incorrect data being
> > passed into another function:
> > 
> > drivers/iio/common/ssp_sensors/ssp_iio.c:95:6: error: variable 'calculated_time' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> >         if (indio_dev->scan_timestamp) {
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/iio/common/ssp_sensors/ssp_iio.c:102:9: note: uninitialized use occurs here
> >                                                   calculated_time);
> >                                                   ^~~~~~~~~~~~~~~
> > drivers/iio/common/ssp_sensors/ssp_iio.c:95:2: note: remove the 'if' if its condition is always true
> >         if (indio_dev->scan_timestamp) {
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/iio/common/ssp_sensors/ssp_iio.c:84:25: note: initialize the variable 'calculated_time' to silence this warning
> >         int64_t calculated_time;
> >                                ^
> > The data is subsequently ignored by iio_push_to_buffers_with_timestamp(),
> > but the warning still feels legitimate and to work around it, we can
> > initialize the time in the other case.
> > 
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=18501
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/iio/common/ssp_sensors/ssp_iio.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> > index 645f2e3975db..81e8f4844c90 100644
> > --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
> > +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> > @@ -96,6 +96,8 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
> >  		memcpy(&time, &((char *)buf)[len], SSP_TIME_SIZE);
> >  		calculated_time =
> >  			timestamp + (int64_t)le32_to_cpu(time) * 1000000;
> > +	} else {
> > +		calculated_time = 0;
> >  	}
> >  
> >  	return iio_push_to_buffers_with_timestamp(indio_dev, spd->buffer,
> > -- 
> > 2.20.0
> >   
> 
> I sent a similar change, which is sitting in Jonathan's testing branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=0643039b4fee4aa54a233ead15dc0b2286f059d7
> 
> You made a good point previously that initializing the variable at the
> beginning of a function may not always be the best choice. I don't have
> a personal preference for which patch stays around so:
> 
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Just in case.
> 
> Nathan
I'll stick to the original, mostly to avoid unnecessary churn.
Apologies for the delay in pull requests making these more generally visible.
Always takes me a while to get one out after RC1.  Would imagine these
will go to Greg and hence linux-next sometime in the next week.

Jonathan


