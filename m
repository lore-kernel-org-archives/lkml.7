Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB868C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45E12077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ARPF8ysR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfGQJIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:08:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41547 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbfGQJIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:08:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so10978746lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 02:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7UdXNTU/Lcm5T+73Mu9Lk3fJTqZdL2ygB2hxg/bvs0=;
        b=ARPF8ysRS2qme660bnfPo9Sf6dUPUtYkSPR39gw+zuIoL7NZtNifRCF1SXDGFunevB
         uB8IuWYM1iKac8uIBfwlUQMiC8nlsO8DxhVUztZfWDxGTVv0AP3VA2gNewP/19w1a1LW
         +DLcKtE6254Ku0JHNY1kGsvrzSV9XAaFc8P93ruj/1XfqkiXTeiLARokVfXAhvHNhUAp
         oU/deRwXfo0vLuXt+HfYNfQX609LSRr1XRlJKA2ojTpGANWQaz3QzdMP8uvHrMD7iW8j
         FKIENDnCF1zDqRZvKhZ/RJljDTl2EmbDSDS67+xcSz06fthg9HXQPPGsqQ0bzxxY3PqD
         Ki/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7UdXNTU/Lcm5T+73Mu9Lk3fJTqZdL2ygB2hxg/bvs0=;
        b=ukU0R2kj1rk37MmdWEQCb2IfKQpC4CWDe2cXA22t7BpRja8TR1oUOk9X3p7XSBtIv0
         EcTpiFiInmZQ7yaCYUb0ma+BchbkIStcpvVh+OhQPD0tNtTTPuwvcSluUI/It8M72hJU
         iUpIzEXzfr0+h/grIAWy2jSQla0djh0oODgPuhaYvuiUiY0V/QPupBMhwE5/ZpxttzFF
         xjt2QuXB2yT89va4jOLlJr78rMMRli11mqAN4OKFsZBu6KET1hQaermZQpuym4Sm/nHq
         hjaS3EGQpx1384OSS+iTxetpGvjk1NJOF5szEy9tcR9bgbfb8GIGbAp+laAthNrGHR93
         kMxg==
X-Gm-Message-State: APjAAAW70fnpstcn+WGtCJTQUOL8R66WkOykxa9ukWOR/PeqVP2Zro6w
        7Fz7exyfViU9Yp6IZUgHrqniq7SsJPWYJXQaGJ2/Zg==
X-Google-Smtp-Source: APXvYqyUa5Y6gp/AOOmOhWXG0woHIHFHQ/pw+MgFTpkHnca8dVBQpSXO7UwrMm763Jwm92ZWv/5Cb/402QneMPo+DUs=
X-Received: by 2002:ac2:4644:: with SMTP id s4mr17067571lfo.158.1563354489475;
 Wed, 17 Jul 2019 02:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <1558611952-13295-1-git-send-email-yash.shah@sifive.com>
 <1558611952-13295-2-git-send-email-yash.shah@sifive.com> <CAL_Jsq+p5PnTDgxuh9_Aw1RvTk4aTYjKxyMq7DPczLzQVv8_ew@mail.gmail.com>
 <b0c60ec9-2f57-c3f5-c3b4-ee83a5ec4c45@microchip.com>
In-Reply-To: <b0c60ec9-2f57-c3f5-c3b4-ee83a5ec4c45@microchip.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Wed, 17 Jul 2019 14:37:33 +0530
Message-ID: <CAJ2_jOFEVZQat0Yprg4hem4jRrqkB72FKSeQj4p8P5KA-+rgww@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/macb: bindings doc: add sifive fu540-c000 binding
To:     Nicolas Ferre <Nicolas.Ferre@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 9:08 PM <Nicolas.Ferre@microchip.com> wrote:
>
> On 23/05/2019 at 22:50, Rob Herring wrote:
> > On Thu, May 23, 2019 at 6:46 AM Yash Shah <yash.shah@sifive.com> wrote:
> >>
> >> Add the compatibility string documentation for SiFive FU540-C0000
> >> interface.
> >> On the FU540, this driver also needs to read and write registers in a
> >> management IP block that monitors or drives boundary signals for the
> >> GEMGXL IP block that are not directly mapped to GEMGXL registers.
> >> Therefore, add additional range to "reg" property for SiFive GEMGXL
> >> management IP registers.
> >>
> >> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> >> ---
> >>   Documentation/devicetree/bindings/net/macb.txt | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
> >> index 9c5e944..91a2a66 100644
> >> --- a/Documentation/devicetree/bindings/net/macb.txt
> >> +++ b/Documentation/devicetree/bindings/net/macb.txt
> >> @@ -4,6 +4,7 @@ Required properties:
> >>   - compatible: Should be "cdns,[<chip>-]{macb|gem}"
> >>     Use "cdns,at91rm9200-emac" Atmel at91rm9200 SoC.
> >>     Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs.
> >> +  Use "cdns,fu540-macb" for SiFive FU540-C000 SoC.
> >
> > This pattern that Atmel started isn't really correct. The vendor
> > prefix here should be sifive. 'cdns' would be appropriate for a
> > fallback.
>
> Ok, we missed this for the sam9x60 SoC that we added recently then.
>
> Anyway a little too late, coming back to this machine, and talking to
> Yash, isn't "sifive,fu540-c000-macb" more specific and a better match
> for being future proof? I would advice for the most specific possible
> with other compatible strings on the same line in the DT, like:
>
> "sifive,fu540-c000-macb", "sifive,fu540-macb"
>

Yes, I agree that "sifive,fu540-c000-macb" is a better match.

> Moreover, is it really a "macb" or a "gem" type of interface from
> Cadence? Not a big deal, but just to discuss the topic to the bone...

I believe it should be "gem". I will plan to submit the patch for
these changes. Thanks for pointing it out.

- Yash

>
> Note that I'm fine if you consider that what you have in net-next new is
> correct.
>
> Regards,
>    Nicolas
>
> >>     Use "cdns,sam9x60-macb" for Microchip sam9x60 SoC.
> >>     Use "cdns,np4-macb" for NP4 SoC devices.
> >>     Use "cdns,at32ap7000-macb" for other 10/100 usage or use the generic form: "cdns,macb".
> >> @@ -17,6 +18,8 @@ Required properties:
> >>     Use "cdns,zynqmp-gem" for Zynq Ultrascale+ MPSoC.
> >>     Or the generic form: "cdns,emac".
> >>   - reg: Address and length of the register set for the device
> >> +       For "cdns,fu540-macb", second range is required to specify the
> >> +       address and length of the registers for GEMGXL Management block.
> >>   - interrupts: Should contain macb interrupt
> >>   - phy-mode: See ethernet.txt file in the same directory.
> >>   - clock-names: Tuple listing input clock names.
> >> --
> >> 1.9.1
> >>
> >
>
>
> --
> Nicolas Ferre
