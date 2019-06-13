Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9568AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C04420679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DuXyWXqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391626AbfFMQMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:12:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43051 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731223AbfFMQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:12:10 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so18143373ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6v/23h74yo3j/zUughy0wFFC9yfO7oR+qGcuy0DJBZk=;
        b=DuXyWXqHXbK8HuFNvok5v3l44KGSaXUZ1sTcFqSZMnKszMlUEbzqFaaqQKvrgWdt46
         YYkGsl/GqHupyJpXzDqjbJB5SvCmaNd07MaC3gtGS19OoCkNrhvVaEi1/Fyj0w5IwK10
         NYvTsRGyh722FTs2L1AN0LF1/jyu/pNUmRZsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6v/23h74yo3j/zUughy0wFFC9yfO7oR+qGcuy0DJBZk=;
        b=dCtYgCVlT8ky252gKgYoh7H3wyf3vbG0YA+LApifCsmIs7xhF35j9Jd8HNGhjQqXGl
         ncSvFxiAWCflKBH/7QhhDIQX4ZFiCOSg6gLso3LV0D+oB1Xuew4K7f/rp1LEaWajLhfi
         IYfKQO0drovSqOEp+/WwU5YMQWlymwz23D+83id2CBicJ0M02eCDorNLselih6SjTSqQ
         tzYWYxwe4jsvWjAcHNSAt2HuoS6EsAivU9Y38soSpzqOWoWll+zgawjeSbYIUB/m+CAJ
         aXpKt+w+OPFcmSZojrL0fHDCdDWOMch37o22tCuECibPKhOS7MXLOS+l/nS69uzuWZ4f
         GF8Q==
X-Gm-Message-State: APjAAAVxcmWxu6+iUH/PmgnJqAlXSGNFwTM9k8SYFtslMtukA8HRNBAj
        I0E+m+n/InrprFHOQminfv8nc3WgsbI=
X-Google-Smtp-Source: APXvYqyXg0pDc+TvjpEgv1yZrMXS6g+2xKTjSDahD0IMW0IM3A7LIg+f0J0HLX08p0YXKKjN/9Jckg==
X-Received: by 2002:a02:a806:: with SMTP id f6mr61450916jaj.74.1560442329423;
        Thu, 13 Jun 2019 09:12:09 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id t133sm502930iof.21.2019.06.13.09.12.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 09:12:08 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id u13so18174364iop.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 09:12:08 -0700 (PDT)
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr11718339iop.168.1560442328298;
 Thu, 13 Jun 2019 09:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <c2e6af51-5676-3715-6666-c3f18df7b992@free.fr> <CAK8P3a1_WvHYW243MR5-NdFm3cSt+cVGM5EJmOM8uiQMQ3vQjQ@mail.gmail.com>
 <a732f522-5e65-3ac4-de04-802ef5455747@free.fr>
In-Reply-To: <a732f522-5e65-3ac4-de04-802ef5455747@free.fr>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Jun 2019 09:11:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+Ky1bAuAuuY+eBdTP9U3kbuH0tfwyN0Zs-iw0GNUFyQ@mail.gmail.com>
Message-ID: <CAD=FV=U+Ky1bAuAuuY+eBdTP9U3kbuH0tfwyN0Zs-iw0GNUFyQ@mail.gmail.com>
Subject: Re: [PATCH v1] iopoll: Tweak readx_poll_timeout sleep range
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 13, 2019 at 9:04 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wro=
te:
>
> On 13/06/2019 14:42, Arnd Bergmann wrote:
>
> > On Thu, Jun 13, 2019 at 2:16 PM Marc Gonzalez wrote:
> >
> >> Chopping max delay in 4 seems excessive. Let's just cut it in half.
> >>
> >> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> >> ---
> >> When max_us=3D100, old_min was 26 us; new_min would be 50 us
> >> Was there a good reason for the 1/4th?
> >> Is new_min=3D0 a problem? (for max=3D1)
> >
> > You normally want a large enough range between min and max. I don't
> > see anything wrong with a factor of four.
>
> Hmmm, I expect the typical use-case to be:
> "HW manual states operation X completes in 100 =C2=B5s.
> Let's call usleep_range(100, foo); before hitting the reg."
>
> And foo needs to be a "reasonable" value: big enough to be able
> to merge several requests, low enough not to wait too long after
> the HW is ready.
>
> In this case, I'd say usleep_range(100, 200); makes sense.
>
> Come to think of it, I'm not sure min=3D26 (or min=3D50) makes sense...
> Why wait *less* than what the user specified?

IIRC usleep_range() nearly always tries to sleep for the max.  My
recollection of the design is that you only end up with something less
than the max if the system was going to wake up anyway.  In such a
case it seems like it wouldn't be insane to go and check if the
condition is already true if 25% of the time has passed.  Maybe you'll
get lucky and you can return early.

Are you actually seeing problems with the / 4, or is this patch just a
result of code inspection?

-Doug
