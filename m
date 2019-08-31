Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62402C3A5A8
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3796523429
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT0v7UCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfHaP0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 11:26:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43988 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfHaP0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 11:26:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id v12so6443549pfn.10;
        Sat, 31 Aug 2019 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RPm3wNYaAJfeMv33ykpRQXFtymYX8spAHZhOaV4FMtw=;
        b=RT0v7UCg8XIW3feVMun1Z8EQMB0RJUFpGzxMw1XggaH7RCqWOLXKFdZBexNrg2V9so
         ZRXTO8r/0Qv2fszYeE2mWC1o/eaOLIIx1M2tkYCvsOyjFWRxENzkL9+5fL0/vcFGj5Pu
         wpue46UQhSslVUplYU1QWSQFC13RMGc+Iu8sl5t1kj3Apy/tTdHM9ZCn+pQrYBzxQ42r
         cXcRbHVEa41cQyNUu5T1p6zTJNRrj+PWxt1J31sIuHQ2DPVnCzUq5bAHrc0XeL2aOPZY
         UWKQIV/AYVtY1yVgjGAzVkN+YvuK0iE58R7XN2lCcwP8GUxYzH7LO6oHdFmYNdmXvEkE
         5YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RPm3wNYaAJfeMv33ykpRQXFtymYX8spAHZhOaV4FMtw=;
        b=cEg6DN0I9+Tbivxb7dB/gxzNJIbLu6O1eFB0Xpt5Ko3vyGIFIKynXhpCQPzCcW9baq
         K6Hb7xDHkH42mp/2kSeRiGPKHSCu0ycMslpwbelTIXXsPktHvkDGBksVWNzCYLtcIMh7
         sBARxC2NDRdryTR/TbliEC4gWzxjnxKTO5RVX5+eR/mhAIAGQzhzkimsBCBUxaNImRJ2
         bDINH6/h5YRQtWxUqG2Jy/f5VQVMMPuRXzbvbTWDLx0NgvNVqAM8Pyfm9x2ZYRSyeaaR
         ZRN+TPK3uh6Oy54vkoQ6YB5E1inPAElepoJdGmJwgc4V/I2k4AY5pTQ8ZMyZc3/bn5TE
         jgyw==
X-Gm-Message-State: APjAAAVRHiqMAzd+Bahx6ZDlzcqIVBkNBzzosk5I9d5i0MolyVPR0+HI
        1zEh3pKT/BXR0mSAU32iRFM=
X-Google-Smtp-Source: APXvYqyJqEFxeB6QZitGffSy1/9nDmFnIkSMbAmBdxvl613w1CBE+EMOAAgfFHTaVNzZDYLyc85W0g==
X-Received: by 2002:a63:ec13:: with SMTP id j19mr17399821pgh.369.1567265192358;
        Sat, 31 Aug 2019 08:26:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f188sm3094603pfa.170.2019.08.31.08.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 08:26:31 -0700 (PDT)
Date:   Sat, 31 Aug 2019 08:26:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, mark.rutland@arm.com,
        robh+dt@kernel.org, jdelvare@suse.com
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: Document ibm,cffps2
 compatible string
Message-ID: <20190831152630.GA8907@roeck-us.net>
References: <1567192263-15065-1-git-send-email-eajames@linux.ibm.com>
 <1567192263-15065-2-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567192263-15065-2-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 02:11:01PM -0500, Eddie James wrote:
> Document the compatible string for version 2 of the IBM CFFPS PSU.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied to hwmon-next. Note that we'll still need review from a DT maintainer.
I don't see any problems, but then who knows.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt b/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> index f68a0a6..1036f65 100644
> --- a/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> +++ b/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> @@ -1,8 +1,10 @@
> -Device-tree bindings for IBM Common Form Factor Power Supply Version 1
> -----------------------------------------------------------------------
> +Device-tree bindings for IBM Common Form Factor Power Supply Versions 1 and 2
> +-----------------------------------------------------------------------------
>  
>  Required properties:
> - - compatible = "ibm,cffps1";
> + - compatible				: Must be one of the following:
> +						"ibm,cffps1"
> +						"ibm,cffps2"
>   - reg = < I2C bus address >;		: Address of the power supply on the
>  					  I2C bus.
>  
