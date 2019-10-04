Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6453C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB97215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZIJeMHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbfJDXYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:24:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45265 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbfJDXYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:24:46 -0400
Received: by mail-io1-f65.google.com with SMTP id c25so16991615iot.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5VoJmyM1gIMOj2ihP4m0dtGZhlTOsx/IWyANJwdZVw=;
        b=qZIJeMHuRRyz9aYl84QLkP2KgLaLrHTfF6B2u847hCYU+r/+0kBlyQHUlkoKVSkjNC
         advNWiZJ0xqEG0BgQQhSpyT5/MYyXgkmWIK1NzllFw+CUK2g+l3u6rPb8YmZAFO/Pzig
         xUpdwXU7xuws8uqCAgvrKKNXzll3QLKdd46jJQGNPe2WXpuczp84Y2GpcigQwz1YmqoW
         Z1tXKcfMErZmbK3HXUCpq1+o4JbvK/IM+bZZ3CFeX50q556ZfBNxYlOEWDxe5NDssp+l
         UyGM68+EgtBAZw2tlK+6NRbexNzKayIf8gF3C6ucLBBA0wTv70Rf72YwWTYBI82bx/An
         ehCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5VoJmyM1gIMOj2ihP4m0dtGZhlTOsx/IWyANJwdZVw=;
        b=fjmgvlxN1xrY2JmyI5K1PIgvOFHQ9dhyJZyMqycwzEfRzE4dSLWvfLoYSG/Nz7wgC3
         FVGZclqNnFcqDKagrzXwaXgxCCmD0rS3DwZxXMOZC3RmSZHVI+jyVRJGHtt8aRYXgbub
         zuf2gpY69bSBxyHFxN/vrl2PycxbEpi9vKj5+r7OEc5+XSi5d+2fdIECuFz34o8RFGgD
         8qqwOI1CMM8IP7v4zUvlUYG/FEW4bYnx/NOULWyXL83ZuZRjQIwYdSNse7SFAI8f/c4k
         xaH8iFKElJvRrXAl9R73tMHOqwNP4LBKkJ/UP4bplwpYqe9T/smbaAPMIsu8l2/uJgPZ
         UQ7w==
X-Gm-Message-State: APjAAAVKCt1tJITnKk3Mkvp3lLvgkgCzom9JdBOjeHYFX+xYj2ArKjmH
        jwPLf76VJgoNrjLvfcTD8DQ/WeKlHaRWUmXmMMmlAw==
X-Google-Smtp-Source: APXvYqx308aZCOI6xyKA+PpfI3mwAwHMdWiaKcu5fdslzxso/ABtjWOM3BvEg2g12QeUqihbpfUU65wAmmU0PIXWH5o=
X-Received: by 2002:a02:ac82:: with SMTP id x2mr17276510jan.18.1570231485310;
 Fri, 04 Oct 2019 16:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191004215615.5479-1-sean.j.christopherson@intel.com> <20191004215615.5479-6-sean.j.christopherson@intel.com>
In-Reply-To: <20191004215615.5479-6-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 4 Oct 2019 16:24:34 -0700
Message-ID: <CALMp9eQ-XnYo0e+Z7a931_+J9Q-9cmgPZZ3higmg2A=WiPz5iA@mail.gmail.com>
Subject: Re: [PATCH 05/16] KVM: VMX: Drop initialization of
 IA32_FEATURE_CONTROL MSR
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 2:56 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Remove the code to initialize IA32_FEATURE_CONTROL MSR when KVM is
> loaded now that the MSR is initialized during boot on all CPUs that
> support VMX, i.e. can possibly load kvm_intel.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
