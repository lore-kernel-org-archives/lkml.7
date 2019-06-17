Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ACFC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B820D20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfFQVLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:11:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44203 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfFQVLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:11:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so6316313pfe.11;
        Mon, 17 Jun 2019 14:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=opkG1qef1rxaB9MLU7WTvGnCWk3AjYn68RxS3C8luR4=;
        b=aL6zFVE+sKOg/mLKBs8ggt2NPzITwtSP8e+l6Cr7cBTh0Zh9zdic+No42M/2fYcG3w
         a61On09uk3Z4XbMxE2vVIsQlfNgwEGbMRX9//B096CqBtvRYnGwovRfECA9+cAFLzFEE
         Gs1fAaarb/T+/UHWzZnzZmb7i5IelwuI4Gzdd5XztjzNCEd8F6kTwU/g6qRPzxOt+Ziu
         In/VwuWSIdQFZA1MzxM/mhcJqDaQ1omxWwhf6SmoX6Oab8DgocmbXNWQ1EeVPcYs7soA
         1TnqLS2mu0ZWMEW/8aOBWShiNNaCJY7jYSFooFemWJfw2SwCVwKsYBhNvjN4mfpLKuJc
         oXIw==
X-Gm-Message-State: APjAAAVQIboWgMKKdBCT7ZbUGU2ZR6cWvMKSo4q5y5j3C/jEqq2qRx67
        yLX4pWqfrvrd8qV+i+UUhiA=
X-Google-Smtp-Source: APXvYqyGNr9bMK5hPPswV5Y15Ekkz7I470S6OP0w859vv5dnOxfcXFe+JNmM62YPFNzTyK+G/3EsUg==
X-Received: by 2002:a17:90a:778c:: with SMTP id v12mr972067pjk.141.1560805868191;
        Mon, 17 Jun 2019 14:11:08 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f17sm13277058pgv.16.2019.06.17.14.11.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 14:11:07 -0700 (PDT)
Subject: Re: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Douglas Gilbert <dgilbert@interlog.com>
References: <2de15293-b9be-4d41-bc67-a69417f27f7a@free.fr>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <621306ee-7ab6-9cd2-e934-94b3d6d731fc@acm.org>
Date:   Mon, 17 Jun 2019 14:11:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2de15293-b9be-4d41-bc67-a69417f27f7a@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 6:59 AM, Marc Gonzalez wrote:
> According to the option's help message, SCSI_PROC_FS has been
> superseded for ~15 years. Don't select it by default anymore.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>   drivers/scsi/Kconfig | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 73bce9b6d037..8c95e9ad6470 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -54,14 +54,11 @@ config SCSI_NETLINK
>   config SCSI_PROC_FS
>   	bool "legacy /proc/scsi/ support"
>   	depends on SCSI && PROC_FS
> -	default y
>   	---help---
>   	  This option enables support for the various files in
>   	  /proc/scsi.  In Linux 2.6 this has been superseded by
>   	  files in sysfs but many legacy applications rely on this.
>   
> -	  If unsure say Y.
> -
>   comment "SCSI support type (disk, tape, CD-ROM)"
>   	depends on SCSI

Hi Doug,

If I run grep "/proc/scsi" over the sg3_utils source code then grep 
reports 38 matches for that string. Does sg3_utils break with 
SCSI_PROC_FS=n?

Thanks,

Bart.
