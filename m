Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B110C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B962053B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfEIK2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 06:28:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39448 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfEIK2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 06:28:40 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hOgI2-0000ag-2E
        for linux-kernel@vger.kernel.org; Thu, 09 May 2019 10:28:38 +0000
Received: by mail-pl1-f198.google.com with SMTP id g89so1314988plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 03:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iqO4jAPKI5EtPAMUNTTqbiH8EXREdlEaOkeV8WUNd4o=;
        b=MVbftPuM+eHZqB0F36C+SywXSHc1RiVZ95FBsDPOXFCUzNxWCb98ILRu/fRVsYdI1K
         d5kbqf6B02GFguty+RBnXqhhEJl/ErkzMXk3TFIyyjJeZr3zTVPUqC2wzvbVZYw4gwNJ
         1rIgz5cDjLjq6I4uCuoahDoEJ3bUj642A7K4s6yhe5fe9loa1lFMnw0r3OUailiVVw+V
         NsnlLAFA3lWF+1MXXhDqCGTnMrIxgLFCHgHwOYraGFBy6aemW62HoVKyjB1UXr9AjTOu
         6JXHhl2LChAAadU+L4RB8Ntf6zw7Ufp7CmqaUvp7diBDSJoKoPSRguVKYg8gkZ5r17eT
         WqoA==
X-Gm-Message-State: APjAAAV9XnaXnQ7Pvp++McvanJ8vNemdFJyEhkDjFvrIfSM0IBqFOrTo
        s9FgqINMdFrnsUR2pbtRw1gJYs8mfsz+NAZSZfIssrcYC921EQfzoNd2ybY/PPKWHwGxK+Y4tqe
        eKdxWa88eps5JtVic3cy9ugrDB2i4LHUl6mvW+TM/Qg==
X-Received: by 2002:a17:902:9002:: with SMTP id a2mr3830409plp.43.1557397716748;
        Thu, 09 May 2019 03:28:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyirYEaLJu/laJ4c1rSpRcvUuVa2X9DdCx+9zraOT/K7aD24GwK2dDRqBBw+jE7Tbbvs7nkUw==
X-Received: by 2002:a17:902:9002:: with SMTP id a2mr3830334plp.43.1557397716088;
        Thu, 09 May 2019 03:28:36 -0700 (PDT)
Received: from 2001-b011-380f-14b9-f0ba-4a15-3e79-97f9.dynamic-ip6.hinet.net (2001-b011-380f-14b9-f0ba-4a15-3e79-97f9.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:f0ba:4a15:3e79:97f9])
        by smtp.gmail.com with ESMTPSA id b144sm2638855pfb.68.2019.05.09.03.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 03:28:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190509095601.GA19041@lst.de>
Date:   Thu, 9 May 2019 18:28:32 +0800
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
Message-Id: <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain>
 <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de>
 <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de>
 <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 17:56, Christoph Hellwig <hch@lst.de> wrote:

> On Thu, May 09, 2019 at 05:42:30PM +0800, Kai-Heng Feng wrote:
>>> That would be a set of 6 new suspend and resume callbacks, mind you,
>>> and there's quite a few of them already.  And the majority of drivers
>>> would not need to use them anyway.
>>
>> I think suspend_to_idle() and resume_from_idle() should be enough?
>> What are other 4 callbacks?
>>
>>> Also, please note that, possibly apart from the device power state
>>> setting, the S2I and S2R handling really aren't that different at all.
>>> You basically need to carry out the same preparations during suspend
>>> and reverse them during resume in both cases.
>>
>> But for this case, it’s quite different to the original suspend and
>> resume callbacks.
>
> Let's think of what cases we needed.
>
> The "classic" suspend in the nvme driver basically shuts down the
> device entirely.  This is useful for:
>
>  a) device that have no power management
>  b) System power states that eventually power off the entire PCIe bus.
>     I think that would:
>
>      - suspend to disk (hibernate)
>      - classic suspend to ram
>
> The we have the sequence in your patch.  This seems to be related to
> some of the MS wording, but I'm not sure what for example tearing down
> the queues buys us.  Can you explain a bit more where those bits
> make a difference?

Based on my testing if queues (IRQ) are not disabled, NVMe controller won’t  
be quiesced.
Symptoms can be high power drain or system freeze.

I can check with vendors whether this also necessary under Windows.

>
> Otherwise I think we should use a "no-op" suspend, just leaving the
> power management to the device, or a simple setting the device to the
> deepest power state for everything else, where everything else is
> suspend, or suspend to idle.

I am not sure I get your idea. Does this “no-op” suspend happen in NVMe  
driver or PM core?

>
> And of course than we have windows modern standby actually mandating
> runtime D3 in some case, and vague handwaving mentions of this being
> forced on the platforms, which I'm not entirely sure how they fit
> into the above picture.

I was told that Windows doesn’t use runtime D3, APST is used exclusively.

Kai-Heng


