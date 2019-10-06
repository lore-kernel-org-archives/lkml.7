Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC132C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 15:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D78E2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 15:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuGxXKri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfJFPeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:34:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43614 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJFPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 11:34:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so7006941pfo.10;
        Sun, 06 Oct 2019 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4EQLsnEWmRKXsrWscamvfXIozdZPp3UqHIAewrp831M=;
        b=FuGxXKri8LhCjnaN52YWE/1RoQILpF5JVBvK/LBftn3CIZUjrqKTPma/y+MzzrPBZq
         UhlQwgJuBn0CYCFYOU9R8W/ONHoOe7ar09zwZgDURZs/5+i++cdQ8cFEFDubxv2FbxZd
         YGJn3C9EZOZp8zhTRr0w3kRIFrPQs+gyWaM49yFyqpsyLDsFDYf8AErTp2/aQ5fKK+db
         BsCcGuMSgx4syafg7xJVarO1PrWiC3z93MRyPLLx+o6YbKMkKenir4TdZwAmnUxqUP7w
         a/bzUwQieDUkJAQg/zAB4fqDRzSfyjljrpe7kPgia1kbriX0fuSvYz1aZ8n/fXkXaVt9
         ofBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4EQLsnEWmRKXsrWscamvfXIozdZPp3UqHIAewrp831M=;
        b=ajyMXXOz+1UlL2BMLzuUGoqLmjcIWADBNsx0co0j6a3Berv6cP4FFTvCL+qbTGLALx
         5Ls77OvPjY5BIwsT5hXGgFhbB1IluFyCLFd4S+sFT0cu1Xtr8a0JQT+p8/0J6UefkfmY
         wlLynmyDE/qh/W+rnN/WXNlAtRlC6ZE0DfAVfpvKXUInIu0vbgX1i/+ZVmGI4EglMdno
         QKSL2rYJ6D/Km07vbgxQcsUA4NYgmrTLdhvqthgW1HJnpapFAh11eM/NeyEE5zIChD5C
         5IK7iRe4m6jWUMKtajcLLh8qr0Y4HVNNgSY3y2/89eWxrT869ce1njcbrvwJAC4Zg220
         1fxA==
X-Gm-Message-State: APjAAAWBK9Z58Zuo+wf+UjnFf4p7N91PSpSDquIz5fVRzqLdkfxd8vpm
        AZ5vXJKXMXI/xz3Eru83zPU=
X-Google-Smtp-Source: APXvYqzzSq63aKM+d2Ii0hhLkgvoyfa4HNqxGKmBgbMCb5H398GjWtkeFeDqRZmM/efGjioGX2zwSA==
X-Received: by 2002:a17:90a:b108:: with SMTP id z8mr28208287pjq.64.1570376050673;
        Sun, 06 Oct 2019 08:34:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p17sm12568178pfn.50.2019.10.06.08.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Oct 2019 08:34:10 -0700 (PDT)
Date:   Sun, 6 Oct 2019 08:34:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: abituguru: make array probe_order static, makes
 object smaller
Message-ID: <20191006153409.GA7882@roeck-us.net>
References: <20191006145231.24022-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006145231.24022-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 03:52:31PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array probe_order on the stack but instead make it
> static. Makes the object code smaller by 94 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   41473	  13448	    320	  55241	   d7c9	drivers/hwmon/abituguru.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   41315	  13512	    320	  55147	   d76b	drivers/hwmon/abituguru.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/abituguru.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
> index a5cf6b2a6e49..681f0623868f 100644
> --- a/drivers/hwmon/abituguru.c
> +++ b/drivers/hwmon/abituguru.c
> @@ -1264,7 +1264,7 @@ static int abituguru_probe(struct platform_device *pdev)
>  	 * El weirdo probe order, to keep the sysfs order identical to the
>  	 * BIOS and window-appliction listing order.
>  	 */
> -	const u8 probe_order[ABIT_UGURU_MAX_BANK1_SENSORS] = {
> +	static const u8 probe_order[ABIT_UGURU_MAX_BANK1_SENSORS] = {
>  		0x00, 0x01, 0x03, 0x04, 0x0A, 0x08, 0x0E, 0x02,
>  		0x09, 0x06, 0x05, 0x0B, 0x0F, 0x0D, 0x07, 0x0C };
>  
