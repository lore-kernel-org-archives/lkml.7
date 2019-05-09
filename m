Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA49C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946332089E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEIMAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:00:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40972 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfEIMAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:00:02 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hOhiS-0006kS-NN
        for linux-kernel@vger.kernel.org; Thu, 09 May 2019 12:00:00 +0000
Received: by mail-pl1-f200.google.com with SMTP id d20so1428110pls.15
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 05:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E3TYfjvumInlqPDbN4Vbyl7YloQy+afwdCg60dhd7F0=;
        b=ALny7XyDmbEaBxTcAoNADRU1xMi4ytezZHzCjhTaEsbeBXHYfj+DGMzJa+xP62wiIY
         9Rr9zav22OfZrry5bnrXL9a43Vda0u4qV+kOgrP0vMP4SVczU+gBOmB70gR5W7I9AGNT
         Cv3FbxzW00IVPE3n4aQm69Q+lKaRJ3LyMOyoN5onYY6dNGfwPCst3zKt1GUblKcwNxt2
         UuJ7BLOLfpHZC86YgWYc0R+VpwYVZDqo0KpuYPEMmrEVYsjkXbd9LxQsdfrUUk/GPsob
         OmR7SDRrys0oYxd8+3+u4/0HpyzJOLz5gZkfOE9j5zsR6ZC5a2P21Hdpkcf7i8DW40bT
         ALQg==
X-Gm-Message-State: APjAAAX3zocn+1E4hTPaittAeJs2f7CADxOH6tJldNdi13yCerbNVdFe
        T+OcCpC+ADw0kYfB+2ZO3ykH1qmnXPNeNvl0l5aVf8qjg+8ovYV9FiQzlLjFStVvFyAj/Nc1hgg
        vX432PyhvpkPxRbrPhonBYp1DA64gmCSUhhzI8Mda9w==
X-Received: by 2002:a62:5103:: with SMTP id f3mr4624679pfb.146.1557403199488;
        Thu, 09 May 2019 04:59:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzB5E7z/u9EHWChcxhdicQVecXs0mOSIs+L3HYhGGVLiG0ziOSNWMEfQATir0Eew7MlZhwziQ==
X-Received: by 2002:a62:5103:: with SMTP id f3mr4624646pfb.146.1557403199255;
        Thu, 09 May 2019 04:59:59 -0700 (PDT)
Received: from 2001-b011-380f-14b9-f0ba-4a15-3e79-97f9.dynamic-ip6.hinet.net (2001-b011-380f-14b9-f0ba-4a15-3e79-97f9.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:f0ba:4a15:3e79:97f9])
        by smtp.gmail.com with ESMTPSA id 19sm2126839pfz.84.2019.05.09.04.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:59:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190509103142.GA19550@lst.de>
Date:   Thu, 9 May 2019 19:59:55 +0800
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
References: <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de>
 <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de>
 <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 18:31, Christoph Hellwig <hch@lst.de> wrote:

> On Thu, May 09, 2019 at 06:28:32PM +0800, Kai-Heng Feng wrote:
>> Based on my testing if queues (IRQ) are not disabled, NVMe controller
>> won’t be quiesced.
>> Symptoms can be high power drain or system freeze.
>>
>> I can check with vendors whether this also necessary under Windows.
>
> System freeze sounds odd.  And we had a patch from a person on the
> Cc list here that was handed to me through a few indirections that
> just skipps the suspend entirely for some cases, which seemd to
> work fine with the controllers in question.

That works fine for some devices, but for Toshiba NVMes this said scenario  
freezes the system, hence the new patch here.

And for all NVMes I tested this new suspend routine saves even more power  
than simply skipping suspend.

>
>>> Otherwise I think we should use a "no-op" suspend, just leaving the
>>> power management to the device, or a simple setting the device to the
>>> deepest power state for everything else, where everything else is
>>> suspend, or suspend to idle.
>>
>> I am not sure I get your idea. Does this “no-op” suspend happen in NVMe
>> driver or PM core?
>
> no-op means we don't want to do anything in nvme.  If that happens
> by not calling nvme or stubbing out the method for that particular
> case does not matter.

Ok, but we still need to figure out how to prevent the device device from  
tradition to D3.

>
>>> And of course than we have windows modern standby actually mandating
>>> runtime D3 in some case, and vague handwaving mentions of this being
>>> forced on the platforms, which I'm not entirely sure how they fit
>>> into the above picture.
>>
>> I was told that Windows doesn’t use runtime D3, APST is used exclusively.
>
> As far as I know the default power management modes in the Microsoft
> NVMe driver is explicit power management transitions, and in the Intel
> RST driver that is commonly used it is APST.  But both could still
> be comined with runtime D3 in theory, I'm just not sure if they are.
>
> Microsoft has been pushing for aggressive runtime D3 for a while, but
> I don't know if that includes NVMe devices.

Ok, I’ll check with vendors about this.

Kai-Heng

>
>> Kai-Heng
> ---end quoted text—


