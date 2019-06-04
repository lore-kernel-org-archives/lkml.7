Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1DEC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DF023CEC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R65lslW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfFDQtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:49:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37864 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfFDQtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:49:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so1384678eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=htJGxlotLvs1Z4U6dZKpFxplNjTIfrsnnYtpYuTDheU=;
        b=R65lslW41TgbT3+HYxMMjdC1uaQkK3+KBb3U0Ny04v00ZXQz0M5njpJO0tzBd/YuNW
         RxIApA/5BN6eLgog0OTyD225kmO2K54y61DD+jOoUglq8uH3oRxCm/TWybHsmKXMFkWn
         c/6tNH9A+v0XZFWm5dCH8txy2CUadmZk/a7Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=htJGxlotLvs1Z4U6dZKpFxplNjTIfrsnnYtpYuTDheU=;
        b=cLknR2KSJR0J7EGl/6ZVNjRIqDqK7rcPqwrXHc1aosL3K0Wspyf/yNGm/I46KoPj4o
         Ai4GX24tC1vXVtDxTmB0KJoFcV1v2ZE8+uEDhcsp/eSOmqftPDS5XaGEV9EhGkipsqtX
         VUp+jmBvwhFFD59mGHmcqffyT5mx10U0ZF9MW21B4sqQQrFJmMGwoUuK+P1l5aolQHZh
         4zNkVmPS4JvOH/Bx2Tk3/UGfMvYNTSG93GNimFZZKNQPV/GYxBopHM5dByN6W4n/pXp3
         rx8ZtMF1jAKHaWhpl2Qh421dADuA3wBYNHIhNXbhpPovTSGE8sWcM6D3XSYR6u3Hhu47
         L6nw==
X-Gm-Message-State: APjAAAWaQOth2Z8MpxLWaPU9jBPpXdYMNJLfGbVtghMYQQB1C3DCykyG
        fk1aZ4d0d9UOjVa2YCK1r1HS0Q==
X-Google-Smtp-Source: APXvYqztipAoz79D/S8ve0jSHSJoCk4kQevwSEFXnnm7enKqQcPjs6vXyDkTT7yXt9aaPM5FJWIVHw==
X-Received: by 2002:a17:906:d7ab:: with SMTP id pk11mr11277278ejb.216.1559666943273;
        Tue, 04 Jun 2019 09:49:03 -0700 (PDT)
Received: from [192.168.178.17] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id e45sm4818556edb.12.2019.06.04.09.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 09:49:02 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Doug Anderson <dianders@chromium.org>,
        Wright Feng <Wright.Feng@cypress.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        Madhan Mohan R <MadhanMohan.R@cypress.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        "Chi-Hsien Lin" <Chi-Hsien.Lin@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        "linux-wireless" <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Naveen Gupta <Naveen.Gupta@cypress.com>,
        "brcm80211-dev-list" <brcm80211-dev-list@cypress.com>,
        Double Lo <Double.Lo@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>
Date:   Tue, 04 Jun 2019 18:48:57 +0200
Message-ID: <16b2364c8c0.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAD=FV=Wr4WsO7Xmei5GB4X91L_sDN331B1_oH+CPZOeFUkxyMg@mail.gmail.com>
References: <20190517225420.176893-2-dianders@chromium.org>
 <20190528121833.7D3A460A00@smtp.codeaurora.org>
 <CAD=FV=VtxdEeFQsdF=U7-_7R+TXfVmA2_JMB_-WYidGHTLDgLw@mail.gmail.com>
 <16aff33f3e0.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <16aff358a20.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <40587a64-490b-8b1e-8a11-1e1aebdab2f3@cypress.com>
 <CAD=FV=Wr4WsO7Xmei5GB4X91L_sDN331B1_oH+CPZOeFUkxyMg@mail.gmail.com>
User-Agent: AquaMail/1.20.0-1451 (build: 102000001)
Subject: Re: [PATCH 1/3] brcmfmac: re-enable command decode in sdio_aos for BRCM 4354
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 4, 2019 6:01:26 PM Doug Anderson <dianders@chromium.org> wrote:

> Hi,
>
> On Mon, Jun 3, 2019 at 8:20 PM Wright Feng <Wright.Feng@cypress.com> wrote:
>>
>> On 2019/5/29 上午 12:11, Arend Van Spriel wrote:
>> > On May 28, 2019 6:09:21 PM Arend Van Spriel
>> > <arend.vanspriel@broadcom.com> wrote:
>> >
>> >> On May 28, 2019 5:52:10 PM Doug Anderson <dianders@chromium.org> wrote:
>> >>
>> >>> Hi,
>> >>>
>> >>> On Tue, May 28, 2019 at 5:18 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>> >>>>
>> >>>> Douglas Anderson <dianders@chromium.org> wrote:
>> >>>>
>> >>>> > In commit 29f6589140a1 ("brcmfmac: disable command decode in
>> >>>> > sdio_aos") we disabled something called "command decode in sdio_aos"
>> >>>> > for a whole bunch of Broadcom SDIO WiFi parts.
>> >>>> >
>> >>>> > After that patch landed I find that my kernel log on
>> >>>> > rk3288-veyron-minnie and rk3288-veyron-speedy is filled with:
>> >>>> >   brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep
>> >>>> state -110
>> >>>> >
>> >>>> > This seems to happen every time the Broadcom WiFi transitions out of
>> >>>> > sleep mode.  Reverting the part of the commit that affects the
>> >>>> WiFi on
>> >>>> > my boards fixes the problem for me, so that's what this patch does.
>> >>>> >
>> >>>> > Note that, in general, the justification in the original commit
>> >>>> seemed
>> >>>> > a little weak.  It looked like someone was testing on a SD card
>> >>>> > controller that would sometimes die if there were CRC errors on the
>> >>>> > bus.  This used to happen back in early days of dw_mmc (the
>> >>>> controller
>> >>>> > on my boards), but we fixed it.  Disabling a feature on all boards
>> >>>> > just because one SD card controller is broken seems bad.  ...so
>> >>>> > instead of just this patch possibly the right thing to do is to fully
>> >>>> > revert the original commit.
>> >>>> >
>> Since the commit 29f6589140a1 ("brcmfmac: disable command decode in
>> sdio_aos") causes the regression on other SD card controller, it is
>> better to revert it as you mentioned.
>> Actually, without the commit, we hit MMC timeout(-110) and hanged
>> instead of CRC error in our test.
>
> Any chance I can convince you to provide some official tags like
> Reviewed-by or Tested-by on the revert?
>
>> Would you please share the analysis of
>> dw_mmc issue which you fixed? We'd like to compare whether we got the
>> same issue.
>
> I'm not sure there's any single magic commit I can point to.  When I
> started working on dw_mmc it was terrible at handling error cases and
> would often crash / hang / stop all future communication upon certain
> classes or efforts.  There were dozens of problems we've had to fix
> over the years.  These problems showed up when we started supporting
> HS200 / UHS since the tuning phase really stress the error handling of
> the host controller.
>
> I searched and by the time we were supporting Broadcom SDIO cards the
> error handling was already pretty good.  ...but if we hadn't already
> made the error handling more robust for UHS tuning then we would have
> definitely hit these types of problems.  The only problem I remember
> having to solve in dw_mmc that was unique to Broadcom was commit
> 0bdbd0e88cf6 ("mmc: dw_mmc: Don't start commands while busy").  Any
> chance that could be what you're hitting?

That is indeed an issue I recall resulting in -110 errors.

> What host controller are you having problems with?

Knowing that will be a good start.

Regards,
Arend


