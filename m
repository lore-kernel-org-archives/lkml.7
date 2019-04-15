Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B1C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4760720848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzVW/xoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfDOU2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:28:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36451 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfDOU2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:28:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id ck15so9147244plb.3;
        Mon, 15 Apr 2019 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YqnhuNgc7VdSe8SUfJShm53vwl4yGwe2rbhqG6KHg0c=;
        b=jzVW/xocORFUraAMBcr3CakCJU5LViGD9IefKD4E2rgeKwrp5Ea2YBnPzZSbwQf9Bb
         z7Opu2Y4TTIJdyM7rfHTlKuamp5iqnEZqoxJ9eTC6k+Bw6NfS2VnrF0vAP35guBxRvnd
         dlBqg7iO0ynrFor/H4ifDYoM487+MX+8FftCH/Xful/D4G3Sd1nfaMnx1Glhk5xl6fes
         QKJcmiOqNBhrgRnhEtImsb7SRdjBp9rP0+rTsTccBoXRjExuDOxe3eaEmPP0PmwriA1p
         urS9Rk7YULnIDnppXATy7tZEIxheH1LIuhuF1+06/SHg1dK5NkdRuK4RXLaXJIojiAiF
         rvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YqnhuNgc7VdSe8SUfJShm53vwl4yGwe2rbhqG6KHg0c=;
        b=JwJUj066CUrVeGft1MgkhPjywdjX4EfNFQJnWY5DoGo81LiD49Vp4P9OP2Ho7TzLDb
         0C+TSAQLWWgxHieQO6EiPYzycYWGJkNUdZuMG157Gsb9oOh6WCloE9TLiPNQu5FHwKh/
         2SlkH5dmvPJuLgWreBzsaXgZdwJcJ4FMxUzH1JtPYZjnjXi9EYchAHRvuP+iuqzNt1Mb
         ODGx7pPCOuyGCyvsOrQsiS0CSCuRGfqsKApnht/hLr69h+wLQild8BvfxQL+kS5Zq9Ch
         gMsizOv0R80niTjCMbzlseHJTXmPjgpAHVlvtTUBJUrCMvVUdFth7GTIGMsJKmSgcbrW
         2RXQ==
X-Gm-Message-State: APjAAAVJP9x/I207aqQG68Fkjnooy12UMLUmcBHGSJJkWGADbQod6k3a
        2SNtd12V1DSjLk0pBSIC99I=
X-Google-Smtp-Source: APXvYqwIsDtqp01+FeKUkGbGFzy0CyiA0oK+zkyZjCaN8Nz1/u2nCJcNE6C8DsHRVIQcREtiYr3GeA==
X-Received: by 2002:a17:902:e091:: with SMTP id cb17mr79150996plb.222.1555360130815;
        Mon, 15 Apr 2019 13:28:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 4sm67066101pfn.159.2019.04.15.13.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 13:28:50 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:28:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lei YU <mine260309@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Eddie James <eajames@linux.ibm.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH] hwmon (occ): Fix extended status bits
Message-ID: <20190415202849.GA31243@roeck-us.net>
References: <1555324640-152061-1-git-send-email-mine260309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555324640-152061-1-git-send-email-mine260309@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 06:37:20PM +0800, Lei YU wrote:
> The occ's extended status is checked and shown as sysfs attributes. But
> the code was incorrectly checking the "status" bits.
> Fix it by checking the "ext_status" bits.
> 
> Signed-off-by: Lei YU <mine260309@gmail.com>

Looks ok to me, but can I get a confirmation from someone at IBM ?

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/sysfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
> index fe3d15e..a71ca94 100644
> --- a/drivers/hwmon/occ/sysfs.c
> +++ b/drivers/hwmon/occ/sysfs.c
> @@ -42,16 +42,16 @@ static ssize_t occ_sysfs_show(struct device *dev,
>  		val = !!(header->status & OCC_STAT_ACTIVE);
>  		break;
>  	case 2:
> -		val = !!(header->status & OCC_EXT_STAT_DVFS_OT);
> +		val = !!(header->ext_status & OCC_EXT_STAT_DVFS_OT);
>  		break;
>  	case 3:
> -		val = !!(header->status & OCC_EXT_STAT_DVFS_POWER);
> +		val = !!(header->ext_status & OCC_EXT_STAT_DVFS_POWER);
>  		break;
>  	case 4:
> -		val = !!(header->status & OCC_EXT_STAT_MEM_THROTTLE);
> +		val = !!(header->ext_status & OCC_EXT_STAT_MEM_THROTTLE);
>  		break;
>  	case 5:
> -		val = !!(header->status & OCC_EXT_STAT_QUICK_DROP);
> +		val = !!(header->ext_status & OCC_EXT_STAT_QUICK_DROP);
>  		break;
>  	case 6:
>  		val = header->occ_state;
