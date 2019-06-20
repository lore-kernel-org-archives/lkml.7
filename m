Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D3C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828812080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfFTMOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:14:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33392 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFTMOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:14:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so6794023wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 05:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j6RqlD3tjx4apx8Dop5hpUBnB0AsX4GUNp1imsaFEWU=;
        b=kucKfdTSA9e+yI3+ompGQEJQVuF6h2zQ+7dQ2KjOy4TuC2FOEfHcTtCCzBum02OUf7
         2sm8VVfpz35WaN6Zpq3sNZb4sX8M3zvNPtvCU7U61mC38NJT7IXRF2zBJ4un/QIA2x0r
         ORYmThPrilJ3g+hT5RDxvj3KkluUiecP++fJMu0OS/QfogvsST7STzEvfSmNz9G2IXps
         bqOYuWIffAIKuBwMW3EBy6TdiesSeD4AuGfsNG4h1X2DD41BEJ8qZB75vi/fL0hbxFTy
         Mu//biJ3nMvilVwVDDD5Bf394UG2uA+5V3tCOvcRW3TpvlM/Ek2T0YsJW/TwHnX5irDd
         RLrw==
X-Gm-Message-State: APjAAAWVyNMtO/oYcTxnd2WwC1AatY8+fPr5GJmfWGmwUAxh4SeYyhRY
        KPedJze6QSYri30KgBZbMurdeA==
X-Google-Smtp-Source: APXvYqwqNN7z4fPCN4X79oZjI2lnVPj/ReOJhcvL+WrOsnOt4/UEvzaGwgwU76LsXJVRmVm2vDz7Eg==
X-Received: by 2002:a05:600c:228b:: with SMTP id 11mr2745365wmf.26.1561032849420;
        Thu, 20 Jun 2019 05:14:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab? ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
        by smtp.gmail.com with ESMTPSA id h133sm2091970wme.28.2019.06.20.05.14.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 05:14:08 -0700 (PDT)
Subject: Re: [PATCH RFC 0/5] x86/KVM/svm: get rid of hardcoded instructions
 lengths
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>
References: <20190620110240.25799-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3515d812-e5dd-4436-b73f-1d64bc93b079@redhat.com>
Date:   Thu, 20 Jun 2019 14:14:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190620110240.25799-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/19 13:02, Vitaly Kuznetsov wrote:
> 
> P.S. If you'd like to test the series you'll have to have a CPU without
> NRIP_SAVE feature or forcefully disable it, something like:
> 
> index 8d4e50428b68..93c7eaad7915 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -922,6 +922,9 @@ static void init_amd(struct cpuinfo_x86 *c)
>         /* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
>         if (!cpu_has(c, X86_FEATURE_XENPV))
>                 set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
> +
> +       /* No nrips */
> +       clear_cpu_cap(c, X86_FEATURE_NRIPS);
>  }
>  
>  #ifdef CONFIG_X86_32

Let's add a module parameter instead.  Patch sent (forgot to Cc you).

Paolo
