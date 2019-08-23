Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F498C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F2C233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbfHWCEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:04:34 -0400
Received: from vps.redhazel.co.uk ([68.66.241.172]:52128 "EHLO
        vps.redhazel.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733086AbfHWCEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:04:34 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Aug 2019 22:04:33 EDT
Received: from [192.168.1.66] (unknown [212.159.68.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vps.redhazel.co.uk (Postfix) with ESMTPSA id 9D73D1C021B5;
        Fri, 23 Aug 2019 02:54:55 +0100 (BST)
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
To:     Daniel Drake <drake@endlessm.com>, aros@gmx.com
Cc:     linux-kernel@vger.kernel.org, linux@endlessm.com,
        hadess@hadess.net, hannes@cmpxchg.org
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
 <20190820064620.5119-1-drake@endlessm.com>
From:   ndrw <ndrw.xf@redhazel.co.uk>
Message-ID: <4d998874-d02b-395f-1b81-7034db1a8fcd@redhazel.co.uk>
Date:   Fri, 23 Aug 2019 02:54:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820064620.5119-1-drake@endlessm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2019 07:46, Daniel Drake wrote:
> To share our results so far, despite this daemon being a quick initial
> implementation, we find that it is bringing excellent results, no more memory
> pressure hangs. The system recovers in less than 30 seconds, usually in more
> like 10-15 seconds.

That's obviously a lot better than hard freezes but I wouldn't call such 
system lock-ups an excellent result. PSI-triggered OOM killer would have 
indeed been very useful as an emergency brake, and IMHO such mechanism 
should be built in the kernel and enabled by default. But in my 
experience it does a very poor job at detecting imminent freezes on 
systems without swap or with very fast swap (zram). So far, watching 
MemAvailable (like earlyoom does) is far more reliable and accurate. 
Unfortunately, there just doesn't seem to be a kernel feature that would 
reserve a user-defined amount of memory for caches.

> There's just one issue we've seen so far: a single report of psi reporting
> memory pressure on a desktop system with 4GB RAM which is only running
> the normal desktop components plus a single gmail tab in the web browser.
> psi occasionally reports high memory pressure, so then psi-monitor steps in and
> kills the browser tab, which seems erroneous.

Is it Chrome/Chromium? If so, that's a known bug 
(https://bugs.chromium.org/p/chromium/issues/detail?id=333617)

Best regards,

ndrw


