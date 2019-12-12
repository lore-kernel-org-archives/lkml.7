Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49021C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FB6206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/NXCOyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfLLR5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:57:21 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40525 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbfLLR5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:57:21 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so3728562iop.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z3b25UQSnY6IqzYufZw5HPv7RWsFnuJ1qSwiqH0n/5k=;
        b=P/NXCOyuvKPRWV08VvBA1CWwjXOq2454qr5DFs1i0dx4F3LwmHgj/7p/j/+AGA99YD
         XIWPe87cEztItjq6Zn8pXyHQMZzUEyk8kqXBqi68MgB1GzmECBjHyMdn1YF8qh4niHqF
         15iEyVZAXPani4kohcMWSIPOP56G3yUYSGRJL25s3s84BNsfC5kk8KqEHY45RIJQ+km+
         7nHZhB/fWqMWEC6MkyRtbCJy0SemmaaZZQ7fv7RUOd6VaANEf7I7bBZlkcwJwTtSaJyL
         vQnVIlgojZJ3h4eqkao2clnBKHHZBF/oNu3jwsKJCm7C8CENNAUPifuciLGZ/2ZT8P21
         DDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z3b25UQSnY6IqzYufZw5HPv7RWsFnuJ1qSwiqH0n/5k=;
        b=Vxj6ybZ+4/uyh5Q9pnyfCShL72QBWpImRZg2f6OIs+acBXq1WK9bUVviIxrAiRmgeh
         HFVxH8jCn/vM1JNGhHjM0JjwUaEmpvMWMttaxcmm0rk1kQP+YAHygElBLLhg+ko2f8yO
         6mcZyWWtmorvGaEJmtfYsgWIxEWt8+IAmzwHOh6ugcc68EWywTCl2cGl3P45niFupTWS
         NeZfq7Oe7m27i2JGEWsueBo+BygpB5sFuijgDMtplenKvjncCrGnph7DeClTTGrGn82C
         CHt13av41w3HumbbfJkB29o2gPXrs3iVoQjyGXPMgjkSKJdB/Fz5tl8Ss6S5TgKhXy2H
         vtVw==
X-Gm-Message-State: APjAAAXnvujGsFlt9s/0QFPXYY5fOhBPAet58WEbjhwotmEXAD1mQAlP
        jFxiUcJ5GCuGBBYKcnnhxbKhp0gVwQ03xQ9TOquauQ==
X-Google-Smtp-Source: APXvYqyPE6NbezzK+SCpWx81FOcItGOWVU3L02OQJNEvkysZZsXSDO4rXcsGBPHVc3pNcmN4ZTMpi09J8E7N8GzXb0A=
X-Received: by 2002:a5e:9b15:: with SMTP id j21mr3746698iok.108.1576173439923;
 Thu, 12 Dec 2019 09:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com> <20191212122646.GE4991@zn.tnic>
 <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com> <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
 <17c6569e-d0af-539c-6d63-f4c07367d8d1@redhat.com> <20191212174357.GE3163@linux.intel.com>
 <52dd758d-a590-52a6-4248-22d6852b75cd@redhat.com> <DA429131-7A4C-4B74-A020-6CE7622ED2F8@oracle.com>
In-Reply-To: <DA429131-7A4C-4B74-A020-6CE7622ED2F8@oracle.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 12 Dec 2019 09:57:08 -0800
Message-ID: <CALMp9eRAYj=dKDtnPymkUA_OOMv+9a4WdPNt4hdpFtBgzwNA9w@mail.gmail.com>
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using VMX_FEATURES_*
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-edac@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 9:53 AM Liran Alon <liran.alon@oracle.com> wrote:

> Why should CPU VMX features be treated differently than standard CPUID deduced features?

Do we have the right Intel people on the recipient list to answer this
question? Presumably, Intel felt that this information should be
available in supervisor mode only.

Sean?
