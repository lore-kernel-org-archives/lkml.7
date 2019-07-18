Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27B1C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C9921783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390502AbfGRONn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:13:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43697 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfGRONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:13:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so28852824wru.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 07:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aitVK5dUi4iEyTg8KMkolW2+9CkRNR/J+VhQtXZUx7o=;
        b=g9OXbF7btNF2T67o8fT8dYpFsosZj2fd1uvfUCAcYDUsyd085lGJFy5PPwAciu9+Kv
         VVRlou21R0WldMrP3vkNpExnjrL/K2cuUxBNTrf1Yx2Ff2Bu1DKrUoFwMV6opAf+v++V
         55rp+0tMgWepTxYMc+JYbWg0mFFLEFjhCZ0wR/nF7tI30+1HOECOhCN91870bPqV9HT4
         +hbHx1rz5k2rDRHKKb578/sMQlDxyPgWrZpdsGH963LNUOdr4uQx+yd+iO3E/15Q13KK
         DJ47p5WE4gZsCeIQ8K3DbXdaWYBx3o7IaJKvNTCXmwwi8VJNWaYuai1F22VOUDoweqUo
         C2bA==
X-Gm-Message-State: APjAAAV7eRD2740oXACELTeIY9W4H2DDBFX1pv/jvfq0SxziIgCFSVgY
        M9s7OWqdyzIbDBHo7StszQbUuIu6M+uL4g==
X-Google-Smtp-Source: APXvYqy4uIh+8Y3VPnsbRO6NYSm6LtRCImetvfh+P5rVBBkEbFi9FhuTmF4xj0Et+xPHBUNXbpOX4w==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr52667728wrr.41.1563459221549;
        Thu, 18 Jul 2019 07:13:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2? ([2001:b07:6468:f312:e427:3beb:1110:dda2])
        by smtp.gmail.com with ESMTPSA id z1sm30251747wrp.51.2019.07.18.07.13.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 07:13:40 -0700 (PDT)
Subject: Re: [PATCH v2 04/22] x86/kvm: Don't call kvm_spurious_fault() from
 .fixup
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <cover.1563413318.git.jpoimboe@redhat.com>
 <64a9b64d127e87b6920a97afde8e96ea76f6524e.1563413318.git.jpoimboe@redhat.com>
 <65bbf58d-f88b-c7d6-523b-6e35f4972bf2@redhat.com>
 <20190718131654.GE28096@linux.intel.com>
 <1b891612-18e6-48ed-cfb5-05e8aca79dcb@redhat.com>
 <20190718141210.us7giumvgbgifvtv@treble>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <86ce6b06-baa7-51a2-b3ea-142547b7f3c3@redhat.com>
Date:   Thu, 18 Jul 2019 16:13:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718141210.us7giumvgbgifvtv@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/19 16:12, Josh Poimboeuf wrote:
> On Thu, Jul 18, 2019 at 03:18:50PM +0200, Paolo Bonzini wrote:
>> On 18/07/19 15:16, Sean Christopherson wrote:
>>>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>>>>
>>>> This has a side effect of adding a jump in a generally hot path, but
>>>> let's hope that the speculation gods for once help us.
>>> Any reason not to take the same approach as vmx_vmenter() and ud2 directly
>>> from fixup?  I've never found kvm_spurious_fault() to be all that helpful,
>>> IMO it's a win win. :-)
>>
>> Honestly I've never seen a backtrace from here but I would rather not
>> regret this when a customer encounters it...
> 
> In theory, changing the "call kvm_spurious_fault" to ud2 should be fine.
> It should be tested, of course.
> 
> I would defer to Sean to make the patch on top of mine :-)
> 

Yes, this can be done easily on top.

Paolo
