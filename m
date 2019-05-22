Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9D1C18E7C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23CE20862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfEVDAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 23:00:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36062 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfEVDAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 23:00:48 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hTHUj-00018Z-Kx
        for linux-kernel@vger.kernel.org; Wed, 22 May 2019 03:00:45 +0000
Received: by mail-pl1-f200.google.com with SMTP id g7so487033pll.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 20:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=id/NZhcx+jIJshw7p/dmLaypejR+eS3hPRHrnEVTIbc=;
        b=MHCigxu1deDmyyZ9B9beZNg0aTmxdIgGjS9QeqEGcjvzmv8tcZ1jZg1o79fU78BPhG
         oWQuIw9zUNWOUbfm0SYjeZN8qqu9xKK6fScVk1BJ9gv83i0CisoVTog4NqV3zO9ZcbLe
         GWTWtT4FH7/8GqCSYFqcIoZEiG2X3mN6HCy/lsUd1VMx1ORLvFqnsCoHqrNiFV3luHDY
         dOajtcnOQAq/XgvHdbO0uwYkT7LWV3zPtdrEJXH7HNL8y8YZe7vR2LMEcq1KaW3eq09U
         5yJ61HRvIvVRHCfUjsgtb1bkXJjJyH/AYIp7EmCSqaLA+O7CP8rVIOE3+2xqe+Pcb4Bb
         WW4Q==
X-Gm-Message-State: APjAAAX6B8RF0hLunaAc5A1zk7ncgHBujAxrn2MV8nOVGqSoC8RQeePl
        WC9F6Kzr3W4LUfk5Jhuj4/6PWDSncOHYiu/g69RqyGXG01SpfkKd1rvyZg6W8b8muKTKKC11KRw
        TunRMoLlWnatI+YCebakiQNzS9Wmzrei/Y0lkAkOs+Q==
X-Received: by 2002:a17:902:b695:: with SMTP id c21mr87789111pls.160.1558494044335;
        Tue, 21 May 2019 20:00:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMIF+8AjS8WcNWyHLwDTypoQOT69dFpWJ9C/6oOBCiBWjFM7EM7pha5xwuLpf27fALbjsX6w==
X-Received: by 2002:a17:902:b695:: with SMTP id c21mr87789070pls.160.1558494043989;
        Tue, 21 May 2019 20:00:43 -0700 (PDT)
Received: from [10.101.46.168] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id 14sm26507074pfx.13.2019.05.21.20.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 20:00:43 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Disable LE Advertising in
 hci_suspend_dev()
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190430092544.13653-1-kai.heng.feng@canonical.com>
Date:   Wed, 22 May 2019 11:00:41 +0800
Cc:     Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <329E5979-6716-4776-9B1A-1859998D19D0@canonical.com>
References: <20190430092544.13653-1-kai.heng.feng@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

at 5:25 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> LE Advertising may wake up system during system-wide sleep, disable it
> to prevent this issue from happening.
>
> Do the reverse in hci_resume_dev().

Do you have any suggestion for this patch?

Kai-Heng

>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Abstract away enabling/disabling LE advertising from btusb.
>
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 47 ++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h  
> b/include/net/bluetooth/hci_core.h
> index 094e61e07030..65574943131d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -269,6 +269,7 @@ struct hci_dev {
>  	__u16		le_max_rx_time;
>  	__u8		le_max_key_size;
>  	__u8		le_min_key_size;
> +	__u8		le_events[8];
>  	__u16		discov_interleaved_timeout;
>  	__u16		conn_info_min_age;
>  	__u16		conn_info_max_age;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d6b2540ba7f8..7c19e3b9294c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -412,6 +412,49 @@ static void hci_setup_event_mask(struct hci_request  
> *req)
>  	hci_req_add(req, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
>  }
>
> +static int hci_enable_le_advertising_req(struct hci_request *req,  
> unsigned long opt)
> +{
> +	struct hci_dev *hdev = req->hdev;
> +	u8 events[8];
> +	memcpy(events, hdev->le_events, sizeof(events));
> +
> +	hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
> +			events);
> +
> +	return 0;
> +}
> +
> +static int hci_disable_le_advertising_req(struct hci_request *req,  
> unsigned long opt)
> +{
> +	struct hci_dev *hdev = req->hdev;
> +
> +	u8 events[8];
> +	memcpy(events, hdev->le_events, sizeof(events));
> +
> +	events[0] &= ~(u8)0x02;	/* LE Advertising Report */
> +
> +	hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
> +			events);
> +
> +	return 0;
> +}
> +
> +static int hci_enable_le_advertising(struct hci_dev *hdev)
> +{
> +	if (!lmp_le_capable(hdev))
> +		return 0;
> +
> +	return __hci_req_sync(hdev, hci_enable_le_advertising_req, 0,  
> HCI_CMD_TIMEOUT, NULL);
> +}
> +
> +static int hci_disable_le_advertising(struct hci_dev *hdev)
> +{
> +	if (!lmp_le_capable(hdev))
> +		return 0;
> +
> +	return __hci_req_sync(hdev, hci_disable_le_advertising_req, 0,  
> HCI_CMD_TIMEOUT, NULL);
> +}
> +
>  static int hci_init2_req(struct hci_request *req, unsigned long opt)
>  {
>  	struct hci_dev *hdev = req->hdev;
> @@ -772,6 +815,8 @@ static int hci_init3_req(struct hci_request *req,  
> unsigned long opt)
>  		}
>
>  		hci_set_le_support(req);
> +
> +		memcpy(hdev->le_events, events, sizeof(events));
>  	}
>
>  	/* Read features beyond page 1 if available */
> @@ -3431,6 +3476,7 @@ EXPORT_SYMBOL(hci_unregister_dev);
>  /* Suspend HCI device */
>  int hci_suspend_dev(struct hci_dev *hdev)
>  {
> +	hci_disable_le_advertising(hdev);
>  	hci_sock_dev_event(hdev, HCI_DEV_SUSPEND);
>  	return 0;
>  }
> @@ -3440,6 +3486,7 @@ EXPORT_SYMBOL(hci_suspend_dev);
>  int hci_resume_dev(struct hci_dev *hdev)
>  {
>  	hci_sock_dev_event(hdev, HCI_DEV_RESUME);
> +	hci_enable_le_advertising(hdev);
>  	return 0;
>  }
>  EXPORT_SYMBOL(hci_resume_dev);
> -- 
> 2.17.1


