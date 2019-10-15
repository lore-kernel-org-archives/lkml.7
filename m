Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B521C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE55217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TL+mG/A5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfJOHD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:03:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40632 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfJOHD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:03:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so22409957wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 00:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GHtFroTnmdsw/Ufdcr+oeGxBq/Br2emxbnTYV8HYTnw=;
        b=TL+mG/A5+Efmzbs0sdeqxBrMYlFpc2FrEEyfL35EFopAe+HsGZuSQJJOqZQFnTxLGk
         pXbcVtmRsFkkyzP/COnHyIpnMkaRZKdDE9YFzfjkak0a/3xf2LPASERjCd8qr95IHRop
         u3qrvdTDtspEI0NvFxBgbf1InlzLmWjVrH0eY7fH/BbUst9CyqS796cH7dD04UAF3fBs
         UOLUKY0DgE+awjrgKhTZml/iGB6Mmw9IF0FiORJ4TRf01y0n0aCHK+VQHtGMjbUWIOvR
         uXpTELzC7bA9CWJQ5mQCCcv0n723sA14uWqPiJBZSc7hkKmm/aRik47imHkpydcfVIQH
         LKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHtFroTnmdsw/Ufdcr+oeGxBq/Br2emxbnTYV8HYTnw=;
        b=hsVegkiIagpPCwgq15R7M8TXSfwxoikahqY4i+DoJtlnJsiPT4YhArOla+yzw7nFZH
         YOTbRJPJfmWgGE+9g7WDJFdX5HktXpM6tdb/IQRLf4tuFG9n8uL6CmMvg5txOA2BnLub
         TDYxau62BONCEd2nsk0y8GWY3RRvE99FpMODmDeIox2RqWEglnRPfWPBPCYu90G5vtcO
         5sNvgRaINEiIvt3q8cbuG0RHUmv01RB3hpYppCnCz1hlI63BM3BtpjH1ru6T4M9Zw2DW
         SBRvjBRYr12kGr1GyG3/BPb/zweCIbsoob0aBVTiUXO3nOPD38AibNRTlkX+zpVy/aV2
         E7jw==
X-Gm-Message-State: APjAAAVjABI7ymxkg1EcYNLBKYtrXUPRFHWmKIUjDA8RLbdAHpPTsLLW
        ySTM9WI8ARxAvarucqfgfgLHyj3p786GD4/R8Th3pw==
X-Google-Smtp-Source: APXvYqyKestQtzWxynMKapAwLdcXnenRLDrzlPOr7NMxNHh1aAGyDLQQ27NbkRbsM8xOclShSRlCeUCU8nceBe/WLeQ=
X-Received: by 2002:adf:f983:: with SMTP id f3mr28670813wrr.169.1571123035492;
 Tue, 15 Oct 2019 00:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191002231617.3670-1-john.stultz@linaro.org> <20191002231617.3670-3-john.stultz@linaro.org>
 <20191003112618.GA2420393@kroah.com> <CALAqxLWm_u3KsXHn4a6PdBCOKM1vs5k0xS3G5jY+M-=HBqUJag@mail.gmail.com>
 <9cfccb6a-fba1-61a3-3eb6-3009c2f5e747@redhat.com> <CALAqxLX3uSJKvRwzcQznaF4WK52BcM5Bh+PNXHmfDe1aTSUL8Q@mail.gmail.com>
 <fa44a7ab-14bc-24ec-a19b-7bf15e100ce1@redhat.com>
In-Reply-To: <fa44a7ab-14bc-24ec-a19b-7bf15e100ce1@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 15 Oct 2019 00:03:43 -0700
Message-ID: <CALAqxLWk-29eNJ+hPjSBcLLeMKbaZEY9A3LVz6fGjv=mjRmNqw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 8:22 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Anyways back the code to add a usb role switch notifier. I do
> not think that this is a good idea, this is making "core" changes
> to deal with a special case. If you are going to use a notfier for
> this then IMHO the notifier should be part of the hikey960 usb role
> swtich driver and not be in the usb-role-switch class code, since
> this is very much a device specific hack.

Ok, that sounds fair.  I still need to find some way to hook into the
role-switch path between the tcpm and the dwc3 in order to switch to
the hub, but I guess I can try to add a hook somewhere in the dwc3
code itself. I'll dig on this a bit.

thanks
-john
