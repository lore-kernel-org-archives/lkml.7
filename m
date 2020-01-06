Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80C5C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B103207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tx133Dbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgAFUQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:16:53 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39876 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgAFUQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:16:53 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so20108543ioh.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ad1Ao2TlSfLCNigJ6Pa+3nawhinGXzkpiWfEgqcNlkE=;
        b=Tx133DbulEz48pvKM16QrOTa6SZ28yS4BBeei2HnoOx+0KVySJgiNWMTLHVNcbxMqs
         +uzP9l3dy899SpHobHnByiwalfHz4eThgOlxnvMCV1GO5KJViLO/Yx47cRhfzuYfWq7W
         nSvVHrkyVWVmKOf8scyQmojf2UkxHBnkOsKsPrGkoju1JDAMgXefnp9f0eJ0HmKH7G70
         c4NSG2PXorEyu0HFzENfdo7Mf2U5DXvN46b2g7TDNb8XfcAltl9bmlnHIUTRZblFQvTb
         p2js4weuJx6rCjiwnnfjOZuFlwFBFkTcHFspYJQ+WczeLq4SrTWmOgqbzFQxxn8/95UJ
         06VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ad1Ao2TlSfLCNigJ6Pa+3nawhinGXzkpiWfEgqcNlkE=;
        b=IwGcSHXGQAnMjIvM6Owyw4m4YbGebALScWpQmpjaKrj9RlGa6AQXrEyVs9thcCWN6g
         eyimGLRLK8IyWh0BJNJT0OGWweGQ6zRGxXs4kuv/2mjZ/YNzSv02xkoS7Lr0VAnL+4Ae
         KGQZL2ZB41ndKwvDu4bDFuvqrK9u/Uuq96QiyyvWwRmlgniu1qc9wWTrNif7vPyPpbDO
         ndqMOMMfuFYmRh47VOQlHtCWU4ddb/kceZUwje8wezGmYixuUqHh5D29lxwzXVtvuWuv
         ATxtWkWq2gHAQj3Sft1X+2cJajJnDDKq7ZL06s5McdLqZ19dIKU91yozJDbrBNwLbTf/
         ZYxg==
X-Gm-Message-State: APjAAAV4IY+qZ7PBnXHNYCaA260S342RJwZc2fKiF0mVg7A+iiJiEh5S
        7lIN9RZcqYoTWsxZfU0G6y5wQuIAydStyDD/SVyz9Q==
X-Google-Smtp-Source: APXvYqwwxRjaUDXqnO8pwICqhkfTcFjemZ9i/gfqccux/oxs4oMkZdlQpoikYKZZolo7WWtBG/O8CGjdGya5UKFV970=
X-Received: by 2002:a5d:9953:: with SMTP id v19mr70376880ios.118.1578341812201;
 Mon, 06 Jan 2020 12:16:52 -0800 (PST)
MIME-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-3-pomonis@google.com>
 <314f6d96-b75f-e159-d94d-1d30a5140e40@de.ibm.com> <CALMp9eTOD6r13sPZ3skz_YkSFn2ZKbsr5zbLP9LgzjpHnsebkQ@mail.gmail.com>
 <73a7a1ce-7e68-7b15-70eb-7b6217af5e1a@de.ibm.com>
In-Reply-To: <73a7a1ce-7e68-7b15-70eb-7b6217af5e1a@de.ibm.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 6 Jan 2020 12:16:41 -0800
Message-ID: <CALMp9eQ5S1oD6YtEp-peX+iLRbX5bhRVTrD4DamAsDJtwe7yOA@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] KVM: x86: Protect kvm_hv_msr_[get|set]_crash_data()
 from Spectre-v1/L1TF attacks
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Marios Pomonis <pomonis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 9:47 AM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 12.12.19 18:44, Jim Mattson wrote:
> > On Thu, Dec 12, 2019 at 9:31 AM Christian Borntraeger
> > <borntraeger@de.ibm.com> wrote:
> >>
> >>
> >>
> >> On 11.12.19 21:47, Marios Pomonis wrote:
> >>> This fixes Spectre-v1/L1TF vulnerabilities in kvm_hv_msr_get_crash_data()
> >>> and kvm_hv_msr_set_crash_data().
> >>> These functions contain index computations that use the
> >>> (attacker-controlled) MSR number.
> >>>
> >>> Fixes: commit e7d9513b60e8 ("kvm/x86: added hyper-v crash msrs into kvm hyperv context")
> >>>
> >>> Signed-off-by: Nick Finco <nifi@google.com>
> >>> Signed-off-by: Marios Pomonis <pomonis@google.com>
> >>> Reviewed-by: Andrew Honig <ahonig@google.com>
> >>> Cc: stable@vger.kernel.org

Reviewed-by: Jim Mattson <jmattson@google.com>
