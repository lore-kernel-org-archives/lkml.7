Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B21C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6ABC20842
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfCGAJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:09:58 -0500
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:42034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbfCGAJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:09:58 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B725C182CED34;
        Thu,  7 Mar 2019 00:09:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: teeth37_397cd891af75b
X-Filterd-Recvd-Size: 3177
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Mar 2019 00:09:54 +0000 (UTC)
Message-ID: <d596d6db449d4747b3eebf4cb42f6657ad42f989.camel@perches.com>
Subject: Re: [GIT PULL] Driver core patches for 5.1-rc1
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Date:   Wed, 06 Mar 2019 16:09:53 -0800
In-Reply-To: <CAHk-=wjT+pPxi8favCu9V5ZtGZuTZybLuwnwtNLspFPmKgr42g@mail.gmail.com>
References: <20190306103350.GA10570@kroah.com>
         <CAHk-=wjT+pPxi8favCu9V5ZtGZuTZybLuwnwtNLspFPmKgr42g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-06 at 15:47 -0800, Linus Torvalds wrote:
> On Wed, Mar 6, 2019 at 2:33 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > Joe Perches (1):
> >       device.h: Add __cold to dev_<level> logging functions
> 
> This is very funky, but that commit generates a new warning in a
> totally unrelated area:

Very very funky.

Are you sure it's the __cold marking of an
entirely unrelated function that isn't
even used in the code with the new warning?

btw; what compiler version?

>  drivers/iio/adc/qcom-pm8xxx-xoadc.c: In function ‘pm8xxx_xoadc_probe’:
>   drivers/iio/adc/qcom-pm8xxx-xoadc.c:633:8: warning: ‘ch’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>     ret = pm8xxx_read_channel_rsv(adc, ch, AMUX_RSV4,
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>              &read_nomux_rsv4, true);
>              ~~~~~~~~~~~~~~~~~~~~~~~
>   drivers/iio/adc/qcom-pm8xxx-xoadc.c:426:27: note: ‘ch’ was declared here
>     struct pm8xxx_chan_info *ch;
>                              ^~
> 
> and it all looks entirely insane if you look at that line 633 where
> the ostensibly uninitialized variable is (it clearly _is_ initialized
> there), but if you then look at that line 426 you notice that it
> actually makes some kind of sense. The value comes from another
> function that was apparently inlined, and that other function does not
> "obviously" initialize it.
> 
> I wonder why this wasn't seen in linux-next? Yes, the connection is
> odd, and maybe it's very compiler version dependent, but I do hope
> people react to new warnings. The kernel is entirely warning-free for
> me for an x86-64 allmodconfig build, and I want to keep it that way.
> 
> And _because_ I want to keep it that way (one of the things I do
> during the merge window is look for oddities coming in during pulls,
> and new warnings is a big deal for me), I applied the attached patch.
> Just FYI.
> 
>                    Linus

