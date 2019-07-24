Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC13C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1EC2238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfGXPrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:47:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37780 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfGXPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:47:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id i70so10691507pgd.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 08:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vy+7PP8pTGQ+X9auiWqQ+l1tfzBTRZcEHjGxTn8iQ5M=;
        b=t3UK8y50C6nkx8jbivtKeYjUpIyQSPlULPwQMumjwYNtzJhkXHpMSxMvIERrmdg3eB
         uvfUxCB/Lovy0qkG2wvSYrZm6P7x3DsoJy2ME0rfNOuman4r+056cDyoV7cGmfcOzk5X
         nbbmgKwe3bC+EBDLZcJ0ur9OCB7iUiX1RI35B8PCmLrP1OhXfeFqdHzlAKdlQ+nRRwH6
         Qqhr3eWuDFoHBmdBSVF7fWotXuYDLnPFkLP47UV8KR+pBWOxrryph1dRLnUojLQN44Rs
         ums5qikqJg8Htlduh8Z3KLcVb88c2ldLHYwSuSdZKF1qap0laYhtUzPmhQRKdQwrClLH
         IrpQ==
X-Gm-Message-State: APjAAAWqq+IAMcnoq4iXTvVUR6KTdl0s+7gQhoYxfbmiaZzUwX9tW7eU
        f8g3oQUWCnaRMjQ8DJqvNcI=
X-Google-Smtp-Source: APXvYqwM7yJkDlRA6fOFXNax17rTw0VruON9zuB3CNfJ43SO8bUzE0XM59us9YeC1R/CsSNDKnT09w==
X-Received: by 2002:a62:e308:: with SMTP id g8mr12570717pfh.162.1563983223060;
        Wed, 24 Jul 2019 08:47:03 -0700 (PDT)
Received: from asus.site ([2601:647:4000:52d2:bbe8:c2d7:f336:57bc])
        by smtp.gmail.com with ESMTPSA id o14sm97085674pfh.153.2019.07.24.08.47.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 08:47:02 -0700 (PDT)
Subject: Re: [PATCH 3/4] locking/lockdep: Reduce space occupied by stack
 traces
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Yuyang Du <duyuyang@gmail.com>,
        Waiman Long <longman@redhat.com>
References: <20190722182443.216015-1-bvanassche@acm.org>
 <20190722182443.216015-4-bvanassche@acm.org>
 <20190724045610.GC643@sol.localdomain>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ee1cd751-cc8a-ca03-e30c-34b4cf8a13bf@acm.org>
Date:   Wed, 24 Jul 2019 08:47:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724045610.GC643@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/19 9:56 PM, Eric Biggers wrote:
> Does this also fix any of the other bugs listed at
> https://lore.kernel.org/lkml/20190710055838.GC2152@sol.localdomain/
> ?
> 
> BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> BUG: MAX_LOCKDEP_CHAINS too low!
> BUG: MAX_LOCK_DEPTH too low! (2)
> BUG: MAX_LOCKDEP_ENTRIES too low!

Hi Eric,

I don't think so. This patch only affects the space occupied by stack 
traces and not the space occupied by any of the other lockdep data 
strutures. BTW, in that report I found the following:

Title:              BUG: MAX_LOCKDEP_CHAINS too low!
Last occurred:      5 days ago
Reported:           284 days ago

Title:              BUG: MAX_LOCK_DEPTH too low! (2)
Last occurred:      362 days ago
Reported:           392 days ago

Since these bugs were reported more than 150 days ago these bugs are 
older than my lockdep changes and hence not a regression due to my 
lockdep changes.

My patch series did not increase the number of "list_entries" tracked by 
lockdep so I don't think that the "BUG: MAX_LOCKDEP_ENTRIES too low" 
behavior can be triggered more easily due to my lockdep changes.

The "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!" complaint however may be 
related. I will check whether it is possible to reduce the space 
occupied by held lock chains again to what was needed before my patch 
series.

Bart.
