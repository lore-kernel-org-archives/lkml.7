Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B265C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B856216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfHEPtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:49:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35572 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfHEPtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:49:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so84929308wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 08:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=965zgdxTpawv/xodHdjHPNchDoxDHf/nNEvAYnHyeaw=;
        b=WAO5OgJVJXFugeK6icG99oTGRw/uvREgGOPcemjhSjiNNG46x50BwHTb7+eYpRicQO
         DjEH97a/Yih58UkbPOH1ChIkBKT144yp0FCEkSTLiOLlQ5Qs9zK244za7RIaojKaW3qE
         GOuJ5keRrLPU4w5bAHh3p4fUFrAEiCySxd+ByQYs7dmNjhNYU2Lhc/Sj91hQCSewtR3P
         2XlciWp0R2cuwW45f+ldw5wfvWPUuSvNHWGYD6E0Fpm9WJcusDBYpeY5dsQ6skz9z/Lu
         33V0m13dymMzMfE/H1LJyF6OqWcGb1d0EfSpqt0Rr0CQE/dHFOmdGS+Qp7IbaAlEH/QE
         d6SA==
X-Gm-Message-State: APjAAAWSR18RO4wgppwOuAj1wo8R0pQKKqTEbNdV/xFzJU3hqtzl4ujO
        eKl85hy4O4sP2xdFQHgc2um0yanNg7k=
X-Google-Smtp-Source: APXvYqxpq/VRwNb4eDeKTNIzh3vUSyhUSzrlzOhdyS9uCibJCszxrfR7GChMrB2IKLQN4flVLQ8TEQ==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr23939395wru.339.1565020151874;
        Mon, 05 Aug 2019 08:49:11 -0700 (PDT)
Received: from [192.168.178.40] ([151.21.165.91])
        by smtp.gmail.com with ESMTPSA id n8sm71962097wro.89.2019.08.05.08.49.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 08:49:11 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] KVM: remove kvm_arch_has_vcpu_debugfs()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Radim Krm <rkrcmar@redhat.com>, kvm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20190731185556.GA703@kroah.com>
 <6ddc98b6-67d9-1ea4-77d8-dcaf0b5a94cc@redhat.com>
 <alpine.DEB.2.21.1908030939530.4029@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <cd8e8df4-7d12-f111-04fd-fa4d5cb0d89b@redhat.com>
Date:   Mon, 5 Aug 2019 17:49:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908030939530.4029@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/19 09:41, Thomas Gleixner wrote:
> On Sat, 3 Aug 2019, Paolo Bonzini wrote:
>> On 31/07/19 20:55, Greg KH wrote:
>>> There is no need for this function as all arches have to implement
>>> kvm_arch_create_vcpu_debugfs() no matter what, so just remove this call
>>> as it is pointless.
>>
>> Let's remove kvm_arch_arch_create_vcpu_debugfs too for non-x86 arches.
> 
> Can't we remove _all_ that virt muck? That would solve a lot more problems
> in one go.

It sure would take some maintainer burden off me. :)

Paolo
