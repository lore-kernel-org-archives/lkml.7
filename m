Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6F8C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2790207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aR+KCZ9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfJDXfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:35:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42470 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbfJDXfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:35:54 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so17040617iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 16:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+T7DRRD+UBJWxQqae2a5KokUy893Q+Fh/NFyFQWVL5c=;
        b=aR+KCZ9iMZp71ShYHM33WPPJZLgnz4zsUdnjqJr8GHFuHLR7FyxN/fle/WUHQd2S1g
         OfLnAhfjfVGHzOaJK0w0TC11rXg1X4dvELPEblK609VJWdmUv3sZEwya23vmrWxc9DIG
         vIwRS1tb3jC35O1UM0jW9C+Ii5AJiQBiaQ1Ur7s/C07BnQkMOVZ4W9F3sPzf++A2KGb7
         xR6BJ5NeINKOa0O4NpITK3QSA5A4hBhi6JPVSDWobx9wowRsCSuZB6NQRnkdoOs+Z2W2
         osQu5NuuvxVuUBBBHYMDims/a/amUqM21/mCbGDA6dx/4nzkkCX+H13qHMc6NbHauO0N
         1cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+T7DRRD+UBJWxQqae2a5KokUy893Q+Fh/NFyFQWVL5c=;
        b=ZSQ1M50Jy7oLYYe55n+zMxm+UzX4VqKZt3XtkjFOFS6C9Tey8vLvnwA1cosYlexfE0
         T5H5sJr9zO9Tk2vm1QT0CK5TcqWu1xqBlMhGaTbO32125uuvMHSO8YSiVXJigHlN+Cjt
         1+3xjaJDN/NdKD/0liEIVAuWe1AD9VXqS1LJdQQw5oiz8uy7PCmoecDHairo+/0rNAdC
         FpglDp/eSWCpl23FIAwFomNfqTeLtwge06I2G4P5N3o0ZjGR68tbhyWRUni/7mrMnLhz
         bOQ7aeBEb03JZWg2uSgFL2UR1HkcZYBHSS0y8uz6rBGpwOFsDBizTemJNZAJCsBv6bSW
         ieHQ==
X-Gm-Message-State: APjAAAU15fusUYXZl5szGuT4N7H0zijI9FSGUUQd0m2jfTk3WYJjsKr+
        6a9x1hxnqXWgkxwGnzvTio0uaS5Q+1d9hFaTsMh88g==
X-Google-Smtp-Source: APXvYqx43jSstCJvk+2c6AUFzK14t9HPWx/edmJdJr8SoFrOND4p+DMir84DYAG2WVlbh9N6FdgDkbxAOENqDWPCqg4=
X-Received: by 2002:a92:5a10:: with SMTP id o16mr19118181ilb.296.1570232153408;
 Fri, 04 Oct 2019 16:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191004215615.5479-1-sean.j.christopherson@intel.com> <20191004215615.5479-9-sean.j.christopherson@intel.com>
In-Reply-To: <20191004215615.5479-9-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 4 Oct 2019 16:35:42 -0700
Message-ID: <CALMp9eSEF-MKxF1+ApTe9-2fJbRBt2svHiCdX=4jP25Ed2LqBg@mail.gmail.com>
Subject: Re: [PATCH 08/16] KVM: VMX: Check for full VMX support when verifying
 CPU compatibility
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
> Explicitly check the current CPU's VMX feature flag when verifying
> compatibility across physical CPUs.  This effectively adds a check on
> IA32_FEATURE_CONTROL to ensure that VMX is fully enabled on all CPUs.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
