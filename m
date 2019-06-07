Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6DFC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698F1208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B/6hqqM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbfFGSAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:00:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34119 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbfFGSAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:00:17 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so2096409iot.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpEKImARlNSrR2CnDXXq0hDAys3pJayRssH3rrFbf2w=;
        b=B/6hqqM0rL+x3KFCsh7CUaMSPWa9JWojv6AjMWoMhrS0wrU1xTYxzwXiUvpjHpkUQw
         SNx2W7ZoTf+ySa7oHh505uHwWR+M3fqOEIJUN0a63wixYrtcrvUANb5EgLcalI+np2RJ
         HiB74IYHz905zihBSHU9WNQVreYfYBXw2lEW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpEKImARlNSrR2CnDXXq0hDAys3pJayRssH3rrFbf2w=;
        b=B0FKc331uSJ6vrt4TJzVl2Z7Ab+eaXvrpxp+SnQJZk0/39ybtrJ+hceAA2M4WmbRc9
         Qz1aoitCoXeYYKIv34+MmZqNSnme78eOlswPzMs/4Eibabdc59+9fyryDvGI40HsrQ5w
         2e/fSnkH6B3FbBGIcpgwNzG2JZsIVU6Kywg3omuwaLdgu11oP28aRjOB87x85P6rePoB
         QGG1XZzbU/uncy6cLaWLonv0h4RLOEjDGlkUQw1HcvB148pldRq8dniJ2Fx2p1EYzTGT
         Qsyeku9IrsifYU7JdB7xiZrwx+CK3Q1d+EGQFn+2A4Lo+czt2RyI1ZUlYNwcv8zSIarc
         VP4g==
X-Gm-Message-State: APjAAAW4P9YpVFuVPNjehxY2gz9RwLsUJd8Gy+bZj/a/04ZT+LIeJg1t
        SHf1ZxosMVZEmOfygeIzBa4CBZB766Q=
X-Google-Smtp-Source: APXvYqxwm1H87ABC5atoGpZhDFNlojLrm5T+CLsckGgvRNOfBqIpLiVAxNoTr5OWSMiyIsFTYf9D2w==
X-Received: by 2002:a5e:d615:: with SMTP id w21mr36965874iom.0.1559930416903;
        Fri, 07 Jun 2019 11:00:16 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id m62sm1079656itg.24.2019.06.07.11.00.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:00:15 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id m24so2097882ioo.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:00:14 -0700 (PDT)
X-Received: by 2002:a6b:b642:: with SMTP id g63mr18948289iof.142.1559930414169;
 Fri, 07 Jun 2019 11:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190603183740.239031-1-dianders@chromium.org>
 <20190603183740.239031-4-dianders@chromium.org> <42fc30b1-adab-7fa8-104c-cbb7855f2032@intel.com>
 <CAD=FV=UPfCOr-syAbVZ-FjHQy7bgQf5BS5pdV-Bwd3hquRqEGg@mail.gmail.com> <2e9f80af-aa26-5590-9ff0-9889400068d6@intel.com>
In-Reply-To: <2e9f80af-aa26-5590-9ff0-9889400068d6@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Jun 2019 11:00:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WGxXvcCuuspAkHY=m+vhQ+R96i4HCBZNCO1-jQ5U9+3Q@mail.gmail.com>
Message-ID: <CAD=FV=WGxXvcCuuspAkHY=m+vhQ+R96i4HCBZNCO1-jQ5U9+3Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] brcmfmac: sdio: Disable auto-tuning around
 commands expected to fail
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        Franky Lin <franky.lin@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 7, 2019 at 5:29 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> >> @@ -711,8 +720,16 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
> >>                         err_cnt = 0;
> >>                 }
> >>                 /* bail out upon subsequent access errors */
> >> -               if (err && (err_cnt++ > BRCMF_SDIO_MAX_ACCESS_ERRORS))
> >> -                       break;
> >> +               if (err && (err_cnt++ > BRCMF_SDIO_MAX_ACCESS_ERRORS)) {
> >> +                       if (!retune_release)
> >> +                               break;
> >> +                       /*
> >> +                        * Allow one more retry with re-tuning released in case
> >> +                        * it helps.
> >> +                        */
> >> +                       sdio_retune_release(bus->sdiodev->func1);
> >> +                       retune_release = false;
> >
> > I would be tempted to wait before adding this logic until we actually
> > see that it's needed.  Sure, doing one more transfer probably won't
> > really hurt, but until we know that it actually helps it seems like
> > we're just adding extra complexity?
>
> Depends, what is the downside of unnecessarily returning an error from
> brcmf_sdio_kso_control() in that case?

I'm not aware of any downside, but without any example of it being
needed it's just untested code that might or might not fix a problem.
For now I'm going to leave it out of my patch and if someone later
finds it needed or if you're convinced that we really need it we can
add it as a patch atop.

-Doug
