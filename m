Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B49FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C9020854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405514AbfJPPhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:37:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48837 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfJPPho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:37:44 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4003F87638
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 15:37:43 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a15so2848496wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V6hR9H4+lxaTVZm42Obod2VDDJdFkvo/7dcvc/koK54=;
        b=dgup4bOkjMdeodJZy1z4RDmD5isa8f/I1Tb7qF310xv0CEsw1+9XgRoUWDD7LZffse
         RWe5h682afZi2EmluTW/bNTWkyALkAE9pf/ddEWamJWwoKlX6snK9EQOD1ahwpA6dR0P
         KAzUxlcRqLx2sDs/gMh/IXqKHQ4iAWsVzV5Vq2u1gOVig38JTyRf8E7QFCPCx4aUG/k+
         0Xvd8URInPP4PnBGL7HEYfSl8aIrTcVllzYj3Y4gEvavASdCteaQ9iYy6M2T8IIiFHOr
         1y5aBx6SsHId3ovjafTgYcb8U84fG/XjE6kmLpTxur5Zb/1nnZfX0jt986IgMjtJB9W/
         pvAg==
X-Gm-Message-State: APjAAAUdA1HTpIeKAGzLRDEbijUCorlyZ7BXuDGDicC53CM3DINDhh/J
        iTX4N4RZvfjvHN0m1jDkz0XNGn1A35RSyEBwcVywghCGgLLo5JUNGK9LYjGVghScxBzmVJ7LcI7
        FLZy7eZ4KTism3dwDS5yjKE3B
X-Received: by 2002:adf:eec4:: with SMTP id a4mr2808802wrp.38.1571240261721;
        Wed, 16 Oct 2019 08:37:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwt1fLjCxwAblIIbCXdSfq16TKVqcCfYDAFhjaP+M99q7uE0WC3rfXXLkAGNqMzvsZlJQDnSg==
X-Received: by 2002:adf:eec4:: with SMTP id a4mr2808772wrp.38.1571240261365;
        Wed, 16 Oct 2019 08:37:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41? ([2001:b07:6468:f312:d001:591b:c73b:6c41])
        by smtp.gmail.com with ESMTPSA id o18sm6831906wrm.11.2019.10.16.08.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 08:37:40 -0700 (PDT)
Subject: Re: [PATCH v9 09/17] x86/split_lock: Handle #AC exception for split
 lock
To:     Thomas Gleixner <tglx@linutronix.de>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
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
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
 <1560897679-228028-10-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1906262209590.32342@nanos.tec.linutronix.de>
 <20190626203637.GC245468@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1906262338220.32342@nanos.tec.linutronix.de>
 <20190925180931.GG31852@linux.intel.com>
 <3ec328dc-2763-9da5-28d6-e28970262c58@redhat.com>
 <alpine.DEB.2.21.1910161142560.2046@nanos.tec.linutronix.de>
 <57f40083-9063-5d41-f06d-fa1ae4c78ec6@redhat.com>
 <c3ff2fb3-4380-fb07-1fa3-15896a09e748@intel.com>
 <d30652bb-89fa-671a-5691-e2c76af231d0@redhat.com>
 <8808c9ac-0906-5eec-a31f-27cbec778f9c@intel.com>
 <alpine.DEB.2.21.1910161519260.2046@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ba2c0aab-1d7c-5cfd-0054-ac2c266c1df3@redhat.com>
Date:   Wed, 16 Oct 2019 17:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910161519260.2046@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 16:43, Thomas Gleixner wrote:
> 
> N | #AC       | #AC enabled | SMT | Ctrl    | Guest | Action
> R | available | on host     |     | exposed | #AC   |
> --|-----------|-------------|-----|---------|-------|---------------------
>   |           |             |     |         |       |
> 0 | N         |     x       |  x  |   N     |   x   | None
>   |           |             |     |         |       |
> 1 | Y         |     N       |  x  |   N     |   x   | None

So far so good.

> 2 | Y         |     Y       |  x  |   Y     |   Y   | Forward to guest
>
> 3 | Y         |     Y       |  N  |   Y     |   N   | A) Store in vCPU and
>   |           |             |     |         |       |    toggle on VMENTER/EXIT
>   |           |             |     |         |       |
>   |           |             |     |         |       | B) SIGBUS or KVM exit code

(2) is problematic for the SMT=y case, because of what happens when #AC 
is disabled on the host---safe guests can start to be susceptible to 
DoS.

For (3), which is the SMT=n case,, the behavior is the same independent of
guest #AC.

So I would change these two lines to:

  2 | Y         |     Y       |  Y  |   N     |   x   | On first guest #AC,
    |           |             |     |         |       | disable globally on host.
    |           |             |     |         |       |
  3 | Y         |     Y       |  N  |   Y     |   x   | Switch MSR_TEST_CTRL on
    |           |             |     |         |       | enter/exit, plus:
    |           |             |     |         |       | A) #AC forwarded to guest.
    |           |             |     |         |       | B) SIGBUS or KVM exit code

> 4 | Y         |     Y       |  Y  |   Y     |   N   | A) Disable globally on
>   |           |             |     |         |       |    host. Store in vCPU/guest
>   |           |             |     |         |       |    state and evtl. reenable
>   |           |             |     |         |       |    when guest goes away.
>   |           |             |     |         |       |
>   |           |             |     |         |       | B) SIGBUS or KVM exit code

Also okay.  And finally:

  5 | Y         |     Y       |  Y  |   Y     |   Y   | Forward to guest

> Now there are a two possible state transitions:

>  #AC enabled on host during runtime
> 
>    Existing guests are not notified. Nothing changes.

Switches from (1) to (2) or (4) and (5).  Ugly for (2) and (4A), in that
split-lock detection might end up being forcibly disabled on the host, but
guests do not notice anything.  Okay for (4B) and (5).

>  #AC disabled on host during runtime

Switches from (2), (4) and (5) to (1).  Bad for (4A) and (5), in that
guests might miss #ACs from userspace.  No problem for (2), okay for (4B)
since the host admin decision affects KVM userspace but not KVM guests.

Because (4A) and (5) are problematic, and (4B) can cause guests to halt
irrecoverably on guest #AC, I'd prefer the control not to be
exposed by default.  In KVM API terms:

- KVM_GET_SUPPORTED_CPUID should *not* return the new CPUID bit and
KVM_GET_MSR_INDEX_LIST should not return MSR_TEST_CTRL.  A separate
capability can be queried with KVM_CHECK_EXTENSION to determine whether
KVM supports split-lock detection is available.  The default behavior will
be (2).

- we only need to pick one of (3A)/(4A) and (3B)/(4B).  (3A) should definitely
be the default, probably (4A) too.  But if both are implemented, the
aforementioned capability can be used with KVM_ENABLE_CAP to switch from
one behavior to the other.

Paolo
