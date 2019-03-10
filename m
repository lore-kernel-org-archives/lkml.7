Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC985C10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 09:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8052E2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 09:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552210667;
	bh=Q7DkCHbLhMEzIxCOgMSvMJCtt2Hgmqeo9pGt8L2qikY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=F2Jv2a8VDMsHervqKMuGdtztjHvOjajAZ+FZC8Ygy+oY/xyolZs7NKjDEcTSgD8L7
	 1mYCotSLDFZtOaCBPNCg4yy3evOC1u/35bhsf+x8iNv0Umm8T6LHSCG9RVL+C1DgQh
	 BqICkhMq+yRfeOGHu1j8IHsECWjZf8jzKwdOpTG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfCJJhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 05:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfCJJhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 05:37:45 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44752206BA;
        Sun, 10 Mar 2019 09:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552210664;
        bh=Q7DkCHbLhMEzIxCOgMSvMJCtt2Hgmqeo9pGt8L2qikY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GiWn1jcQcqkJspJnXAZd+qXsNyAE3nZB0ahWQkw11c1UPQXtF1bmxn5bFVy4+Vo4q
         asiX1RUT4lEDHw6JfmFEr9N7v9TMr8hCBU5mnk8kQy+Ce33Yz1phvfSgv7RBvxbPWh
         h62FGDAeCVxTNDq+i4MCBxefL0FtnIh8J7tZwj2E=
Date:   Sun, 10 Mar 2019 09:37:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] iio: common: ssp_sensors: Initialize calculated_time in
 ssp_common_process_data
Message-ID: <20190310093738.72c1019b@archlinux>
In-Reply-To: <CAKwvOdkeVmcoD7WusKE83MmRjX+h73rnHDY=Rn_a7LXsULPsrw@mail.gmail.com>
References: <20190307214546.9624-1-natechancellor@gmail.com>
        <CAKwvOdkeVmcoD7WusKE83MmRjX+h73rnHDY=Rn_a7LXsULPsrw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019 16:35:26 -0800
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Thu, Mar 7, 2019 at 1:46 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When building with -Wsometimes-uninitialized, Clang warns:
> >
> > drivers/iio/common/ssp_sensors/ssp_iio.c:95:6: warning: variable
> > 'calculated_time' is used uninitialized whenever 'if' condition is false
> > [-Wsometimes-uninitialized]
> >
> > While it isn't wrong, this will never be a problem because
> > iio_push_to_buffers_with_timestamp only uses calculated_time
> > on the same condition that it is assigned (when scan_timestamp
> > is not zero). While iio_push_to_buffers_with_timestamp is marked
> > as inline, Clang does inlining in the optimization stage, which
> > happens after the semantic analysis phase (plus inline is merely
> > a hint to the compiler).
> >
> > Fix this by just zero initializing calculated_time.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/394
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>  
> 
> Knowing that the same invariant holds across function boundaries to
> protect access of unitialized values and thus undefined behavior
> sounds tricky to diagnose accurately.  Thanks for the patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Note this is going to be a while before it hits mainline but as
it is a false (if reasonable!) warning I'm not going to rush
it in as a fix.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/common/ssp_sensors/ssp_iio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> > index 645f2e3975db..e38f704d88b7 100644
> > --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
> > +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> > @@ -81,7 +81,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
> >                             unsigned int len, int64_t timestamp)
> >  {
> >         __le32 time;
> > -       int64_t calculated_time;
> > +       int64_t calculated_time = 0;
> >         struct ssp_sensor_data *spd = iio_priv(indio_dev);
> >
> >         if (indio_dev->scan_bytes == 0)
> > --
> > 2.21.0
> >  
> 
> 

