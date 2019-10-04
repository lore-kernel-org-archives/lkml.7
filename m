Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E202EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C6120862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQCZ4JuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfJDHdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 03:33:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53189 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727326AbfJDHdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 03:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570174421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=8Y//Zmntx4ufnGGRI8hf20Nrx5NIc6pYNaUZckNMkBo=;
        b=VQCZ4JuKJl3MrdqvF2AiRQlqKVlAxS9iOVKDaFi6WIRgVOW5WVJYh5P3+6Ng4l6t6aVMSw
        BWNtlvLCvjCVjabtQM3Lx4ph10yss2pvEf1E1iD26QSs78rFAnt3dU314jyyggH0Pm4ftg
        CndjwenTNfa/v4PhCstlJZkTAD8UgRU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-ddQelPRAMLurdwA9josS6g-1; Fri, 04 Oct 2019 03:33:38 -0400
Received: by mail-wr1-f71.google.com with SMTP id w10so2313991wrl.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 00:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t4ppAKkwTNFOQrRrntnYHnidIdCMVMlsgWRFlLoEftU=;
        b=V0cwKnVCY2+QtBx17OU3q2U39L5wSz0PU8H/h13NXFz11ok43gW8Bp8TF53eqFIzEO
         CW/Z4RFcGdcmCRkUK8CoVhBiAp6d4o6Wm+2eWWy01XD5bY4rnblDFp2JUslgBn7BuCX2
         s1l7EfsPwkuC0+j7lgxyebxYSbz0OxHdKnjiktzvgTiyby8CAaDNGi0JneNWY+7wQQsw
         fkjQpqmcpc01y75Yj24e6IEmxKZQfr7JSiQo8L5jlgH+pa24ltleSCFBIImqeNeur2ZS
         KmdK6aLgWwm+08pdp5iiO7pJgS5ZVRXEIeHxcKnjtMeG/9uGjDpV32p0u/ytWLOyCqpf
         /K3Q==
X-Gm-Message-State: APjAAAUHRMLBQxPcCuv2V4rhHpjoRjTJ8mvhv8p7CaXcIVtizDUx/cCb
        5vgJgTknNm6kMLlU/3mWt6ycQB0Z465ZhElvu63C9RVs3i0LVgSZMfFfSYk9iWZsGPFgJATJjSb
        uIkGsiSgHeKtro8/TkPluKuEA
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr11022753wrt.100.1570174416797;
        Fri, 04 Oct 2019 00:33:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwHyEyM3S+vayaNWQN/Gp53Rbi7fPv/uH0l0mxTG5dhQxQVT8pRgCbd+4675sQR97/I/iY/tg==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr11022736wrt.100.1570174416564;
        Fri, 04 Oct 2019 00:33:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e56d:fbdf:8b79:c79c? ([2001:b07:6468:f312:e56d:fbdf:8b79:c79c])
        by smtp.gmail.com with ESMTPSA id e9sm15809881wme.3.2019.10.04.00.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 00:33:36 -0700 (PDT)
Subject: Re: [RFC PATCH 10/13] x86/mm: Add NR page bit for KVM XO
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        luto@kernel.org, peterz@infradead.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, keescook@chromium.org
Cc:     kristen@linux.intel.com, deneen.t.dock@intel.com
References: <20191003212400.31130-1-rick.p.edgecombe@intel.com>
 <20191003212400.31130-11-rick.p.edgecombe@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <19d7bde0-6063-c337-994f-0c75cbcfb721@redhat.com>
Date:   Fri, 4 Oct 2019 09:33:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003212400.31130-11-rick.p.edgecombe@intel.com>
Content-Language: en-US
X-MC-Unique: ddQelPRAMLurdwA9josS6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/19 23:23, Rick Edgecombe wrote:
> +/* KVM based not-readable: only valid after cpuid check */
> +#define _PAGE_BIT_NR=09=09(__pgtable_kvmxo_bit)
> +#else /* defined(CONFIG_KVM_XO) && !defined(__ASSEMBLY__) */
> +#define _PAGE_BIT_NR=09=090
> +#endif /* defined(CONFIG_KVM_XO) && !defined(__ASSEMBLY__) */

Please do not #define _PAGE_BIT_NR and _PAGE_NR, so that it's clear that
they are variables.

Paolo

