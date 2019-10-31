Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C1ECA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 08:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66842083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 08:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEGDXtnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfJaI5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 04:57:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43623 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfJaI5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 04:57:34 -0400
Received: by mail-io1-f66.google.com with SMTP id c11so5791952iom.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 01:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IZcXOhYWcQPPh8pbPgFawvnUK9M/706xBPYei9/eFw=;
        b=AEGDXtnZWMhiiDLrfPhBu5ICyGLokIcM97C5AqmmYtNp2z4rEDiNSMFiVGL9YFN4gK
         Uj3f2kBx7U99NDg1jvXkxJErUOKgrZq4hYWliDqk5fXZSjCI4KVDvH11dVlLkSqJieet
         Mkto6617w/B5M8W5C/mJkZh6kUhVSBZXVZOAm82Y6b46MpJk0KXr12xXSSlENtsXCge+
         UVqwAuvztYyNydIQGwWELbDJaKvyOdYOvCG8GUT19u4WJAGWj2rczHUjtop76ip9KZju
         8r1Dl7DhMKHmcVXhCWd6lWLkR3ZuMGJ+T8Hr54LnR96RGeOKnJ6wGQb0FGWK+Mu6m8UY
         4wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IZcXOhYWcQPPh8pbPgFawvnUK9M/706xBPYei9/eFw=;
        b=jGtzxhiFWhYZcmmDnizPy2tgvTrSTXnQL9dJ0YseLBGzdEOGSzWPrY9JAsT7sVppMW
         NtwnTDP5IHEc7XL/Er9cuB1E/9bYiweBdqTb+x003y+aUi9QNzBpxbSVII6YHkoTRHgX
         aasTLInKge+ujTgi3QQWxotjyQbVZSYGE+DHg4UeR7Sw7mIp0NHfl0jUyeLEjCJhulGn
         hnCsdU8UNiuXo32+SteyQfmt3hwRUWZnYrKKWACuRwqbj09sYxvjj8cy4vpmR8grgYiw
         goD+rJEdgTXtEvYBV0KM2IOTwugB8npJeBUd0b4WDuazkmjE79jI7qKaTtYi/2w4rzMo
         nc4w==
X-Gm-Message-State: APjAAAWYgoakHntrzL0QuPQhpFKdpDh3lW6sM3eU4f4I8Zx/giNohUx4
        h3D+Dk0/GLzGxCI0jtGQ/I2hvNuk7QDTU3UCCtT0ww==
X-Google-Smtp-Source: APXvYqxV+dCgVfvyNIf9sww3KhPCvrGskZ13qCx0x5s+9JoRgcMYQVptyGjQDTFpRDYcZA9EtyzX0lv/U5iCaEQCo+0=
X-Received: by 2002:a5d:8909:: with SMTP id b9mr4355813ion.138.1572512252076;
 Thu, 31 Oct 2019 01:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191030091038.678-1-daniel.lezcano@linaro.org> <20191030091038.678-2-daniel.lezcano@linaro.org>
In-Reply-To: <20191030091038.678-2-daniel.lezcano@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 31 Oct 2019 14:27:20 +0530
Message-ID: <CAKohpokt8_Ru8_g=EY+XEG71wTVUC+_h5+Bu=kydAzx0i0zEsQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: cpu_cooling: Reorder the header file
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 at 14:41, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> As the conditions are simplified and unified, it is useless to have
> different blocks of definitions under the same compiler condition,
> let's merge the blocks.
>
> There is no functional change.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  include/linux/cpu_cooling.h | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
