Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1101C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF01324679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfLTMPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:15:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:5665 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfLTMPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:15:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 04:15:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,335,1571727600"; 
   d="scan'208";a="416519636"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 20 Dec 2019 04:15:43 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1iiHC3-0002kc-8y; Fri, 20 Dec 2019 14:15:43 +0200
Date:   Fri, 20 Dec 2019 14:15:43 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 12/13] gpiolib: add new ioctl() for monitoring changes
 in line info
Message-ID: <20191220121543.GY32742@smile.fi.intel.com>
References: <20191219171528.6348-1-brgl@bgdev.pl>
 <20191219171528.6348-13-brgl@bgdev.pl>
 <CAHp75VeMEngXiFmvTrsW7UZMz0ppR-W-J4D1xU+qKGfLXkG3kg@mail.gmail.com>
 <CAMpxmJV4UU21x8rfNMaJ6G2OiRa3qC2vYQWH4C_T+nS4b_NcUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJV4UU21x8rfNMaJ6G2OiRa3qC2vYQWH4C_T+nS4b_NcUw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 12:25:59PM +0100, Bartosz Golaszewski wrote:
> czw., 19 gru 2019 o 19:17 Andy Shevchenko <andy.shevchenko@gmail.com>
> napisał(a):
> > On Thu, Dec 19, 2019 at 7:17 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

...

> > > +/**
> > > + * struct gpioline_info_changed - Information about a change in status
> > > + * of a GPIO line
> > > + * @info: updated line information
> > > + * @timestamp: estimate of time of status change occurrence, in nanoseconds
> > > + * and GPIOLINE_CHANGED_CONFIG
> > > + * @event_type: one of GPIOLINE_CHANGED_REQUESTED, GPIOLINE_CHANGED_RELEASED
> > > + */
> > > +struct gpioline_info_changed {
> >
> > > +       struct gpioline_info info;
> >
> > Is this guaranteed to be always 8 byte aligned?
> > I'm expecting to see some comments there and / or here about it.
> >
> 
> struct gpioline_info alone is 32-bit aligned but its size is 72 bytes
> which works for 64-bit alignment. This new structure's biggest element
> in 64-bit, so it's 64-bit aligned on 64-bit arch. We have 72 bytes of
> gpioline_info, 8 bytes of timestamp, 32 bytes of event type and 5 * 32
> bytes of padding. Should be fine, but I'll add comments to the header.

Yes, what I meant is to add comment at least to struct gpioline_info definition
that if somebody would like to change it there (which also might be a
problematic here, if there is no versioning scheme / length member).

> > > +       __u64 timestamp;
> > > +       __u32 event_type;
> > > +       __u32 padding[5]; /* for future use */
> > > +};

Offtopic a bit, had you had a chance to look at Buildroot and our scripts
I shared?

-- 
With Best Regards,
Andy Shevchenko


