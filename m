Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E902C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA7920707
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcygGCX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfLEL1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:27:49 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:41358 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfLEL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 06:27:49 -0500
Received: by mail-qv1-f67.google.com with SMTP id b18so1127495qvo.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 03:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RN4UxK4XX/wD+FOSD/QSslR64zPY0NoSPi7sfqEDTcg=;
        b=HcygGCX60Afhxpnw9ZYlpuKkkt5wdM44SN/KOzDuDxVXQAJYVla5vHk6t3E4umUT94
         WY3Uy/DUPWgjn0jDpNuvlQTfbRf6E7c08Qp9KQdy8d9VELeRNDHm65ZdVHDB3uZSyxM7
         eHufFLkzIjwZBrX6+UXDf4ik+qPNtMwBIdCqJDm4sA2uNoBYHBhVnpbaMdg/VJS1UEn8
         AM0jTK3oFUhIZANAHf2pmaFrBnf0iz7jtAqeryjk6H+rOQm8s1DrQnC4hXGmy2QVdwbA
         KebmWYKIj3F0ms5Jw0G2v2v3JX7QX7bocZ4OdEkrQzuV2CoGugRaRRbvp9/fH59JF56p
         S+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RN4UxK4XX/wD+FOSD/QSslR64zPY0NoSPi7sfqEDTcg=;
        b=KVsbdYMG0SflTkiglmD36Nq7RXqJz0xPm/1byHzth7FDXhC8Mt6Q6ez3a+GEYd8jwo
         FHYU5gvDctWWm8Q98rLfGlPJcmNcX8VG0Luo6daUQNfQEfLTq0Sey9OlXJItiJZmE6u9
         ypZ4H7BylLRc+v+krbRjM8XgmYAf7TrBC8oyIzENFWmpGwB85ChfejMhr3a7xhSzUcaE
         c6rDL5N3Y8Vc2vsWhtWjhqBLt34/IqLjpbNJ2gZC/24AcOqQ+mWk9ud06Za68iX1KHeN
         uQKAKkCmwCENqP5mSR7U+N4GZXZiRVAa7yBamhgovc66KP9t5eJIEnHL0aKPlReKH4Ap
         pOGQ==
X-Gm-Message-State: APjAAAWPhCN0sKSm5KCAgVXIFwqEwmhYEXukMpwaTojPCaZkl+ZL7j6k
        RG20xQvL96QxSouNabX6VOG3t3QJBKm3uNWuQXvgAQ==
X-Google-Smtp-Source: APXvYqxH9YNJe5L8BxMqoB1aZ+mLyrbeKewaHX+sfn84IGKLFUtHvCbxNr7Nz7Mt9VNZMqmAAHeTZG/lcpsKaNbOTFE=
X-Received: by 2002:a0c:f8d1:: with SMTP id h17mr7099085qvo.80.1575545267533;
 Thu, 05 Dec 2019 03:27:47 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003e640e0598e7abc3@google.com> <41c082f5-5d22-d398-3bdd-3f4bf69d7ea3@redhat.com>
 <CACT4Y+bCHOCLYF+TW062n8+tqfK9vizaRvyjUXNPdneciq0Ahg@mail.gmail.com>
 <f4db22f2-53a3-68ed-0f85-9f4541530f5d@redhat.com> <CACT4Y+ZHCmTu4tdfP+iCswU3r6+_NBM9M-pAZEypVSZ9DEq3TQ@mail.gmail.com>
 <e03140c6-8ff5-9abb-1af6-17a5f68d1829@redhat.com>
In-Reply-To: <e03140c6-8ff5-9abb-1af6-17a5f68d1829@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Dec 2019 12:27:35 +0100
Message-ID: <CACT4Y+YopHoCFDRHCE6brnWfHb5YUsTJS1Mc+58GgO8CDEcgHQ@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI <dri-devel@lists.freedesktop.org>, ghalat@redhat.com,
        Gleb Natapov <gleb@kernel.org>, gwshan@linux.vnet.ibm.com,
        "H. Peter Anvin" <hpa@zytor.com>, James Morris <jmorris@namei.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KVM list <kvm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Russell Currey <ruscur@russell.cc>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, stewart@linux.vnet.ibm.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 11:53 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 05/12/19 11:31, Dmitry Vyukov wrote:
> >> Ah, and because the machine is a KVM guest, kvm_wait appears in a lot of
> >> backtrace and I get to share syzkaller's joy every time. :)
> > I don't see any mention of "kvm" in the crash report.
>
> It's there in the stack trace, not sure if this is what triggered my Cc:
>
>  [<ffffffff810c7c3a>] kvm_wait+0xca/0xe0 arch/x86/kernel/kvm.c:612
>
> Paolo


Oh, you mean the final bisection crash. Indeed it contains a kvm frame
and it turns out to be a bug in syzkaller code that indeed
misattributed it to kvm instead of netfilter.
Should be fixed now, you may read the commit message for details:
https://github.com/google/syzkaller/commit/4fb74474cf0af2126be3a8989d770c3947ae9478

Overall this "making sense out of kernel output" task is the ultimate
insanity, you may skim through this file to get a taste of amount of
hardcoding and special corner cases that need to be handled:
https://github.com/google/syzkaller/blob/master/pkg/report/linux.go
And this is never done, such "exception from exception corner case"
things pop up every week. There is always something to shuffle and
tune. It only keeps functioning due to 500+ test cases for all
possible insane kernel outputs:
https://github.com/google/syzkaller/tree/master/pkg/report/testdata/linux/report
https://github.com/google/syzkaller/tree/master/pkg/report/testdata/linux/guilty

So thanks for persisting and questioning! We are getting better with
each new test.
