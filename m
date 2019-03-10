Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC48C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 09:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C61420870
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 09:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552211168;
	bh=OVB2k/NWWavwDhadOBIAMAJzLTgj8jcNf58kwfzmhnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CJNLDj78SLpOOnwvNAYLZ+Dayqj1qHXCAa6k2zh/L0G5KiL3Wutd2pSec1dtwcygi
	 y4tCJOh5NCnsiEXAe9IgKv34jNEpZFJr3mGQWsQ14uzoMY4KIltJr/x5nijdqBIYrd
	 JrmNDxBwo0lZd9KxryiVhZKnunEDPtQmoI0WlNnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfCJJqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 05:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfCJJqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 05:46:04 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC9120657;
        Sun, 10 Mar 2019 09:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552211163;
        bh=OVB2k/NWWavwDhadOBIAMAJzLTgj8jcNf58kwfzmhnU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fObSizwsq4IwmHClFG15DgBnTs/mCy2jV8jx0OXf4Be8jp9YdvLaRAikCjA9c2Buc
         oZsc4aepsyZzDzHBYlh3YV3v844zQmjfUHu4nmwaMaoyCe9GvTlgbw98r/xxspNwgS
         l/T0O0MMFRVAgzsBWS+xZskmBZ8v9luKkpd4yVcA=
Date:   Sun, 10 Mar 2019 09:45:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stefan Agner <stefan@agner.ch>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] iio: adc: stmpe-adc: Shuffle an if statement around in
 stmpe_adc_isr
Message-ID: <20190310094556.3ae7c5fa@archlinux>
In-Reply-To: <CAKwvOdn4s_BdBPtOSyeQfRE+PCQLpDgm9VSkSR6eBkrBp_GhrA@mail.gmail.com>
References: <20190307171604.27791-1-natechancellor@gmail.com>
        <CAKwvOdn4s_BdBPtOSyeQfRE+PCQLpDgm9VSkSR6eBkrBp_GhrA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019 10:31:55 -0800
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Thu, Mar 7, 2019 at 9:16 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When building with -Wsometimes-uninitialized, Clang warns:
> >
> > drivers/iio/adc/stmpe-adc.c:204:13: warning: variable 'data' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> >
> > Clang can't tell that data will never be used uninitialized because the
> > two if statements take care of all cases. Remove the first if statement
> > and make it the else branch of the second one so that it is apparent to
> > Clang that all cases are covered.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/387
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>  
> 
> LGTM, thanks Nathan.
> Reviewed-by: NIck Desaulniers <ndesaulniers@google.com>
Agreed. Seems obviously correct.  Stefan, I'm only pushing this out as
testing for now so happy to rebase if you have comments.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/adc/stmpe-adc.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> > index 37f4b74a5d32..7921f827c6ec 100644
> > --- a/drivers/iio/adc/stmpe-adc.c
> > +++ b/drivers/iio/adc/stmpe-adc.c
> > @@ -184,9 +184,6 @@ static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
> >         struct stmpe_adc *info = (struct stmpe_adc *)dev_id;
> >         u16 data;
> >
> > -       if (info->channel > STMPE_TEMP_CHANNEL)
> > -               return IRQ_NONE;
> > -
> >         if (info->channel <= STMPE_ADC_LAST_NR) {
> >                 int int_sta;
> >
> > @@ -205,6 +202,8 @@ static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
> >                 /* Read value */
> >                 stmpe_block_read(info->stmpe, STMPE_REG_TEMP_DATA, 2,
> >                                 (u8 *) &data);
> > +       } else {
> > +               return IRQ_NONE;
> >         }
> >
> >         info->value = (u32) be16_to_cpu(data);
> > --
> > 2.21.0
> >  
> 
> 

