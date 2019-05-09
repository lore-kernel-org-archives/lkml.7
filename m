Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BD5C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15FC2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEIGtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 02:49:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35217 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfEIGtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 02:49:07 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hOcrZ-0003dq-4u
        for linux-kernel@vger.kernel.org; Thu, 09 May 2019 06:49:05 +0000
Received: by mail-pg1-f200.google.com with SMTP id z12so1024784pgs.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 23:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=32kiJIP116e2mLUfbaNVIRXAUg5m0z/rzvErm/or1eE=;
        b=WPIYS+nEyUwdD8e0S5fkNUi2H3hTaIV2xE0s+h0vcDpuIkIlI7FL4Z/ayNmYXydvUB
         RRU1lq15X7VAgDFyV3SV/VOi5b+wTIin/K3L2u/VYblVq2fRqk86DDU43AfthcRdE6Nt
         LjX6CiH6f66B3j6loWvoZYcIWfAtnmOwbtnSflnL8QDlxNe0WWz1Wvxieqrgcq0E7fe0
         bnNkJGtsw7xIRacbB3GByaTB+tmSFaZZUG7Pm++TY7XrAAwjDTKGFxfwJDAV8AZMqibF
         vNIY+IC/PHy3+MbB7Qium5g2Lbqap5OR0ruGd32PhOmMHIk9mI3RAmB9mkkmwsiXOk1L
         EKTw==
X-Gm-Message-State: APjAAAUomCqKZH4HFJ6PbPRPzyDcAquFGKA8w71Nw51eBMOX2XhCZgEq
        2jGZnqepIP/WIafOJOAb2ZtvHuG5gUr08uFa1XOQlJxBgQ/MQXTf+d5VI9kpMgMABPl5nYUUjq0
        EozqLgRVVkzoXOD6slX15CuGcOYBhLByjx9ju7BG9qw==
X-Received: by 2002:a17:902:2927:: with SMTP id g36mr2893657plb.6.1557384543703;
        Wed, 08 May 2019 23:49:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxJPM/iiIg9NOJAfxK2pfbyNTkSEm2UBAYNaAFq1fQROUzkh4woLlPJ4IuDqPN3TMlHwJyvEA==
X-Received: by 2002:a17:902:2927:: with SMTP id g36mr2893630plb.6.1557384543367;
        Wed, 08 May 2019 23:49:03 -0700 (PDT)
Received: from 2001-b011-380f-14b9-f0ba-4a15-3e79-97f9.dynamic-ip6.hinet.net (2001-b011-380f-14b9-f0ba-4a15-3e79-97f9.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:f0ba:4a15:3e79:97f9])
        by smtp.gmail.com with ESMTPSA id i12sm1460088pgb.61.2019.05.08.23.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 23:49:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190509061237.GA15229@lst.de>
Date:   Thu, 9 May 2019 14:48:59 +0800
Cc:     Mario.Limonciello@dell.com, Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain>
 <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de>
 <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de>
To:     Christoph Hellwig <hch@lst.de>, rafael.j.wysocki@intel.com
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Rafael and linux-pm

at 14:12, Christoph Hellwig <hch@lst.de> wrote:

> On Wed, May 08, 2019 at 08:28:30PM +0000, Mario.Limonciello@dell.com wrote:
>> You might think this would be adding runtime_suspend/runtime_resume
>> callbacks, but those also get called actually at runtime which is not
>> the goal here.  At runtime, these types of disks should rely on APST which
>> should calculate the appropriate latencies around the different power  
>> states.
>>
>> This code path is only applicable in the suspend to idle state, which  
>> /does/
>> call suspend/resume functions associated with dev_pm_ops.  There isn't
>> a dedicated function in there for use only in suspend to idle, which is
>> why pm_suspend_via_s2idle() needs to get called.
>
> The problem is that it also gets called for others paths:
>
> #ifdef CONFIG_PM_SLEEP
> #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>         .suspend = suspend_fn, \
> 	.resume = resume_fn, \
> 	.freeze = suspend_fn, \
> 	.thaw = resume_fn, \
> 	.poweroff = suspend_fn, \
> 	.restore = resume_fn,
> #else
> else
> #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> #endif
>
> #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> const struct dev_pm_ops name = { \
> 	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> }
>
> And at least for poweroff this new code seems completely wrong, even
> for freeze it looks rather borderline.

Not really, for hibernation pm_suspend_via_s2idle() evaluates to false so  
the old code path will be taken.

>
> And more to the points - if these "modern MS standby" systems are
> becoming common, which it looks they are, we need support in the PM core
> for those instead of working around the decisions in low-level drivers.

Rafael, what do you think about this?
Including this patch, there are five drivers that use  
pm_suspend_via_{firmware,s2idle}() to differentiate between S2I and S3.
So I think maybe it’s time to introduce a new suspend callback for S2I?

>
>> SIMPLE_DEV_PM_OPS normally sets the same function for suspend and
>> freeze (hibernate), so to avoid any changes to the hibernate case it seems
>> to me that there needs to be a new nvme_freeze() that calls into the  
>> existing
>> nvme_dev_disable for the freeze pm op and nvme_thaw() that calls into the
>> existing nvme_reset_ctrl for the thaw pm op.
>
> At least, yes.

Hibernation should remain the same as stated above.

>
>>> enterprise class NVMe devices
>>> that don't do APST and don't really do different power states at
>>> all in many cases.
>>
>> Enterprise class NVMe devices that don't do APST - do they typically
>> have a non-zero value for ndev->ctrl.npss?
>>
>> If not, they wouldn't enter this new codepath even if the server entered  
>> into S2I.
>
> No, devices that do set NPSS will have at least some power states
> per definition, although they might not be too useful.  I suspect checking
> APSTA might be safer, but if we don't want to rely on APST we should
> check for a power state supporting the condition that the MS document
> quoted in the original document supports.

If Modern Standby or Connected Standby is not supported by servers, I don’t  
think the design documents mean much here.
We probably should check if the platform firmware really supports S2I  
instead.

Kai-Heng

