Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F23C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C21121734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgACQZn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:25:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36105 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgACQZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:25:42 -0500
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1inPlc-00021n-5f
        for linux-kernel@vger.kernel.org; Fri, 03 Jan 2020 16:25:40 +0000
Received: by mail-pl1-f197.google.com with SMTP id a2so10479544plm.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 08:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Fy+eTIrLJtig9Xio3xZc26BukFgrnKTWNzBm9Oqoh28=;
        b=iroHhN3U1f0VCvRVav98bPw1Q+d2oi14g9tAYCv3U5uptO+QdgwtLT0Xnz07H1SMa5
         q6t5UVvx7MchLQaAR15Z9PcT4OwXJqAvwB23nHVxQ4VwEw1qBEi1S7U0VfWJ5LQRfeYk
         t6Pqd4mW4YixjpEg1GlBGZrv8ZTTBLGSXLnxAhTrqM8jvK7+KE47+wa2dDjkO79Bd/YP
         NqC/iUskAx1ueHA7x+Jdqum2xOuleO7qrZgFZRnxUNblc8Q7kW/ZIGtdDs54KDEZfMxs
         2bof3i0Q5ohNLux3WccZ5UQICqj/x3onFGpaOB5T46133rg7BJv13+k6MwZ8sZGr2pdd
         mnJA==
X-Gm-Message-State: APjAAAVct3PXQ3lCgy8mbFtW4pjbq5aelfiYxnw+70u95fuJwfJETo9J
        Sue/y7OLZj1fWR4o7gECQFvGnu9ytsGhjbi4baJEpsLSXox1BCoM1RM15dRm3pIugoqkKqFZNjF
        zelwFtYrvdStKZeIyUXsqlWvKuiJPu4S7M0k8xBwOhw==
X-Received: by 2002:a17:90a:1696:: with SMTP id o22mr27651529pja.78.1578068738235;
        Fri, 03 Jan 2020 08:25:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjdLrvwcdvl2Uij0GtL60kvT1W8Bh7k1xN83HTvNDc7yvwagNvoYL4y/Aob0pe2g9VAkM/CA==
X-Received: by 2002:a17:90a:1696:: with SMTP id o22mr27651495pja.78.1578068737938;
        Fri, 03 Jan 2020 08:25:37 -0800 (PST)
Received: from 2001-b011-380f-35a3-58a8-ce0f-e12f-6096.dynamic-ip6.hinet.net (2001-b011-380f-35a3-58a8-ce0f-e12f-6096.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:58a8:ce0f:e12f:6096])
        by smtp.gmail.com with ESMTPSA id l8sm15254146pjy.24.2020.01.03.08.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:25:37 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH 3/3] USB: Disable LPM on WD19's Realtek Hub during setting
 its ports to U0
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.2001031018290.1560-100000@iolanthe.rowland.org>
Date:   Sat, 4 Jan 2020 00:25:34 +0800
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        gregkh@linuxfoundation.org, acelan.kao@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B3E0C8C0-3E45-42B3-86D9-E34D669E1F4A@canonical.com>
References: <Pine.LNX.4.44L0.2001031018290.1560-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> On Jan 3, 2020, at 23:21, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> On Fri, 3 Jan 2020, Kai-Heng Feng wrote:
> 
>> Realtek Hub (0bda:0x0487) used in Dell Dock WD19 sometimes drops off the
>> bus when bringing underlying ports from U3 to U0.
>> 
>> After some expirements and guessworks, the hub itself needs to be U0
>> during setting its port's link state back to U0.
>> 
>> So add a new quirk to let the hub disables LPM on setting U0 for its
>> downstream facing ports.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/usb/core/hub.c     | 12 ++++++++++--
>> drivers/usb/core/quirks.c  |  7 +++++++
>> include/linux/usb/quirks.h |  3 +++
>> 3 files changed, 20 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index f229ad6952c0..35a035781c5a 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -3533,9 +3533,17 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>> 	}
>> 
>> 	/* see 7.1.7.7; affects power usage, but not budgeting */
>> -	if (hub_is_superspeed(hub->hdev))
>> +	if (hub_is_superspeed(hub->hdev)) {
>> +		if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
>> +			usb_lock_device(hub->hdev);
>> +			usb_unlocked_disable_lpm(hub->hdev);
>> +		}
>> 		status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U0);
>> -	else
>> +		if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
>> +			usb_unlocked_enable_lpm(hub->hdev);
>> +			usb_unlock_device(hub->hdev);
> 
> The locking here seems questionable.  Doesn't this code sometimes get
> called with the hub already locked?  Or with the child device locked
> (in which case locking the hub would violate the normal locking order:  
> parent first, child second)?

Maybe introduce a new lock? The lock however will only be used by this specific hub.
But I still want the LPM can be enabled for this hub.

> 
>> +		}
>> +	} else
>> 		status = usb_clear_port_feature(hub->hdev,
>> 				port1, USB_PORT_FEAT_SUSPEND);
>> 	if (status) {
>> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
>> index 6b6413073584..69474d0d2b38 100644
>> --- a/drivers/usb/core/quirks.c
>> +++ b/drivers/usb/core/quirks.c
>> @@ -131,6 +131,9 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
>> 			case 'o':
>> 				flags |= USB_QUIRK_HUB_SLOW_RESET;
>> 				break;
>> +			case 'p':
>> +				flags |= USB_QUIRK_DISABLE_LPM_ON_U0;
>> +				break;
> 
> The new 'p' flag needs to be documented.

Yes I missed that, will add in v2.

Kai-Heng

> 
> Alan Stern

