Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DEFC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0DB2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfDLG6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:58:18 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42420 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfDLG6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:58:18 -0400
Received: by mail-wr1-f45.google.com with SMTP id g3so10438985wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 23:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lbP1KVcl3zMO4rpwUxV8R4hbYaY9Zu6yn4TXp52qwX4=;
        b=h6ol4mq5UiqKkEHCp3H52EeasKUjcbH/SL2nuo5JblbnxtD2C2KQgal76zMwXxgquL
         JGE8EVQCB3t2AoF2aPuOTVAyDRQN1isbcTXZpujaxvxfQMYu2JsaNq8CfbKa4yGK8QEG
         rbHoRryKdA8wY98sCXO5XvFm/7vHtfcRYreMu6RQThDrQeyICpU36McmlQzkEbUObQYi
         ruTif6xDVf21TI5GF1iGlWlTxJMChg3XdUsFlDs67L2Nk3aVgAWhIK/qdZX1L3hGcC3O
         x3ZIakNGZo6HHdjg1LEdxIJUzjSryfsrwZDx2Fzb9RxnKbcXaQ66GpxjJVP31tB6GnHa
         Qq/g==
X-Gm-Message-State: APjAAAUw2/dcv1RJmYdcYim0XdTB5rE9ZhACIbFHBolOPwFOSb1xhfM5
        TzOFUnOWsg3/X/hyvdQr+Vc8sg==
X-Google-Smtp-Source: APXvYqxkYmsvyFzoX6xsL4SLQMf6iCeiDE0Hs6yL7+F4sD0doPHEvepjfCFZWUhjkEJYB8+E2g7Apg==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr36654089wru.36.1555052296554;
        Thu, 11 Apr 2019 23:58:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-213-220-248-130.net.upcbroadband.cz. [213.220.248.130])
        by smtp.gmail.com with ESMTPSA id i28sm113343371wrc.32.2019.04.11.23.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 23:58:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "m.maya.nakamura" <m.maya.nakamura@gmail.com>
Cc:     "x86\@kernel.org" <x86@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal\@kernel.org" <sashal@kernel.org>
Subject: RE: [PATCH 4/6] x86: hv: mmu.c: Replace page definitions with Hyper-V specific ones
In-Reply-To: <DM5PR2101MB091843B6DD7A11C2C27917F1D7280@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com> <3bc5d60092473815fbd90422875233fb6075285b.1554426040.git.m.maya.nakamura@gmail.com> <87zhp4iu6h.fsf@vitty.brq.redhat.com> <DM5PR2101MB091843B6DD7A11C2C27917F1D7280@DM5PR2101MB0918.namprd21.prod.outlook.com>
Date:   Fri, 12 Apr 2019 08:58:15 +0200
Message-ID: <87v9zjg16g.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Friday, April 5, 2019 4:11 AM
>> >
>> > @@ -32,15 +32,15 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
>> >  	do {
>> >  		diff = end > cur ? end - cur : 0;
>> >
>> > -		gva_list[gva_n] = cur & PAGE_MASK;
>> > +		gva_list[gva_n] = cur & HV_HYP_PAGE_MASK;
>> 
>> I'm not sure this is correct: here we're expressing guest virtual
>> addresses in need of flushing, this should be unrelated to the
>> hypervisor page size.
>> 
>
> I talked to the Hyper-V guys about this.  They have not implemented
> the HvFlushVirtualAddressList hypercalls for ARM64 yet.  But when they
> do, they expect the GVA list will need to be in terms of the Hyper-V
> page size.  They don't want to have to figure out the guest page size
> and adjust their arithmetic on a per-guest basis.

Understood, thanks! However, what I wanted to say is that this code is
x86-specific (arch/x86/hyperv/mmu.c) and the implementation is
hard-wired to the spec, namely we use lower 12 bits (there's even a
comment in the code about this which the patch doesn't change) to encode
the number of pages to flush. We can speculate that when these
hypercalls are implemented on ARM they'll have similar requirements but
I'd suggest we leave it as-is for now and fix this when (and, actually,
if) we decide to move this to arch-independent part. We may need to do
additional adjustments - and we don't know about them yet because
there's no spec published.

-- 
Vitaly
