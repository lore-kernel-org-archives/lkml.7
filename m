Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F7FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ACB20868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfEVTFK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:05:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58919 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbfEVTFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:05:08 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hTWXz-0001vu-DG
        for linux-kernel@vger.kernel.org; Wed, 22 May 2019 19:05:07 +0000
Received: by mail-pl1-f200.google.com with SMTP id b69so1895412plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=czfXF4X+WzadjYZP7hUsAFz3lA9BYtuDgy22wPY8BdM=;
        b=JrvyWfcSe9m1dXc/PJCv5LgofgRO4+cyCRRR2b0AmD+W1Q46HKn+4i2RkWzi+e5qS1
         c616zGlJyh2Khu1z2AtzKfNzplA/ihexpuKHmbLVnsGOvY/sBTqt5IA8LfN921qlMtID
         aq6BF1LQ/XUM8SUNThsyj+4XkYjGSJ3KvfMBlHX5Gr9IRGtjLm4NqDbCq60G/8ntSWtT
         lvzuUNwTN6hjBiVB1pReQmrSsx7b0y5/sAnuJL1MGdVsC+67VTKYBfm0ywmGqfV9ZU8h
         bQAGk4oSTkGPY91IwyeF8CMSNpg08Azw7B6KH3o09iWZUcdFHozMyyCjhQz4N0vMZdQ5
         qRIQ==
X-Gm-Message-State: APjAAAWQxh8+AnRMLEHkuWoK3FmZWD7c002g9/7H+VGzdKTbcY7/WOQ7
        dkkHNStHtAp4FHq4NRznBCzaPJjVFdOK2dHOs4pzlXhMtlTkf8b4s9gRCvVuVLpy4+vi2PCmU9U
        zQB4GLeMlHFCuA4ZjyDYFu6XTm0FF8gqFJlGX1PUmqg==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr21885951plv.298.1558551906123;
        Wed, 22 May 2019 12:05:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwICiuaHiG2EomDuE5aveWHHAOjp0PRky8IYbMLukmRtN+STI+JHnlJPa1KkQOBxiMrcxBL6Q==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr21885926plv.298.1558551905870;
        Wed, 22 May 2019 12:05:05 -0700 (PDT)
Received: from [192.168.1.220] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id i27sm53077607pfk.162.2019.05.22.12.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:05:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] PCI / PM: Don't runtime suspend when device only supports
 wakeup from D0
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190522185339.pfo5xeopyz2i5iem@wunner.de>
Date:   Thu, 23 May 2019 03:05:08 +0800
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <850CC1CD-2043-4C32-8BB1-5F5BAC1DDF55@canonical.com>
References: <20190522181157.GC79339@google.com>
 <Pine.LNX.4.44L0.1905221433310.1410-100000@iolanthe.rowland.org>
 <20190522185339.pfo5xeopyz2i5iem@wunner.de>
To:     Lukas Wunner <lukas@wunner.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 23, 2019, at 2:53 AM, Lukas Wunner <lukas@wunner.de> wrote:
> 
> On Wed, May 22, 2019 at 02:39:56PM -0400, Alan Stern wrote:
>> According to Kai, PME signalling doesn't work in D0 -- or at least, it
>> is _documented_ not to work in D0 -- even though it is enabled and the
>> device claims to support it.
>> 
>> In any case, I don't really see any point in "runtime suspending" a 
>> device while leaving it in D0.  We might as well just leave it alone.
> 
> There may be devices whose drivers are able to reduce power consumption
> through some device-specific means when runtime suspending, even though
> the device remains in PCI_D0.  The patch would cause a power regression
> for those.
> 
> In particular, pci_target_state() returns PCI_D0 if the device lacks the
> PM capability.

So an explicit device_can_wakeup() check before calling pci_target_state()
is needed to avoid the case you described.

I’ll add this in patch v2.

Kai-Heng

> 
> Thanks,
> 
> Lukas

