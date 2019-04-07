Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B14CC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A8E2084F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="YNkqkkPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfDGJ2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 05:28:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38259 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDGJ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 05:28:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so5566122pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 02:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uFYLvSxEIBgYtMKaj/ypzTQtcpWXVCK+99ol/GIJUfk=;
        b=YNkqkkPjeLuAMOyiu0WYBoAW3k98JJaQQYZjM2v8jBcU6JJocmRPYKnBBD70Xffl3M
         xuhkUCz+5xF4hY6+9fovhGuH7cxWD0TN5W7UDhSlt/W7VTBHSFJKmOEGcGU5ZOYAmlsk
         aHPYY8WaT3UJFxBlv/qE76FEh1N1naIq0cV7DMHxd/6VWsNlr9w8h/shsL0ggb1dtUrO
         UKo5Js7ooj7CJbdAD+TJtBoerc4rT5ptvnefhvrD3bfst93Iqwj8Fgtr98xyQ3h+Yy1z
         dzFIzxAGBjzDoxjrwoK5+xU4YN2Ets/Mue5eE2J+8uR4jWuNolGlmass8XeH/nGXAHJa
         w33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uFYLvSxEIBgYtMKaj/ypzTQtcpWXVCK+99ol/GIJUfk=;
        b=jAM8Fh2sYqwjVByA/CgFqt4XWojI7mHTx4O5Z1DctKOyZCWm0i+cqW8nINr8t+8yV0
         9POk1J4ETDDEx7JIk9Own0BDb7IFlvGQ/edwW8hVsI/17zUJQYivvtLGJw/IHmb4/XUO
         AGxzUrzNHFXawfwv/KY1/fuBDl+KmpdPHSaiQBM6j/q2GT2c+ZxK4nWWAsGPgWlJn3qL
         4UcfW+nBmN2nvknh52c+9Li1SWGFzvm7O02RqvoP6EtruIH9fkDnUjJHMSDhwVNUCK/A
         qhnGeaYtXuNYAzPTcYHtDKuNXSdPxMqTUl3xrBwg8pHkmx4ns8WzVtVFlRazSCQ2K+5E
         nYJQ==
X-Gm-Message-State: APjAAAUsG7G9dXIVK/rPP7WzQRFsDzIHb3sj0t3Z9vlFXQRquwXkBSXr
        W8n8+LBnSShzJFpI35851GVzPA==
X-Google-Smtp-Source: APXvYqzUZT1ogOoGldpnwogQesJoWnUHsgI+2x/qKnrfoKrFOkRare+uEOVqfKGNWWnhznWw1mgSbA==
X-Received: by 2002:a62:14c3:: with SMTP id 186mr23469137pfu.21.1554629289007;
        Sun, 07 Apr 2019 02:28:09 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:8daf:800d:46cf:9ade? ([2601:646:c200:1ef2:8daf:800d:46cf:9ade])
        by smtp.gmail.com with ESMTPSA id o81sm6923606pfa.156.2019.04.07.02.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 02:28:08 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch V2 28/29] x86/irq/64: Remap the IRQ stack with guard pages
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <alpine.DEB.2.21.1904070803200.1840@nanos.tec.linutronix.de>
Date:   Sun, 7 Apr 2019 02:28:07 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <50F7A079-11F5-45EA-B378-7527B5920A7C@amacapital.net>
References: <20190405150658.237064784@linutronix.de> <20190405150930.967389183@linutronix.de> <CALCETrWF_YgQODJ=Rpm2MnhFxJXCfoo4H792hUQni0GS9on7og@mail.gmail.com> <alpine.DEB.2.21.1904070803200.1840@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 6, 2019, at 11:08 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Sat, 6 Apr 2019, Andy Lutomirski wrote:
>>> On Fri, Apr 5, 2019 at 8:11 AM Thomas Gleixner <tglx@linutronix.de> wrot=
e:
>>>=20
>>> From: Andy Lutomirski <luto@kernel.org>
>>>=20
>>> The IRQ stack lives in percpu space, so an IRQ handler that overflows it=

>>> will overwrite other data structures.
>>>=20
>>> Use vmap() to remap the IRQ stack so that it will have the usual guard
>>> pages that vmap/vmalloc allocations have. With this the kernel will pani=
c
>>> immediately on an IRQ stack overflow.
>>=20
>> The 0day bot noticed that this dies with DEBUG_PAGEALLOC on.  This is
>> because the store_stackinfo() function is utter garbage and this patch
>> correctly detects just how broken it is.  The attached patch "fixes"
>> it.  (It also contains a reliability improvement that should probably
>> get folded in, but is otherwise unrelated.)
>>=20
>> A real fix would remove the generic kstack_end() function entirely
>> along with __HAVE_ARCH_KSTACK_END and would optionally replace
>> store_stackinfo() with something useful.  Josh, do we have a generic
>> API to do a little stack walk like this?  Otherwise, I don't think it
>> would be the end of the world to just remove the offending code.
>=20
> Yes, I found the same yesterday before heading out. It's already broken
> with the percpu stack because there is no guarantee that the per cpu stack=

> is thread size aligned. It's guaranteed to be page aligned not more.
>=20
> I'm all for removing that nonsense, but the real question is whether there=

> is more code which assumes THREAD_SIZE aligned stacks aside of the thread
> stack itself.
>=20
>=20

Well, any code like this is already busted, since the stacks alignment doesn=
=E2=80=99t really change with these patches applied.=
