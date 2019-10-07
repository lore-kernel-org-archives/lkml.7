Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C7CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2522084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfJGRFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:05:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60753 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbfJGRFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:05:32 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD0EB5859E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 17:05:31 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 190so97073wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 10:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qWZZwMI60/Yk1Jo1iNOlqvg6GvjDVvDOelOPf/CZZOs=;
        b=jYRt3P4Nb0+IsSHnywf6ZSbOTYvxLr6knI/SYHKX6nH3OAYbjIp97aZZGZMGhRVmtf
         sMhRuEzfYQeWCtCnYPZnZEZZ2B3gduTrHspLznmfLOROIvpkqGmUTJb1mrnlzccADl6b
         EJdGCzmZjcSkSIoC0HCch/Y4vf5d6omiGoruZMXAK1zCDQOhXJk4hNYKQgv4OMOz0uLR
         K+Naxq8PXai4mq38lwmk7rH6Vtz55JXULfgMWM8hANkgul4VlxoIP2WDII/8O5iLV/G8
         dEVH+m68zgIflWsR2MrM9v97mToaAJ5x1OgT6DMXPKNETsyvB5UGRQM6rvYbhwg/hcwr
         kbYQ==
X-Gm-Message-State: APjAAAX+SIZzHLQOr80RA5vOz9Krt+4cDkR8DEj4k0JPHAR25sKZuUsg
        3c8kbib2FEzFC5J1IiPcBWpy/bP/GMsXOzVOTMO/t21UgS3RniDQm54GERrxa5BlbmrYCzIbyTy
        SVnvQZnvPVRUwUyS7KrBs9tTD
X-Received: by 2002:adf:eb4d:: with SMTP id u13mr13794259wrn.224.1570467930414;
        Mon, 07 Oct 2019 10:05:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzC3fvN/T7itcRThqgFQBEe9qKN64SezWk2klHi7Dhoy4KkaqSAol3vKnzlrw6BJtZMoXZ+g==
X-Received: by 2002:adf:eb4d:: with SMTP id u13mr13794225wrn.224.1570467930111;
        Mon, 07 Oct 2019 10:05:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dd9:ce92:89b5:d1f2? ([2001:b07:6468:f312:9dd9:ce92:89b5:d1f2])
        by smtp.gmail.com with ESMTPSA id d10sm206901wma.42.2019.10.07.10.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 10:05:29 -0700 (PDT)
Subject: Re: [PATCH 01/16] x86/intel: Initialize IA32_FEATURE_CONTROL MSR at
 boot
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20191004215615.5479-1-sean.j.christopherson@intel.com>
 <20191004215615.5479-2-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <afd37a28-d135-7c34-bd63-7c11099998bc@redhat.com>
Date:   Mon, 7 Oct 2019 19:05:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004215615.5479-2-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/19 23:56, Sean Christopherson wrote:
> Always lock IA32_FEATURE_CONTROL if it exists, even if the CPU doesn't
> support VMX, so that other existing and future kernel code that queries
> IA32_FEATURE_CONTROL can assume it's locked.

Possibly stupid question: why bother locking it?  It makes sense to lock
the MSR bits to _off_ in the firmware, but if the BIOS hasn't locked it,
why should the OS?

It seems to me that locking introduces a lot of complication.

Paolo
