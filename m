Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E81C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53E724A31
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFfV/BaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfFDETz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 00:19:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39940 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFDETz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 00:19:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so9537836pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 21:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rqesh/1RcslZqpfaYXp2NOCg2du22Gl0mzXUAG7Z6/w=;
        b=AFfV/BaCBqJ6kDwO3NSGhJY0v7DGK+9j8+swmyBQx1qu0MHJcYdjWqr0jP0gMBDnYx
         n+t9Nj3ya/YptxpENH/30szuBnvleTl83So+VwVF+QRqx6KijhaeOqp7MmrY9UBFHA6r
         VktQjI0mFeYQ9R5bF2AQOW1YJuAEXCPpSYbGR+kTBXY5CUkb1V9JO3HiLNfLAg/fi/kk
         J58wHK7mhQXhnHG1Vi823fUdCnTvjyqS2NaAxhDhVrnx9uC835+Cpinn7XSiMJsborRs
         tdmK/jp3FbQ2RYW772i0pEP8+x2mYA57z+2v8bNQyUPl/jkwDFXUKayBDya0lhD1PLY6
         +skQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rqesh/1RcslZqpfaYXp2NOCg2du22Gl0mzXUAG7Z6/w=;
        b=V8r+ADZr0DvOIK3YoFaBlEEm7+W7K9UHMzIlGn8ov58KJZdNKdo68kC+Dqs4LMWWgW
         z2IaGRkMbf/znEnh6ij9xlkuqpGIofPL3SEj/LuX/xv1YanppghHZkl3ULj2OMMvLkBm
         EWJTPooczDMSvHILnvg3AM2cAreOJomA2XTUmv5XG7dfZBlyCJEMooCxQbYyWPK6bBjP
         wgCe84ibPh4I5tMaGZPZW90kOhXocQuspzt2nvNbHP65Bbw2GgjfFpW7Y/GGW3bbH6Gn
         iuUFxDUJu1h+xmQtP0UzN3+sSHUe9tKCUVfmsQdPV7JtSdquBW7WpaY8Q3NOz9W/BzsN
         qLFA==
X-Gm-Message-State: APjAAAU5e0lCYy8FlO6HlCx9CHTyvyVNirxMWfx8sJo04yhKyHZ4ssV3
        aVR1K+ceHAjokQfw8CuZ84U=
X-Google-Smtp-Source: APXvYqwxXhBFVO4rZBeSlIpjSfLs3AH1VBh7lBCiVio59+4okEljODkLiYqqdycbhIB/cK81c/kcyw==
X-Received: by 2002:a17:90a:cb84:: with SMTP id a4mr34316807pju.104.1559621994365;
        Mon, 03 Jun 2019 21:19:54 -0700 (PDT)
Received: from [192.168.1.5] ([117.192.17.118])
        by smtp.gmail.com with ESMTPSA id m20sm371756pjn.16.2019.06.03.21.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 21:19:53 -0700 (PDT)
Subject: Re: [PATCH v2 8/9] staging: rtl8712: fixed enable_rx_ff0_filter as
 bool and CamelCase
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
References: <cover.1559470737.git.linux.dkm@gmail.com>
 <7b32a7cf85ef0c3f6d2ba82480a1f8d0ad651779.1559470738.git.linux.dkm@gmail.com>
 <20190602171427.GE19671@kroah.com>
From:   Deepak Kumar Mishra <linux.dkm@gmail.com>
Message-ID: <07d55e1d-982e-b2c6-7c81-e22a33b22efa@gmail.com>
Date:   Tue, 4 Jun 2019 09:49:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190602171427.GE19671@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/06/19 10:44 PM, Greg KH wrote:
> On Sun, Jun 02, 2019 at 03:55:37PM +0530, Deepak Mishra wrote:
>> This patch fixes CamelCase blnEnableRxFF0Filter by renaming it
>> to enable_rx_ff0_filter in drv_types.h and related files rtl871x_cmd.c
>> xmit_linux.c
>> It was reported by checkpatch.pl
>>
>> This fix also makes enable_rx_ff0_filter a bool and uses true false than
>> previously used u8 as suggested by joe@perches.com
>>
>> Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
>> ---
>>   drivers/staging/rtl8712/drv_types.h   | 2 +-
>>   drivers/staging/rtl8712/rtl871x_cmd.c | 2 +-
>>   drivers/staging/rtl8712/xmit_linux.c  | 4 ++--
>>   3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
>> index ddab6514a549..e3e2b32e964e 100644
>> --- a/drivers/staging/rtl8712/drv_types.h
>> +++ b/drivers/staging/rtl8712/drv_types.h
>> @@ -164,7 +164,7 @@ struct _adapter {
>>   	struct iw_statistics iwstats;
>>   	int pid; /*process id from UI*/
>>   	struct work_struct wk_filter_rx_ff0;
>> -	u8 blnEnableRxFF0Filter;
>> +	bool enable_rx_ff0_filter;
>>   	spinlock_t lockRxFF0Filter;
>>   	const struct firmware *fw;
>>   	struct usb_interface *pusb_intf;
>> diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
>> index 05a78ac24987..6a8d58d97873 100644
>> --- a/drivers/staging/rtl8712/rtl871x_cmd.c
>> +++ b/drivers/staging/rtl8712/rtl871x_cmd.c
>> @@ -238,7 +238,7 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
>>   	mod_timer(&pmlmepriv->scan_to_timer,
>>   		  jiffies + msecs_to_jiffies(SCANNING_TIMEOUT));
>>   	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_SITE_SURVEY);
>> -	padapter->blnEnableRxFF0Filter = 0;
>> +	padapter->enable_rx_ff0_filter = false;
>>   	return _SUCCESS;
>>   }
>>   
>> diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
>> index e65a51c7f372..9fa1abcf5e50 100644
>> --- a/drivers/staging/rtl8712/xmit_linux.c
>> +++ b/drivers/staging/rtl8712/xmit_linux.c
>> @@ -103,11 +103,11 @@ void r8712_SetFilter(struct work_struct *work)
>>   	r8712_write8(padapter, 0x117, newvalue);
>>   
>>   	spin_lock_irqsave(&padapter->lockRxFF0Filter, irqL);
>> -	padapter->blnEnableRxFF0Filter = 1;
>> +	padapter->enable_rx_ff0_filter = true;
>>   	spin_unlock_irqrestore(&padapter->lockRxFF0Filter, irqL);
>>   	do {
>>   		msleep(100);
>> -	} while (padapter->blnEnableRxFF0Filter == 1);
>> +	} while (padapter->enable_rx_ff0_filter == true);
> That is horrible, and I'm amazed it ever even works.  Please fix this
> properly, spinning on a random variable is not how you do
> synchronization in the kernel.

I agree and will submit a different fix for this.

I am submitting a patchset v3 for removal of unused variables and 
CamelCase fix for now.

Thanks.

Deepak Mishra

> thanks,
>
> greg k-h
