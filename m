Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9A7C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD36F208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oYB6QTOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfETSUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:20:40 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43374 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfETSUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:20:39 -0400
Received: by mail-vs1-f66.google.com with SMTP id d128so9490511vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEsXYaOHHpFfqvOIf/R9j2mgz7hkA3ZSG0hiHjJfsfQ=;
        b=oYB6QTOAyrW+xrurBLaMKPFnUo9r8uSNIw0B5/zqa2y0TSIR3nr+FiEhLSwmdmx4XT
         PSW8n6oIFIvgbr1Q8u1FLhEjC2pMWGPcFrxz9D/vDnrjHb6YxdngV4/rsvj4XVMkiS7u
         zji43e+I4SpiwFIfKB7pf85C9sv2FuOd9EGRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEsXYaOHHpFfqvOIf/R9j2mgz7hkA3ZSG0hiHjJfsfQ=;
        b=o1UzQQp1RDbjh2nHcWNWAeV0gj6kwgdnLpKx6rupHXcSylfuptdCXjFBK/hu/lVNOO
         MX/39wDJwwcL0rSAcmJovYbvS3ZZGQy/lwP2MZE2eyaFmAKtf0D0r0oE/yhtAz0e0AID
         d0T1nWzUzFvpF1kmbUm0n5TJ8N5obigFO7yQh7cATpfEuEELLdjQVJ6TZXc0ylYAI06g
         OxH+Tlp7DACy0BvR1hQ+MhDDra7eo0l5cv8me0lKJHg3PeqlIzTbauZQg7pwEb2tCphs
         uBXEvZtwYkuCij7s3cbELXipLO2QMghQtLn6bbPdeOzGgIKOSrdA/MP6FHpQ1JmUz5rP
         iksQ==
X-Gm-Message-State: APjAAAUUpvp06yWveqZWQ+UX1p2IFOofzit/O7/D6BT4a9dtP07fNtgt
        oD2Clskzr9iZkk8iuNjGI2jRdrimXtE=
X-Google-Smtp-Source: APXvYqx6tvmqJsmEDv/aDQTv2cQsvAfccgX2Q9zvB7zSfEN5dpmFzczY+EEj1y7IAfhvOPUWrnrzFw==
X-Received: by 2002:a05:6102:382:: with SMTP id m2mr17617742vsq.134.1558376438361;
        Mon, 20 May 2019 11:20:38 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id n23sm11555732vsj.27.2019.05.20.11.20.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 11:20:34 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id u4so5602715uau.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:20:34 -0700 (PDT)
X-Received: by 2002:a9f:24a3:: with SMTP id 32mr13553176uar.109.1558376433588;
 Mon, 20 May 2019 11:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-2-dianders@chromium.org> <e3f54bcb-8d10-1336-1458-2bd11cfc1010@broadcom.com>
In-Reply-To: <e3f54bcb-8d10-1336-1458-2bd11cfc1010@broadcom.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 May 2019 11:20:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uvc1wUQe-W1Jvm_gQ722pFm2a4OWvJDNVtkyQynFe4Gw@mail.gmail.com>
Message-ID: <CAD=FV=Uvc1wUQe-W1Jvm_gQ722pFm2a4OWvJDNVtkyQynFe4Gw@mail.gmail.com>
Subject: Re: [PATCH 1/3] brcmfmac: re-enable command decode in sdio_aos for
 BRCM 4354
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        Franky Lin <franky.lin@broadcom.com>,
        netdev <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        brcm80211-dev-list@cypress.com, YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 20, 2019 at 1:09 AM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 5/18/2019 12:54 AM, Douglas Anderson wrote:
> > In commit 29f6589140a1 ("brcmfmac: disable command decode in
> > sdio_aos") we disabled something called "command decode in sdio_aos"
> > for a whole bunch of Broadcom SDIO WiFi parts.
> >
> > After that patch landed I find that my kernel log on
> > rk3288-veyron-minnie and rk3288-veyron-speedy is filled with:
> >    brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep state -110
> >
> > This seems to happen every time the Broadcom WiFi transitions out of
> > sleep mode.  Reverting the part of the commit that affects the WiFi on
> > my boards fixes the problem for me, so that's what this patch does.
>
> This sounds very similar to the issue we had during integration of wifi
> on rk3288 chromebooks years ago.

I'm working on those same Chromebooks.  ;-)  I'm working on trying to
make them well on newer kernels.

...but I guess you're saying that the problem faced by the people who
wanted commit 29f6589140a1 ("brcmfmac: disable command decode in
sdio_aos") are similar to the problems we saw in the past on those
Chromebooks.  I'd tend to agree.  In general it's difficult to get a
SD Host Controller to be fully robust in the fact of any/all errors on
the bus.  While dw_mmc is pretty robust these days I'm assuming that
some other host controllers aren't.


> > Note that, in general, the justification in the original commit seemed
> > a little weak.  It looked like someone was testing on a SD card
> > controller that would sometimes die if there were CRC errors on the
> > bus.  This used to happen back in early days of dw_mmc (the controller
> > on my boards), but we fixed it.  Disabling a feature on all boards
> > just because one SD card controller is broken seems bad.  ...so
> > instead of just this patch possibly the right thing to do is to fully
> > revert the original commit.
>
> I am leaning towards a full revert, but let's wait for more background info.

I'd be fine with a full revert too.  Presumably that will break
someone but maybe they need to come up with a better solution?

-Doug
