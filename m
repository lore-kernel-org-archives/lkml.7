Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA08CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD2B2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411148;
	bh=5p9znZHy/+JE1vi+OsqhfdBBdHTrOeCF6XTukLuBhWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m6+Md6cin42hpPwm24HQ4dpZnkrHmhO7JB5AWxbVyd5lYD9mILnfEZ5xn84my66QW
	 EOAwv5J7R5Y1wg2dqJ1adeuUi27DzxevC1H4+umMISaD9whdi43uFv923mRMv1EZvi
	 dx88jUOHlkCL7dV8VwiyoiE8YRp78ZpBkoiRcgZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfCLRTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbfCLRSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:18:23 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65197217D4;
        Tue, 12 Mar 2019 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411102;
        bh=5p9znZHy/+JE1vi+OsqhfdBBdHTrOeCF6XTukLuBhWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ySsDzLxKeqBgo+/qjpYQueLo5ZTZUxxxMSYeZJ/alXCgw/85sckZpl051XJFP7Mf6
         O028/3vy/9FjJmpS3vkLvEPXeI+EqwTnAW7ZyUi3o21fZoIwhQsFiVNgKcWoe8Wg7s
         bRfcPZp8sA3LkW4xCfJ0rI2cqX6ibmuuSWYiQS0w=
Date:   Tue, 12 Mar 2019 10:13:36 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     robh+dt@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/6] Add Fieldbus subsystem + support HMS Profinet card
Message-ID: <20190312171336.GA29680@kroah.com>
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <CAGngYiWFU-VnG=ODLWaUf0yp69qaU2GSd9exdHvyi6Ko1ib9qw@mail.gmail.com>
 <20190208121916.GE23483@kroah.com>
 <CAGngYiVVNitd5SDLah-kxP69W6XHYHOQrOz=DnevuGnqoHD7HA@mail.gmail.com>
 <20190208141400.GA22162@kroah.com>
 <CAGngYiXZtNcqQ3JGgavBxypo75WtAT7T-X4DQFNWD8kQcifU8g@mail.gmail.com>
 <20190311191339.GA5628@kroah.com>
 <CAGngYiVB=6627d31ad5ajfrmBtV5_pDLudKkBuPNyNnqkssBAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiVB=6627d31ad5ajfrmBtV5_pDLudKkBuPNyNnqkssBAA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 01:11:11PM -0400, Sven Van Asbroeck wrote:
> On Mon, Mar 11, 2019 at 3:13 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > That sounds like a good plan, I'll take that.  Want to respin the
> > patches with the code in drivers/staging/ and I'll be glad to queue them
> > up after 5.1-rc1 is out.
> 
> Andreas Farber suggested that the patchset may have more success reaching
> its target audience by cross-posting in netdev, and maybe linux-serial +
> linux-gpio. Does that sound ok? Any other group where the patchset might
> be welcome?
> 
> Greg, are you ok with holding off taking the patch for a few days, to give
> the netdev/serial/gpio people a chance to react?

I can't take anything until after 5.1-rc1 is out.  I have no rush,
please take your time, get it right :)

greg k-h
