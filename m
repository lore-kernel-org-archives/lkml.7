Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4E6C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8159720645
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Qrs+9teS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfFVAdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:33:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45393 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfFVAda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:33:30 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so5219175ioc.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NHLr//yQH3FibWWGf0VOdOavz2CGejgKb89IUY1MXFo=;
        b=Qrs+9teS7UTpNo2fGNSwnTnrhefMfzdW8D6HsbxK6k6IJ3rUcPChijTddejlho5w0k
         lNhWWeMdKb7GSy5o9Wt/kZH6YUAlxG5bwjlHgjlqtwbYNjFgmSFrDySBkOH8VYiLFVog
         BUPhcxeEr/MaJIiquLdplXElopUWHZT3bPTFr3cfFG7EfzGovHA9gRfEwdKuPQO5UqZu
         MKDfFUcB5ltI9K145I5ktm68luneLChPyFgiorD4CMrNLC4j2MXFJEY6M7RjX9h3ctgo
         48HG7QRrtcb37BD1k09Gw1yi3BKlSuxuaYLYXCYNDTE0B/XoRndnGTAMYA4ERncr/HxK
         dazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NHLr//yQH3FibWWGf0VOdOavz2CGejgKb89IUY1MXFo=;
        b=lRnaD+jwD0YEGUbRoLhtOa9KrE99H7t+BxvO6vDr20grj+mGGzBNTmX7qtoG7a9EXB
         ATK9B8XPPR+exWObYKzo0RObZ22ciVFql8sgf2HY1xIJaTZ/SRnIVqtx+2BJqYfwljVe
         E5nLZxFksoC/VhSTceOTuCojpvNYKlZzh+lXI/8W0nNByMUKJN4EXmQ1kDXc1Vbeo/qn
         WXRpF71VHl5UB1s3vneapGTIXy1dJuowyDKFXQQXOrISkhzPxE928/m0cZL1aVOVBemm
         4TyIr46PLAQiq2GkjitosKvor9QvQVz8j+nhn5MpgQbN0K4u0+ZBs+rE1k8QfXCWpeqW
         2cHQ==
X-Gm-Message-State: APjAAAXysRjgK8uVcL5xynyNb6ObKNGQExrZcc7ZQvAWWNZnEYrKPsUF
        A+QjcAmKCMzJ5P2P1b8pLFGssg==
X-Google-Smtp-Source: APXvYqxKicFVJ7wXzGl2bB4xCk/+YuG5c3I5NfchOVDHv5Um/Mjq2VFrSa7LjeWfHs1Nqhg56Sd1pQ==
X-Received: by 2002:a5d:9c46:: with SMTP id 6mr3383520iof.6.1561163609280;
        Fri, 21 Jun 2019 17:33:29 -0700 (PDT)
Received: from [192.168.1.196] ([216.160.37.230])
        by smtp.gmail.com with ESMTPSA id q13sm4895543ioh.36.2019.06.21.17.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 17:33:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
From:   Troy Benjegerdes <troy.benjegerdes@sifive.com>
In-Reply-To: <43da99709709d2a480b78f25356cda9255205372.camel@wdc.com>
Date:   Fri, 21 Jun 2019 19:33:27 -0500
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "sachin.ghadi@sifive.com" <sachin.ghadi@sifive.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "yash.shah@sifive.com" <yash.shah@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>
Content-Transfer-Encoding: 7bit
Message-Id: <A3E7D245-ABFA-4D81-87D6-3F6983AA3A93@sifive.com>
References: <1561114429-29612-1-git-send-email-yash.shah@sifive.com>
 <1561114429-29612-2-git-send-email-yash.shah@sifive.com>
 <18c7992607dd1fed062bd295ac0738a759eff078.camel@wdc.com>
 <CAF5mof3QB8C7VjOyEvCsf9NEDkJhV3cBO5sBD+8z-GrWrnrAyg@mail.gmail.com>
 <3f91c8032e113a19dcec10ca71b017af1427ef7e.camel@wdc.com>
 <43da99709709d2a480b78f25356cda9255205372.camel@wdc.com>
