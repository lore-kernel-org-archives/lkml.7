Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE64C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7732173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfGQQ1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:27:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40885 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfGQQ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:27:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so25502289wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=77LfX5TBrAXvTY65lk0+TDDEXR8yxc8w01mcbTPv8w8=;
        b=tKjJwfjLg8R4TKUiXtMk1KcjGAxEXt1kB0gR8WcMp6BVOBNkuPVQZmTIDy/NfFoXik
         lGg6LacaNdlRaclhcJ8Xo/2nLrdyWZWklX41wZFokqROavzB2CSsqw4bSf2PVZ45do0J
         sA8LZlfvtYnyUAHbTP1I4z5PNt9NbDuMK2znjskC7Pb83+DbavmH1V67hh3ENzcPvlEH
         FT/28hSD8jtySgaS+w3nZQbu7lqrPf1pDhTmqQIQKVRIyMQlS3uoO5AeVocHMaPJrust
         mS73V3A1tm6X8lv3a3RTQQyeCVOe3aGPDnqQgi3RNncH608Ftyr7tHX7d/2dr5ASGHv7
         twDg==
X-Gm-Message-State: APjAAAXJ8BXIkNUiIhFddhX0Q9ue53Go+JVlNP44SEZIdItI5slnHpYt
        m7DFFtEBXYcfzjNqY+xP44AEiQ==
X-Google-Smtp-Source: APXvYqwM9ov3nYMPI5jYiMjqrCSzPDsPtgILq6tjd7jCtMRTyA7mtJXiXg+g9/ZGRFcts9g5h4rzJQ==
X-Received: by 2002:a5d:5452:: with SMTP id w18mr5278577wrv.327.1563380824795;
        Wed, 17 Jul 2019 09:27:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2? ([2001:b07:6468:f312:e427:3beb:1110:dda2])
        by smtp.gmail.com with ESMTPSA id e19sm33590007wra.71.2019.07.17.09.27.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 09:27:04 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] KVM: LAPIC: Inject timer interrupt via posted
 interrupt
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
References: <1562376411-3533-1-git-send-email-wanpengli@tencent.com>
 <1562376411-3533-3-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e8bc7f76-28e0-6c02-5cf2-bb1015a0d0db@redhat.com>
Date:   Wed, 17 Jul 2019 18:27:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562376411-3533-3-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/19 03:26, Wanpeng Li wrote:
> +
> +void kvm_wait_lapic_expire(struct kvm_vcpu *vcpu)
> +{
> +	if (!lapic_timer_int_injected(vcpu))
> +		return;
> +
> +	__kvm_wait_lapic_expire(vcpu);
> +}
>  EXPORT_SYMBOL_GPL(kvm_wait_lapic_expire);

I changed this to

	if (lapic_timer_int_injected(vcpu))
		__kvm_wait_lapic_expire(vcpu);

and queued the two patches.

Paolo
