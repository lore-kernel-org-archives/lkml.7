Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E9AC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BFC20578
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrtCqF9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfHTPVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:21:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33143 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfHTPVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:21:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so3589931pfq.0;
        Tue, 20 Aug 2019 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MJt24EPy43Ti5EtCu4AqEKxniVOrhxVv02Gleo5IXyE=;
        b=SrtCqF9pPnng7ehiqNQgq73kEhqLuhCwqieKSAEaSvgM23Ld7sPB5E1MwQCM6rBqBE
         nqmNgyz4x/nxY4sF9m29OUz7Q8LcQesHeXcjY5dDR/poJ+uuGoar38LR4oSXQQbNi7h8
         NC2Gmvd7gVALP/tUWbPViXAR+Q0UMpmmYgw8Ifjl1MPhUE+f4LAio38eFt3bo7fid0jk
         DuuI61zdjgYUyQuD/Fbs/mNe1ZXXj5DtM9P1PH6dtY10xMKyWCGV1DKpj1cizs/ndrTQ
         BLWALERkRMpKMX4SP267bTOSwNXQI1JFEtEj/4LVICaNPpCOiKJdchjzLRYBdjqovWE3
         K8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=MJt24EPy43Ti5EtCu4AqEKxniVOrhxVv02Gleo5IXyE=;
        b=qDBwPtbN8i7DKHq/9ljuodPuSgl9Cq1vNSwCWbBvcRQ3+sU9XgElRdfOgrdFiTw7yb
         G1nvrQxXDvYb5/Bi6K/N/sRsSmz6Mf50SftJ3BYEKeolAJFgo+rxEcoiSR5R97G/k70O
         WU+zApSwSpfa/9xxEuxRGxnuLIrUko5Y/oDEvp8klXZHEI1lrUuWzzE0b/CbaEGh4bYR
         eR29OekIN+uu52h5xkccR3zvFYs+YerX3aUFh9k0OEr5HW86pONB812UuAcKcvfA7gN1
         VyvS8m7howi2qCQ0dBECfxcpBiVjftOvgDUEB0Z4wghh+gp7W7nfBJs/67lZdS9Aoczh
         BSFg==
X-Gm-Message-State: APjAAAX/JNYjcQWGJtrwmoohhi6ADW8H+kTEIMYS1Xzs2sb5aF+0Mg6f
        06wZ0bNQM4y0d7cr2jM5wsQ=
X-Google-Smtp-Source: APXvYqyye+f2ZvNPRYjsHLx9yEZsbjtsiD/vrXS+OvTR4qsU+Ap8Rb5ttF0FQamv2w/cdmS4Sjesdg==
X-Received: by 2002:a63:b20f:: with SMTP id x15mr25966808pge.453.1566314501422;
        Tue, 20 Aug 2019 08:21:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w2sm513828pjr.27.2019.08.20.08.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:21:40 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:21:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Wang <wangzqbj@inspur.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, trivial@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, duanzhijia01@inspur.com,
        mine260309@gmail.com, joel@jms.id.au
Subject: Re: [PATCH v6 1/2] dt-bindings: Add ipsps1 as a trivial device
Message-ID: <20190820152140.GA13677@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 05:14:25PM +0800, John Wang wrote:
> The ipsps1 is an Inspur Power System power supply unit
> 
> Signed-off-by: John Wang <wangzqbj@inspur.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Aplied to hwmon-next. If someone else wants to take it, please
let me know and I'll drop it.

Thanks,
Guenter

> ---
> v6:
>     - No changes
> v5:
>     - No changes
> v4:
>     - Rebased on 5.3-rc4 instead of 5.2, No changes
> v3:
>     - Fix adding entry to the inappropriate line
> v2:
>     - No changes.
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 2e742d399e87..870ac52d2225 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -104,6 +104,8 @@ properties:
>            - infineon,slb9645tt
>              # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>            - infineon,tlv493d-a1b6
> +            # Inspur Power System power supply unit version 1
> +          - inspur,ipsps1
>              # Intersil ISL29028 Ambient Light and Proximity Sensor
>            - isil,isl29028
>              # Intersil ISL29030 Ambient Light and Proximity Sensor
> -- 
> 2.17.1
> 
