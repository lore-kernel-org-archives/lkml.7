Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28873C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 06:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B0C21670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 06:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfGEG6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 02:58:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36631 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfGEG6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 02:58:35 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hjIAy-0006YY-Cl
        for linux-kernel@vger.kernel.org; Fri, 05 Jul 2019 06:58:32 +0000
Received: by mail-pg1-f198.google.com with SMTP id t2so5028801pgs.21
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 23:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eZqEf7xmNMA5rKDyuD/VrM2oNxltKYjl6KQelNpHGU0=;
        b=V9+8ZKIhQ88z6Dhtg69+mJpURuqlGb2ok/emiR0fak/3oz0L/LjTh66jIeHUxg1kcT
         cSSE50+D86RblJmoGhnErTsYK8HiuD3t1YPHKHSP7AYJXjQNMSh+vcKZPuBcIqHtehfU
         23CDKLhvcQuv0Of66cj2uQ3pBwKmtp0NFr3ydfILJnt1Zb9aC+docRkkF6s1LzpZ2lDz
         gKqXolnCZCy7s+fuaI+gsLoKqEpd2Ds5TWT+U3XqpHZ/GFVonFshqrY704pdCsm/gaQQ
         CovcAOP9l+GDxAWDexpjYH0QOiAfA5kqLV8Aic5rKehSyC+qPudMMt3ZpNp2rb4/u4mL
         /XPw==
X-Gm-Message-State: APjAAAUU/JNxD3cztsSyb1C7y0oBeZ0MQ4EZrLywmuYkJsVqe/mV5FOG
        mmgg3etowidx0iiYaQEWt/xBqJ8IYRz6Zp1TO5l/SjEnqsMuV4cX30pSV3/hql1PtBTPQ2d5Lox
        lZ902EdXAALrqeaWy5f6ld5XdbGi1PeT5dL/f0wyswg==
X-Received: by 2002:a17:902:44f:: with SMTP id 73mr3214083ple.192.1562309911068;
        Thu, 04 Jul 2019 23:58:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxBm9SG0ZQzZ64kySYWGAdtvXFMn9O0/qVGQhPZocuEH4uFbJqztt2EWTn/JflEVJBdM4+NcA==
X-Received: by 2002:a17:902:44f:: with SMTP id 73mr3214051ple.192.1562309910800;
        Thu, 04 Jul 2019 23:58:30 -0700 (PDT)
Received: from 2001-b011-380f-3511-154d-4126-51e3-28cb.dynamic-ip6.hinet.net (2001-b011-380f-3511-154d-4126-51e3-28cb.dynamic-ip6.hinet.net. [2001:b011:380f:3511:154d:4126:51e3:28cb])
        by smtp.gmail.com with ESMTPSA id 196sm8945565pfy.167.2019.07.04.23.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 23:58:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Disable LE Advertising in
 hci_suspend_dev()
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <329E5979-6716-4776-9B1A-1859998D19D0@canonical.com>
Date:   Fri, 5 Jul 2019 14:58:27 +0800
Cc:     Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E5997B89-4FEF-4FD5-BA4E-852E39DCFA75@canonical.com>
References: <20190430092544.13653-1-kai.heng.feng@canonical.com>
 <329E5979-6716-4776-9B1A-1859998D19D0@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 11:00, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:

> Hi Marcel,
>
> at 5:25 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
>> LE Advertising may wake up system during system-wide sleep, disable it
>> to prevent this issue from happening.
>>
>> Do the reverse in hci_resume_dev().
>
> Do you have any suggestion for this patch?

Please let me know where I can do further improvement.

This can solve a hard freeze during system suspend.

Kai-Heng

>
> Kai-Heng
>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2:
>> - Abstract away enabling/disabling LE advertising from btusb.
>>
>>  include/net/bluetooth/hci_core.h |  1 +
>>  net/bluetooth/hci_core.c         | 47 ++++++++++++++++++++++++++++++++
>>  2 files changed, 48 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci_core.h  
>> b/include/net/bluetooth/hci_core.h
>> index 094e61e07030..65574943131d 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -269,6 +269,7 @@ struct hci_dev {
>>  	__u16		le_max_rx_time;
>>  	__u8		le_max_key_size;
>>  	__u8		le_min_key_size;
>> +	__u8		le_events[8];
>>  	__u16		discov_interleaved_timeout;
>>  	__u16		conn_info_min_age;
>>  	__u16		conn_info_max_age;
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index d6b2540ba7f8..7c19e3b9294c 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -412,6 +412,49 @@ static void hci_setup_event_mask(struct hci_request  
>> *req)
>>  	hci_req_add(req, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
>>  }
>>
>> +static int hci_enable_le_advertising_req(struct hci_request *req,  
>> unsigned long opt)
>> +{
>> +	struct hci_dev *hdev = req->hdev;
>> +	u8 events[8];
>> +	memcpy(events, hdev->le_events, sizeof(events));
>> +
>> +	hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
>> +			events);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hci_disable_le_advertising_req(struct hci_request *req,  
>> unsigned long opt)
>> +{
>> +	struct hci_dev *hdev = req->hdev;
>> +
>> +	u8 events[8];
>> +	memcpy(events, hdev->le_events, sizeof(events));
>> +
>> +	events[0] &= ~(u8)0x02;	/* LE Advertising Report */
>> +
>> +	hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
>> +			events);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hci_enable_le_advertising(struct hci_dev *hdev)
>> +{
>> +	if (!lmp_le_capable(hdev))
>> +		return 0;
>> +
>> +	return __hci_req_sync(hdev, hci_enable_le_advertising_req, 0,  
>> HCI_CMD_TIMEOUT, NULL);
>> +}
>> +
>> +static int hci_disable_le_advertising(struct hci_dev *hdev)
>> +{
>> +	if (!lmp_le_capable(hdev))
>> +		return 0;
>> +
>> +	return __hci_req_sync(hdev, hci_disable_le_advertising_req, 0,  
>> HCI_CMD_TIMEOUT, NULL);
>> +}
>> +
>>  static int hci_init2_req(struct hci_request *req, unsigned long opt)
>>  {
>>  	struct hci_dev *hdev = req->hdev;
>> @@ -772,6 +815,8 @@ static int hci_init3_req(struct hci_request *req,  
>> unsigned long opt)
>>  		}
>>
>>  		hci_set_le_support(req);
>> +
>> +		memcpy(hdev->le_events, events, sizeof(events));
>>  	}
>>
>>  	/* Read features beyond page 1 if available */
>> @@ -3431,6 +3476,7 @@ EXPORT_SYMBOL(hci_unregister_dev);
>>  /* Suspend HCI device */
>>  int hci_suspend_dev(struct hci_dev *hdev)
>>  {
>> +	hci_disable_le_advertising(hdev);
>>  	hci_sock_dev_event(hdev, HCI_DEV_SUSPEND);
>>  	return 0;
>>  }
>> @@ -3440,6 +3486,7 @@ EXPORT_SYMBOL(hci_suspend_dev);
>>  int hci_resume_dev(struct hci_dev *hdev)
>>  {
>>  	hci_sock_dev_event(hdev, HCI_DEV_RESUME);
>> +	hci_enable_le_advertising(hdev);
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(hci_resume_dev);
>> -- 
>> 2.17.1


