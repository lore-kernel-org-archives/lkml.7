Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74555C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAD9216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfHEPsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:48:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45692 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbfHEPsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:48:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so5993340wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 08:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+APdg992bZ0oRRkRFf34r5YQsAc0QiyZb6EG2cGQrZc=;
        b=k3+h3ObbJ9M+93Xx9wtP7+0I3cNwZtnBlhIxgCeemVuwvNaaxGA19UlbcrXOTG83B/
         gyLTuMNkukUJJugm/LFnrmsEQ51p5yLNdn7T9PVGHgILbSGk4thRxkZ+B5OWlVbYW4vP
         bz8hEg5gjBInljsqYQbDj04FZ+ai0hUFfYg4lLcUwEZZLb8xuGQHSdIyW7EheZvpCkwS
         dma5wAmwp71JTs+aeJ4DOVtK4dPJjbDaRVYIw+66TvxQs/ffoFeWWkhDazZMpiFNwI6z
         3bS6d1cPAJzJQMNZ/5cxEiLQoeTY3v7zEW619DYcvEp8twwaqDBp1B+ypS80DgegPhdr
         bDbw==
X-Gm-Message-State: APjAAAVlcsRs3/nQOl49aOfDYgLJSMH4UDTLRkv52OoDsCUI/Gi4WdB6
        H2RRdFUN/jxqcIO6uCTkZDTuSopyjwI=
X-Google-Smtp-Source: APXvYqz4HdsMgydpHvuXq8L97rT6K5yfgYcAxLS8myU32TmmmvCZsdQRCZXIj0/aehnLvGi/WfQMNw==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr20893476wrw.191.1565020097350;
        Mon, 05 Aug 2019 08:48:17 -0700 (PDT)
Received: from [192.168.178.40] ([151.21.165.91])
        by smtp.gmail.com with ESMTPSA id c11sm144380104wrq.45.2019.08.05.08.48.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 08:48:16 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] KVM: remove kvm_arch_has_vcpu_debugfs()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Radim Krm <rkrcmar@redhat.com>, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20190731185556.GA703@kroah.com>
 <6ddc98b6-67d9-1ea4-77d8-dcaf0b5a94cc@redhat.com>
 <20190805153605.GA27752@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2da5d82a-e88c-903a-1f8b-338f06c76d6b@redhat.com>
Date:   Mon, 5 Aug 2019 17:48:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805153605.GA27752@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/19 17:36, Greg KH wrote:
> On Sat, Aug 03, 2019 at 08:23:25AM +0200, Paolo Bonzini wrote:
>> On 31/07/19 20:55, Greg KH wrote:
>>> There is no need for this function as all arches have to implement
>>> kvm_arch_create_vcpu_debugfs() no matter what, so just remove this call
>>> as it is pointless.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: "Radim Krm" <rkrcmar@redhat.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: <x86@kernel.org>
>>> Cc: <kvm@vger.kernel.org>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>> v2: new patch in the series
>>
>> Let's remove kvm_arch_arch_create_vcpu_debugfs too for non-x86 arches.
>>
>> I'll queue your 2/2.
> 
> Great, so what about 1/2?  I have no objection to your patch for this.

I'll queue my own replacement of 1/2, together with your 2/2.  Both
should reach Linus later this week.

Paolo

