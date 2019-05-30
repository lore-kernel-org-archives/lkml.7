Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F71C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FA025FFE
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="RPnZUCBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfE3E6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:58:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40485 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389148AbfE3E6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:58:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so3371464qtn.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 21:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLmgEjHoFbZEgDIpNdCHV3eTKhj4yByl9zF5X6YEDyU=;
        b=RPnZUCBgRQHtYNK14mI5pN632nIxFQ9nLcYN1I5h78/zyx3v50ePjNHdlKRtRu/G3C
         hWbB0se/iWL0ROpD9gWbN28s4bBolC9R9WmpJRKZC2D8eoPKqSvW0def9L5GLi1i/Wry
         /pDU7Y8f9zQecUtCv0HO2QRN3jWQE9FmsnMbyQOFm7EnrJeXK4zBTV7Hn3MZXpoe51Kq
         iXtMHowwtmYgFLmJ7S19FxXG5pOdjdcZ/Is90S8cWSvOKjbufCIYwRFwMViwfBAhxYg0
         Yt+jtrrJdpuLDcqwyEaSLafp6AHzuWRI7L9f2qdZE+jVHczQoWI41SvYEzs+Bx/Nuat3
         gadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLmgEjHoFbZEgDIpNdCHV3eTKhj4yByl9zF5X6YEDyU=;
        b=hnviHFsgbwbLGPPvlNCEPB7pTule4tlJyNMjLTVzmYmYAjdLNHHKdIyXGURNiI/8Z7
         ffgbr6GC41GcLhv9b8Rpk8EEze6v+hN8yKb11d1KI91Z6G4+3BsO06gN205FVYmNJFCq
         XG+VU6lhKMgjBv11DbbYy9qDBudDAFudga38VSVg5OAMAWeYl+r0IbJHvLGa8LZIqgoS
         C1VVfAkIPNszuY8WNL6v17tV/iRJhgkseaQ2kdlBho2lowuBXlxUIYVY0fekyoxG79Br
         bEtG7nZiut5llImhPINr/zdaOwmIU/CfEmN2je9kkFb6F9eZbn9Ev5zrYZdfZUhtzRHW
         xZ8A==
X-Gm-Message-State: APjAAAXD70yrDE2g854HHkSc8FSf1kVIBpIpk5jm2o+xMV9JvvvMUihD
        EIYwt5r27f9nSfkzpTSxhgquX7jllj+g4SmF+M2EZw==
X-Google-Smtp-Source: APXvYqykJVzyUNjoIJTxPOCOl5J357hUfTlOmm8qycXoUfA80/eqCZBpMHgAh/kbPPhBE08WD9UbtmZTxYfSv0n8FEA=
X-Received: by 2002:a0c:be87:: with SMTP id n7mr1524590qvi.65.1559192309628;
 Wed, 29 May 2019 21:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190529050335.72061-1-chiu@endlessm.com> <5f5e262d-aadb-cca0-8576-879735366a73@lwfinger.net>
In-Reply-To: <5f5e262d-aadb-cca0-8576-879735366a73@lwfinger.net>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 30 May 2019 12:58:18 +0800
Message-ID: <CAB4CAwdB_8f-JZWWpXdYDghaGQv+Kc4H=G4UUrEK-_xbNg4Ctw@mail.gmail.com>
Subject: Re: [RFC PATCH v3] rtl8xxxu: Improve TX performance of RTL8723BU on
 rtl8xxxu driver
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 2:22 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 5/29/19 12:03 AM, Chris Chiu wrote:
> > We have 3 laptops which connect the wifi by the same RTL8723BU.
> > The PCI VID/PID of the wifi chip is 10EC:B720 which is supported.
> > They have the same problem with the in-kernel rtl8xxxu driver, the
> > iperf (as a client to an ethernet-connected server) gets ~1Mbps.
> > Nevertheless, the signal strength is reported as around -40dBm,
> > which is quite good. From the wireshark capture, the tx rate for each
> > data and qos data packet is only 1Mbps. Compare to the driver from
> > https://github.com/lwfinger/rtl8723bu, the same iperf test gets ~12
> > Mbps or more. The signal strength is reported similarly around
> > -40dBm. That's why we want to improve.
>
> The driver at GitHub was written by Realtek. I only published it in a prominent
> location, and fix it for kernel API changes. I would say "the Realtek driver at
> https://...", and every mention of "Larry's driver" should say "Realtek's
> driver". That attribution is more correct.

Thanks. I'll modify this in next revision.

> >
> > After reading the source code of the rtl8xxxu driver and Larry's, the
> > major difference is that Larry's driver has a watchdog which will keep
> > monitoring the signal quality and updating the rate mask just like the
> > rtl8xxxu_gen2_update_rate_mask() does if signal quality changes.
> > And this kind of watchdog also exists in rtlwifi driver of some specific
> > chips, ex rtl8192ee, rtl8188ee, rtl8723ae, rtl8821ae...etc. They have
> > the same member function named dm_watchdog and will invoke the
> > corresponding dm_refresh_rate_adaptive_mask to adjust the tx rate
> > mask.
> >
> > With this commit, the tx rate of each data and qos data packet will
> > be 39Mbps (MCS4) with the 0xF00000 as the tx rate mask. The 20th bit
> > to 23th bit means MCS4 to MCS7. It means that the firmware still picks
> > the lowest rate from the rate mask and explains why the tx rate of
> > data and qos data is always lowest 1Mbps because the default rate mask
> > passed is always 0xFFFFFFF ranges from the basic CCK rate, OFDM rate,
> > and MCS rate. However, with Larry's driver, the tx rate observed from
> > wireshark under the same condition is almost 65Mbps or 72Mbps.
> >
> > I believe the firmware of RTL8723BU may need fix. And I think we
> > can still bring in the dm_watchdog as rtlwifi to improve from the
> > driver side. Please leave precious comments for my commits and
> > suggest what I can do better. Or suggest if there's any better idea
> > to fix this. Thanks.
> >
> > Signed-off-by: Chris Chiu <chiu@endlessm.com>
>
> I have not tested this patch, but I plan to soon.
>
> Larry
>
>
