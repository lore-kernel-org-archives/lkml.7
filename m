Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5326C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CD82077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="riq4R8w2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfDOQtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:49:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37897 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfDOQt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:49:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so16316943ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1TyrP6q3aXD4CjZb2Vj20teJ+w6WQrUSbi9Y4/iuPQE=;
        b=riq4R8w2+WqNBT7GaMC/ZRUtNF4103rmB0c/KSuPzwEvcW9McOwcDyGNKJSlyp7742
         D2N8DXH2tPZ63MStpe4k/peCQ0erR2Ss7TWlpcGtIYOJN2XThpAtWYCqEcVSElwMP16j
         MUa97KR4fNKcjyGRNXDiQay1DLyvnEU5GR/FRhVivn9pjBzlCb/KcAHH5Fs0qByCxb1X
         k2pJZ86tG/6j5ef/kaoad7NXISCdsC0h7t2gQ9AOEM8+2vLnh53AAmOEdddbltysfds4
         ceKQ9uzFtspWBbMsfCLoddmGH2a+l5X5S8NdlxMwSxvACZkDtj52N7EKvcRPMPAT8ztA
         PzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1TyrP6q3aXD4CjZb2Vj20teJ+w6WQrUSbi9Y4/iuPQE=;
        b=HVd2r+qtRPTSageGUClOzcO5NBEl6GoTzUwZhDtTA/pqsbQJ3Jphred/ChFNVuM8nt
         wJZMRa9q0Fxd+xFE9Klpz7o14mxpUj1MM+muIy5Dz13XVmoZ5x6uv9qcjBwRaT8z7Qx4
         UxzUEc6Dc3boKXEgGau8QE16Vr5Fb//zsvz5pk78PIUgK+SDNv+wH9k2ZgCu95lbz7yW
         cBNieNWlajLEw8+edU6DQJV/6bOwHWwEBQac6t+6mUu2/v0qJBcJgAdUrVRFOAkjWZ0K
         WlMbN92Vf2cuu5zo5/gJXR+aBrM1aMICldrJkn2Ym0CjEEXFKCo17HjzEHGLg7ynFmrY
         VI2w==
X-Gm-Message-State: APjAAAUSRbjUkNycDRHGGCCDRJpfBDv7ceEnzxP92ebRmKCMP4k8W2qR
        IXc9s1NBCounDP9lreFFgfAD0Q==
X-Google-Smtp-Source: APXvYqzITwpyZL1+ApheZfkjLF2tNjpJuRVyXuAeJyay/XiydND59++gCfP2BV0DzLv7WaxNRcl+Ow==
X-Received: by 2002:a2e:8906:: with SMTP id d6mr40711878lji.152.1555346966824;
        Mon, 15 Apr 2019 09:49:26 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.61])
        by smtp.gmail.com with ESMTPSA id u11sm10164212lfb.17.2019.04.15.09.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 09:49:25 -0700 (PDT)
Subject: Re: [PATCH v10 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>
References: <1555313834-15107-1-git-send-email-masonccyang@mxic.com.tw>
 <1555313834-15107-4-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <907f2e87-1cb4-fa37-5406-82bf2bf71188@cogentembedded.com>
Date:   Mon, 15 Apr 2019 19:49:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1555313834-15107-4-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/2019 10:37 AM, Mason Yang wrote:

> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> new file mode 100644
> index 0000000..bfb3d29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> @@ -0,0 +1,37 @@
> +Renesas R-Car Gen3 RPC-IF MFD controller Device Tree Bindings
> +-------------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +		"renesas,rcar-gen3-rpc" as a fallback.
> +		supported SoC-specific values are:
> +		"renesas,r8a77995-rpc"	(R-Car D3)
> +- reg: should contain 2 entries, one for the base address of rpc-if registers,
> +	and one for the direct mapping area
> +- reg-names: should contain "regs", and "dirmap"

   The device tree describes the hardware, not the driver. Why did you remove
the "wbuf" area?

[...]

MBR, Sergei
