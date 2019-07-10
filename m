Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E071CC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75CB20838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivw+OD5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfGJU4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:56:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44028 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfGJU4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:56:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so1786474pgv.10;
        Wed, 10 Jul 2019 13:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4GDlvVIbuEMSjpog68D853qJdshnlOic8vHoIJzFbR8=;
        b=ivw+OD5nX4iQuO1JTrBDV5FzrEry3ElHLfV4wuZyAJCyH++EJYSwauxZJRmw1Y5Cw6
         mP9bOLVYebi+a77jr2fYBmyYQDa9SMtCkL9GtaLdq865LJtjeKFJ7x9TkQuMZIPHXrAI
         ZIsHQwNv+Fq93FOnnHwGxQnhXPGDrSPGUsfQVzHNzImw70uTHIKnaP+RWbZGvJcUwnq+
         tIbXt5ux8DyT5ZITZ2LQG8Vxfsl6EU6T7S8rFhj4kAuJc9Tb4GWlyTa+jIrmum0efIWD
         mE0Y8ozfhhrliHgMITG/V5D2LVNnxmYp2lSyciEY8NgdbsrakEyTDYYvw40ijWy6Yy//
         FKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4GDlvVIbuEMSjpog68D853qJdshnlOic8vHoIJzFbR8=;
        b=LkYT5If7SBOx81vK67F5VYUThfqSDr7vZa5l6rv7Z+drTqJo15PQVgPpc7/0fLhfmc
         K1BXW3TkpPcqEHyf9Jen9UbusBoeAAHaljZq0OcLu0x53nmNbjOQLqx2/OFCyQmuWryN
         PLo6SH/VAKyH8X5WRApfwWr7Vxps231r+9Be5onUUh0/0TVkylPjbacfk1lohXbfgi+O
         XT6eUG02JrHwNLf/H6OOhZl0hs3+330G3qyswWLRH1qqpjiGkrsHH2T35DnN09BnMvaC
         6PlLBSLPqPbaIhoZ0IA7qnOztjAOFQc5egoxeCw1X+UQ1BsBl1BDjkFZJsZQerhwR7LJ
         LAoQ==
X-Gm-Message-State: APjAAAXJ6uTp1S/5zsW/wHcDQJsKTX98FxVcoEp1xEQMGD9k0bQuX/1H
        vsuqs6q+sZ4IGFcy9kbKjhA=
X-Google-Smtp-Source: APXvYqz9wvasYcGFZOAF/O+EHv/0f99oo5XH+0E6bgjvB2lvBle5sQTAm3dgUwqxMFDZFcC/TXPdqA==
X-Received: by 2002:a63:2c8e:: with SMTP id s136mr205549pgs.277.1562792167340;
        Wed, 10 Jul 2019 13:56:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v14sm2462422pfm.164.2019.07.10.13.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:56:06 -0700 (PDT)
Date:   Wed, 10 Jul 2019 13:56:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-hwmon@vger.kernel.org, Eddie James <eajames@linux.ibm.com>,
        Alexander Amelkin <a.amelkin@yadro.com>,
        Lei YU <mine260309@gmail.com>,
        Alexander Soldatov <a.soldatov@yadro.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon (occ): Add temp sensor value check
Message-ID: <20190710205605.GA7749@roeck-us.net>
References: <20190710072606.4849-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710072606.4849-1-joel@jms.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 04:56:06PM +0930, Joel Stanley wrote:
> From: Alexander Soldatov <a.soldatov@yadro.com>
> 
> The occ driver supports two formats for the temp sensor value.
> 
> The OCC firmware for P8 supports only the first format, for which
> no range checking or error processing is performed in the driver.
> Inspecting the OCC sources for P8 reveals that OCC may send
> a special value 0xFFFF to indicate that a sensor read timeout
> has occurred, see
> 
> https://github.com/open-power/occ/blob/master_p8/src/occ/cmdh/cmdh_fsp_cmds.c#L395
> 
> That situation wasn't handled in the driver. This patch adds invalid
> temp value check for the sensor data format 1 and handles it the same
> way as it is done for the format 2, where EREMOTEIO is reported for
> this case.
> 
> Fixes: 54076cb3b5ff ("hwmon (occ): Add sensor attributes and register hwmon device")
> Signed-off-by: Alexander Soldatov <a.soldatov@yadro.com>
> Signed-off-by: Alexander Amelkin <a.amelkin@yadro.com>
> Reviewed-by: Alexander Amelkin <a.amelkin@yadro.com>
> Reviewed-by: Eddie James <eajames@linux.ibm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index cccf91742c1a..a7d2b16dd702 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -241,6 +241,12 @@ static ssize_t occ_show_temp_1(struct device *dev,
>  		val = get_unaligned_be16(&temp->sensor_id);
>  		break;
>  	case 1:
> +		/*
> +		 * If a sensor reading has expired and couldn't be refreshed,
> +		 * OCC returns 0xFFFF for that sensor.
> +		 */
> +		if (temp->value == 0xFFFF)
> +			return -EREMOTEIO;
>  		val = get_unaligned_be16(&temp->value) * 1000;
>  		break;
>  	default:
