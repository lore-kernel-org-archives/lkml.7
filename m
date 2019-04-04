Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09DEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37862075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfDDMcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:32:35 -0400
Received: from ns.iliad.fr ([212.27.33.1]:54006 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbfDDMcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:32:35 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 6EF0020E99;
        Thu,  4 Apr 2019 14:32:33 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 53BEE20B19;
        Thu,  4 Apr 2019 14:32:33 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] dt-bindings: net: bluetooth: Add device property
 nvm-postfix for QCA6174
To:     Rocky Liao <rjliao@codeaurora.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        MSM <linux-arm-msm@vger.kernel.org>, bgodavar@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>
References: <1554359858-21049-1-git-send-email-rjliao@codeaurora.org>
 <1554368908-22017-1-git-send-email-rjliao@codeaurora.org>
 <1554368908-22017-2-git-send-email-rjliao@codeaurora.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <535c74d4-00b1-eef2-578a-8807f4b9f640@free.fr>
Date:   Thu, 4 Apr 2019 14:32:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554368908-22017-2-git-send-email-rjliao@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Apr  4 14:32:33 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+robh

On 04/04/2019 11:08, Rocky Liao wrote:

> This patchs patch adds an optional device property nvm-postfix to allow the
> driver to load customized nvm file based on this property

While text /before/ is indeed called a "prefix", text /after/ is not a "postfix",
but a "suffix".


>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 824c0e2..70cda4b 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -16,6 +16,7 @@ Optional properties for compatible string qcom,qca6174-bt:
>  
>   - enable-gpios: gpio specifier used to enable chip
>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
> + - nvm-postfix: nvm file postfix to load customized nvm file

The device tree is supposed to describe hardware.

The name of which file to load can hardly be considered part of the HW.

Possible solutions:
1) derive the file name from the compatible string
2) pass the name as a module parameter
3) something else


> @@ -39,6 +40,7 @@ serial@7570000 {
>  
>  		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
>  		clocks = <&divclk4>;
> +		nvm-postfix = "i2s";
>  	};
>  };

If one provides the entire suffix, including the underscore, then you can
simplify the code:

	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x%s.bin", soc_ver, suffix ? suffix : "");

Regards.
