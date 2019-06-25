Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71722C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6E42085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561447863;
	bh=/QdJpDShT/yWCyXy42YAGFG+PVbKrfugMkhIQqmAP4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fbimm/3VSu5VG4spekgtOG89ZxiVTf4fqJRapQizqkAcYD9WrNXrLrOvSAgMy+TX4
	 aBoB27DvoR78h48DF4AOTn0B5CsN8KMCSURYsNM8msm+2iLwceMXWk+c6NBxJ0o3ke
	 pR8NLtMnNlwtzVdMehkedLErQ6kVbH3uvj94ZCOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfFYHbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbfFYHa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:30:58 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C87120863;
        Tue, 25 Jun 2019 07:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561447857;
        bh=/QdJpDShT/yWCyXy42YAGFG+PVbKrfugMkhIQqmAP4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHE0jibf9j1D1l6TBM/X56TOxidrIG+agSqI7oHmTprTBS7wHKn7aSMpK+bSm8s0D
         7O2AABe2JJs76+UlY8WLUEYOtahYLqikXpK6DtL7zb1TCiZhcwUu1mrDJIkif6/Vcy
         yt7oJrJR8QzU8kPOnwwzvZqfbr3Zs/nfU0PxrYoM=
Date:   Tue, 25 Jun 2019 15:30:16 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: Adjust scope for CONFIG_HAS_IOMEM before
 devm_platform_ioremap_resource()
Message-ID: <20190625073016.GA18381@kroah.com>
References: <20190221162627.3476-1-brgl@bgdev.pl>
 <9efcbce2-4d49-7197-a3d8-0e83850892d5@web.de>
 <CAMpxmJX-wXQ-ff1RWkPmJBWSsP_v2MjZrA3fhj3HQX0_zM0eZA@mail.gmail.com>
 <39ae399a-c606-c6de-f84d-35e39d0410c0@metux.net>
 <CAMRc=McepqowJNi6ay6x9KKoHOC8aCxP_ob12SgbsnJU_sKQng@mail.gmail.com>
 <1dd52704-0e41-db31-33f4-c9f446a47344@metux.net>
 <CAMRc=Mfp85diy849r_8UHKS9eao26djrsMF0_iwE--d62mQ5jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfp85diy849r_8UHKS9eao26djrsMF0_iwE--d62mQ5jg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:10:25AM +0200, Bartosz Golaszewski wrote:
> pon., 24 cze 2019 o 20:22 Enrico Weigelt, metux IT consult
> <lkml@metux.net> napisał(a):
> >
> > On 24.06.19 12:46, Bartosz Golaszewski wrote:
> >
> > >> The patch seems pretty trivial and doesn't change any actual code, so
> > >> I don't see hard resons for rejecting it.
> > >>
> > >
> > > In its current form it makes the code even less readable. The #ifdef
> > > should actually be one line lower and touch the comment instead of the
> > > EXPORT_SYMBOL() related to a different function.
> >
> > Okay, that missing newline should be fixed (as well as the extra one
> > after the #ifdef). Besides that, I don't see any further problems.
> >
> 
> Are we sure this even changes something? Does kernel documentation get
> generated according to current config options? I really think this
> patch just pollutes the history for now apparent reason.
> 
> Greg, could you give your opinion on this?

Why are you all arguing with a all-but-instinguishable-from-a-bot
persona about a patch that I will never apply?

greg k-h
