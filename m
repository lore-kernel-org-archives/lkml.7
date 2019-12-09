Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E24C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1DD2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhTVsCMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLIRDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:03:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49166 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726589AbfLIRDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575911018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZscNEm/8S7rYYR2nNxSKnziRbIDnKfxgL2hsBGVmf0=;
        b=HhTVsCMIiL6oVH5vsVqoPCg+c+64le8COVqzevEE/jM8Wd1b3VO4rIsUXjUv5yP2WA5qta
        W6d2RFtACRT3E66+zFdfhP+3iKj5iZhSWU8NE5YzasQpgpqpivzgOWgVNJMBOi0/wFecm/
        hwbTsN83zMDrXqv1UupnBw+eamZJ5fE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-NOyaSIETNGyiRfqQQ8_F_A-1; Mon, 09 Dec 2019 12:03:34 -0500
Received: by mail-wr1-f69.google.com with SMTP id w6so7714365wrm.16
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 09:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XZscNEm/8S7rYYR2nNxSKnziRbIDnKfxgL2hsBGVmf0=;
        b=c5T+anOd1fg8gyazM0fXQjfH7BztsyCUiQhfs77Y+5ufVxpy1rqxb8xBINz3ANGQrl
         5thbuYVd1+SqkTQ4YhorUmCV1msH7+nMvKwyiBAt64S0yzisxlYfD1S8uFGsMboh7jgI
         nO9ZUZpPpYPSZBxCZvbbK5vDj3BuWJvEiWu3PGGSfiD9/h0h0PIttT0L1EFtn+DUs1wv
         6z3XFkxl/ArvkdyIwFXnqQgS0RK7LQD+xwUvVuxVFikCEQFlsrJqxw36T+T8Dz8NnsVx
         OI9wS9ivtOFnsfzuYdev/KUE3a038ejL6A5c0uTyvvHn9aA7qbD+0fPMmrqpeKiDu6Hq
         KLrA==
X-Gm-Message-State: APjAAAWIvSI2QoOCELuOZyJSh/SFYgbHIeZbnQjtOKSCx+IU3N80qDRR
        jf4/VFlpGCxLO8M/O1TFAi/XeLVVQTcOStRgvxL6nH2pn4n4SIV8koZWSJ96+n8KomoB5mKoc4n
        tYENDkTTT3BDFpyF/hSwgyCO5
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr9567wmj.41.1575911013017;
        Mon, 09 Dec 2019 09:03:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDpR0s5SjlfMtDdgShxfdl9maDu+Un6Z+SFZJ5fcGr598GSHGZuwP95n0rBAgJvv9SZhP8JA==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr9536wmj.41.1575911012749;
        Mon, 09 Dec 2019 09:03:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id d12sm72894wrp.62.2019.12.09.09.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 09:03:31 -0800 (PST)
Subject: Re: [PATCH v4 1/2] KVM: VMX: FIXED+PHYSICAL mode single target IPI
 fastpath
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Liran Alon <liran.alon@oracle.com>
References: <1574306232-872-1-git-send-email-wanpengli@tencent.com>
 <CANRm+CxYpPftErvk=JJdWZikKSn-PYsVRVP3LpF+Q3yBF8ypxg@mail.gmail.com>
 <CANRm+Cy_Aq4HY9vYDtBfoNyo8wikf8Mi3u7NBm=U78w1VtTFMA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bc78a4c-6023-2566-d5ce-af611b199603@redhat.com>
Date:   Mon, 9 Dec 2019 18:03:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CANRm+Cy_Aq4HY9vYDtBfoNyo8wikf8Mi3u7NBm=U78w1VtTFMA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: NOyaSIETNGyiRfqQQ8_F_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/19 09:15, Wanpeng Li wrote:
> kindly ping after the merge window. :)

Looks good.  Naming is hard, and I don't like very much the "accel"
part.  As soon as I come up with some names I prefer I will propose them
and apply the patch.

Paolo