To:     Atish Patra <Atish.Patra@wdc.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 21, 2019, at 4:59 PM, Atish Patra <Atish.Patra@wdc.com> wrote:
> 
> On Fri, 2019-06-21 at 14:46 -0700, Atish Patra wrote:
>> On Fri, 2019-06-21 at 14:18 -0500, Troy Benjegerdes wrote:
>>> Can you post the fsbl and other images you used to boot/test this?
>>> 
>> 
> 
> Resending it without the attachment. Obviously, the mail did not go
> through with the binary blob attached :( :(. My bad.
> 
> Let me know if you still want me to share the binary with you. I will
> probably share it via some other method.

The bl came through as it was sent direct to me, and I can deal with
the tftp config manually. I have a kernel image, but not the boot.scr.uimg
that it looks like you are using. Is that from Yocto?

> 
>> I have not changed fsbl. It's the default one came with the board.
>> Here are the heads of OpenSBI + U-Boot + Linux repo.
>> 
>> OpenSBI: cd2dfdc870ed (master)
>> U-boot: 77f6e2dd0551 + Anup's patch series (v4)
>> https://github.com/atishp04/u-boot/tree/unleashed_working
>> 
>> Linux: bed3c0d84e7e + Yash's Macb Series + this patch
>> https://github.com/atishp04/linux/tree/5.2-rc6-pre
>> 
>> I have also attached the OpenSBI + U-boot binary as well. But this is
>> pre-configured with my tftpboot server. You need to change that.
>> 
>>> I keep running into various failures when I build from source and I
>>> want to rule out potential hardware issues related to clock and/or
>>> ddr initialization
>>> 
>>> On Fri, Jun 21, 2019, 2:14 PM Atish Patra <Atish.Patra@wdc.com>
>>> wrote:
>>>> On Fri, 2019-06-21 at 16:23 +0530, Yash Shah wrote:
>>>>> DT node for SiFive FU540-C000 GEMGXL Ethernet controller driver
>>>> added
>>>>> Signed-off-by: Yash Shah <yash.shah@sifive.com>
>>>>> ---
>>>>> arch/riscv/boot/dts/sifive/fu540-c000.dtsi          | 16
>>>>> ++++++++++++++++
>>>>> arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  9
>>>> +++++++++
>>>>> 2 files changed, 25 insertions(+)
>>>>> 
>>>>> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>>>>> b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>>>>> index 4e8fbde..c53b4ea 100644
>>>>> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>>>>> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>>>>> @@ -225,5 +225,21 @@
>>>>>                      #address-cells = <1>;
>>>>>                      #size-cells = <0>;
>>>>>              };
>>>>> +             eth0: ethernet@10090000 {
>>>>> +                     compatible = "sifive,fu540-macb";
>>>>> +                     interrupt-parent = <&plic0>;
>>>>> +                     interrupts = <53>;
>>>>> +                     reg = <0x0 0x10090000 0x0 0x2000
>>>>> +                            0x0 0x100a0000 0x0 0x1000>;
>>>>> +                     reg-names = "control";
>>>>> +                     status = "disabled";
>>>>> +                     local-mac-address = [00 00 00 00 00 00];
>>>>> +                     clock-names = "pclk", "hclk";
>>>>> +                     clocks = <&prci PRCI_CLK_GEMGXLPLL>,
>>>>> +                              <&prci PRCI_CLK_GEMGXLPLL>;
>>>>> +                     #address-cells = <1>;
>>>>> +                     #size-cells = <0>;
>>>>> +             };
>>>>> +
>>>>>      };
>>>>> };
>>>>> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-
>>>>> a00.dts
>>>>> b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>>>>> index 4da8870..d783bf2 100644
>>>>> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>>>>> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>>>>> @@ -63,3 +63,12 @@
>>>>>              disable-wp;
>>>>>      };
>>>>> };
>>>>> +
>>>>> +&eth0 {
>>>>> +     status = "okay";
>>>>> +     phy-mode = "gmii";
>>>>> +     phy-handle = <&phy1>;
>>>>> +     phy1: ethernet-phy@0 {
>>>>> +             reg = <0>;
>>>>> +     };
>>>>> +};
>>>> 
>>>> Thanks. I am able to boot Unleashed with networking enabled with
>>>> this
>>>> patch.
>>>> 
>>>> FWIW, 
>>>> Tested-by: Atish Patra <atish.patra@wdc.com>
>>>> 
>>>> Regards,
>>>> Atish
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv

