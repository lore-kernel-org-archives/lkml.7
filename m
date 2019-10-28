Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D818CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9188208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbfJ1JwY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:52:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56312 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbfJ1JwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:52:23 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iP1hF-0001zd-Ls
        for linux-kernel@vger.kernel.org; Mon, 28 Oct 2019 09:52:21 +0000
Received: by mail-pl1-f198.google.com with SMTP id w20so3400041plq.21
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 02:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ucd8G3ncCjjGAR+QruBIbeyIMVOY8PJbSpfeucAn18s=;
        b=HT06eE315AGr0fPsTQvWby9k9N4OeJTlX73xioqa+WT1HOymau8rv8W2ba2F7DooCe
         MSHCsFBpDbbe+rViirK5QA1IjmlDBIN1PuYd5rEv4FfTuZ7hXtix7ejHGAo+5n9Cf8JN
         2Dr5IIuHy9KUgzvG4QdDf87iSztX1lljy4ZqVvacNOWGgAw7feQOd5NGw9ACTkDqSJCa
         Q3o7jCvcot8Vg0sjIN8b2rnHiN58kKitqK/kTzc8rSH2bE3byRLs+cHhn/NjS41HpsNy
         26ShIiVIXHtIbwq+NPxhgn7gbVko3vnh4/51cdZKkCqROGMhHw+rZGZ8wnosT5wwttYk
         dTpg==
X-Gm-Message-State: APjAAAX6C6Ab0M86YN9Os73gQ5lYjfbONzX4yNewYa7Pi4W8IOmoIJnZ
        6WROiLIf/H1KxKtR3xgFsRE6uvFDWdxoISPKKPHfE3B98nYwMaisuHufFl6MVCsBgDYJvhVd3CP
        zG5lnP8KRF2EtA3PDb1YhBiBfagecpQz4/4Dpr1803A==
X-Received: by 2002:a63:165b:: with SMTP id 27mr19770765pgw.420.1572256340310;
        Mon, 28 Oct 2019 02:52:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyuaevUyIwsBsO17w+abwittBHPXUZ7Jv2gyLyiWwnNViaUN5dJY0+6QbfKjXTeFouFVnZ9Kw==
X-Received: by 2002:a63:165b:: with SMTP id 27mr19770721pgw.420.1572256339916;
        Mon, 28 Oct 2019 02:52:19 -0700 (PDT)
Received: from 2001-b011-380f-3c42-74a9-e8b4-eac5-9609.dynamic-ip6.hinet.net (2001-b011-380f-3c42-74a9-e8b4-eac5-9609.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:74a9:e8b4:eac5:9609])
        by smtp.gmail.com with ESMTPSA id x25sm6334088pfq.73.2019.10.28.02.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 02:52:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601\))
Subject: Re: [PATCH 1/2] r8152: Pass driver_info to REALTEK_USB_DEVICE() macro
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <0835B3720019904CB8F7AA43166CEEB2F18EF1C4@RTITMBSVM03.realtek.com.tw>
Date:   Mon, 28 Oct 2019 17:52:16 +0800
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "oliver@neukum.org" <oliver@neukum.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C307CD73-9CDE-4B70-9928-E8B0303CCDB5@canonical.com>
References: <20191025105919.689-1-kai.heng.feng@canonical.com>
 <0835B3720019904CB8F7AA43166CEEB2F18EF1C4@RTITMBSVM03.realtek.com.tw>
To:     Hayes Wang <hayeswang@realtek.com>
X-Mailer: Apple Mail (2.3601)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 28, 2019, at 17:41, Hayes Wang <hayeswang@realtek.com> wrote:
> 
> Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
>> Sent: Friday, October 25, 2019 6:59 PM
> [...]
>> -#define REALTEK_USB_DEVICE(vend, prod)	\
>> +#define REALTEK_USB_DEVICE(vend, prod, info)	\
>> 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE | \
>> 		       USB_DEVICE_ID_MATCH_INT_CLASS, \
>> 	.idVendor = (vend), \
>> 	.idProduct = (prod), \
>> -	.bInterfaceClass = USB_CLASS_VENDOR_SPEC \
>> +	.bInterfaceClass = USB_CLASS_VENDOR_SPEC, \
>> +	.driver_info = (info) \
>> }, \
>> { \
>> 	.match_flags = USB_DEVICE_ID_MATCH_INT_INFO | \
>> @@ -6739,25 +6740,26 @@ static void rtl8152_disconnect(struct
>> usb_interface *intf)
>> 	.idProduct = (prod), \
>> 	.bInterfaceClass = USB_CLASS_COMM, \
>> 	.bInterfaceSubClass = USB_CDC_SUBCLASS_ETHERNET, \
>> -	.bInterfaceProtocol = USB_CDC_PROTO_NONE
>> +	.bInterfaceProtocol = USB_CDC_PROTO_NONE, \
>> +	.driver_info = (info) \
> 
> This part is for ECM mode. Add driver_info here is useless,
> because it is never be used. The driver always changes
> the ECM mode to vendor mode.

Thanks for the explanation.
Since we are going to compare IDs directly in probe(), I'll just drop this patch.

Kai-Heng

> 
> Best Regards,
> Hayes
> 
> 

