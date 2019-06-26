Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E0AC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709652085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561567851;
	bh=S4Ncvx4sxZHwQdV7oXACPmmJ2PQLIIk4E9TaysZH9yc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q4EMDy7hM+/7I7M7cNXdQ/uzXfwYJpgzI9wNowFgizcZLdYapxExAj8N1ZH+ZhYxH
	 rK9Q4jArPbjohiI+O5Scl1M5ZeJvQGgIcBl3Ad9W2z+4uRPi7e9w3w8EuRh8rH8OIj
	 v7s+XunPVV67kCrMJC15jx/utFJQvqR9lwAIU0kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFZQuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfFZQut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:50:49 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A153921738
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561567848;
        bh=S4Ncvx4sxZHwQdV7oXACPmmJ2PQLIIk4E9TaysZH9yc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N/kQ6jvbBB9wubufo1QVUilhuPng0BCusrsq+oRdO3z0H9yjS1vyjXxx5Yi400p6X
         ElrnjCzr+Sh4FFAu170Q77gE2c4dj09PfIfZPzfVZm23KZ3RTk8Z+oz39Lvvp/aLW+
         C8cKXwDkvHPe3T+aYhd+iIprDKXPyA6RnUS541Rc=
Received: by mail-wr1-f50.google.com with SMTP id f15so3569902wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 09:50:48 -0700 (PDT)
X-Gm-Message-State: APjAAAVbWK3z/UVQ9QZP2ECJZaLQjkww/ZjmCDqGWPrvY1RZQh6ThwhM
        I/Memmz5HtmRqqUN/rPydK174gaJGizv+z+zVoLj/Q==
X-Google-Smtp-Source: APXvYqxcFEWwRBRwm/F4tHOlws6Gt7Av3XgucqY6ejYlr5sv7QYh9UmjP6m4/drK3bhVF5ovDLmpSeb2gv7teUIv1Fw=
X-Received: by 2002:adf:a443:: with SMTP id e3mr4271982wra.221.1561567847240;
 Wed, 26 Jun 2019 09:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190613064813.8102-1-namit@vmware.com> <20190613064813.8102-6-namit@vmware.com>
 <86e04985-7884-3d33-c479-92614b4e4342@intel.com> <CALCETrXbC=w5KyR8x-hD24DC0BzZ3MjHR1FUOoEXkBOPHPXwXQ@mail.gmail.com>
 <09591002-92C0-4D1D-AA4B-FB1C49661A59@vmware.com>
In-Reply-To: <09591002-92C0-4D1D-AA4B-FB1C49661A59@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 26 Jun 2019 09:50:35 -0700
X-Gmail-Original-Message-ID: <CALCETrV530yi=C9+XOSyY8kvF7EN6PVtSBV4xVauAFC1q5UW8w@mail.gmail.com>
Message-ID: <CALCETrV530yi=C9+XOSyY8kvF7EN6PVtSBV4xVauAFC1q5UW8w@mail.gmail.com>
Subject: Re: [PATCH 5/9] x86/mm/tlb: Optimize local TLB flushes
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 9:39 AM Nadav Amit <namit@vmware.com> wrote:
>
> > On Jun 26, 2019, at 9:33 AM, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Tue, Jun 25, 2019 at 2:36 PM Dave Hansen <dave.hansen@intel.com> wro=
te:
> >> On 6/12/19 11:48 PM, Nadav Amit wrote:
> >>> While the updated smp infrastructure is capable of running a function=
 on
> >>> a single local core, it is not optimized for this case.
> >>
> >> OK, so flush_tlb_multi() is optimized for flushing local+remote at the
> >> same time and is also (near?) the most optimal way to flush remote-onl=
y.
> >> But, it's not as optimized at doing local-only flushes.  But,
> >> flush_tlb_on_cpus() *is* optimized for local-only flushes.
> >
> > Can we stick the optimization into flush_tlb_multi() in the interest
> > of keeping this stuff readable?
>
> flush_tlb_on_cpus() will be much simpler once I remove the fallback
> path that is in there for Xen and hyper-v. I can then open-code it in
> flush_tlb_mm_range() and arch_tlbbatch_flush().
>
> >
> > Also, would this series be easier to understand if there was a patch
> > to just remove the UV optimization before making other changes?
>
> If you just want me to remove it, I can do it. I don=E2=80=99t know who u=
ses it and
> what the impact might be.
>

Only if you think it simplifies things.  The impact will be somewhat
slower flushes on affected hardware.  The UV maintainers know how to
fix this more sustainably, and maybe this will encourage them to do it
:)
