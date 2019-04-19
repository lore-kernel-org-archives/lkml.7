Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B36BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB78222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="dNCGd7XR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfDSS2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:28:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46074 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDSS2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:28:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so5286869ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uY7PXhPPIbtwGBJ7+viJGiFCPyh+whXUTf1tbSnJh+k=;
        b=dNCGd7XReD01+88Ijx/UELpZySKJdi2Eu4HlGCDiTrSAUBnqLuxwwpbvJaTcU/z8HM
         kc3fyyRldwRaUR7FcbepqdTpV/ftS3hbH06PyY3QYbrY1bsBsCw4Ynz0NAP7lnIE68IZ
         EJ+Fnt+Vv6xAoYV0mEip5kxph5qllCtCpMqwxYZ20h3FgIX4eo5ghNx+5a+sHYWNCNbx
         7ST8VYIKyF0oipAfNdvHVhczEt9chg6Gc/xcRFtU1dorHnamQqzVl17wHWXkV3cbXQXo
         PNtOtKji6/eEBKol9smQpVrQqJtD71R+/k/ok8At0D0oFbhcuQyW81josvKvP9iz6Ecf
         3kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uY7PXhPPIbtwGBJ7+viJGiFCPyh+whXUTf1tbSnJh+k=;
        b=I33MUs1N6ojV6YSqUUvep17GUWxAND5pwfwnN9FfqlQIUvMDITL+Qu3+aSc8MKXgRk
         9aA11L+SrT36UJKw4f/DyhL9IVqik5j3YQ34ezNFCWwcBrgSF7nW0LJr+YWKghO5vLfM
         jPI0lVbNjgYPA1qscDDXxDGrQPeq9pqoBrFlCIv6G50T7tpvHuqlTryHZH6bGPX8mfj7
         xqHnuPT1nnUsi9eXGqADMv4SLRmGXPjNUgkU/XZ1WEe2kS7ZIqH0Sr/uFkQ/XTZFYZ1K
         4xSlfQ4w4fNq5ouNNrfRpZMdiiGpEqusdTTegfw0dg7zMB8DNNpqeNd/cTmoyeSXdTfW
         rYxA==
X-Gm-Message-State: APjAAAV+uAc7X8Ax+CPunKmzBn+OjGGkUPxFaq5C+aQuEzke3IWyANQp
        3TlwwYWjTcE1XsfsVRzuI9oJofban6c=
X-Google-Smtp-Source: APXvYqy10GULKxsK4IKRaCxPOpY5H2eN+BjxOt1t2HotSVkRw3CuJT5qCcHNIevCAU3IoYWbFH2EfA==
X-Received: by 2002:a2e:9a46:: with SMTP id k6mr2627567ljj.119.1555688682241;
        Fri, 19 Apr 2019 08:44:42 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.82.91])
        by smtp.gmail.com with ESMTPSA id d22sm1206931lfc.80.2019.04.19.08.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 08:44:40 -0700 (PDT)
Subject: Re: [PATCH v10 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF controller bindings
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
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
 <9bc4847f-8e7e-3627-5394-6f2b5c5972bc@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <d4e7b0b3-f69e-0513-84b0-076210aa4548@cogentembedded.com>
Date:   Fri, 19 Apr 2019 18:44:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <9bc4847f-8e7e-3627-5394-6f2b5c5972bc@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2019 07:55 PM, Sergei Shtylyov wrote:

>>>>  > > Document the bindings used by the Renesas R-Car Gen3 RPC-IF
>>> MFD controller.
>>>>  > >
>>>>  > > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>>>>  > > ---
>>>>  > >  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt  | 37 +++++++++
>>>>  > +++++++++++++
>>>>  > >  1 file changed, 37 insertions(+)
>>>>  > >  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-
>>>>  > renesas-rpc.txt
>>>>  > >
>>>>  > > diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-
>>>>  > rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>>>>  > > new file mode 100644
>>>>  > > index 0000000..bfb3d29
>>>>  > > --- /dev/null
>>>>  > > +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>>>>  > > @@ -0,0 +1,37 @@
>>>>  > > +Renesas R-Car Gen3 RPC-IF MFD controller Device Tree Bindings
>>>>  > > +-------------------------------------------------------------
>>>>  > > +
>>>>  > > +Required properties:
>>>>  > > +- compatible: should be an SoC-specific compatible value, followed by
>>>>  > > +      "renesas,rcar-gen3-rpc" as a fallback.
>>>>  > > +      supported SoC-specific values are:
>>>>  > > +      "renesas,r8a77995-rpc" (R-Car D3)
>>>>  > > +- reg: should contain 2 entries, one for the base address of rpc-
>>>>  > if registers,
>>>>  > > +   and one for the direct mapping area
>>>>  > > +- reg-names: should contain "regs", and "dirmap"
>>>>  >
>>>>  >    The device tree describes the hardware, not the driver. Why
>>> did you remove
>>>>  > the "wbuf" area?
>>>>
>>>> I don't think we should describe the hardware that driver did not
>>> implement it
>>>> because there are still many RPC registers we don't use them.
>>>
>>>     I have to repeat: we describe the hardware, not the driver capabilities.
>>
>> how about:
>>
>> - reg: should contain three register areas:
>>           first for the base address of rpc-if registers,
>>           second for the direct mapping read mode and
>>           third for an optional write buffer area.
>>  - reg-names: should contain "regs", "dirmap" and "wbuf"(optional).
>>
>> is it OK ?
> 
>    No, the write buffer area is always there, at least on the gen3 chips.
> (I forgot which other Renesas SoC has RPC-IF as well).

   So it was RZ/A1. But it didn't have the HyperFlash mode...

>> thanks & best regards,
>> Mason

MBR, Sergei
