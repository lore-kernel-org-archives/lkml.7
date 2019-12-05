Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B73C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5B320707
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Su291t1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfLEL3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:29:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20566 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729260AbfLEL32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 06:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575545367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbaSGfutZwhZA116gvr95IAUlIVoaJxPvvW+eFCW8zI=;
        b=Su291t1eGFT3SH7xXcP17RW8wQuyFCu4TV9qt0BLkuATFaEkUK5NsqLXAalYNDNodetJ/N
        PCq3U3g8ojkuFduB+z+iQQBX/xkJ44jerbjNnfJ6zMWm4xRTWZ97j117R8Eu9BNori8ELF
        2xdEwKvQOywMDyuLc/XkD6LZgelWyxg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-AOQQ6ZUNOFajVLI066qgGw-1; Thu, 05 Dec 2019 06:29:24 -0500
Received: by mail-wr1-f70.google.com with SMTP id j13so1389727wrr.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 03:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lbaSGfutZwhZA116gvr95IAUlIVoaJxPvvW+eFCW8zI=;
        b=unWAFwfEoX/2zwvh0ortyAvHs+zVRvDoTQm1hOppSaoWABY5a7oRKM8l40OKFEdFAe
         /vX7OYTGNZY79DS6S6M6E0iQDbjOB6DaLynEEuQ/G2vJhGBiBeqq8anOMhIcwGA8p/1F
         bRxR1l5pXjyRGrwRt0rBGzZ1z66filynVtyoMjYhWpsvJUKQLM4EgE98xD2ij0+9pj4A
         b7xBkN3NbAePJRKxwGzkcwddnREGBk8hYiHjXkTMhQBLJNM/119a37UeQFtv6fErNw2x
         l/o1KacjefI1aRADcuQ2J+AdH49thEE1E5sKyB+0aFlTq5RxvgBKlIGtf0vIAfxHDL8P
         +NUQ==
X-Gm-Message-State: APjAAAXWZO4xQMDpcspHZFf4jcABXWWWsusN69w0RVkvH9PQOCkBs1D7
        vzGc5OuwhljJg/J2ss6GiuX0RaOwn9qHwJVXaHhSVkbLQWXWfokgSmnM20SbDj/BL60F07p/Vnw
        SerNAGB0uIaJbTPGZDHyGsQ+l
X-Received: by 2002:a1c:1dc4:: with SMTP id d187mr4900398wmd.46.1575545363049;
        Thu, 05 Dec 2019 03:29:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9Xt8ZW3hE0/KfrEcZYT8qrPPraxHN0nr72IWYS5MoUhQN15mYYzXu7Q6Ai0EaHlN2GKcQ5w==
X-Received: by 2002:a1c:1dc4:: with SMTP id d187mr4900356wmd.46.1575545362806;
        Thu, 05 Dec 2019 03:29:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:541f:a977:4b60:6802? ([2001:b07:6468:f312:541f:a977:4b60:6802])
        by smtp.gmail.com with ESMTPSA id e18sm11632611wrr.95.2019.12.05.03.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 03:29:22 -0800 (PST)
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
 <f4db22f2-53a3-68ed-0f85-9f4541530f5d@redhat.com>
 <CACT4Y+ZHCmTu4tdfP+iCswU3r6+_NBM9M-pAZEypVSZ9DEq3TQ@mail.gmail.com>
 <e03140c6-8ff5-9abb-1af6-17a5f68d1829@redhat.com>
 <CACT4Y+YopHoCFDRHCE6brnWfHb5YUsTJS1Mc+58GgO8CDEcgHQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf93410c-7e59-a679-c00d-5333a9879128@redhat.com>
Date:   Thu, 5 Dec 2019 12:29:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YopHoCFDRHCE6brnWfHb5YUsTJS1Mc+58GgO8CDEcgHQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: AOQQ6ZUNOFajVLI066qgGw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/19 12:27, Dmitry Vyukov wrote:
> Oh, you mean the final bisection crash. Indeed it contains a kvm frame
> and it turns out to be a bug in syzkaller code that indeed
> misattributed it to kvm instead of netfilter.
> Should be fixed now, you may read the commit message for details:
> https://github.com/google/syzkaller/commit/4fb74474cf0af2126be3a8989d770c3947ae9478
> 
> Overall this "making sense out of kernel output" task is the ultimate
> insanity, you may skim through this file to get a taste of amount of
> hardcoding and special corner cases that need to be handled:
> https://github.com/google/syzkaller/blob/master/pkg/report/linux.go
> And this is never done, such "exception from exception corner case"
> things pop up every week. There is always something to shuffle and
> tune. It only keeps functioning due to 500+ test cases for all
> possible insane kernel outputs:
> https://github.com/google/syzkaller/tree/master/pkg/report/testdata/linux/report
> https://github.com/google/syzkaller/tree/master/pkg/report/testdata/linux/guilty
> 
> So thanks for persisting and questioning! We are getting better with
> each new test.

Thanks to you!  I "complain" because I know you're so responsive. :)

Paolo

