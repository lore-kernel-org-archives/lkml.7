Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172A7C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E383F216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfEJPSc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:18:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46037 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfEJPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:18:31 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hP7Gy-0006xC-Ak
        for linux-kernel@vger.kernel.org; Fri, 10 May 2019 15:17:20 +0000
Received: by mail-pg1-f197.google.com with SMTP id e14so4241508pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 08:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9ksYfkmpkpH6va/jl6WUWe9ADNC1rlHcm4W2AWAcxsI=;
        b=LSbUL39zqR45oXTqAnhlJs6NZXh7kMtkshRSedv1A1xUK+iXF2vaZfPcSerI9n//xE
         gY2CymAppnm72FZXmBpaHIEdTSgJHzQvdBDZ6R/bo4BqcMUv2z/fL37wgbK9VjON3nOK
         T8Vo0/XbTfRuClKN/OdrYD6/THorQZaIF8XQFAmUVRQvU8F+UAH+1Lo+UOTqZU8yOCpF
         AyNo5AFq2EK/rJWz7juGo0zSiSF+1crY16bNYhKz8UO2hdqkaaRFzDGtRu6gg2pgnHK0
         vpvYkK7SiX7xbv8cz4p/Mk/TqHcf+KgwHdtIK+EyS3Amwoqir7avS8j24Xfvjg5FDTLT
         tDKQ==
X-Gm-Message-State: APjAAAXhpGD3Syq4cEY2fJz2F5nkiSv8r2NZpEro+cEHzdXlHGV1wZf5
        MITrjJ86tTiJoJFBm+9udvAufbQqJV7Au2brgnpOANbZ0vEJefnIsgmmtFzfTW9RaPegcl5yBEt
        hTk/cR8r2O6Ej7vSc2W4BoN67zOOVRH4BgRMDVc5D+Q==
X-Received: by 2002:a63:d408:: with SMTP id a8mr14221500pgh.184.1557501438679;
        Fri, 10 May 2019 08:17:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyh/Bshj4Iu4LZ0+PAJP0YH+FOpi9SNU4iCGkiuMtOOEWfwyyXrJlCA2wUcsW2TXEFDfy/FnA==
X-Received: by 2002:a63:d408:: with SMTP id a8mr14221469pgh.184.1557501438481;
        Fri, 10 May 2019 08:17:18 -0700 (PDT)
Received: from [192.168.1.220] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id s79sm11301512pfa.31.2019.05.10.08.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 08:17:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190510140209.GG9675@localhost.localdomain>
Date:   Fri, 10 May 2019 23:18:52 +0800
Cc:     "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Busch, Keith" <keith.busch@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D2D197AF-0072-42AC-A844-8D6BC9677949@canonical.com>
References: <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
 <20190509215409.GD9675@localhost.localdomain>
 <495d76c66aec41a8bfbbf527820f8eb9@AUSX13MPC101.AMER.DELL.COM>
 <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
 <20190510140209.GG9675@localhost.localdomain>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 10, 2019, at 10:02 PM, Keith Busch <kbusch@kernel.org> wrote:
> 
> On Thu, May 09, 2019 at 11:05:42PM -0700, Kai-Heng Feng wrote:
>> Yes, that’ what I was told by the NVMe vendor, so all I know is to impose a  
>> memory barrier.
>> If mb() shouldn’t be used here, what’s the correct variant to use in this  
>> context?
> 
> I'm afraid the requirement is still not clear to me. AFAIK, all our
> barriers routines ensure data is visible either between CPUs, or between
> CPU and devices. The CPU never accesses HMB memory, so there must be some
> other reasoning if this barrier is a real requirement for this device.

Sure, I’ll ask vendor what that MemRd is for.

Kai-Heng
