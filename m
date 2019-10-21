Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D086CCA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9C920659
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfJUNGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:06:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbfJUNGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:06:55 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEB18882FB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:06:54 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j14so6969707wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 06:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OR1AnertDj9O4GLIj+lVWxAfR9XbJVaHE5lZ4ZzOGVw=;
        b=rf4WEAGHkoO89dDzzGKVCxgN3Fwl6BV4DNLSqRwLzBN3AMXiMmO+kHcm7wFg8ewxqS
         9L3EW7vkMZgV4lQTfU8RjhYlR1uLMCMu1ypOQJQVwNcPytAYUJuqI0sSBWxIHdeWPaSz
         SRB1PIMHRmMnk8L78TugeHw3TytxcaIM1GpLANsRCt7ecrCY4Mzgi82pLAiPGEZ+o/N+
         tMgEoOGqCgK0+Ne1gsNJ/6PgPb9SXLioSiAGMTxtaL/auXAb51pFgGD4xz51ykzJKV67
         /xDyaymWDYTUg1W8qaTQc54qKJYE7qm+erttipvVlG96Wb/ey7kXnroIactyPgmVg046
         LQBg==
X-Gm-Message-State: APjAAAXUFbwsN/pdSvgmRPu+o9PybmG0sEaXaxTUNy3Io8YABo9/OrcE
        uksuz4gor0ThxolglPuocuwdJYHCHoO0Jiy1qpHD7vZmV0XkrBRccwQRKc6NIOgf7W05GOCtXKS
        vfpq/FC3BWDcx+GCuP3giFu9O
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr18624156wmj.165.1571663213198;
        Mon, 21 Oct 2019 06:06:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz/4LPbaN2Besmntxj94BKXEekqUBRvHZViOeLPLikyg307qenBIlxEQZdWScP+C+9YX5Gw8g==
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr18624115wmj.165.1571663212929;
        Mon, 21 Oct 2019 06:06:52 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id k3sm1750717wro.77.2019.10.21.06.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:06:52 -0700 (PDT)
Subject: Re: [PATCH v9 09/17] x86/split_lock: Handle #AC exception for split
 lock
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
References: <3ec328dc-2763-9da5-28d6-e28970262c58@redhat.com>
 <alpine.DEB.2.21.1910161142560.2046@nanos.tec.linutronix.de>
 <57f40083-9063-5d41-f06d-fa1ae4c78ec6@redhat.com>
 <alpine.DEB.2.21.1910161244060.2046@nanos.tec.linutronix.de>
 <3a12810b-1196-b70a-aa2e-9fe17dc7341a@redhat.com>
 <b2c42a64-eb42-1f18-f609-42eec3faef18@intel.com>
 <d2fc3cbe-1506-94fc-73a4-8ed55dc9337d@redhat.com>
 <20191016154116.GA5866@linux.intel.com>
 <d235ed9a-314c-705c-691f-b31f2f8fa4e8@redhat.com>
 <20191016162337.GC5866@linux.intel.com>
 <20191016174200.GF5866@linux.intel.com>
 <54cba514-23bb-5a96-f5f7-10520d1f0df2@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8c5b11c9-58df-38e7-a514-dc12d687b198@redhat.com>
Date:   Mon, 21 Oct 2019 15:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <54cba514-23bb-5a96-f5f7-10520d1f0df2@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/19 03:23, Xiaoyao Li wrote:
> However, without force_emulation_prefix enabled, I'm not sure whether
> malicious guest can create the case causing the emulation with a lock
> prefix and going to the emulator_cmpxchg_emulated().
> I found it impossible without force_emulation_prefix enabled and I'm not
> familiar with emulation at all. If I missed something, please let me know.

It's always possible to invoke the emulator on arbitrary instructions
without FEP:

1) use big real mode on processors without unrestricted mode

2) set up two processors racing between executing an MMIO access, and
rewriting it so that the emulator sees a different instruction

3) a variant of (2) where you rewrite the page tables so that the
processor's iTLB lookup uses a stale translation.  Then the stale
translation can point to an MMIO access, while the emulator sees the
instruction pointed by the current contents of the page tables.

FEP was introduced just to keep the test code clean.

Paolo
