Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513B9C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2664524652
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlTrzQir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfLEKWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:22:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50914 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728794AbfLEKW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575541347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HaIFegi+0Clb4nOD0Kmjt0kKgC/aYqjcyu4Ow354nhs=;
        b=AlTrzQir4JWInpL9EkmZTHlUljf8NACOfC1zqZygvX8ygbD9zFnHbvMWZqbShensWFZ9Sk
        5hNOQHmHAoSpMLecCb13w1T93iS6Eh2Wlqt/J4G87H48NnXgw9qK8Iloj68djUpobF13Ur
        mlEKJ70LNKjZE0oiueHOBBQFFNk0bb0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-TeeYIHYxMg223WjOhVlOjQ-1; Thu, 05 Dec 2019 05:22:25 -0500
Received: by mail-wm1-f69.google.com with SMTP id f4so707055wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 02:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HaIFegi+0Clb4nOD0Kmjt0kKgC/aYqjcyu4Ow354nhs=;
        b=KempqS+oUnU6vPeZhvg+GffWG+Ng9ANNfnU51FWKEwGHCFLEn7GfCgGUP5Bom0z0N6
         BHZnOTfrPbJdrHiVx9WRqvSdU/aIbQ48AfHrBjVZ25CNNzv1vfry5j0vjdxfKuFcCNXt
         m+NAKBWvf5onx1jjIhwRnyBBNWYXJoBvIDDhM5dtIqfs0PNzDOXN/ninKpWbvTpu7N1x
         2O0JefrwiFrdIGwkFpSKHGE0sVMJ2Dmm3viTosiGlV825sjfHpZCiCj4ESHPsoVDDMq6
         nVMtO+PqIm6190bHVZerlZPaknUISdDi+1cRna6vrdSFThdB+1V7nkx4AxSBZLSTJNwM
         Ggfg==
X-Gm-Message-State: APjAAAW69NGeYoSaEi3ffUhEyJpVVit3AonveVhvRv8ipHZ7QnRU+iAh
        mdy/+4RltMwBP1NQWTbEswzNBhUs/SmtLhEyvHpbPjwKHCHo75MDbAmOUUByZShWJ46K28bYneZ
        LiOV5TyETsPsnURCPCZ62E1CH
X-Received: by 2002:a05:600c:d7:: with SMTP id u23mr3707003wmm.145.1575541344298;
        Thu, 05 Dec 2019 02:22:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIBQBRqyvopjnTZJ1NeKsKZIwQ0OV7bU/UZtQCKNf5+J4JDf0f71xe1rLVBcdblu3GRJ9yUA==
X-Received: by 2002:a05:600c:d7:: with SMTP id u23mr3706957wmm.145.1575541344042;
        Thu, 05 Dec 2019 02:22:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:541f:a977:4b60:6802? ([2001:b07:6468:f312:541f:a977:4b60:6802])
        by smtp.gmail.com with ESMTPSA id c1sm11635129wrs.24.2019.12.05.02.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 02:22:23 -0800 (PST)
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
To:     Dmitry Vyukov <dvyukov@google.com>
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
        the arch/x86 maintainers <x86@kernel.org>
References: <0000000000003e640e0598e7abc3@google.com>
 <41c082f5-5d22-d398-3bdd-3f4bf69d7ea3@redhat.com>
 <CACT4Y+bCHOCLYF+TW062n8+tqfK9vizaRvyjUXNPdneciq0Ahg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4db22f2-53a3-68ed-0f85-9f4541530f5d@redhat.com>
Date:   Thu, 5 Dec 2019 11:22:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bCHOCLYF+TW062n8+tqfK9vizaRvyjUXNPdneciq0Ahg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: TeeYIHYxMg223WjOhVlOjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/19 11:16, Dmitry Vyukov wrote:
> On Thu, Dec 5, 2019 at 11:13 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 04/12/19 22:41, syzbot wrote:
>>> syzbot has bisected this bug to:
>>>
>>> commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
>>> Author: Russell Currey <ruscur@russell.cc>
>>> Date:   Mon Feb 8 04:08:20 2016 +0000
>>>
>>>     powerpc/powernv: Remove support for p5ioc2
>>>
>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127a042ae00000
>>> start commit:   76bb8b05 Merge tag 'kbuild-v5.5' of
>>> git://git.kernel.org/p..
>>> git tree:       upstream
>>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=117a042ae00000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=167a042ae00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
>>> dashboard link:
>>> https://syzkaller.appspot.com/bug?extid=4455ca3b3291de891abc
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11181edae00000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105cbb7ae00000
>>>
>>> Reported-by: syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com
>>> Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")
>>>
>>> For information about bisection process see:
>>> https://goo.gl/tpsmEJ#bisection
>>>
>>
>> Why is everybody being CC'd, even if the bug has nothing to do with the
>> person's subsystem?
> 
> The To list should be intersection of 2 groups of emails: result of
> get_maintainers.pl on the file identified as culprit in the crash
> message + emails extracted from the bisected to commit.

Ah, and because the machine is a KVM guest, kvm_wait appears in a lot of
backtrace and I get to share syzkaller's joy every time. :)

This bisect result is bogus, though Tetsuo found the bug anyway.
Perhaps you can exclude commits that only touch architectures other than
x86?

Paolo

