Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DC4C04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7542070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfE2BYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:24:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35530 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfE2BYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:24:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so378219wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 18:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UiPLvWA/ifZmBgOu5RY7iG79Uns1KHbXQ9v+2ITYDvE=;
        b=GEQ23c7YfN3I0Y/KoU+KhFDqjOPLVnUuwHfJueiHEeGQ09gF2GpiX7F//yDnQYmFBO
         Bi4SBIwAxhI9vry9ARNbdj1+aqORebqqxnJJRYvJTaorR4vAvbSKnzxYwnuWJvHvB6pQ
         IQchkMyYjTcdO+KVkK0FxTkT9sO81V7rcCNwDmal0oGb6UpmVvT8+q+Z7DZIT5AwBzfg
         YuuwMarD2Tj0TyjU9AY3hLfTzEdogEDVEMMpjDeRXPEhZXCiLUwysDR5f33RIGzIoLcJ
         cGAFiEhLjcdU2onaj7fx1Fw+yUrzOQkRyuI16HHKccGXuB+rw3dGaANMEkuyXkvOKhIb
         iSlg==
X-Gm-Message-State: APjAAAWFlOpq7F7dVpylvkdnnyCTHX3etCvBoJKiRUM6mnQa0kidFIYC
        1Gw7PrcpvSTgkCks2WXqZqnYBQ==
X-Google-Smtp-Source: APXvYqyXLAZxyqIf9pbTP7YEBWBAjL4jFU3SBYm8nLl1/MmAXqgwazyQevT5XTPPFzfWUQKFyN+3qw==
X-Received: by 2002:a1c:23c4:: with SMTP id j187mr4908475wmj.176.1559093055974;
        Tue, 28 May 2019 18:24:15 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f2sm7111992wrq.48.2019.05.28.18.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 18:24:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] KVM: x86: add support for user wait instructions
To:     Tao Xu <tao3.xu@intel.com>, rkrcmar@redhat.com, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sean.j.christopherson@intel.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jingqi.liu@intel.com
References: <20190524075637.29496-1-tao3.xu@intel.com>
 <20190524075637.29496-2-tao3.xu@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <419f62f3-69a8-7ec0-5eeb-20bed69925f2@redhat.com>
Date:   Wed, 29 May 2019 03:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524075637.29496-2-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/19 09:56, Tao Xu wrote:
> +7.19 KVM_CAP_ENABLE_USR_WAIT_PAUSE
> +
> +Architectures: x86
> +Parameters: args[0] whether feature should be enabled or not
> +
> +With this capability enabled, a VM can use UMONITOR, UMWAIT and TPAUSE
> +instructions. If the instruction causes a delay, the amount of
> +time delayed is called here the physical delay. The physical delay is
> +first computed by determining the virtual delay (the time to delay
> +relative to the VM’s timestamp counter). Otherwise, UMONITOR, UMWAIT
> +and TPAUSE cause an invalid-opcode exception(#UD).
> +

There is no need to make it a capability.  You can just check the guest
CPUID and see if it includes X86_FEATURE_WAITPKG.

Paolo
