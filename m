Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67640C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F472087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b9QWvLYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfD2Rne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:43:34 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41717 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbfD2Rn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:43:29 -0400
Received: by mail-vs1-f67.google.com with SMTP id g187so6400555vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ofJyIqXwomA7GmqHzXwPuN8m6L/H0ryPXhElh4AzLbo=;
        b=b9QWvLYtbc+VcNpxKV+IAdHf8oOksS7WNX6Jars+H2fG+d6ckHlQ4BFMCrET38xecj
         gSQ6VW5/T+RIZwE3S2Kc+cQK/ngg2sceJ2wMxtRGy0aUsrkJA41QOvbvb7RCsq6AXXbR
         3/oNq6sHc+kr5KfFz9Cc5x0ei1ULxzSvuFGZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ofJyIqXwomA7GmqHzXwPuN8m6L/H0ryPXhElh4AzLbo=;
        b=I98iuj/lnQ6+OnD3uj0HQL7cF+bF2iy7oYHUfPb1zGhiumBwsacxmoD6BbuSX06ZjY
         z42ozXGGj7VCm2uTFWRn3ASQThRNgKpow1nVGwzX6E6j0ZIEgu0/Zfy33/n94sVBbw8h
         I7i9NWp9XXzcu2I39dB3+VoAPlj3h2yIs9Urf/A/AuJVEvR0sc3FUvy/10fZUw/m2Ym+
         oCsuHlKvxh52BuU7rqjIqVOf7pFqm83pMMv+Ctz1LGWuuvv5cmrglvrOMFh8wodXXfo+
         G6s1A7QKZry2cTj36B8LEZJtfvEURmdGxxVpHFfC0NdJ++z19sOQaud5PPW5YgrXAMoB
         vM4g==
X-Gm-Message-State: APjAAAXVXtdOdRV3QjldavDjP7Oymb4wcHcAma7rx6WZhvuoA2gDXotY
        njOlddGvDIbOUKAraxOth5q0Ap+MqzI=
X-Google-Smtp-Source: APXvYqxRE0J1LhmcrQP6BJXSFd0m2w8OicqDE9jcP97UyTLGR6XZKx6HZep3ACTkZjkKooVM9mXZEA==
X-Received: by 2002:a67:b44c:: with SMTP id c12mr12631254vsm.169.1556559808355;
        Mon, 29 Apr 2019 10:43:28 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 2sm38975733vke.27.2019.04.29.10.43.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 10:43:27 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id p13so3785467uaa.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:43:26 -0700 (PDT)
X-Received: by 2002:ab0:20c1:: with SMTP id z1mr6396608ual.109.1556559806547;
 Mon, 29 Apr 2019 10:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555672441.git.arturp@synopsys.com> <87k1fis1b5.fsf@linux.intel.com>
 <SN1PR12MB2431EB450993E07730C3672FA73D0@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=WKJMks9oCdUVS9vTKp9yD_VPE_uaAmTM9HgNoz8tt4pA@mail.gmail.com>
 <SN1PR12MB24312AEFA71B7EEF6FE4EB59A73E0@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=WmtKYt5hn8s1PrjEgFcJqyc-8UWbyEmjPPVq0o4YgD5w@mail.gmail.com>
 <CAD=FV=WM7k-6moen+sgzZXnX-Zcw_BY9L=RTTrmt6pSHpXPLng@mail.gmail.com> <SN1PR12MB2431C9312AD486935C9B728AA7390@SN1PR12MB2431.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB2431C9312AD486935C9B728AA7390@SN1PR12MB2431.namprd12.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Apr 2019 10:43:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VtNUu0GyamvOv8x4rFHjFZdOaLMkFN=Rh0mJED08fW2Q@mail.gmail.com>
Message-ID: <CAD=FV=VtNUu0GyamvOv8x4rFHjFZdOaLMkFN=Rh0mJED08fW2Q@mail.gmail.com>
Subject: Re: [PATCH v1 00/14] usb: dwc2: Fix and improve power saving modes.
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 29, 2019 at 5:05 AM Artur Petrosyan
<Arthur.Petrosyan@synopsys.com> wrote:
>
> > To add a bit of breadcrumbs, I did the rebase atop my patches and also
> > did some basic review of yours.  Other than a few nits I think I found
> > at least one bug where you're unlocking a spinlock twice in the
> > partial power down case.
> Yeah thank you so much for the review it really helps to make
> conclusions on the implementations. I have tested those patches on
> HAPS-DX platform and have not got any problem. Hibernation and partial
> power down flows are working ok.

Do you happen to have any boards that have "OTG_EN_PWROPT =3D 0"?  I'd
love testing of my patch series with that.


> > I continue to be convinced that the right thing to do is to finish
> > landing my series and then once you've spun yours atop mine we can
> > look at landing it.
> >
> > Here's all my picks atop Felipe's tree that show how I resolved
> > things:  https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__chromiu=
m.googlesource.com_chromiumos_third-5Fparty_kernel_-2Blog_refs_sandbox_dian=
ders_190426-2Ddwc2-2Dstuff&d=3DDwIFaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFK=
CJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3Dmdz-R9O5TUR_zXEeeCZO2341dvcwZro2c=
edCZzIIans&s=3DmVfBGtiMQg2XVHXmGCWcd584g0DYRH1JDVnEnJWE6P8&e=3D
> >
> >
> > -Doug
> >
>
> I will make my changes then will go ahead and rebase.

Thanks!


-Doug
