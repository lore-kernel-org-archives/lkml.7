Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ADCC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F5B2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="HdUyjwMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfFNIZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:25:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44158 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfFNIZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:25:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so1097200lfm.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 01:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ui1gY2AP8chXdXn4wmlJQTa1agcsKtmFVHRK40WFU4U=;
        b=HdUyjwMq0kBBGoMRXEpch9I9ao93cxtEIRbVgFkLWO81MCwFQdr2DIrPJj0FNeFPcm
         acPkqkVYftUgC0vIt8Zp7FixT4eDYUZJpsFZFK0YF8Vl6VeEx6JsnY1ehgrd/8mM8Cr2
         VqrkTt3Z4tLGu9b7BB9RauoMtmTHITL0yQXBIBqsmle7L4djMJKrHKyGgHXD73aTFKWw
         /wRiGIkiGMiftqtBc6PYEPiUDkWujvPZM7PJ5RGsKLw9sMjBuHPeSWNFrgB8+amNQ8H6
         UoY4phfPjhmeB0Bzy+5sCboHEMe0oSnHAChnE9iKHX4V565rMv5U9WY2mWOm4yTmlCHm
         qoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ui1gY2AP8chXdXn4wmlJQTa1agcsKtmFVHRK40WFU4U=;
        b=XyZDo60NfPmvwhQANtNSOxgvq3OvvnLyukk6ymKYTbzgr6HVcS4zDeHP2SN/ohxYxJ
         lo6ONAMs4U9iDJi61qMtegXuFuWlNQ2aa9fl0jn7glNUvrG1hMln65HNOeKbzrald/yQ
         V13f2hiYB8byxQQ3FJ2LBI5ExitBdrHeX5QkHhVd3ijOfAZptYKyfDvmQT9uRYhKMfZu
         Hk0+Rs5+BZImC/CrrRjHOeaEY8NRE1Ag2CmmXGyyAvBuwLpZ6DSRN9cqrIcHkEh32eDl
         JIPkz1AetcyGNZ4Uxy1xhw3M4aFUK1hCBt+E1e9IIaJiinu2uvgce1B01Y392fGMBGAS
         36Iw==
X-Gm-Message-State: APjAAAVlTzgaznrMFkSz2otl5Gl04+6ybrwOWyk4yNeUWzE6vuygA9Zm
        xi4m7lZvApRNrwTs+loV87AVkA==
X-Google-Smtp-Source: APXvYqxqAzZa3TgvBcOszolL8TArMgvi7Ng31/rAXeYBcOf3R76pCykuiCkcuVwtNQ4QHwmGavmYeA==
X-Received: by 2002:a19:e05c:: with SMTP id g28mr33170062lfj.167.1560500698732;
        Fri, 14 Jun 2019 01:24:58 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.84.143])
        by smtp.gmail.com with ESMTPSA id b11sm454239ljf.8.2019.06.14.01.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 01:24:58 -0700 (PDT)
Subject: Re: [RFC 3/3] ata: sata_mv, avoid trigerrable BUG_ON
To:     Jiri Slaby <jslaby@suse.cz>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20190614071140.6233-1-jslaby@suse.cz>
 <20190614071140.6233-3-jslaby@suse.cz>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <0e9f8a3b-65b9-4d87-21f1-684f7e44b166@cogentembedded.com>
Date:   Fri, 14 Jun 2019 11:24:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614071140.6233-3-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 14.06.2019 10:11, Jiri Slaby wrote:

> There are several reports that the BUG_ON on unsupported command in
> mv_qc_prep can be triggered under some circumstances:
> https://bugzilla.suse.com/show_bug.cgi?id=1110252
> https://serverfault.com/questions/888897/raid-problems-after-power-outage
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1652185
> https://bugs.centos.org/view.php?id=14998
> 
> Let sata_mv handle the failure gracefully: warn about that incl. the
> failed command number and return an AC_ERR_INVALID error. We can do that
> now thanks to the previous patch.
> 
> Remove also the long-standing FIXME.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-ide@vger.kernel.org
> ---
>   drivers/ata/sata_mv.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index d6aac7b31c45..144fa0982168 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2098,12 +2098,10 @@ static int mv_qc_prep(struct ata_queued_cmd *qc)
>   		 * non-NCQ mode are: [RW] STREAM DMA and W DMA FUA EXT, none
>   		 * of which are defined/used by Linux.  If we get here, this
>   		 * driver needs work.
> -		 *
> -		 * FIXME: modify libata to give qc_prep a return value and
> -		 * return error here.
>   		 */
> -		BUG_ON(tf->command);
> -		break;
> +		ata_port_err(ap, "%s: unsupported command: %d\n", __func__,
> +				tf->command);

    I'd use "%x" here instead of "%d".

> +		return AC_ERR_INVALID;
>   	}
>   	mv_crqb_pack_cmd(cw++, tf->nsect, ATA_REG_NSECT, 0);
>   	mv_crqb_pack_cmd(cw++, tf->hob_lbal, ATA_REG_LBAL, 0);

MBR, Sergei
