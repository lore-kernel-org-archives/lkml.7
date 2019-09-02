Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC6EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 02:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022E92186A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 02:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0WtRbVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfIBC7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 22:59:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38888 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfIBC7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 22:59:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id d10so2089552pgo.5;
        Sun, 01 Sep 2019 19:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KkuAItPCObG7Xv6hke9ccba/rUm0EoOSedBhG147eCQ=;
        b=A0WtRbVQwOo4A/StLnWxwbVgFzDgcHdyOue7A/eluObTN0uWKZKCw8E/Kjf1KSzJxj
         CdP3zdOntEmJoIIPPdawP/2KP5aCXXa4iQL+LnyCAGiXMQzoWZ3SNh4idMXT2z2l95bB
         tCZTGTE1ru1ZE5dthdyu68gXitXr9faA99gxR68OtrPD/0wFlFgCsp+vEb2v2qXSUx3b
         nNefzU31kglhRUYGlJTKnqhVoMxPdgzDd7kCyq9WgTsoIbTzWB7x0kmgvb1/I3iiVjaP
         RzpSWtBy2XcAMT3Hzo/qaiWQW6h40VRR1H21tXb6yXBqaPaZ1A45gMW/tLR96cVrioWE
         L+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KkuAItPCObG7Xv6hke9ccba/rUm0EoOSedBhG147eCQ=;
        b=RMgeXr8zuXmRQxQAn6Q0nYibVzTvayqI6EMxOpffg90MIQdL+nlTRnYCd9iaUZUbFf
         IMhsCuIqRYbvIK8LHkNnnslBUjL40TEDOq/Lo6nb7n1r/EKCIZsgWgAfaG9kpeIGWlaN
         d2Z4Pn3LgNc8jI3bzWYHU+yscy97Ej1jvqj+2KsDbRTuje9BWBom0M+L/hreS/HCMGez
         kVbCq/7NpS725xt/fRxsVLakYGZ+KxBRVjBKbSisWbhf87Gke50g8aj6l5eKYDwthGxV
         HtRsHZpd4MgJjKjwq/R2+W1Vk61QmNyXyffoXU9H67qNEIXnFPbHu9P5wgQ1HqJ60DUg
         nTjA==
X-Gm-Message-State: APjAAAVDFxXiBH5CTWUASbtIBClrowBMWH2SJtiLeDErfCBZay/L2Fz9
        f2c2SqhQ7gYivJ0qO5gAxjU=
X-Google-Smtp-Source: APXvYqz3epFgPOFLqTTRNtu1wL1R5RpY2qPkOF0SGjWVBAJzCb/qY4/xwd/QnyRm0tvxZ9+SS/DCDg==
X-Received: by 2002:aa7:9ab6:: with SMTP id x22mr32406157pfi.80.1567393160357;
        Sun, 01 Sep 2019 19:59:20 -0700 (PDT)
Received: from [192.168.1.60] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id o67sm19538578pfb.39.2019.09.01.19.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2019 19:59:19 -0700 (PDT)
Subject: Re: [PATCH V1 3/6] USB: serial: f81232: Add generator for F81534A
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1559789656-15847-4-git-send-email-hpeter+linux_kernel@gmail.com>
 <20190828150252.GJ13017@localhost>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <b194f7e6-963d-df3b-5295-4323dae0846d@gmail.com>
Date:   Mon, 2 Sep 2019 10:59:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828150252.GJ13017@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Johan Hovold 於 2019/8/28 下午 11:02 寫道:
> On Thu, Jun 06, 2019 at 10:54:13AM +0800, Ji-Ze Hong (Peter Hong) wrote:
>> The Fintek F81534A series is contains 1 HUB / 1 GPIO device / n UARTs,
>> but the UART is default disable and need enabled by GPIO device(2c42/16F8).
>> When F81534A plug to host, we can only see 1 HUB & 1 GPIO device, add
>> GPIO device USB interface to device_list and trigger generate worker,
>> f81534a_generate_worker to run f81534a_ctrl_generate_ports().
>>
>> The operation in f81534a_ctrl_generate_ports() as following:
>> 	1: Write 0x8fff to F81534A_CMD_ENABLE_PORT register for enable all
>> 	   UART device.
>>
>> 	2: Read port existence & current status from F81534A_CMD_PORT_STATUS
>> 	   register. the higher 16bit will indicate the UART existence. If the
>> 	   UART is existence, we'll check it GPIO mode as long as not default
>> 	   value (default is all input mode).
>>
>> 	3: 1 GPIO device will check with max 15s and check next GPIO device when
>> 	   timeout. (F81534A_CTRL_RETRY * F81534A_CTRL_TIMER)
>>
>> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> 
> This is all looks crazy... Please better describe how the device works,
> and you want to implement support.

