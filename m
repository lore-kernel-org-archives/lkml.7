Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C02C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817FE2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCb+t9jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfJFTuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 15:50:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35426 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJFTuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:50:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so12779675wrt.2;
        Sun, 06 Oct 2019 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=SF3ve2/BTUkIULmgsBwIXtaoivMNXD9/DFfQmDFlSVM=;
        b=WCb+t9jwEYGZQSJkSVHLE8EFck+4SgZCH15o1AjWwGVAVttdTdlgxF+XKZYy991Efi
         2l62TnJxPwv5rVodwo1DxxTQq8u4Ha/igbJxxJkqp/FTvZSJIzJa15SlpF0jtT+ihlrI
         uxlujJ28cUf4Yk33siXsvvLBdSWz3kB2EVfeqyio4GxAVNllD38S2PSKwBNWfRzU82yP
         nEJSKnl2roA1Kf5gYoLkvzIDo09z2ufMc6CUCUfYaXoiYDqJXAuXAc8+S9EMfDx++xLi
         BYPNjy80Igjw7V2WjmPeRSxmGb7CeaTe25IXDwaC5kvEqCqMdNT7h5ywWBUw05jZtWHH
         WF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=SF3ve2/BTUkIULmgsBwIXtaoivMNXD9/DFfQmDFlSVM=;
        b=bkbB2HyTCbZoigD2INvkRgwGgzKXZQofLYDpWeE5DI2ZrNrJOAZuzuVJHB6UvUpcoB
         8ikpFZybdSCN1FmL5yJKi661s150jjoVezYnt+2sBpBkmXkEJWtIvaWf/83LhiMRifZC
         h2ukTR41qtN35hIhhDXow6cj2f01uLjtPnZWUxfTh6kVXv0/ZNv+JXBC+wTe/nIdu/hB
         cJI88MAnBNkZPSmNHUqgJ7YIoPexxX+Wm4jGpcm4nD+m6wGNsy5YX3+cO05raAbOwmcs
         3nNeOgwYYnPwwLvJq2i/YaMZ2Z57eli/Se734sfKyJhaOMqaRXo4DUO3tBi82kqRaFVi
         r5PA==
X-Gm-Message-State: APjAAAW+7fl458MXPmnBDiO5yrxobD9mp2Jpqu1pSKnFJD+yFoRPUmIh
        7S1NqUD1d7YGNNMEiBZmXz8=
X-Google-Smtp-Source: APXvYqxATYtyWsBwj3st87+ddDby4qJ5JPK9YSeU7U9c5UyOyXXi8fOFenqo8kZijK2LBkrzcVLj0A==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr17998797wrw.281.1570391419078;
        Sun, 06 Oct 2019 12:50:19 -0700 (PDT)
Received: from localhost ([94.73.41.211])
        by smtp.gmail.com with ESMTPSA id u10sm13213035wmm.0.2019.10.06.12.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 12:50:18 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <ezequiel@collabora.com>,
        <akash@openedev.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix usb-c on Hugsun X99 TV Box
Date:   Sun, 06 Oct 2019 21:50:16 +0200
MIME-Version: 1.0
Message-ID: <4cb2b781-e177-4008-86ae-a9108bd303e4@gmail.com>
In-Reply-To: <20191005005200.GA11418@vivek-desktop>
References: <20190929032230.24628-1-npcomplete13@gmail.com>
 <54c67ca8-8428-48ee-9a96-e1216ba02839@gmail.com>
 <20190929234615.GA5355@vivek-desktop> <2223294.9I8gkMH88G@phil>
 <20191005005200.GA11418@vivek-desktop>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, October 5, 2019 2:52:00 AM CEST, Vivek Unune wrote:
> On Fri, Oct 04, 2019 at 11:45:08PM +0200, Heiko Stuebner wrote:
>> Hi Vivek,
>>=20
>> Am Montag, 30. September 2019, 01:46:15 CEST schrieb Vivek Unune: ...
>
> Hi Heiko,
>
> I tested the c09b73cf patch without modifying exsisting dts. I can confirm
> that that patch doesn't work for me. No usb-c devices were recognized.
>
> Vicen=C3=A7 - were you able to test it?

I can also confirm that

c09b73cfac2a9317f1104169045c519c6021aa1d
usb: dwc3: don't set gadget->is_otg flag

alone does not fix the issue.

e1d9149e8389f1690cdd4e4056766dd26488a0fe
arm64: dts: rockchip: Fix USB3 Type-C on rk3399-sapphire

is still required for the USB-C to work on the Sapphire board.

Regards,
  Vicen=C3=A7.

> As soon as I apply dts patch, usb-c devices are recognized.
>
> Thanks,
>
> Vivek

