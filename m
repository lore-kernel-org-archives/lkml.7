Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E652C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3265020828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfCFI6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:58:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:41170 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728907AbfCFI6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:58:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C36AB135;
        Wed,  6 Mar 2019 08:58:31 +0000 (UTC)
Date:   Wed, 6 Mar 2019 09:58:29 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Louis Taylor <louis@kragniz.eu>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org
Subject: Re: [PATCH] i2c: sis630: correct format strings
Message-ID: <20190306095829.5ba295c4@endymion>
In-Reply-To: <20190302141836.24638-1-louis@kragniz.eu>
References: <20190302141836.24638-1-louis@kragniz.eu>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Louis,

On Sat,  2 Mar 2019 14:18:36 +0000, Louis Taylor wrote:
> When compiling with -Wformat, clang warns:
> 
> drivers/i2c/busses/i2c-sis630.c:482:4: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                         smbus_base + SMB_STS,
>                         ^~~~~~~~~~~~~~~~~~~~
> 
> drivers/i2c/busses/i2c-sis630.c:483:4: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                         smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> drivers/i2c/busses/i2c-sis630.c:531:37: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                  "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
>                                           ~~~~~   ^~~~~~~~~~~~~~~~~~~~
> 
> This patch fixes the format strings to use the format type for int.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  drivers/i2c/busses/i2c-sis630.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
> index 1e6805b5cef2..a57aa4fe51a4 100644
> --- a/drivers/i2c/busses/i2c-sis630.c
> +++ b/drivers/i2c/busses/i2c-sis630.c
> @@ -478,7 +478,7 @@ static int sis630_setup(struct pci_dev *sis630_dev)
>  	if (!request_region(smbus_base + SMB_STS, SIS630_SMB_IOREGION,
>  			    sis630_driver.name)) {
>  		dev_err(&sis630_dev->dev,
> -			"I/O Region 0x%04hx-0x%04hx for SMBus already in use.\n",
> +			"I/O Region 0x%04x-0x%04x for SMBus already in use.\n",
>  			smbus_base + SMB_STS,
>  			smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
>  		retval = -EBUSY;
> @@ -528,7 +528,7 @@ static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	sis630_adapter.dev.parent = &dev->dev;
>  
>  	snprintf(sis630_adapter.name, sizeof(sis630_adapter.name),
> -		 "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
> +		 "SMBus SIS630 adapter at %04x", smbus_base + SMB_STS);
>  
>  	return i2c_add_adapter(&sis630_adapter);
>  }

Signed-off-by: Jean Delvare <jdelvare@suse.de>

Would be nice if gcc itself would reports such formatting issues...

Thanks,
-- 
Jean Delvare
SUSE L3 Support
