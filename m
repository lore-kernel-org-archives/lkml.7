Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF03C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC4A20828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bc/qm2Af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfF1QFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:05:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36975 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfF1QFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:05:45 -0400
Received: by mail-ot1-f68.google.com with SMTP id s20so6494168otp.4;
        Fri, 28 Jun 2019 09:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rB3m6lymfmEJSrj5bHYQhYToOLJuP/M6N6+Gh/hsbFw=;
        b=bc/qm2AfIl7/pff81NO1XSTxiwj/Tf0ODnPhZSJ5FTf056oge76zhm015auns2dWOc
         RinrawyZ0O2i6XS3+Gia3nZKyP4l+hj94CO63lQVLxbXgIhu7crlszsOV628/OdmjOHs
         sgA2BP1tBdIoQGCZBW6+NVSOzl9jEECi2MCa0a/YPJDDCTBDdePstSg/jnqv6PrxCsmQ
         ThKE283f5h0W/IlmNX0oHfVqT1Ne7o8ahjcCU6dkor7BD58aVUBqhrXrvV7DJyiPPXkB
         MJa5LLDboqWiBQHW5V5SO5bR4xRlOCIXS7xPSUT6OYP8peQqJOrSThluXwg3T02RX4Hq
         coBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rB3m6lymfmEJSrj5bHYQhYToOLJuP/M6N6+Gh/hsbFw=;
        b=f57rzuyiHsmTyh+TVoIAj1FYAiRWKgBIr4ozKq3hu0XIvUDr7tH+zU8MTJZA/hHuZV
         ypjoYJhKR+2CCyyNySxt8E0J7Ys1lbm5ts9ThCKZ9bHd0wKp+ioR7I1gMOyhbcCZihij
         fee0ecvLy5S47WCRGKySAz73TcPkqVr7jXLzYKUqiqMG1ExbNPvjt1C1VZV8LXVSWOHl
         ndXGe3VP0VIhesHazh8QVgexDcyP80Wcup2pvMZeepJyK/eFVUDIIfDAnEO2b1HACRPX
         6yuHLY0w7gh24fvIiB5QEp92s7UnqAVi7ndJgb6rmSKPpyfK3FXJxfMy0Kx3euFoe087
         x4VQ==
X-Gm-Message-State: APjAAAW6jhKf2xygj4clXyj4SY7oL7DW+1/H42IEKYRfEVpWpkUSkyAO
        Q5st7kTGeUf8FO6kzuDuEbLBLUxco/3NeRmAaZI=
X-Google-Smtp-Source: APXvYqxpqVINGUIuZUIFanNgoXeInzShDbpDl64F0HtsRM7t1NOYrZCC3Ebzuzy9/EHv7T38+pkX4a5YcGAPWYaVwrw=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr8604745otb.98.1561737944761;
 Fri, 28 Jun 2019 09:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190617165836.4673-1-colin.king@canonical.com>
 <20190619051308.23582-1-martin.blumenstingl@googlemail.com>
 <92f9e5a6-d2a2-6bf2-ff8a-2430fe977f93@canonical.com> <CAFBinCDmYVPDMcwAAYhMfxxuTsG=xunduN58_8e20zE_Mhmb7Q@mail.gmail.com>
 <CAFBinCC-LLpfXQRFcKBbUpCfKc0S9Xtt60QrhEThsOFV-T7vFw@mail.gmail.com>
 <c46d2d17-c35b-46f0-0674-0c55bea3a272@canonical.com> <CAFBinCBk5aPVE+vq5px3QKS1T_R=WGXXxEJMC9X676KGvi9jdg@mail.gmail.com>
 <26646ff1-059f-fb2d-e05d-43009aeb2150@canonical.com>
In-Reply-To: <26646ff1-059f-fb2d-e05d-43009aeb2150@canonical.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 28 Jun 2019 18:05:33 +0200
Message-ID: <CAFBinCAx5qrPK1z68bF-tGKpJQfKLnee65qBOxMS4nj8t381+Q@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: add sanity check to device_property_read_u32_array
 call
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alexandre.torgue@st.com, davem@davemloft.net, joabreu@synopsys.com,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        peppe.cavallaro@st.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Fri, Jun 28, 2019 at 10:32 AM Colin Ian King
<colin.king@canonical.com> wrote:
>
> On 28/06/2019 05:15, Martin Blumenstingl wrote:
> > On Tue, Jun 25, 2019 at 9:58 AM Colin Ian King <colin.king@canonical.com> wrote:
> >>
> >> On 25/06/2019 05:44, Martin Blumenstingl wrote:
> >>> Hi Colin,
> >>>
> >>> On Thu, Jun 20, 2019 at 3:34 AM Martin Blumenstingl
> >>> <martin.blumenstingl@googlemail.com> wrote:
> >>>>
> >>>> Hi Colin,
> >>>>
> >>>> On Wed, Jun 19, 2019 at 8:55 AM Colin Ian King <colin.king@canonical.com> wrote:
> >>>>>
> >>>>> On 19/06/2019 06:13, Martin Blumenstingl wrote:
> >>>>>> Hi Colin,
> >>>>>>
> >>>>>>> Currently the call to device_property_read_u32_array is not error checked
> >>>>>>> leading to potential garbage values in the delays array that are then used
> >>>>>>> in msleep delays.  Add a sanity check to the property fetching.
> >>>>>>>
> >>>>>>> Addresses-Coverity: ("Uninitialized scalar variable")
> >>>>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >>>>>> I have also sent a patch [0] to fix initialize the array.
> >>>>>> can you please look at my patch so we can work out which one to use?
> >>>>>>
> >>>>>> my concern is that the "snps,reset-delays-us" property is optional,
> >>>>>> the current dt-bindings documentation states that it's a required
> >>>>>> property. in reality it isn't, there are boards (two examples are
> >>>>>> mentioned in my patch: [0]) without it.
> >>>>>>
> >>>>>> so I believe that the resulting behavior has to be:
> >>>>>> 1. don't delay if this property is missing (instead of delaying for
> >>>>>>    <garbage value> ms)
> >>>>>> 2. don't error out if this property is missing
> >>>>>>
> >>>>>> your patch covers #1, can you please check whether #2 is also covered?
> >>>>>> I tested case #2 when submitting my patch and it worked fine (even
> >>>>>> though I could not reproduce the garbage values which are being read
> >>>>>> on some boards)
> >>> in the meantime I have tested your patch.
> >>> when I don't set the "snps,reset-delays-us" property then I get the
> >>> following error:
> >>>   invalid property snps,reset-delays-us
> >>>
> >>> my patch has landed in the meantime: [0]
> >>> how should we proceed with your patch?
>
> Your fix is good, so I think we should just drop/forget about my fix.
thank you for looking at the situation

as far I understand the -net/-net-next tree all commits are immutable
so if we want to remove your patch we need to send a revert
do you want me to do that (I can do it on Monday) or will you take care of that?


Martin
