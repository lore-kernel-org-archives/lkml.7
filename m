Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CB1C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEEF20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="m/Dmg/JW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfITTwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 15:52:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38557 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbfITTwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:52:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so5212028pfe.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=gcNXvtSyWvuQ5LByHh2uePUN26jQ3PokWQXYeNMdTRo=;
        b=m/Dmg/JW+4n89iQLkwR9YixMDIeVf27zFQCHMeU2vrr/Vf/mPOfxnNvPfe3OPGVCIb
         JgAPKsXQJhnD7tFI5MlKzN2xVjy8lP1etFfFQJ6uqTzpoQ2zt6AqXypDzmNHpc8wPlxV
         crjt8+KJWIThyAPCT4EQPrvHrdHbinVspic5j9BKz5RbkcHdT9crv3tv4qpn/aE9eA1n
         PMBQ0OAdva2QoUZMRO40b1D4dh+MZ0oPBPl/uwt1PjK41QI5n4GP65bK/tOOocfdaOPb
         fW7AswBfwe7B/XRzdJs+JsavsZIwjqyEid+QSgHJFI3Ye2MQDRaVklFCyYyobPXtLX0a
         K9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=gcNXvtSyWvuQ5LByHh2uePUN26jQ3PokWQXYeNMdTRo=;
        b=ICeLVFOmtR1dL2noB+miocN39MeYc7SFABIc7oWjv9WZ8ZfaSt0XvMcHFp2SvEc0tR
         AOXj9uZIGqMNDiz/gsZeuvZNMRnfrATy+UEd/F4kq7b4WkODEGm+aeDZBnnooF2zPVrz
         gmGoBUyEPv2stWoDa+LG8EWDQjwr02e4HnIe2KfPTbzcqxphC9WdynagayREUNCWngkU
         hbJh5vKtq4nT02tMswIVl4m/WUlMqozVZyDZubt2PcbDTh+dcNFFa+NgKVjIZ7MLF16P
         WW23AOIn41R7lYhmmu4dqcGVdru6kJh/GtG3V2Tol3fqUFNrU26z/AcMrbGOXS2yLt3J
         0dOw==
X-Gm-Message-State: APjAAAX2MIGs9cmh4gdADLrd3EE35HtaSXikIf2dbsVs8ibqUmK35adh
        kq/o7c8+IRxQdT+tYM/8qHncHg==
X-Google-Smtp-Source: APXvYqxtb4M5gtpX7qWD4dcjCAwsr874h41gGdjXYxHCsHqxUWbY1aFs2BvIpYyEDF4qF+PsPWIWvw==
X-Received: by 2002:a62:cb:: with SMTP id 194mr20209663pfa.130.1569009150487;
        Fri, 20 Sep 2019 12:52:30 -0700 (PDT)
Received: from ?IPv6:2600:1010:b006:e11f:c970:783e:78af:e8f5? ([2600:1010:b006:e11f:c970:783e:78af:e8f5])
        by smtp.gmail.com with ESMTPSA id c20sm5107273pfd.122.2019.09.20.12.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 12:52:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and introduce getrandom2()
Date:   Fri, 20 Sep 2019 12:52:28 -0700
Message-Id: <C5BE6F0F-15B1-404B-A490-5B4E5C8C61A0@amacapital.net>
References: <20190920193740.GD1889@1wt.eu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
In-Reply-To: <20190920193740.GD1889@1wt.eu>
To:     Willy Tarreau <w@1wt.eu>
X-Mailer: iPhone Mail (17A577)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 20, 2019, at 12:37 PM, Willy Tarreau <w@1wt.eu> wrote:
>=20
> =EF=BB=BFOn Fri, Sep 20, 2019 at 12:22:17PM -0700, Andy Lutomirski wrote:
>> Perhaps userland could register a helper that takes over and does
>> something better?
>=20
> If userland sees the failure it can do whatever the developer/distro
> packager thought suitable for the system facing this condition.
>=20
>> But I think the kernel really should do something
>> vaguely reasonable all by itself.
>=20
> Definitely, that's what Linus' proposal was doing. Sleeping for some time
> is what I call "vaguely reasonable".

I don=E2=80=99t buy it. We have existing programs that can deadlock on boot.=
 Just throwing -EAGAIN at them in a syscall that didn=E2=80=99t previously b=
lock does not strike me as reasonable.

>=20
>> If nothing else, we want the ext4
>> patch that provoked this whole discussion to be applied,
>=20
> Oh absolutely!
>=20
>> which means
>> that we need to unbreak userspace somehow, and returning garbage it to
>> is not a good choice.
>=20
> It depends how it's used. I'd claim that we certainly use randoms for
> other things (such as ASLR/hashtables) *before* using them to generate
> long lived keys thus we can have a bit more time to get some more
> entropy before reaching the point of producing these keys.

The problem is that we don=E2=80=99t know what userspace is doing with the o=
utput from getrandom(..., 0), so I think we have to be conservative. New ker=
nels need to work with old user code. It=E2=80=99s okay if they=E2=80=99re s=
lower to boot than they could be.

>=20
>> Here are some possible approaches that come to mind:
>>=20
>> int count;
>> while (crng isn't inited) {
>>  msleep(1);
>> }
>>=20
>> and modify add_timer_randomness() to at least credit a tiny bit to
>> crng_init_cnt.
>=20
> Without a timeout it's sure we'll still face some situations where
> it blocks forever, which is the current problem.

The point is that we keep the timer running by looping like this, which shou=
ld cause add_timer_randomness() to get called continuously, which should pre=
vent the deadlock.  I assume the deadlock is because we go into nohz-idle an=
d we sit there with nothing happening at all.

>=20
>> Or we do something like intentionally triggering readahead on some
>> offset on the root block device.
>=20
> You don't necessarily have such a device, especially when you're
> in an initramfs. It's precisely where userland can be smarter. When
> the caller is sfdisk for example, it does have more chances to try
> to perform I/O than when it's a tiny http server starting to present
> a configuration page.

What I mean is: allow user code to register a usermode helper that helps get=
 entropy. Or just convince distros to bundle some useful daemon that starts a=
t early boot and lives in the initramfs.

