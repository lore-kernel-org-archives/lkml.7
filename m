Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C70C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8D42173C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfHFVP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:15:59 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:53456 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726016AbfHFVP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:15:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4B4CD8368EF7;
        Tue,  6 Aug 2019 21:15:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tray62_16bee76040d3f
X-Filterd-Recvd-Size: 2426
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Aug 2019 21:15:56 +0000 (UTC)
Message-ID: <a687a6d29d4cc928a6aa128bcada5f55b26f41a4.camel@perches.com>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK
 inputs
From:   Joe Perches <joe@perches.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 06 Aug 2019 14:15:54 -0700
In-Reply-To: <20190806192727.GA11773@rikard>
References: <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
         <2b782cf609330f53b6ecc5b75a8a4b49898483eb.camel@perches.com>
         <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com>
         <20190802181853.GA809@rikard>
         <CAK7LNAT+cNxna4SER04MdkBsq_LDg4TwYR_U1ioNNxYOZWXigA@mail.gmail.com>
         <CAK7LNAQv-5epL8DYDaUdHsQEQ=Va676t_6TgsaSYC30Eix=iyw@mail.gmail.com>
         <20190803183637.GA831@rikard>
         <CAK7LNASBndh4yJKVdeMb7RQGopUzEUSNXPQcUgQdB8PiJetMuQ@mail.gmail.com>
         <20190805195526.GA869@rikard>
         <CAK7LNATpQDWoMv+hnPrb1DTu4HravUhuhANnQkayxaJw99_ajQ@mail.gmail.com>
         <20190806192727.GA11773@rikard>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-06 at 21:27 +0200, Rikard Falkeborn wrote:
> On Wed, Aug 07, 2019 at 12:19:36AM +0900, Masahiro Yamada wrote:
> > How about this?
> > #define GENMASK_INPUT_CHECK(high, low) \
> >        BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> >               __builtin_constant_p((low) > (high)), (low) > (high), 0))
> Thanks for the feedback, your version looks much cleaner than mine. I
> *think* I had a reason for using __is_constexpr() instead of
> __builtin_constant_p but I'll try a full rebuild to see if something
> comes up.

Perhaps a statement expression so high and low aren't possibly
evaluated multiple times?

#define GENMASK_INPUT_CHECK(high, low)				\
({								\
	typeof(high) _high = high;				\
	typeof(low) _low = low;					\
	BUILD_BUG_ON_ZERO(__builtin_constant_p(_low > _high,	\
					       _low > _high,	\
					       0))		\
})


