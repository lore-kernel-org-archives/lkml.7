Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C66CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52822067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfJUI4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56989 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfJUI4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:56:21 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAC4E83F4C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 08:56:21 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id a6so4042823wru.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 01:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQn5Li/EcmWGQTJyF2DN7cNoKtM74y39k0g3g/XyNac=;
        b=gsdUA4EijfHWqRUSl8C8BoY7udA8vXEfcjOBfmaEpaBsWzDsHgBHeOVm6z//oLWFlN
         1JpVo9Oxc+BUmSg2KqWvErmIUoEev9xAzVaEEGJmOgH3WnGRqgLiVqNFeJalomX44xg1
         3MuI29/4iD9Pqy2Nv1vYpcpU3UNsmPYKpuchLAeUkPlpt/cCzhMysuMxum9tqjO5dCWS
         tIo3MB7Nhh3qO1TnhK8jpfPc1S1TRwlNMulj81hvtC+QZEu13PRwxY/QTuD1u/UcsFk6
         AzLaH3eWYWd9vvJSjojpUOl1NJq7XNIh2mbFU7r6/23vHJ3Hx9Mw3uAJV+fh0jT1FWUa
         XLOA==
X-Gm-Message-State: APjAAAWtnmWgts6cObfgYvq7j8U5oH/CXIBAc2c4r6KOrFoArDdgr9dt
        eY+DCCkArURnpMSxhVHIxLqrEcAEQ8LIOFQjqTNronyRmO76JWoOabdPyZSVQwbtJV2dNnv72sp
        hCaGzc6JXUPHgy04jrPvqCKw5
X-Received: by 2002:a5d:464f:: with SMTP id j15mr5164424wrs.366.1571648180110;
        Mon, 21 Oct 2019 01:56:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqysKxDXg0I4Kw8rQkZnFYRtY7gmE/enX8CLo4Y5mT4aGF0Vfe7KNufYviTHlKtqR3lwtPQDew==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr5164400wrs.366.1571648179814;
        Mon, 21 Oct 2019 01:56:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:566:fc24:94f2:2f13? ([2001:b07:6468:f312:566:fc24:94f2:2f13])
        by smtp.gmail.com with ESMTPSA id c8sm720806wml.44.2019.10.21.01.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 01:56:19 -0700 (PDT)
Subject: Re: [PATCH] KVM: remove redundant code in kvm_arch_vm_ioctl
To:     Thomas Gleixner <tglx@linutronix.de>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1571626376-11357-1-git-send-email-linmiaohe@huawei.com>
 <alpine.DEB.2.21.1910211015260.1904@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6ad3a479-5015-10c7-3f32-70f3ed1ecf64@redhat.com>
Date:   Mon, 21 Oct 2019 10:56:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910211015260.1904@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/19 10:16, Thomas Gleixner wrote:
> Can you please get rid of that odd jump label completely?
> 
>   		if (irqchip_kernel(kvm))
> 			r = kvm_vm_ioctl_set_irqchip(kvm, chip);

Keeping the label has the advantage of making the get and set cases a
bit more similar (the get case has to do a copy_to_user after
kvm_vm_ioctl_get_irqchip returns).  Unfortunately struct kvm_irqchip is
quite big (520 bytes) so we don't allocate it on the stack.

So I queued Miaohe's patch.

Paolo
