Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4614EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153D0233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566490283;
	bh=zOMLxHs2VWka/qFMYIuywdwW7/bJZ8chpRACeFjJll8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XO2JgRLk1rk9slkiMA6PSSIzjGs2MbpzNfFgW4iRw8OO42y4A0Sx2ykj+bRMD9uIJ
	 Ahw36sqJWONxi3On3MAPiEoyd3ugHscgrgjwk6lnw6pqdofMAamXRDTEowuzeqkNUO
	 Jfelna5cN48YZ8UNTA0qevdUTvELQQA+gX4ug770=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389833AbfHVQLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732895AbfHVQLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:11:21 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E72B0233FD;
        Thu, 22 Aug 2019 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566490281;
        bh=zOMLxHs2VWka/qFMYIuywdwW7/bJZ8chpRACeFjJll8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gx4N0gs5HtgNNNI/UK3B/3JnCYAtGMrYh/avF9aHXY/GFEJZDbLYFPe7BcU+uefo6
         1z2B/Cbb3Iwz6+HSYwszt9a4aVUn1gi1UUcz0vNkCCM/RQqTD4+ZHTyVumsknbyAib
         dqf8F5Co7o3Nq/0oOfMLaWbluVThrfcPlqT0P8nc=
Received: by mail-qt1-f169.google.com with SMTP id t12so8330749qtp.9;
        Thu, 22 Aug 2019 09:11:20 -0700 (PDT)
X-Gm-Message-State: APjAAAWsWUSAwK7W0Ym9mRCjVl7HPxKlNKqLSt+sGM/1oioVRnZQK9bB
        oi4l2PHNhfwdyLuFviOfDaabbUG7iPw9zhsfBA==
X-Google-Smtp-Source: APXvYqy6FBlK1ClzTIESpRbzxj+d3ls/cIRjhDZi4Cfkk62DRf1Upbl2njPgECs0QSQz5nK0p9oVjHnL75jmEGJ+Cvc=
X-Received: by 2002:ad4:4050:: with SMTP id r16mr122097qvp.200.1566490280005;
 Thu, 22 Aug 2019 09:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
 <20190809133407.25918-2-srinivas.kandagatla@linaro.org> <20190821214436.GA13936@bogus>
 <0272eafd-0aa5-f695-64e4-f6ad7157a3a6@linaro.org> <CAL_JsqJJCJB9obR_Jn3hmn4gq+RQjY-8M+xkdYA185Uaw0MHcw@mail.gmail.com>
 <90b9fa33-3a49-c414-4352-66e26673a05d@linaro.org>
In-Reply-To: <90b9fa33-3a49-c414-4352-66e26673a05d@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 22 Aug 2019 11:11:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLuH5=PLSVvyd=5oOECfcV3mgf8b842Y4ppJKG_NHds-g@mail.gmail.com>
Message-ID: <CAL_JsqLuH5=PLSVvyd=5oOECfcV3mgf8b842Y4ppJKG_NHds-g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: soundwire: add slave bindings
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vinod <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 7:56 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 22/08/2019 13:36, Rob Herring wrote:
> >>>> +soundwire@c2d0000 {
> >>>> +    compatible = "qcom,soundwire-v1.5.0"
> >>>> +    reg = <0x0c2d0000 0x2000>;
> >>>> +
> >>>> +    spkr_left:wsa8810-left{
> >>>> +            compatible = "sdw0110217201000";
> >>>> +            ...
> >>>> +    };
> >>>> +
> >>>> +    spkr_right:wsa8810-right{
> >>>> +            compatible = "sdw0120217201000";
> >>> The normal way to distinguish instances is with 'reg'. So I think you
> >>> need 'reg' with Instance ID moved there at least. Just guessing, but
> >>> perhaps Link ID, too? And for 2 different classes of device is that
> >>> enough?
> >> In previous bindings (https://lists.gt.net/linux/kernel/3403276  ) we
> >> did have instance-id as different property, however Pierre had some good
> >> suggestion to make it align with _ADR encoding as per MIPI DisCo spec.
> >>
> >> Do you still think that we should split the instance id to reg property?
> > Assuming you could have more than 1 of the same device on the bus,
> > then you need some way to distinguish them and the way that's done for
> > DT is unit-address/reg. And compatible strings should be constant for
> > each instance.
> That is a good point!
> Okay that makes more sense keep compatible string constant.
> Class ID would be constant for given functionality that the driver will
> provide.
>
> So we will end up with some thing like this:
>
> soundwire@c2d0000 {
>         compatible = "qcom,soundwire-v1.5.0"
>         reg = <0x0c2d0000 0x2000>;
>          #address-cells = <1>;
>          #size-cells = <0>;
>
>         spkr_left:skpr@1{
>                 compatible = "sdw10217201000";
>                 reg = <0x1>
>                 sdw-link-id = <0>;

Not really sure what Link ID is, but maybe it should be part of reg
too if it is part of how you address a device.

>                 ...
>         };
>
>         spkr_right:spkr@2{
>                 compatible = "sdw10217201000";
>                 reg = <0x2>
>                 sdw-link-id = <0>;
>         };
> };
>
> I will spin this in next version!
>
> Thanks,
> srini
>
> >
> > Rob
