Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516D2CA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EC2206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbfKEIc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:32:28 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:51946 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387686AbfKEIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:32:27 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id E602C3C0588;
        Tue,  5 Nov 2019 09:32:23 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yQUalbo20ufv; Tue,  5 Nov 2019 09:32:18 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 74DD23C0585;
        Tue,  5 Nov 2019 09:32:18 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 5 Nov 2019
 09:32:17 +0100
Date:   Tue, 5 Nov 2019 09:32:13 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-mmc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Machek <pavel@ucw.cz>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add
 'fixed-emmc-driver-type-hs{200,400}'
Message-ID: <20191105083213.GA24603@vmlxhi-102.adit-jv.com>
References: <20191105055015.23656-1-erosca@de.adit-jv.com>
 <20191105062223.GB1048@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191105062223.GB1048@kunai>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Tue, Nov 05, 2019 at 07:22:23AM +0100, Wolfram Sang wrote:
> Hi Eugeniu,
> 
> thanks for this work!

Thanks for the prompt response. Very much appreciated.

> 
> > A certain eMMC manufacturer provided below requirement:
> >  ---snip---
> >  Use "drive strength" value of 4 or 1 for HS400 or 0 for HS200.
> >  ---snip---
> 
> I see.
> 
> > The existing "fixed-emmc-driver-type" property [1] is the closest one
> > to implement the above, but it falls short due to being unable to define
> > two values to differentiate between HS200 and HS400 (both modes may be
> > supported by the same non-removable MMC device).
> > 
> > To allow users to set a preferred HS200/HS400 "drive strength", provide
> > two more bindings inspired from [1]:
> >  - fixed-emmc-driver-type-hs200
> >  - fixed-emmc-driver-type-hs400
> 
> Main question before looking at the code: Can't we just extend the
> existing binding with an optional second parameter?

That's a great question/proposal, but before pushing the v2 right away,
I would like to first share some thoughts.

>         minItems: 1
>         maxItems: 2
> 
> I tend to favour this approach...

The first question which pops up in my mind is related to the meaning
of each item. The option which I envision based on your proposal is:

  * minItems: 1
  * maxItems: 2
  * Item[0]: Presumably equivalent to the current
    "fixed-emmc-driver-type", i.e. the strength value applied in both
    HS200 and HS400 modes.
  * Item[1] (optional): Presumably equivalent to
    "fixed-emmc-driver-type-hs400" proposed in this series. If this
    element is provided, the first one should likely change its role
    and become an equivalent of "fixed-emmc-driver-type-hs200" from
    this series.
  + Pro: Full backward compatibility. No need to touch the existing
    users of "fixed-emmc-driver-type".
  - Con: Not sure we have such DT bindings which dynamically change
    their semantics based on the usage pattern.
  - Con: Can't easily achieve the same flexibility as accomplished in
    this series. For example, current implementation allows users to
    define each of the three parameters (i.e. HSx00-agnostic drive
    strength, HS200 and HS400 specific drive strengths) individually,
    as well as in all possible combinations. This might be needed if,
    in certain HSx00 mode, users still need to rely on the
    RAW/unmodified drive strength. I am unsure if/how this can be
    achieved with an array OF property with a constant or variable
    number of elements (I try to sketch one solution below).

One option to achieve a similar degree of flexibility by using an array
OF property (instead of several u32 properties) would be to agree on a
convention based on magic values, i.e. below DT one-liner could be an
example of providing solely the "fixed-emmc-driver-type-hs200" value
(based on the agreement that 0xFF values are discarded by the driver):

    fixed-emmc-driver-type = <0xFF 0x1 0xFF>;

> 
> > For more details about eMMC I/O driver strength types, see Jedec spec.
> > Keep "fixed-emmc-driver-type" in place for backward compatibility.
> 
> If we decide for the path proposed here, should the old binding be
> deprecated then?

I can either zap "fixed-emmc-driver-type" or extend its type and
meaning, depending on the feedback from the reviewers.
Looking forward to any comments and suggestions.

> 
> Happy hacking,
> 
>    Wolfram

Thanks.

-- 
Best Regards,
Eugeniu