I'll try to refactor more simply for first add into kernel.

>> ---
>>   drivers/usb/serial/f81232.c | 356 +++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 355 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
>> index 75dfc0b9ef30..e9470fb0d691 100644
>> --- a/drivers/usb/serial/f81232.c
>> +++ b/drivers/usb/serial/f81232.c
>> @@ -41,6 +41,12 @@ static const struct usb_device_id id_table[] = {
>>   };
>>   MODULE_DEVICE_TABLE(usb, id_table);
>>   
>> +static const struct usb_device_id f81534a_ctrl_id_table[] = {
>> +	{ USB_DEVICE(0x2c42, 0x16f8) },		/* Global control device */
>> +	{ }					/* Terminating entry */
>> +};
>> +MODULE_DEVICE_TABLE(usb, f81534a_ctrl_id_table);
> 
> You can only have one MODULE_DEVICE_TABLE()...

I had a question about this. In this file, we'll need support 3 sets of
id f81232(1)/f81534a(9)/f81534a_ctrl(1). So I will refactor the code
about id section to the below due to the id table will use more than
once:

=======================================================================
#define F81232_ID		\
	{ USB_DEVICE(0x1934, 0x0706) }	/* 1 port UART device */

#define F81534A_SERIES_ID	\
	{ USB_DEVICE(0x2c42, 0x1602) },	/* In-Box 2 port UART device */	\
	{ USB_DEVICE(0x2c42, 0x1604) },	/* In-Box 4 port UART device */	\
	{ USB_DEVICE(0x2c42, 0x1605) },	/* In-Box 8 port UART device */	\
	{ USB_DEVICE(0x2c42, 0x1606) },	/* In-Box 12 port UART device */ \
	{ USB_DEVICE(0x2c42, 0x1608) },	/* Non-Flash type */ \
	{ USB_DEVICE(0x2c42, 0x1632) },	/* 2 port UART device */ \
	{ USB_DEVICE(0x2c42, 0x1634) },	/* 4 port UART device */ \
	{ USB_DEVICE(0x2c42, 0x1635) },	/* 8 port UART device */ \
	{ USB_DEVICE(0x2c42, 0x1636) }	/* 12 port UART device */

#define F81534A_CTRL_ID		\
	{ USB_DEVICE(0x2c42, 0x16f8) }	/* Global control device */

static const struct usb_device_id id_table[] = {
	F81232_ID,
	{ }					/* Terminating entry */
};

static const struct usb_device_id f81534a_id_table[] = {
	F81534A_SERIES_ID,
	{ }					/* Terminating entry */
};

static const struct usb_device_id f81534a_ctrl_id_table[] = {
	F81534A_CTRL_ID,
	{ }					/* Terminating entry */
};

static const struct usb_device_id all_serial_id_table[] = {
	F81232_ID,
	F81534A_SERIES_ID,
	{ }					/* Terminating entry */
};
MODULE_DEVICE_TABLE(usb, all_serial_id_table);
=======================================================================

but the checkpatch.pl give me the warning below:
ERROR: Macros with complex values should be enclosed in parentheses
#42: FILE: f81232.c:28:
+#define F81534A_SERIES_ID      \
+       { USB_DEVICE(0x2c42, 0x1602) }, /* In-Box 2 port UART device */ \
+       { USB_DEVICE(0x2c42, 0x1604) }, /* In-Box 4 port UART device */ \
+       { USB_DEVICE(0x2c42, 0x1605) }, /* In-Box 8 port UART device */ \
+       { USB_DEVICE(0x2c42, 0x1606) }, /* In-Box 12 port UART device */ \
+       { USB_DEVICE(0x2c42, 0x1608) }, /* Non-Flash type */ \
+       { USB_DEVICE(0x2c42, 0x1632) }, /* 2 port UART device */ \
+       { USB_DEVICE(0x2c42, 0x1634) }, /* 4 port UART device */ \
+       { USB_DEVICE(0x2c42, 0x1635) }, /* 8 port UART device */ \
+       { USB_DEVICE(0x2c42, 0x1636) }  /* 12 port UART device */

Is any suggestion ?

Thanks
-- 
With Best Regards,
Peter Hong
