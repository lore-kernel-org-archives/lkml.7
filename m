Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E46C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730C120830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eULPZPSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfDJSbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:31:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34908 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfDJSbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:31:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so1934118plp.2;
        Wed, 10 Apr 2019 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K5q1mArmhnmzSt9XW4y9g5UDZy89Pu07LHO7UzmM7hs=;
        b=eULPZPSpjnII+u3PFVRSx6rxl1Czmc5unltkENZqNMp+lgqVagkXcyFKics+dxjirF
         iM9sIGJtpotImRPinHt2CxVcm0Bi/jw4LfhrPwgifwtGbPFCBn1avKSCB+PiXba46HRY
         ZczpWAe10T8hm/ElC+ppc5iIzTUg5Jm3y3MEW9Ofz/neiWbEfBwv7Bo4lzGxro4WMlcv
         kLjn4ioaFl+FLNjiekvdZoeqq7osWw8Q5HxWbMCIsXpDE+kQMYLYbf+ydiN+vGL2Yo7S
         rQ77xiYyF3noAFOCLEo5uo7XKEqTwf+fq650B6maSpof6mZvRvAOels6hb5eBjb5WU7K
         jgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=K5q1mArmhnmzSt9XW4y9g5UDZy89Pu07LHO7UzmM7hs=;
        b=OaJNU/pZUoIu0oGt0yw7MR5gt+mS58snfY5nTcHAEc9mixZ/ux/ZouOeYJPDTZCatg
         puiBz9DBdtAXdHNLcDkKMP9LHgqU6DzbNERCpfafYp3ySq2m5/LIYw7ylDAum/Kxrdpg
         dnPKWt/Cv1/SBoASd+jGFfwvIiIfGZY3GTgNx5Taoe32aWBTd7K59Qn8i96d4IT8wwS1
         6JwKb2XorBej14PjIgHgNalJ1TjC9qHfCxawy4LZipYtOvRAppRxkOufh3EkFzMKo64A
         JDHM+24eoqQyF54WImwc2ckVyfwzs/yd+E4WEMjoyeDq8r+O8Cwax/z7WCIf7zXCpbDs
         FyuQ==
X-Gm-Message-State: APjAAAW0bB2cJdBtqaoPTo4abyhGnnw4FToDzn4oaeJGx1xZjpOtdld9
        QadEdsJMdYnPNuRX+3L1dj4=
X-Google-Smtp-Source: APXvYqzN0pLEns/L/firzlMgQrzOsEpX2Ug+7NYdaWjPHfUCzhXu/doxRCCR9RHiuEZemQet983QsQ==
X-Received: by 2002:a17:902:7601:: with SMTP id k1mr7525234pll.35.1554921061075;
        Wed, 10 Apr 2019 11:31:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5sm3376159pff.97.2019.04.10.11.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 11:31:00 -0700 (PDT)
Date:   Wed, 10 Apr 2019 11:30:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 01/21] docs: hwmon: k10temp: convert to ReST format
Message-ID: <20190410183059.GA20261@roeck-us.net>
References: <cover.1554893881.git.mchehab+samsung@kernel.org>
 <9ed53a4f160d7cd4f7c05fb919196ac15ecb6d63.1554893882.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ed53a4f160d7cd4f7c05fb919196ac15ecb6d63.1554893882.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 08:11:51AM -0300, Mauro Carvalho Chehab wrote:
> Convert k10temp to ReST format, in order to allow it to
> be parsed by Sphinx.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

The first Signed-off-by: is bad. This affects all patches in the series.

Guenter

> ---
>  Documentation/hwmon/k10temp | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/k10temp b/Documentation/hwmon/k10temp
> index 254d2f55345a..12a86ba17de9 100644
> --- a/Documentation/hwmon/k10temp
> +++ b/Documentation/hwmon/k10temp
> @@ -2,42 +2,77 @@ Kernel driver k10temp
>  =====================
>  
>  Supported chips:
> +
>  * AMD Family 10h processors:
> +
>    Socket F: Quad-Core/Six-Core/Embedded Opteron (but see below)
> +
>    Socket AM2+: Quad-Core Opteron, Phenom (II) X3/X4, Athlon X2 (but see below)
> +
>    Socket AM3: Quad-Core Opteron, Athlon/Phenom II X2/X3/X4, Sempron II
> +
>    Socket S1G3: Athlon II, Sempron, Turion II
> +
>  * AMD Family 11h processors:
> +
>    Socket S1G2: Athlon (X2), Sempron (X2), Turion X2 (Ultra)
> +
>  * AMD Family 12h processors: "Llano" (E2/A4/A6/A8-Series)
> +
>  * AMD Family 14h processors: "Brazos" (C/E/G/Z-Series)
> +
>  * AMD Family 15h processors: "Bulldozer" (FX-Series), "Trinity", "Kaveri", "Carrizo"
> +
>  * AMD Family 16h processors: "Kabini", "Mullins"
>  
>    Prefix: 'k10temp'
> +
>    Addresses scanned: PCI space
> +
>    Datasheets:
> +
>    BIOS and Kernel Developer's Guide (BKDG) For AMD Family 10h Processors:
> +
>      http://support.amd.com/us/Processor_TechDocs/31116.pdf
> +
>    BIOS and Kernel Developer's Guide (BKDG) for AMD Family 11h Processors:
> +
>      http://support.amd.com/us/Processor_TechDocs/41256.pdf
> +
>    BIOS and Kernel Developer's Guide (BKDG) for AMD Family 12h Processors:
> +
>      http://support.amd.com/us/Processor_TechDocs/41131.pdf
> +
>    BIOS and Kernel Developer's Guide (BKDG) for AMD Family 14h Models 00h-0Fh Processors:
> +
>      http://support.amd.com/us/Processor_TechDocs/43170.pdf
> +
>    Revision Guide for AMD Family 10h Processors:
> +
>      http://support.amd.com/us/Processor_TechDocs/41322.pdf
> +
>    Revision Guide for AMD Family 11h Processors:
> +
>      http://support.amd.com/us/Processor_TechDocs/41788.pdf
> +
>    Revision Guide for AMD Family 12h Processors:
> +
>      http://support.amd.com/us/Processor_TechDocs/44739.pdf
> +
>    Revision Guide for AMD Family 14h Models 00h-0Fh Processors:
> +
>      http://support.amd.com/us/Processor_TechDocs/47534.pdf
> +
>    AMD Family 11h Processor Power and Thermal Data Sheet for Notebooks:
> +
>      http://support.amd.com/us/Processor_TechDocs/43373.pdf
> +
>    AMD Family 10h Server and Workstation Processor Power and Thermal Data Sheet:
> +
>      http://support.amd.com/us/Processor_TechDocs/43374.pdf
> +
>    AMD Family 10h Desktop Processor Power and Thermal Data Sheet:
> +
>      http://support.amd.com/us/Processor_TechDocs/43375.pdf
>  
>  Author: Clemens Ladisch <clemens@ladisch.de>
> @@ -60,7 +95,7 @@ are using an AM3 processor on an AM2+ mainboard, you can safely use the
>  
>  There is one temperature measurement value, available as temp1_input in
>  sysfs. It is measured in degrees Celsius with a resolution of 1/8th degree.
> -Please note that it is defined as a relative value; to quote the AMD manual:
> +Please note that it is defined as a relative value; to quote the AMD manual::
>  
>    Tctl is the processor temperature control value, used by the platform to
>    control cooling systems. Tctl is a non-physical temperature on an
