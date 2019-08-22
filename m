Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0F2C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551AC216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPJ+HTkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfHVCNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:13:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38556 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfHVCNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:13:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id m125so4066049wmm.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 19:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojaEvfqlKAAL2lTKmwRHpldmWlVYnPOGOZegIqvukh4=;
        b=vPJ+HTkPwnSMhE+qk8hSEgNCinF4IuXtqDQft6K7Z6pWsZRigw83vmRIhHY25E6qfN
         gG7UUcRGewF79O4OeMiXpE3WrqVd6YWw1gf+tajAQ42uAD+lyh9ocOcr3zTKvcDHW76K
         mYTudpP2GdNQBAAecf9HQtxfVLHYL/u3Du+nHR+jhwDK90wV53KbznnQQgC/lbs8TdRx
         A1lTRcezQS9D2/pFwd6SZFA5moefvJ06I9ZHAdIhAQf07OEXr8E8LICKyBcXMOmMpARm
         B+F+n0typVorUhOxNHzx0Czag8LXcQCq2ZiRsJEwbMzSnWfDt40QVKe919bw5QR0A04D
         16YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojaEvfqlKAAL2lTKmwRHpldmWlVYnPOGOZegIqvukh4=;
        b=Tn5c6zUmj0niHiZZXEy5IKnNutzojd+jHSJQs4fCku1tbEgY3sLvu0ALNUIBpliTrr
         BrRodAvsR9Z9wx2YCle1eOvsv08X60Zw7mue9Vno2yIdVx4WteP82SNwHJ5mFSkURrLR
         +kXCU/ugAGR0vLwXCodKgU5mK2p11PUgRJU040nCn/w55Xgm+O9DzYtHowYYGZQNpNQh
         bwTrBZ1thJJU8ZtPv6Gjv8zejy/Tp2d4XZhqsVRHXaUKKjn94gov0WtsvCMWnAKDGd2W
         /qcgyz9xh6GL4QIjpXkjKwEAgaNbd79EcoE68zHPZY5bJ1iBIE7bd2zs1qrgENazDxEN
         2vqg==
X-Gm-Message-State: APjAAAV+QqdSny88YcCcjhSZbiQgIZqXJjYMghUfFKCdeLBNqq2ToKrn
        r9eoxBmzgEcoQioOWSqIVnuVWqZL3hub2Eo0bNQ=
X-Google-Smtp-Source: APXvYqz1e6uwc2N1gK7CKn+4vyXXXefJ+pKwR+9EfXYJmVBylK261gkCDlDmCLca8YnY0HAftOAX0k6IOPy/Un811cA=
X-Received: by 2002:a05:600c:352:: with SMTP id u18mr3004060wmd.141.1566439981994;
 Wed, 21 Aug 2019 19:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190820235713.3429-1-natechancellor@gmail.com> <f594d746-9eaf-76fe-d380-bb033cce06f8@amd.com>
In-Reply-To: <f594d746-9eaf-76fe-d380-bb033cce06f8@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 21 Aug 2019 22:12:50 -0400
Message-ID: <CADnq5_PH6gA2kMi5+sT4N=AQdfJkEg4ZhoZtYduLTDAyUT7cBA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix 32-bit divide error in wait_for_alt_mode
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Wed, Aug 21, 2019 at 12:40 PM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-08-20 7:57 p.m., Nathan Chancellor wrote:
> > When building arm32 allyesconfig:
> >
> > ld.lld: error: undefined symbol: __aeabi_uldivmod
> >>>> referenced by dc_link.c
> >>>> gpu/drm/amd/display/dc/core/dc_link.o:(wait_for_alt_mode) in archive drivers/built-in.a
> >>>> referenced by dc_link.c
> >>>> gpu/drm/amd/display/dc/core/dc_link.o:(wait_for_alt_mode) in archive drivers/built-in.a
> >
> > time_taken_in_ns is of type unsigned long long so we need to use div_u64
> > to avoid this error.
> >
> > Fixes: b5b1f4554904 ("drm/amd/display: Enable type C hotplug")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > index f2d78d7b089e..8634923b4444 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > @@ -721,7 +721,7 @@ bool wait_for_alt_mode(struct dc_link *link)
> >                       time_taken_in_ns = dm_get_elapse_time_in_ns(
> >                               link->ctx, finish_timestamp, enter_timestamp);
> >                       DC_LOG_WARNING("Alt mode entered finished after %llu ms\n",
> > -                                    time_taken_in_ns / 1000000);
> > +                                    div_u64(time_taken_in_ns, 1000000));
> >                       return true;
> >               }
> >
> > @@ -730,7 +730,7 @@ bool wait_for_alt_mode(struct dc_link *link)
> >       time_taken_in_ns = dm_get_elapse_time_in_ns(link->ctx, finish_timestamp,
> >                                                   enter_timestamp);
> >       DC_LOG_WARNING("Alt mode has timed out after %llu ms\n",
> > -                     time_taken_in_ns / 1000000);
> > +                     div_u64(time_taken_in_ns, 1000000));
> >       return false;
> >  }
> >
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
