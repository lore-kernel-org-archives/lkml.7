Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81214C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5947D2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfLJVkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:40:22 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:49723 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfLJVkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:40:18 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MbSXf-1i8DVp0nqj-00bv4d for <linux-kernel@vger.kernel.org>; Tue, 10 Dec
 2019 22:40:16 +0100
Received: by mail-qk1-f175.google.com with SMTP id z14so7481495qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 13:40:16 -0800 (PST)
X-Gm-Message-State: APjAAAU3wQe1kzExBy9X5IIjCdrYzJKjlKi7kam84Jfl16lcNTMLVdLS
        p/CNyJ7sHFbeTIAFS+VSJFaCf6A8zEowzXHm/Oc=
X-Google-Smtp-Source: APXvYqxUoC6H/HWZMBtDiTF2+IJfRax40MKZBHGh8CU2NKudSB89mZzzFUDhBYEjsX0QO0qaYD1duiXIHE3h8N56nz0=
X-Received: by 2002:a37:4e4e:: with SMTP id c75mr13322344qkb.3.1576014015095;
 Tue, 10 Dec 2019 13:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20191210203101.2663341-1-arnd@arndb.de> <DM6PR12MB34665D3A13E23D8AA7E2E7919E5B0@DM6PR12MB3466.namprd12.prod.outlook.com>
 <b552de20-dca5-b5d1-e5e8-4c09bc3fdcb5@amd.com>
In-Reply-To: <b552de20-dca5-b5d1-e5e8-4c09bc3fdcb5@amd.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Dec 2019 22:39:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2qM2Vi9qH5b+REBWp2tpb96CpxjmeGSbc63XfGwD6ozg@mail.gmail.com>
Message-ID: <CAK8P3a2qM2Vi9qH5b+REBWp2tpb96CpxjmeGSbc63XfGwD6ozg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix undefined struct member reference
To:     "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Cc:     "Liu, Zhan" <Zhan.Liu@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Liu, Charlene" <Charlene.Liu@amd.com>,
        "Yang, Eric" <Eric.Yang2@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Cornij, Nikola" <Nikola.Cornij@amd.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Lei, Jun" <Jun.Lei@amd.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IX8poFHkhmWDMtT05CyGRNNlyICIfre20x86D5UgS/CzaHTuJED
 ZSkbMjlym3LobiOUkDBHJC7of/LSmA2SZqFZU/lnUMKA1rtjcAJLLYHkHdtwRJ+FIPJkXO/
 RXVqdNm3SLbjkzhKza3y7NAEFeSbQ/oSmoStH4eUEo9DsQwEJEd0rBmYOfD4gdo7Wt6be1J
 31A0jjhgPmqP9IPFO9v9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y0bKYy13xqM=:K5+KBmK6Pe1eeq0vlqvmUq
 pPqGAviGh1Zo4SCGhf6I1H2RLJwd62AdNHOdjMP4aWxxq0Pvozrz3ylSrE1YJpN+kxgjZD/4n
 KfcRW+gSRO8NXSXH7DXtOfP0vyo1imFET6FC1Ak6SeoVau1i3qkq3Kf7mJMN2OhsuxdvQ7RDT
 4sTexFuAVkdbXRNlQsYB/QvZX+AqMD3MRBO5VU/8DsPSOOULAlABlMqd/36sJXTsvRPVoUmIA
 wldqOS1XlCHsYGoz6raTMBLv+Wh19vFyNbkqjIfKoJGRc7UorDdEUE0KwSi0wN1FWCaiHrJbe
 rGh7a5AenYKZNYIVGN5wYPTRrVMtGI72c701REYkDFIOPUiQhBBuWEYG5hy+QX7eV8ZOzW0xt
 EzhOWRFuwA7C+oqRAc5hMm22EJ3Autjhbvx+YKPdGAKQt2OQeFNvZpVUmnOhcP58OBRy2AnD3
 dHbakyB7P+H/dEgZX/UJLqDYDJiskr8L3TQJgJVoMWKb3BpLL7dvZXwXiXT+EAyaoSFfuyNsx
 5pHEAZo/xGyRa1J85sVZ6wT5UnEuPyUHvSKp1gS6ZsskdtFnTiFL7I9u6iPlvZXxocvJ8SSMN
 QSDaH6pGHKL4MsMe+FH1BjNrHyqPuOOn01yHk0oXA8+XgafHPAJyOyA2cm0J2QiF7asLkJVtn
 BDC0+wEFJ1Al0AYP+hbcIjFQ9khsHlBnlEYdmPuFISTdRqCQyg7gKLyqQrA3nnHTSo1Fhilcr
 bBf2OyHNkcjNG439K1BJmmrxDpCvxd7v7GtjVHKerF5RGWUnZ0aDJ0D20UYHge8hFx3RwvXqT
 CXTlNrRgGD6YOTGShqYOFXkyezHlhbhSyDTG/GnTK6mKHFvqlmbW7srhBFiHJCSyJxPgoRd5b
 eB3e3wvIUvu94fqJVBLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 9:56 PM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
> On 2019-12-10 3:54 p.m., Liu, Zhan wrote:

> >>
> >> Fixes: c3d03c5a196f ("drm/amd/display: Include num_vmid and num_dsc
> >> within NV14's resource caps")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Thank you for catching that On my side I kept that flag enabled all the time, so I didn't realize there was a warning hidden here.
> >
> > Reviewed-by: Zhan Liu <zhan.liu@amd.com>
>
> What tree is this reported on?

This is plain linux-5.5-rc1.

> We dropped this flag whenever building DCN. Sounds like we're missing a
> patch if you're getting this.
>
> So this is a NAK from me for going into amd-staging-drm-next at least.

Fair enough, please revert c3d03c5a196f ("drm/amd/display: Include
num_vmid and num_dsc within NV14's resource caps") for 5.5-rc2 then.

      Arnd
