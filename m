Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92F2CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 00:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD6C20854
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 00:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIviEHOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfJTAdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 20:33:18 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43004 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfJTAdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 20:33:18 -0400
Received: by mail-vk1-f193.google.com with SMTP id f1so2027733vkh.9;
        Sat, 19 Oct 2019 17:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=44KfTZ2cJOchaunhfhbiqY31EYfMkgKESbwiMZKSonU=;
        b=dIviEHOfOTLhHGkpYgZiS6o0yow0O3jd7UAXaidTDSiT3So21awMpawthsdY+ePJcg
         iBmdL6Ggec93yDyyiyae1cwUpuWeD61LQOYcjbJPr33LcIWaXf+k1D7tMrlvia0IaQF6
         DAE2k27dHg2tmPvKxTb3qLe9zDXo8bWL5Pdi8wd0d09Xq8LEISq0+2vFELxCH82OeWs1
         IuB71YCF0zkmohbGyMEtUYlt8a4cWq+NolOTfbbfcA9YX7KsfD0AL81DbrrvKw+kYaXH
         Sar1NVQlEJsDp2Jilyarw37gRSd5LgTO0jBoOdLHuepiWgttmV5wdFFAUpNTSsrHDfn8
         RX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=44KfTZ2cJOchaunhfhbiqY31EYfMkgKESbwiMZKSonU=;
        b=sa1Ma5E/ekucdCZT7/QlSC6GuHVxk29cxpx4bgQTqK5ERQZ9z4SPtWR7PaDXz+NWDc
         X9qpkkeQgtIG6Hnzq4g85/ffiHzyTT7q4swkH62D4b+whhm9abCLW59xHPRuu4eFniph
         7s0oxPtUx2gMLQgW7wFQ+xUJfYAEzvyG1LHhc+Eao4ReC6O8yldoPYppvOIVCJYrzNnj
         CiVYzdEfl2ENZqxXC7po0pvJzb++kTyoAqcI5SoQQy7Dt215XTnNw+ksQtvgMMJGXuvK
         cH4ZxNi6NtxSblHHwsJ9irzy7DHeMcQloIkdjGO20LNAnZsnYccl3TB7MEhrylQWP2Uf
         rG8w==
X-Gm-Message-State: APjAAAW9qYKpt6SmxkWF2MFJmxVViH+YO4kv5z/+VIAGC1teovQ3lmz8
        mV87OpwnwIgk8jOz4EmPCg==
X-Google-Smtp-Source: APXvYqxS7T5I11JaN77YECLCFShH6EfDyKIpFbPjEsgv7XfPD9IVGaEokzyBer6Ai5hamzej+ZNv/w==
X-Received: by 2002:a1f:2e0a:: with SMTP id u10mr9293443vku.79.1571531596512;
        Sat, 19 Oct 2019 17:33:16 -0700 (PDT)
Received: from 960ws ([2601:901:202:18cc:6890:3fdd:51d1:9d8c])
        by smtp.gmail.com with ESMTPSA id l199sm2825424vke.49.2019.10.19.17.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 17:33:16 -0700 (PDT)
Message-ID: <482708553d5dc6cec2d4513391d81a22928fd4b2.camel@gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: huawei-wmi: No need to check for
 battery name
From:   ayman.bagabas@gmail.com
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Takashi Iwai <tiwai@suse.de>, Mattias Jacobsson <2pi@mok.nu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kbuild test robot <lkp@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 19 Oct 2019 20:33:14 -0400
In-Reply-To: <20191018224221.15495-2-ayman.bagabas@gmail.com>
References: <20191018224221.15495-1-ayman.bagabas@gmail.com>
         <20191018224221.15495-2-ayman.bagabas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-18 at 18:42 -0400, Ayman Bagabas wrote:
> No need to check for battery name, we already check if the WMI
> function is
> available in huawei_wmi_battery_setup.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>

Thank you,
Ayman
> ---
>  drivers/platform/x86/huawei-wmi.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/huawei-wmi.c
> b/drivers/platform/x86/huawei-wmi.c
> index 26041d44286a..7373a65a61d3 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -471,10 +471,6 @@ static
> DEVICE_ATTR_RW(charge_control_thresholds);
>  
>  static int huawei_wmi_battery_add(struct power_supply *battery)
>  {
> -	/* Huawei laptops come with one battery only */
> -	if (strcmp(battery->desc->name, "BAT") != 1)
> -		return -ENODEV;
> -
>  	device_create_file(&battery->dev,
> &dev_attr_charge_control_start_threshold);
>  	device_create_file(&battery->dev,
> &dev_attr_charge_control_end_threshold);
>  

