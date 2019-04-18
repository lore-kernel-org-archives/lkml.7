Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359BCC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBA22083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="bMQh9r/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389684AbfDRQ4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:56:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43978 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388819AbfDRQ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:56:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id f18so2490463lja.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a65YTKMZPVfyr/OzNwVWAH0nGUFxpw6A5T7wD1qw9X0=;
        b=bMQh9r/umT6ptFa2YD+uz0RncohLw6hge3i0y3wJ+g+EjOMbPT0taoCo0llGhHyxFQ
         0AtfmnKS3E7pbNNB43Z7mEbh4cA/a/3KPyEaB8sOUMn1CjthxpefXmHz2yfG8J70QUz0
         deec+4UNl5R6cicLlBU6zyYTnkhyygfjzudsr/G6P8HUraxKL7z8TXAKx3Po+K2vKo8B
         NEB5F91/m2F3Y9Wvn4BOu0nCM5ANdv3M+FmLfGLjd0hGSHKL+S+v047mQtNJc8fTMZOO
         aBQoBpZ6pLHAT86MvcsJ1CTug85DvdPFFTasaCEI7hHFboZ1PvPELEUZjvGKXMjHRhat
         yXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=a65YTKMZPVfyr/OzNwVWAH0nGUFxpw6A5T7wD1qw9X0=;
        b=Sr3cbgp3ZEMXumDJS3Wscf3Yk+JDxmG0iJuddm0mjVKPdll92xFUXuo7zxPShjsoJj
         Gl4wLIv7kGZlqIvpkOzMoM6YceFE8Vf7FfjDYFdZimjc97Wyc4nSPbsSAi36XxHUxNVx
         i2sOPjTrur/iAE3GyzZVHuD17Vs+RvA67hIWilFIUnj9fTHCfQ1kH8yii2FvAchCTGAc
         f/TAw9f8n/QijIAgBLR5KGEMx5xO4cjs0KI069s4dDbYGQ3r5oVIcaX4CoSiqCJ3h6jg
         SmfofhrllzBzP+4GWz2cFn4uFtS6Z+VM+1pbbIFM1LA7qAFLBOZACPMcI5wPCwtVyVle
         npCA==
X-Gm-Message-State: APjAAAX+ihdB7e9KTdiDvTCZ6ASew/jeipqCzPEuCyIlyMJTXEOLfrM6
        uGMBHURT429o4jJ3fMpOqazPow==
X-Google-Smtp-Source: APXvYqzs95dEFqA3RMLyHDqni2Wy3UA3SmZJf9gN01BBxIkucSjJQW2v2dRF60s9uf+aL1BjXTS6Zw==
X-Received: by 2002:a2e:7a09:: with SMTP id v9mr540275ljc.167.1555606561942;
        Thu, 18 Apr 2019 09:56:01 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.82.67])
        by smtp.gmail.com with ESMTPSA id a17sm550157lfg.88.2019.04.18.09.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 09:56:01 -0700 (PDT)
Subject: Re: [PATCH v10 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org
References: <1555313834-15107-1-git-send-email-masonccyang@mxic.com.tw>
 <1555313834-15107-4-git-send-email-masonccyang@mxic.com.tw>
 <907f2e87-1cb4-fa37-5406-82bf2bf71188@cogentembedded.com>
 <OF2F61A6E6.AA7717A3-ON482583DE.0005C1EE-482583DE.00061474@mxic.com.tw>
 <8720224d-76f4-c620-9e3f-91605d6fa1e3@cogentembedded.com>
 <OFCBCE0527.706EB4F2-ON482583E0.00200707-482583E0.00208EAD@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <9bc4847f-8e7e-3627-5394-6f2b5c5972bc@cogentembedded.com>
Date:   Thu, 18 Apr 2019 19:55:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OFCBCE0527.706EB4F2-ON482583E0.00200707-482583E0.00208EAD@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 04/18/2019 08:55 AM, masonccyang@mxic.com.tw wrote:

>> >  > > Document the bindings used by the Renesas R-Car Gen3 RPC-IF
>> MFD controller.
>> >  > >
>> >  > > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> >  > > ---
>> >  > >  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt  | 37 +++++++++
>> >  > +++++++++++++
>> >  > >  1 file changed, 37 insertions(+)
>> >  > >  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-
>> >  > renesas-rpc.txt
>> >  > >
>> >  > > diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-
>> >  > rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>> >  > > new file mode 100644
>> >  > > index 0000000..bfb3d29
>> >  > > --- /dev/null
>> >  > > +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>> >  > > @@ -0,0 +1,37 @@
>> >  > > +Renesas R-Car Gen3 RPC-IF MFD controller Device Tree Bindings
>> >  > > +-------------------------------------------------------------
>> >  > > +
>> >  > > +Required properties:
>> >  > > +- compatible: should be an SoC-specific compatible value, followed by
>> >  > > +      "renesas,rcar-gen3-rpc" as a fallback.
>> >  > > +      supported SoC-specific values are:
>> >  > > +      "renesas,r8a77995-rpc" (R-Car D3)
>> >  > > +- reg: should contain 2 entries, one for the base address of rpc-
>> >  > if registers,
>> >  > > +   and one for the direct mapping area
>> >  > > +- reg-names: should contain "regs", and "dirmap"
>> >  >
>> >  >    The device tree describes the hardware, not the driver. Why
>> did you remove
>> >  > the "wbuf" area?
>> >
>> > I don't think we should describe the hardware that driver did not
>> implement it
>> > because there are still many RPC registers we don't use them.
>>
>>     I have to repeat: we describe the hardware, not the driver capabilities.
> 
> how about:
> 
> - reg: should contain three register areas:
>           first for the base address of rpc-if registers,
>           second for the direct mapping read mode and
>           third for an optional write buffer area.
>  - reg-names: should contain "regs", "dirmap" and "wbuf"(optional).
> 
> is it OK ?

   No, the write buffer area is always there, at least on the gen3 chips.
(I forgot which other Renesas SoC has RPC-IF as well).

> thanks & best regards,
> Mason

MBR, Sergei
