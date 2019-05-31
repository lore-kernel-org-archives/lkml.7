Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A507EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796CC2663C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfEaJBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:01:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55841 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:01:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id 16so1115340wmg.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 02:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DTiQsLTxPV2jXrLH/uO3q/GEu7ETuQg2TOaV62LmCWk=;
        b=SKvI7eIeNrFc7TT4Yz9tR7hpzXhzO1XD8DJG5ulCujnUQDNK3yYYWHAQUElQUPtb5M
         Ai8+Q47Dn4dCAcmTKskSyqJMYR1BqPFEQnK6x6eEaz9FEKukyW9bSsBtFHbnNSgIU9zI
         /43F3lekczaavaxGOYnyy6RCe43O7nNsSMqPtEEZaMtgDpjlqZ1iMcQiq7eD0bfTWBZC
         s2xTctqqY7kj4xqmfPm2Qtxx6PMFSOTZH4x1Q3/4bLhgNVZBPUC3WKnjj74uDeA/9BTe
         YViSebmYEQaP7srz09RYo3camOTZALehGoLkd3foIjLZAROly0Jt3CU+mBMSRX+lBU+k
         KTeQ==
X-Gm-Message-State: APjAAAVp9Y6RxNDP5FcILGomfAuVy79xH/IhmgVQW4GSdCOce+qwPJAh
        NmhI78tetUgZMay1Ay7tvt+8pQ==
X-Google-Smtp-Source: APXvYqwPM3bx3DRCNnTfMZ6u9wtiYG9PJ9DNHMH+x0DpAEt/eeZaB2JcBrDF6jH6+F1OyKZC4/zIzA==
X-Received: by 2002:a05:600c:240e:: with SMTP id 14mr4902900wmp.133.1559293305650;
        Fri, 31 May 2019 02:01:45 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id k184sm10942021wmk.0.2019.05.31.02.01.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 02:01:44 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: LAPIC: Optimize timer latency consider world
 switch time
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1558585131-1321-1-git-send-email-wanpengli@tencent.com>
 <20190530193653.GA27551@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <754c46dd-3ead-2c27-1bcc-52db26418390@redhat.com>
Date:   Fri, 31 May 2019 11:01:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530193653.GA27551@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/19 21:36, Sean Christopherson wrote:
>> +u32 __read_mostly vmentry_lapic_timer_advance_ns = 0;
>> +module_param(vmentry_lapic_timer_advance_ns, uint, S_IRUGO | S_IWUSR);
> Hmm, an interesting idea would be to have some way to "lock" this param,
> e.g. setting bit 0 locks the param.  That would allow KVM to calculate the
> cycles value to avoid the function call and the MUL+DIV.  If I'm not
> mistaken, vcpu->arch.virtual_tsc_khz is set only in kvm_set_tsc_khz().

I would just make it read-only.  But I'm afraid we're entering somewhat
dangerous territory.  There is a risk that the guest ends up entering
the interrupt handler before the TSC deadline has actually expired, and
there would be no way to know what would happen; even guest hangs are
possible.

Paolo
