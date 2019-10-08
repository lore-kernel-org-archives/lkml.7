Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2971CC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7B62070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfJHPM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:12:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfJHPM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:12:29 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A3BC796EB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2019 15:12:28 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n3so9291468wrt.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 08:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TVxQtqSMZ2FHlKInFtkoosjtqyBQr57VDotUlK3rfd8=;
        b=awPBI37PTPe/qiZsaefHnGCoHnrhD0uHg/+IAmu2gEVmL1d+o5301C5jaSpVovT5Lz
         kwnTkUZgffZSkyOaTpz8eYzRMZ3oYWrGaTTHrRdr8uj/c4OfSSrwiTZaNAvxrMMmcbGe
         eifzL5qzSRi9lCCbG5Er2i+iB7wrcbwq/n0rHD85TO1Ytl3ZwnUZlh4FjD+5C2sHMGL+
         vko7HELwDU06tAFVZ5SMt5ewMS4mq785bfKgdugHihARe1/tc0v8VuXa4m8Pb3lWKFoA
         G+EiroA1yfhkKPwGW8mczpu2Ypiich96mmfQF16FTCGbvGPNzyWA2IIdru6gTaK9dfyP
         wVAw==
X-Gm-Message-State: APjAAAXqe9pJkcDzAwTh4PPYcp7eJQKBqLNvIO8CXspuUvIjGX15b8Bh
        huW+8NIBMPZEO0ow0wC5GB0vZB7gDMMKUKcLC+yJmAEzamEaAibeZ78vVhM6qG3t4AxV998/ggk
        Z56TchjlyQybPSoBfp7w1RMY7
X-Received: by 2002:a5d:6885:: with SMTP id h5mr27879949wru.92.1570547546800;
        Tue, 08 Oct 2019 08:12:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWPsbrFzZkwZFlcJmltVPmPI8g9/KYtbdTHTU1bA2U1kTZdyLlLDzQYpTdTZpJfELXjnhHew==
X-Received: by 2002:a5d:6885:: with SMTP id h5mr27879921wru.92.1570547546560;
        Tue, 08 Oct 2019 08:12:26 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h7sm19634893wrs.15.2019.10.08.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 08:12:25 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: RE: [PATCH 1/2] x86/hyperv: Allow guests to enable InvariantTSC
In-Reply-To: <DM5PR21MB01371F96CD845743D9777DC5D79E0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191003155200.22022-1-parri.andrea@gmail.com> <87k19k1mad.fsf@vitty.brq.redhat.com> <DM5PR21MB01371F96CD845743D9777DC5D79E0@DM5PR21MB0137.namprd21.prod.outlook.com>
Date:   Tue, 08 Oct 2019 17:12:25 +0200
Message-ID: <87tv8jz2xy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, October 4, 2019 9:57 AM
>> 
>> Andrea Parri <parri.andrea@gmail.com> writes:
>> 
>> > If the hardware supports TSC scaling, Hyper-V will set bit 15 of the
>> > HV_PARTITION_PRIVILEGE_MASK in guest VMs with a compatible Hyper-V
>> > configuration version.  Bit 15 corresponds to the
>> > AccessTscInvariantControls privilege.  If this privilege bit is set,
>> > guests can access the HvSyntheticInvariantTscControl MSR: guests can
>> > set bit 0 of this synthetic MSR to enable the InvariantTSC feature.
>> > After setting the synthetic MSR, CPUID will enumerate support for
>> > InvariantTSC.
>> 
>> I tried getting more information from TLFS but as of 5.0C this feature
>> is not described there. I'm really interested in why this additional
>> interface is needed, e.g. why can't Hyper-V just set InvariantTSC
>> unconditionally when TSC scaling is supported?
>> 
>
> Yes, this is very new functionality that is not yet available in a released
> version of Hyper-V.  And as you know, the Hyper-V TLFS has gotten
> woefully out-of-date. :-(
>
> Your question is the same question I asked.   The reason given by
> Hyper-V is to take the more cautious approach of not "automatically"
> giving VMs an InvariantTSC due to updating the underlying Hyper-V
> version.  Instead, guest VMs must have been explicitly coded to take
> advantage of the new InvariantTSC feature.  It's not clear to me how
> much of this caution is driven by Windows guests vs. Linux or FreeBSD
> guests, but it is what it is.
>
> Having to explicitly enable the InvariantTSC does give the Linux code
> the opportunity to be a bit cleaner by doing things like not marking
> the TSC as unstable when the InvariantTSC feature is present, and to
> mark the TSC as reliable so we don't try to do TSC synchronization
> (which Hyper-V does not want guests to try to do).

Thank you for these additional details Michael,

we'll probably have to add support for this bit to KVM and I'd like to
know the background. From Linux perspective, no matter what's the
interface we'd like to get InvariantTSC.

Feel free to add

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
