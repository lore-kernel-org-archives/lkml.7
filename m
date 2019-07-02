Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556DFC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3296D2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfGBQar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:30:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53342 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfGBQaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:30:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so1484963wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 09:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7t5fxGxFhnlaD4K11RN900eA9G9cmbm1+9mO0Myb9vc=;
        b=ohK/u29BC/vWM/YEMAISBmJxlGLyoGiFlaeXoPwHQb0IM9s4Vr2YsgvKbI4KsM88fv
         3Zx8DdCqJyAYuiCkArwWUWWUvdh5X0RAzb+r9sVNejeys7jfA7GHZyPbRlTIe5PJjW76
         AxIumJk9lTmH5HPX3GMx2jp/mOFBsOaP7K0RSll37VJVnKb5mt/I+xpD0OdIMlVGPdqf
         2ZtVg8BTLCYcMd6mbiLhWa4T0iAkUu1Vzes1jqMldHTmTCj3XFlatWA6lXHFdgF15A4B
         ej/6mS4l6P9MIwO9REqCsCDVQKyI+s2yhsA7DNaweHXjpCNp5mHu7j5oHZCa8DuDypcC
         Alow==
X-Gm-Message-State: APjAAAX1rDvuyhskSdtOffckDWhamPDW+x013Nc+9rJ5uuGAdbT416vv
        z93L1eS7UHdPLjIQ+N0pNO/m/Q==
X-Google-Smtp-Source: APXvYqzSIufNHM2Ytv+tIVnOfNtbDHMos5vGPw9lWMOfGrNOPeHY4NRc25xl6t4RrFJUaFf5q5Ow6w==
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr3928214wmc.21.1562085044674;
        Tue, 02 Jul 2019 09:30:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b8:794:183e:9e2a? ([2001:b07:6468:f312:b8:794:183e:9e2a])
        by smtp.gmail.com with ESMTPSA id z5sm1902471wmf.48.2019.07.02.09.30.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 09:30:43 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] x86/kvm/nVMX: fix Enlightened VMCLEAR
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
References: <20190628112333.31165-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41362dc0-a4d5-93ec-848d-193a76a9bd0c@redhat.com>
Date:   Tue, 2 Jul 2019 18:30:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628112333.31165-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/19 13:23, Vitaly Kuznetsov wrote:
> VMCLEAR implementation for Enlightened VMCS is not entirely correct
> when something else than the currently active eVMCS on the calling vCPU
> is targeted. In case there's no currently active eVMCS on the calling vCPU
> we are corrupting the targeted area by writing to the non-existent
> launch_state field.
> 
> Fix the logic by always treating the targeted area as 'enlightened' in case
> Enlightened VMEntry is enabled on the calling vCPU.
> 
> Changes since v1:
> - 'evmcs_vmptr' -> 'evmcs_gpa' [Paolo Bonzini]
> - avoid nested_release_evmcs() in handle_vmclear even for the currently
>   active eVMCS on the calling vCPU [Liran Alon], PATCH1 added to support
>   the change.
> 
> Vitaly Kuznetsov (2):
>   x86/KVM/nVMX: don't use clean fields data on enlightened VMLAUNCH
>   x86/kvm/nVMX: fix VMCLEAR when Enlightened VMCS is in use
> 
>  arch/x86/kvm/vmx/evmcs.c  | 18 ++++++++++++++
>  arch/x86/kvm/vmx/evmcs.h  |  1 +
>  arch/x86/kvm/vmx/nested.c | 52 ++++++++++++++++++++++-----------------
>  3 files changed, 49 insertions(+), 22 deletions(-)
> 

Queued, thanks.

Paolo
