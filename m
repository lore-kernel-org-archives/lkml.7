Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840C3C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550A22070D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv321/z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391109AbfEXQuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:50:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33200 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390346AbfEXQuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:50:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so5376507pgv.0;
        Fri, 24 May 2019 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ljKG1FSpAnI0fQI5UQvftJwABxyuwurggQoq2c5RGI=;
        b=Tv321/z+MZyNy1WU4jYRew/fqti/jyFeedE6AWrYE/Hhoj+nobHJg19kUk2klY/onN
         gu+Rko03axvYxETQjvxIe6ThSTouOFGb/12AgI92orwfSPIp5BI4P9o8wibrqzQCvVvh
         VszAFZlGZPizC3+RHL9//QgV82WYtyJiSdxcdsZOvr1lRCeRiP1E1BjnVHEy4jvjTJbD
         Xx7dlKD8Qkmvf/A9Q327g+eftACu1shDuuv5XAB/6iLXd5T/ZIenxoEknDVshYwGNJ0F
         H8mO592uIz5fp0hgCid+ZEH4LkQ9EhdJ00NjfQWVAWWavf9SBbJsjK2SuklZBc76rMM3
         Coug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ljKG1FSpAnI0fQI5UQvftJwABxyuwurggQoq2c5RGI=;
        b=kvwSl5C8lxijsaBCB+17aXtk483baL8Dc7OdMTliLPFXaft/E9fVA1ZREQVGCPYVQt
         1pUfJqZoOvzxF1VMa3bN8C1YPJRAo0Bq5t72TYWKpfqOU3OG5+2nQ/RjgAUku2/VYch/
         uTRnqaK89+2BrLF9wKPI7pGX/vnuCgTkU25p6qxpUAR/1+sZc7Y7VaLroUee7bP5Fqk5
         Fsg048vjZjudP4gW0mUVBA606Q9hsJVUb/wcc6v4qGqMWrq4GTSlM0wn0urAj/lgr6Yf
         zM1aOj26OD6c3/HpsyUn0Ue5zlplCZflMOighl1vwn4u8A2N6eSXpPXxhRbZCWRVoxfx
         YmHg==
X-Gm-Message-State: APjAAAW6i04mWhJPu1edAjvCSLrrF4UB0rp7NBPKgMmNAsQbHHb8l6n+
        abOIPTi45R1Q5bYuQFbaRLgbBF+/6P3WQpdJ0H0=
X-Google-Smtp-Source: APXvYqwCvw4pVTu0bgA3402cpeKLR/7D4aZKVYALe14wdz62BWmzOOdEFkCmumnnV+7hiG5WARjBPs3YUqvAnHxwbGU=
X-Received: by 2002:a63:fb05:: with SMTP id o5mr23546629pgh.203.1558716614556;
 Fri, 24 May 2019 09:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190429150135.15070-1-hdegoede@redhat.com> <CAHp75VeE=88mCcgVx3Y3PQJPQ819Z7=3s=jRGz1y=t09phk=rA@mail.gmail.com>
 <085c5b6e-d220-ebd1-38d2-def7efca24b8@redhat.com> <CAHp75Vfe9uK_b_V+uG29wb1L6J7u1hpbU+P4beXso9KNPM+8Rg@mail.gmail.com>
 <568ba27d-a6a5-b158-bab1-f22cd8ccb34e@redhat.com> <155726027056.14659.1724431433952718602@swboyd.mtv.corp.google.com>
 <10c8864c-6ee7-4dfd-6274-b1996e767653@redhat.com> <CAHp75VdnxRQi3X6J9hLGUjGsOYTkjoPN5MakJc=mUSumoC+wag@mail.gmail.com>
 <c5546043-4f2d-979a-3718-a46f72bae20b@redhat.com>
In-Reply-To: <c5546043-4f2d-979a-3718-a46f72bae20b@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 May 2019 19:50:04 +0300
Message-ID: <CAHp75VfVfig-R1mVhdMdWrbfpA92VV3hc55SXgopmWT+kn6rnQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: pmc_atom: Add Lex 3I380D industrial PC to
 critclk_systems DMI table
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Semyon Verchenko <semverchenko@factor-ts.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 3:32 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi
>
> On 08-05-19 10:42, Andy Shevchenko wrote:
> > On Wed, May 8, 2019 at 10:48 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >> On 07-05-19 22:17, Stephen Boyd wrote:
> >>> Quoting Hans de Goede (2019-05-06 08:05:42)
> >
> >>> I guess this is urgent?
> >>
> >> Somewhat, getting this into e.g. rc2 would be fine too, waiting till 5.3
> >> would be bad.
> >
> > So, I can do it as a fixes for rc2, just ping me after merge window.
>
> The merge window is done now, can you please get the patch from this
> thread and the
> "PATCH 1/1] platform/x86: pmc_atom: Add several Beckhoff Automation boards to critclk_systems DMI table"
> patch queued up as fixes for 5.2 now ?

PR had been sent couple of hours ago, thanks!

-- 
With Best Regards,
Andy Shevchenko
