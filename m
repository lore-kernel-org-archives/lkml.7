Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDC0CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E7920679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfJUNDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:03:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfJUNDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:03:14 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECE6785536
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:03:13 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id j14so6964700wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 06:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SRsEP7MdZ/U/cm1kcGdYUO6agWlHXT6j/oNDoj6CtAE=;
        b=LqCyb3Fe/A3eYfU2Q2APKQ+H2myz+iuWsLcwxneiXuAjDGAgyv1LstoU3xslhFJLoJ
         dNGKtS/CLh3Ox3BqL071etJIdnXXmfrQ+EfAAzbhwHfP+I0Kb77jJ7i/9mN+IYCHj9Xx
         u+cQQgV8ftLofuNuEDVpGDWt9xlYmwMKgLGQ3/pWIHIhXftw6UNVrl4CdWFDGsBHqaNr
         QlnVRBrCd0UezBREFViEcqYueq9nDrPvpt78kH/U0lyKXXMtIzJK1zqnBBPSbj9H1Ifv
         Zcm4KB43N/4B+2xO3UR6FFTOfH48qiQUCiCL4MByyZCoBS5TCh2jxrjf5vwgiXpylll3
         xRrQ==
X-Gm-Message-State: APjAAAV8HNL65gowGML5Jsic9v1n6iarrKKXGtlO+LfkE7cKNfILtVyI
        u5oGw1Toi5NjNi3oThsxa9NXIT4eyk8LLonLX4IZYhL9yqy+Ik4YRhpm8VWGz4rUmWv8k3hGHuC
        NL6hHOex0lsourplZg69rt7Xu
X-Received: by 2002:adf:ea83:: with SMTP id s3mr4300753wrm.43.1571662992511;
        Mon, 21 Oct 2019 06:03:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0vfWrFJ17dOTpy0SjdT50aBC6AoFTEf08r3xOJ2JAlE1xg/YCfk4j4w2W0Kt7dxid70mggw==
X-Received: by 2002:adf:ea83:: with SMTP id s3mr4300716wrm.43.1571662992251;
        Mon, 21 Oct 2019 06:03:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:566:fc24:94f2:2f13? ([2001:b07:6468:f312:566:fc24:94f2:2f13])
        by smtp.gmail.com with ESMTPSA id l18sm19087044wrn.48.2019.10.21.06.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:03:10 -0700 (PDT)
Subject: Re: [PATCH v9 09/17] x86/split_lock: Handle #AC exception for split
 lock
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e5affe77-ac99-ce3b-dc08-352d9632766d@redhat.com>
Date:   Mon, 21 Oct 2019 15:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191016174200.GF5866@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 19:42, Sean Christopherson wrote:
> KVM uses a locked cmpxchg in emulator_cmpxchg_emulated() and the address
> is guest controlled, e.g. a guest could coerce the host into disabling
> split-lock detection via the host's #AC handler by triggering emulation
> and inducing an #AC in the emulator.

Yes, that's a possible issue.

Paolo
