Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA54C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC802073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="T+oxkSPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfDPICS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:02:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36392 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbfDPICS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:02:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so18262783ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 01:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LnT4UMJdIG7Rl3Qh7QAvuhsqWIBMcODjw/XiXiMfnns=;
        b=T+oxkSPF2X4uafP+luVeKL5THHp15CjB3EGTuskRfCe3DtT5JJR1LK7f4KVr6r2dpR
         2bltaeSS0qP3F1PLUx8J3so9W9Q8enEQCwzX3XmHGrMNL1zvW3lP8RO+lmMOZaNrOTwd
         IK/P3yS3/vEdpDA25aOL8u4XtSPTYC1R6yhhYbNPRnbCF1g0rpuz89wR7909/ediLZWR
         2vcCTUMuUgEVBwlmHRr6eII69Jt9oVd15d+AHeZ7UQx8vRJ9u/BqME4aaMttL/1HOY9h
         rKcLKdIHqXM2ciMrhTvXwkAHg3Qvf2Dgxc1/stTkm7VskiCA339M2rLSvm2RZ4HAw4n1
         C+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LnT4UMJdIG7Rl3Qh7QAvuhsqWIBMcODjw/XiXiMfnns=;
        b=VWwKPd3d7/iWoFBCrN1nO5yTegfdelbSCzlrS99fBomSV2I8mItuiXcp4gNU03I11y
         oqIudRK1ucGgpvHJMG0YapIcdEL2HMu0FaUGv3wn/YscSnFuSkf//Vo4KqG8QBLuZpLq
         8B1lgbR6armINBs7kfrNyf9XStlWK3GdBhIqC0AYzLIbd/5hNd99Z1xu7ZQV9YHztjNo
         y/svi+JhELbs1j4yV0CIr6QfgTqt0Pmk2jvzrolyxjZ4IA7IfXsxlXtA1pMc5/hDD06Q
         uzs2+YM9887G0j84rlbYCN0By1YK7VDCJbOA8tYoM9iyVvoVbHXYImQoqObkxYT27SZK
         FHOw==
X-Gm-Message-State: APjAAAW6JkXdzJc7dal+ggB5vcQoZhYQvVr2t/S23EDIIBdIAlBhTE75
        xPSjLFNEdXSVcOijr11MPQTVCQ==
X-Google-Smtp-Source: APXvYqyiNjxrZVPYIvJNFWYvo4fUAh679SPsbssQAi3uu6W7lBueHM8nlQKhY03tXehX2ovnSLWIYg==
X-Received: by 2002:a2e:9682:: with SMTP id q2mr17749927lji.168.1555401736509;
        Tue, 16 Apr 2019 01:02:16 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.81.188])
        by smtp.gmail.com with ESMTPSA id m19sm6512720lfl.43.2019.04.16.01.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 01:02:15 -0700 (PDT)
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
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <8720224d-76f4-c620-9e3f-91605d6fa1e3@cogentembedded.com>
Date:   Tue, 16 Apr 2019 11:02:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <OF2F61A6E6.AA7717A3-ON482583DE.0005C1EE-482583DE.00061474@mxic.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.2019 4:06, masonccyang@mxic.com.tw wrote:

>  > > Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD controller.
>  > >
>  > > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>  > > ---
>  > >  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt  | 37 +++++++++
>  > +++++++++++++
>  > >  1 file changed, 37 insertions(+)
>  > >  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-
>  > renesas-rpc.txt
>  > >
>  > > diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-
>  > rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>  > > new file mode 100644
>  > > index 0000000..bfb3d29
>  > > --- /dev/null
>  > > +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>  > > @@ -0,0 +1,37 @@
>  > > +Renesas R-Car Gen3 RPC-IF MFD controller Device Tree Bindings
>  > > +-------------------------------------------------------------
>  > > +
>  > > +Required properties:
>  > > +- compatible: should be an SoC-specific compatible value, followed by
>  > > +      "renesas,rcar-gen3-rpc" as a fallback.
>  > > +      supported SoC-specific values are:
>  > > +      "renesas,r8a77995-rpc" (R-Car D3)
>  > > +- reg: should contain 2 entries, one for the base address of rpc-
>  > if registers,
>  > > +   and one for the direct mapping area
>  > > +- reg-names: should contain "regs", and "dirmap"
>  >
>  >    The device tree describes the hardware, not the driver. Why did you remove
>  > the "wbuf" area?
> 
> I don't think we should describe the hardware that driver did not implement it
> because there are still many RPC registers we don't use them.

    I have to repeat: we describe the hardware, not the driver capabilities.

> best regards,
> Mason

MBR, Sergei
