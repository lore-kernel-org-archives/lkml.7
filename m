Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AB0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B583520880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahQf/nJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfDPWPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:15:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34910 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPWPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:15:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so11014456plp.2;
        Tue, 16 Apr 2019 15:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lG6ZpAkmVc5/nyfI7ZVe1dVNTtrQrMePTJsNQFI9tc4=;
        b=ahQf/nJWcetOPpFmYyUMzhGktABMa+/NUUtCrWSttmQhNOf+1vUFB+ia2cZQJBHIV2
         jmko0AeEBl9tDRpHR63hvWrb/HW9Tkc276Rc0uQJ75nUZ42nBqeJRG2qfGBnyiwSKYNq
         r2k29q1u5tV0z/rP2qSeDM0S+y8AsWHaXHA/o/F0o9GJxFX0smIvQ7F0x4SKu6MPPhCD
         dakIKc54jrTlgmNcpiTdDzCGjeDph+vqYjn1nPGX9S7J1sK9WjlMi9PAatRBmdUlWEjn
         a0qRxnVVSO9kzvDLHlkPpk3lECGnWFeZZno3sWiG60nJIy5wdmeiek/nswqKeqOUuzZg
         0yuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lG6ZpAkmVc5/nyfI7ZVe1dVNTtrQrMePTJsNQFI9tc4=;
        b=hRGRu3VPeRUm97jqq9bmhJed19CONghETBh6G3J/U2GqsQQtFAGSEAuC+kIvsiErpm
         p/MRrABRWIpnr/cOj4/NGyB7Nfne0dGJJGGzLg/oE2VuXWeUYYjIpb+dBli1gI5QLK7V
         5+Z+88fUYzrOVX8vZ05vjW3oPNkKYOuvLuGd6FVnam2O2DtoYsEr6kmiA+pGRydKI6rh
         4r65Ai606B9IfpFsIl/Nx0Q6BDCZJKqVqGGyCGxEq8vAFm6Kpr2N7yNRsIFnmGkpoy0E
         x2MAF8/PqS8NshCIUGiAIQr5GOhusjIga9hHA+F5mxjtoGX2ysrIzlNDDc0RozBTrzdQ
         vE/g==
X-Gm-Message-State: APjAAAVxfNhk5J1barKO9CX8N3DvlQUm37Tdq4dVgSr5uiiN+oOJ1nco
        tVOuBGsKCulmiro1a97E2Ac=
X-Google-Smtp-Source: APXvYqxqaGMKRtWL0tl9gxjAvnVdzTJepCLDWyUxXb5p6dX/zTaB3gZ3cEvdAkQDkGL9GZMqXNmXJA==
X-Received: by 2002:a17:902:102a:: with SMTP id b39mr50014720pla.188.1555452912848;
        Tue, 16 Apr 2019 15:15:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v19sm96118299pfa.138.2019.04.16.15.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 15:15:12 -0700 (PDT)
Date:   Tue, 16 Apr 2019 15:15:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, andrew@aj.id.au, mine260309@gmail.com,
        Eddie James <eajames@us.ibm.com>
Subject: Re: [PATCH 3/3] hwmon (occ): Add more details to Kconfig help text
Message-ID: <20190416221511.GA32220@roeck-us.net>
References: <1555429430-23118-1-git-send-email-eajames@linux.ibm.com>
 <1555429430-23118-3-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555429430-23118-3-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:43:50PM +0000, Eddie James wrote:
> From: Eddie James <eajames@us.ibm.com>
> 
> The help text needs to spell out how the driver runs on a BMC, as it
> previously seemed to indicate it ran on a POWER processor.
> 
> Signed-off-by: Eddie James <eajames@us.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/Kconfig | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/Kconfig b/drivers/hwmon/occ/Kconfig
> index 2a3869f..1658634 100644
> --- a/drivers/hwmon/occ/Kconfig
> +++ b/drivers/hwmon/occ/Kconfig
> @@ -9,8 +9,10 @@ config SENSORS_OCC_P8_I2C
>  	select SENSORS_OCC
>  	help
>  	 This option enables support for monitoring sensors provided by the
> -	 On-Chip Controller (OCC) on a POWER8 processor. Communications with
> -	 the OCC are established through I2C bus.
> +	 On-Chip Controller (OCC) on a POWER8 processor. However, this driver
> +	 can only run on a baseboard management controller (BMC) connected to
> +	 the P8, not the POWER processor itself. Communications with the OCC are
> +	 established through I2C bus.
>  
>  	 This driver can also be built as a module. If so, the module will be
>  	 called occ-p8-hwmon.
> @@ -22,8 +24,10 @@ config SENSORS_OCC_P9_SBE
>  	select SENSORS_OCC
>  	help
>  	 This option enables support for monitoring sensors provided by the
> -	 On-Chip Controller (OCC) on a POWER9 processor. Communications with
> -	 the OCC are established through SBE fifo on an FSI bus.
> +	 On-Chip Controller (OCC) on a POWER9 processor. However, this driver
> +	 can only run on a baseboard management controller (BMC) connected to
> +	 the P9, not the POWER processor itself. Communications with the OCC are
> +	 established through SBE fifo on an FSI bus.
>  
>  	 This driver can also be built as a module. If so, the module will be
>  	 called occ-p9-hwmon.
