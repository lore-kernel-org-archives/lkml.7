Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE438C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BF3208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="K4+DIabM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfFGQdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:33:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35160 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfFGQda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:33:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so1443341pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HcwcSPgb2LRTSBlVp16wxUn4yLqFThmUCJS2tDHezDY=;
        b=K4+DIabMx2B0RYXq11ezNJY3ksw/Zlt0hzGvAQ6CAb+Xe0pXe2ndfFb2bHtAsimfM1
         Pefzo+lf0yQYkVXOTQLJ6bEER05wokc/a/J54QWVp5u+SpfZwl7XOx+k3OhiPuzZ1R88
         dGaV6rKUNqmttDGW0TqtyWZE0DUYjIp1QV+uT6/WM1vKg0BZVEHxXUB7AAS/pcL8v9M+
         CSR/+K+kjMlq0fUeSAcBOEqPIMcf1l+1wshU3tSN7Mm8jac+f9gM8VvZenUHAIMWQedB
         sf6sdkJ64RsgfuDLIsupC4fL/Dzd84javsv4mjtJDYbdbUUeylWg3YU5bNDqbJLRw0nZ
         H3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HcwcSPgb2LRTSBlVp16wxUn4yLqFThmUCJS2tDHezDY=;
        b=fGF8z7iGVL2ZqLuekd7om4uW7av5Z068M1w+ZKm35sEYU9VTiUyzyMuQxDtVy7qEXn
         sTl/vdF22HEO1utO2ZGKLBATIG5Ts08GAnQ90h5TFPibhJCNIVa04V9G7R+VWiw3jxoN
         zOw8rFQIQprv9vv2Oy3O9Oia/ig8uBnnwD4lTLQghMR8usTc2es+2H35pAVIhvu8qBbJ
         3/7Ra7eKo5dLf8oJuGDRJXgS1NKRqkqb5G39+O6elTwsFdaReghqYJ0FwnY/Po2OhWE1
         ublehF42cfg9m6UaNbA3JPPqZHHyXEPqEP6JQQ1zC91FTBdwyi7q+8XUokfHRyzBP8Wk
         Ey2A==
X-Gm-Message-State: APjAAAX9Nv90/R+jqiXniPmT887jcyusjWDqHonXTHZKp0flyQxSKhMC
        E7dmqUTcLl31ZmPGm9rAgIGxOQ==
X-Google-Smtp-Source: APXvYqxAu0mI9CxbJoVlBxk+om0zTRQe2LZ0q7P5FIAadF9RE08ri9N9d2Jr1r6l01vHLyHmASSMcg==
X-Received: by 2002:a63:fb05:: with SMTP id o5mr3727724pgh.203.1559925209855;
        Fri, 07 Jun 2019 09:33:29 -0700 (PDT)
Received: from ?IPv6:2600:1012:b044:6f30:60ea:7662:8055:2cca? ([2600:1012:b044:6f30:60ea:7662:8055:2cca])
        by smtp.gmail.com with ESMTPSA id b35sm2616154pjc.15.2019.06.07.09.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 09:33:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 10/15] static_call: Add basic static call infrastructure
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <CAKv+Gu-rsZ2UsyEHbsZcSv9VVnFBqG70q+vk6thgMGFBi+vLSA@mail.gmail.com>
Date:   Fri, 7 Jun 2019 09:33:27 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D3C14BB-6830-46E1-A9E2-D8EBD7E3A2FA@amacapital.net>
References: <20190605130753.327195108@infradead.org> <20190605131945.125037517@infradead.org> <DD54886F-77C6-4230-A711-BF10DD44C52C@vmware.com> <20190607082851.GV3419@hirez.programming.kicks-ass.net> <CAKv+Gu-rsZ2UsyEHbsZcSv9VVnFBqG70q+vk6thgMGFBi+vLSA@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 7, 2019, at 1:49 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wro=
te:
>=20
>> On Fri, 7 Jun 2019 at 10:29, Peter Zijlstra <peterz@infradead.org> wrote:=

>>=20
>> On Thu, Jun 06, 2019 at 10:44:23PM +0000, Nadav Amit wrote:
>>>> + * Usage example:
>>>> + *
>>>> + *   # Start with the following functions (with identical prototypes):=

>>>> + *   int func_a(int arg1, int arg2);
>>>> + *   int func_b(int arg1, int arg2);
>>>> + *
>>>> + *   # Define a 'my_key' reference, associated with func_a() by defaul=
t
>>>> + *   DEFINE_STATIC_CALL(my_key, func_a);
>>>> + *
>>>> + *   # Call func_a()
>>>> + *   static_call(my_key, arg1, arg2);
>>>> + *
>>>> + *   # Update 'my_key' to point to func_b()
>>>> + *   static_call_update(my_key, func_b);
>>>> + *
>>>> + *   # Call func_b()
>>>> + *   static_call(my_key, arg1, arg2);
>>>=20
>>> I think that this calling interface is not very intuitive.
>>=20
>> Yeah, it is somewhat unfortunate..
>>=20
>=20
> Another thing I brought up at the time is that it would be useful to
> have the ability to 'reset' a static call to its default target. E.g.,
> for crypto modules that implement an accelerated version of a library
> interface, removing the module should revert those call sites back to
> the original target, without putting a disproportionate burden on the
> module itself to implement the logic to support this.

I was thinking this could be a layer on top.  We could have a way to registe=
r a static call with the module core so that, when a GPL module with an appr=
opriate symbol is loaded, the static call gets replaced.

KVM could use this too.  Or we could just require KVM to be built in some da=
y.
