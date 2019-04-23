Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50E6C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5FF20693
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqU6ARLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfDWNna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:43:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37151 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfDWNna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:43:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so7643355pgc.4;
        Tue, 23 Apr 2019 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mA3mF+ycxeUdvUahPhxXN3FfcyNfELyy8iLDdoDE09E=;
        b=kqU6ARLZVrNi50fCv25akrY3R3TDlpcSWaTOn+OaLTngZRAUjjZ68QTQRbzvxwMGF8
         TKgq1xtbXDfBCdwZmJYdRH9/g8hSLVAOr3I7fPnZ8KsqB4moyNr2Ivq4z1NrX1sunvCI
         zyeA5wAT3Qn3iTYQSTLeDVHR+Eu349E87JUMuyFb1tuLbDxb/lFn9w1A68Iz8SDOlqO6
         /CO6E7cJcDJUWBNlNE9S9RtrxQm/O5a7Au17tjBXkSH5oPC8jP1kYT20wK+iNjYoNqq8
         joyIrMhOOhheajV9TnyN4Umn6J7tFAPr7cwmWY7dAOB3db91zHeHXRNfuCXa0tQ682l2
         lv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mA3mF+ycxeUdvUahPhxXN3FfcyNfELyy8iLDdoDE09E=;
        b=IsPGLnfpJKIhLnF870QWef9+J26R98Sw42EcRaQ1mK21DRc2AahVPU89F1XrwTx+B+
         irnCEwiASuGaAUt/9eo2+x7moycGrgjbfmeMEfBmFPRRUoK1o/bpF6a+N+BtKc6xPUYj
         aFEioe9F/k7um+sMFSWToWfNdsuraZpocFTDxUjiXT8g3pT86beod90KQQZhtbbVYXDQ
         OmbtWaLO+7FlqEVcONMBFGqhSlZgR0FHLL/ZNYOLV4CdZc0QzewsZcXMokPgWuuPqGhQ
         jqcoScvkxHdLhR4jBsR3koKbBvLvb1vuzqFiq1Gt7lMLGQOotTx0nKLwRlG8L3u3v7WT
         HpwQ==
X-Gm-Message-State: APjAAAX1iv3ruOOR6JFjJjmh1A9VoYhon6f3E4KkPgsIk24/LjRnvpU1
        KEfKrLmtadgvsGvQnqXwDF0=
X-Google-Smtp-Source: APXvYqzKHUvKnbHvWOP3vc8MmOGQBIPY0daPQG/AigqGZaj9m4wYbajx1ahELIYHJMhcHPQ4NRUdRQ==
X-Received: by 2002:a63:c64a:: with SMTP id x10mr24469513pgg.12.1556027009384;
        Tue, 23 Apr 2019 06:43:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f27sm2867144pfk.111.2019.04.23.06.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 06:43:28 -0700 (PDT)
Date:   Tue, 23 Apr 2019 06:43:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH next 07/25] hwmon: s3c: Use dev_get_drvdata()
Message-ID: <20190423134326.GA19164@roeck-us.net>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
 <20190423075020.173734-8-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423075020.173734-8-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:50:02PM +0800, Kefeng Wang wrote:
> Using dev_get_drvdata directly.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/s3c-hwmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
> index 0c4710d35d16..0d65aa5985e2 100644
> --- a/drivers/hwmon/s3c-hwmon.c
> +++ b/drivers/hwmon/s3c-hwmon.c
> @@ -98,7 +98,7 @@ static int s3c_hwmon_read_ch(struct device *dev,
>  static ssize_t s3c_hwmon_show_raw(struct device *dev,
>  				  struct device_attribute *attr, char *buf)
>  {
> -	struct s3c_hwmon *adc = platform_get_drvdata(to_platform_device(dev));
> +	struct s3c_hwmon *adc = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *sa = to_sensor_dev_attr(attr);
>  	int ret;
>  
> @@ -164,7 +164,7 @@ static ssize_t s3c_hwmon_ch_show(struct device *dev,
>  				 char *buf)
>  {
>  	struct sensor_device_attribute *sen_attr = to_sensor_dev_attr(attr);
> -	struct s3c_hwmon *hwmon = platform_get_drvdata(to_platform_device(dev));
> +	struct s3c_hwmon *hwmon = dev_get_drvdata(dev);
>  	struct s3c_hwmon_pdata *pdata = dev_get_platdata(dev);
>  	struct s3c_hwmon_chcfg *cfg;
>  	int ret;
