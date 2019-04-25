Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AB7C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E62D2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfDYQ0w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:26:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47008 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfDYQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:26:51 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hJhD0-0001Qm-5y
        for linux-kernel@vger.kernel.org; Thu, 25 Apr 2019 16:26:50 +0000
Received: by mail-pg1-f198.google.com with SMTP id m9so86652pge.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1oiqi9G6Np0kNTcVBRPgMIfw8IbqDIQ5obuFDLuIjEc=;
        b=JUF/PxMay8TEApqI0If1OyrX13XZeOMOgWNb33b1Q9qEtBGNqG6AArNSBrBLg/MCd+
         NH5wdTm2w9ap9aUYlgaqf/HY9VSPQ7BVAjvUQbEGIvlgDJsBTn09eKILLjUQqXTBqo3J
         Naq/7TZMBZkX7UGTQYQoKS6nx/f3i+voC6ANoVHb7geBLo1BX4XbptMdYAQTkMe8kMwV
         xCaXormV5P21bnEHZzKVKWOAl7ZGfyS4u+206owAjQvZR01MS9tX7KNtVzWZM9q1OD59
         pAlN1khKcb8pyM30aG51ciy7NWloXPrN0SP3Jn1h9nQndtZB89mLHZclNt3yCSfbojT8
         zx1Q==
X-Gm-Message-State: APjAAAUf5AUkXv53jp738unVGLTfK+BXhw8UW1xxpvB9f9aK3iJfdfvD
        bPFWJLXyO8ftsIKvrxf0WrTzPgNv4eF9o3QMRXluDTzsCMNxJ8DKBCPlCwqFGhOZUvVOMHE1fgY
        HWrxPcpmH9Snmzb09TWIocB8F/FetIRNbEqkuZTitpA==
X-Received: by 2002:a17:902:1007:: with SMTP id b7mr40578747pla.48.1556209608300;
        Thu, 25 Apr 2019 09:26:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxy4GUwHxcf74vURkXiIR3S8ygpe5IPfdux4g26IO1WSU7WUQ92IfICcKyqCL2iROoYnNCB2w==
X-Received: by 2002:a17:902:1007:: with SMTP id b7mr40578677pla.48.1556209607611;
        Thu, 25 Apr 2019 09:26:47 -0700 (PDT)
Received: from [192.168.1.220] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id p26sm49851298pfa.49.2019.04.25.09.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:26:46 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 2/2] Bluetooth: btusb: Disable LE Advertising on system
 suspend
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <3E3982D2-2912-4467-A8BF-C0BE53C9B82C@holtmann.org>
Date:   Fri, 26 Apr 2019 00:27:32 +0800
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0AA2825C-2286-4A72-AA88-5E57BC55DFE8@canonical.com>
References: <20190422092034.21461-1-kai.heng.feng@canonical.com>
 <20190422092034.21461-2-kai.heng.feng@canonical.com>
 <3E3982D2-2912-4467-A8BF-C0BE53C9B82C@holtmann.org>
To:     Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

> On Apr 24, 2019, at 12:28 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> 
> Hi Kai-Heng,
> 
>> System may freeze during suspend, and it's caused by btusb early wakeup:
>> 
>> kernel: pci_pm_suspend(): hcd_pci_suspend+0x0/0x30 returns -16
>> kernel: dpm_run_callback(): pci_pm_suspend+0x0/0x130 returns -16
>> kernel: PM: Device 0000:00:14.0 failed to suspend async: error -16
>> kernel: PM: Some devices failed to suspend, or early wake event detected
>> kernel: usb usb1: usb resume
>> kernel: hub 1-0:1.0: hub_resume
>> kernel: usb usb1-port1: status 0507 change 0000
>> kernel: usb usb1-port6: status 0103 change 0004
>> kernel: usb usb1-port10: status 0107 change 0000
>> 
>> where btusb is connecte to usb1-port6.
>> 
>> The expirement shows that the early wakeup is caused by LE Advertising
>> packet.
>> 
>> Disabling it via event mask can prevent the issue from happening.
>> 
>> BugLink: https://bugs.launchpad.net/bugs/1823029
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/bluetooth/btusb.c | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 10c8f9872ee5..f03fcf5687e4 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -490,6 +490,7 @@ struct btusb_data {
>> 	int (*setup_on_usb)(struct hci_dev *hdev);
>> 
>> 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
>> +	bool suspended;
>> };
>> 
>> static inline void btusb_free_frags(struct btusb_data *data)
>> @@ -3316,12 +3317,18 @@ static void btusb_disconnect(struct usb_interface *intf)
>> static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>> {
>> 	struct btusb_data *data = usb_get_intfdata(intf);
>> +	struct hci_dev *hdev = data->hdev;
>> 
>> 	BT_DBG("intf %p", intf);
>> 
>> 	if (data->suspend_count++)
>> 		return 0;
>> 
>> +	if (!PMSG_IS_AUTO(message)) {
>> +		hci_disable_le_advertising(hdev);
>> +		data->suspended = true;
>> +	}
>> +
>> 	spin_lock_irq(&data->txlock);
>> 	if (!(PMSG_IS_AUTO(message) && data->tx_in_flight)) {
>> 		set_bit(BTUSB_SUSPENDING, &data->flags);
>> @@ -3427,6 +3434,11 @@ static int btusb_resume(struct usb_interface *intf)
>> 	spin_unlock_irq(&data->txlock);
>> 	schedule_work(&data->work);
>> 
>> +	if (data->suspended) {
>> +		hci_enable_le_advertising(hdev);
>> +		data->suspended = false;
>> +	}
>> +
>> 	return 0;
> 
> this is a clear NAK. Please stop hacking things.
> 
> Lets use hci_suspend_dev and hci_resume_dev and make it actually do something to disable the events for advertising.

Do you mean hci_disable_le_advertising() should be called by hci_suspend_dev(), which should be called by btusb_suspend()?

I’ve tried calling hci_suspend_dev() without disabling advertising, the issue still presents.

Kai-Heng 

> 
> Regards
> 
> Marcel

