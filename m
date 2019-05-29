Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D47C46470
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5552070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfE2B2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:28:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41831 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfE2B2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:28:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so436581wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 18:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zy4dt0/WsQ2pPQWde6zfELpEkgD8cGRU5zkaONVLf7w=;
        b=XdzZ8tsZDV66g6exchJci/uYn83Fld86fihy3gS5aejUQUsgiTWlm0tfOjaRJfhCUk
         TcGmFiI5X0WbWM8h6JXG/9akhOOXy3QniF6kzNcKL51jfUtLbYi12f79nLWMBcvsR7nv
         mfU3ixSePN699I4GUeDIDu9/nRCOlx1F08eF64xpIp1DlQkH9doZ5In32oKnB3XOQ2Ov
         okDGtieRa6XU7kwIzGMXQHx+iRRAc7A7UuhXWhopIuFV+nM4NYMcXyWYZVBpsqRJ0xN2
         GkdpSzRq9FUXmDs6JZMdrQJQxb/OHiZ4iMoInRAaMl2QLE54ocBq60TUmUFWvq9Kh3/N
         lH5g==
X-Gm-Message-State: APjAAAWRm+1MKS7ICvXNe33DEb5PKBaVxntVgQsVSHcgqn7PTrOSg6o3
        CD2q27z0Y12kxdT/O8YGtQ+dyQ==
X-Google-Smtp-Source: APXvYqwZYgBbYcOXL1jluAbtyuzMdx9moyE1uHZ1h1H51iIfrMrheEe0qRvL24XxCKchdTyl5TIvIA==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr7328142wre.205.1559093301578;
        Tue, 28 May 2019 18:28:21 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id r16sm11765117wrj.13.2019.05.28.18.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 18:28:21 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] KVM: vmx: handle vm-exit for UMWAIT and TPAUSE
To:     Tao Xu <tao3.xu@intel.com>, rkrcmar@redhat.com, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sean.j.christopherson@intel.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jingqi.liu@intel.com
References: <20190524075637.29496-1-tao3.xu@intel.com>
 <20190524075637.29496-4-tao3.xu@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b0958339-b23c-dd9d-8673-aae098769738@redhat.com>
Date:   Wed, 29 May 2019 03:28:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524075637.29496-4-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/19 09:56, Tao Xu wrote:
> As the latest Intel 64 and IA-32 Architectures Software Developer's
> Manual, UMWAIT and TPAUSE instructions cause a VM exit if the
> “RDTSC exiting” and “enable user wait and pause” VM-execution controls
> are both 1.
> 
> This patch is to handle the vm-exit for UMWAIT and TPAUSE as invalid_op.

KVM never enables RDTSC exiting, so this is not necessary.

Paolo
