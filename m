Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC71C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCE52133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgN0RBlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfDDDle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:41:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44192 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDDDle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:41:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so497400pgj.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:references:in-reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=sVTQZTJIJDgHWDkqttRX9W3FlnuYeGRiRP2zotopxQk=;
        b=SgN0RBlCIHpAaLWix2PetN7kBpytCF81WU6flymBEoVKyBTMtBa7R5SZsfRnr0eGD4
         y3/00BesjKkKED68dadrgfHJVuz5q5t3pXMLNd0sVDDbbXpDBLk+kt8URzraVEi72z8/
         ECO3F7uqFqrUBdgV0au/gwMWSgiRzGHuU4klnIVdQ6xwOYv1m70TDqG0LyL5UD8Rvldb
         GkIjpnzt8QagrBUgNU0scSCQmyZCSgM+vADtmVeAci27djGwxljNyQjy7Vs9bpDFMFau
         7Vt5fHU3GYF4F2rq4fk60R2B7n3wORufZm4MykYRfgvT+0zPf0u5oDPap3I54C43fzOf
         nlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:references
         :in-reply-to:user-agent:mime-version:content-transfer-encoding;
        bh=sVTQZTJIJDgHWDkqttRX9W3FlnuYeGRiRP2zotopxQk=;
        b=BEqWxTeyeI9LTAwjUZyWxURebSUtNCSIpAI37XNMb3S1X+pZCcO7zwVtQmqMH39DWq
         KVq8vVVxSjQSCHQ0M5rTlPtZ7XkGsiJZzXwkeJtuNFHXoLwWzmW4eevB3xeLK9/2tslX
         tLSO3EADwecwjnhLah+5cxYfoH1/YpPwIfxAezrhJhORTbkyylWz2IkmyvKEgHxNkTvD
         QRrivDhhNtzuv1zESCxZTzh0eAlq2L3qsccp+0uF7M69UgC95O16B5pktOzmzl3wDkDm
         rQafBZJyAXNQ7g4r7uG1i/PuFW9em4J9/gcTVs9vtE5/52l/w7dAKmlHbj//rTVIqgW5
         IGSQ==
X-Gm-Message-State: APjAAAXTH1tJK4cXNaKIFn2ZTjKqd/w9FTSA41bLZO+sLKIQrhOwuozy
        nhI0mkTRvgNBt0/E8MFl3YMdrGrF
X-Google-Smtp-Source: APXvYqy6RLoNhi+0cL4uuIpPszUSnpAbKitbZ6R0OuvdRrzOJzSUDQFb70C0FbiOvOxygvGV6Mezuw==
X-Received: by 2002:aa7:8443:: with SMTP id r3mr3327133pfn.143.1554349293145;
        Wed, 03 Apr 2019 20:41:33 -0700 (PDT)
Received: from zen.local (216-160-106-16.tukw.qwest.net. [216.160.106.16])
        by smtp.gmail.com with ESMTPSA id b26sm41006902pgn.4.2019.04.03.20.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 20:41:32 -0700 (PDT)
Message-ID: <2f07167152e807917acb8199939886ed8a3a00f9.camel@gmail.com>
Subject: Re: [PATCH] lib: Fix possible incorrect result from rational
 fractions helper
From:   tpiepho@gmail.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Oskar Schirmer <oskar@scara.com>
Date:   Wed, 03 Apr 2019 20:41:30 -0700
References: <20190330205855.19396-1-tpiepho@gmail.com>
         <20190401222228.5692d7e8d5b979a8c574e76c@linux-foundation.org>
In-Reply-To: <20190401222228.5692d7e8d5b979a8c574e76c@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 10:22 PM Andrew Morton <
akpm@linux-foundation.org> wrote:

> On Sat, 30 Mar 2019 13:58:55 -0700 Trent Piepho <tpiepho@gmail.com>
> wrote:
> > In some cases the previous algorithm would not return the closest
> > approximation.  This would happen when a semi-convergent was the
> > closest, as the previous algorithm would only consider convergents.
> > 
> > As an example, consider an initial value of 5/4, and trying to find
> > the
> > closest approximation with a maximum of 4 for numerator and
> > denominator.
> > The previous algorithm would return 1/1 as the closest
> > approximation,
> > while this version will return the correct answer of 4/3.
> 
> What are the userspace-visible runtime effects of this change?

Ok, I looked into this in some detail.

This routine is used in two places in the video4linux code, but in
those cases it is only used to reduce a fraction to lowest terms, which
the existing code will do correctly.  This could be done more
efficiently with a different library routine but it would still be the
Euclidean alogrithm at its heart.  So no change.

The remain users are places where a fractional PLL divider is
programmed.  What would happen is something asked for a clock of X MHz
but instead gets Y MHz, where Y is close to X but not exactly due to
the hardware limitations.  After this change they might, in some cases,
get Y' MHz, where Y' is a little closer to X then Y was.

Users like this are: Three UARTs, in 8250_mid, 8250_lpss, and
imx.  One GPU in vp4_hdmi.  And three clock drivers, clk-cdce706, clk-si5351, and clk-fractional-divider.  The last is a generic clock driver and so would have more users referenced via device tree entries.

I think there's a bug in that one, it's limiting an N bit field that is
offset-by-1 to the range 0 .. (1<<N)-2, when it should be (1<<N)-1 as
the upper limit.

I have an IMX system, one of the UARTs using this, so I can provide a
real example.  If I request a custom baud rate of 1499978, the driver
will program the PLL to produce a baud rate of 1500000.  After this
change, the fractional divider in the UART is programmed to a ratio of
65535/65536, which produces a baud rate of 1499977.0625.  Closer to the
requested value.



