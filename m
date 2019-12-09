Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C36C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFC324655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="AtitwyU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfLISnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:43:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46210 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfLISnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:43:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so7522028pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 10:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=IIH0mWEOKsrcmUy6W4S6vhOIAF99APXeNHDFU0+OuwU=;
        b=AtitwyU5jG9dUQgdTtVCGo+WvR+V5xoyOXDZnvs1Xma9x4r123GcU5mVq2ySCFO27j
         bp/826+4nJMux9V+IUJgYpLdDKC5BraO2w9IVzwB406YKaGsk631poHYEoGnWSpIfyWo
         uYyCIHrNASD0reSbdZqLgB+vV1uAmtBV1XhL0HAfAAbS4Tqp0MoTg//95jLuNNB8tfKl
         qPMvG+UirHZ0IpBISVMc9wMYj4Jf7FPt4dkUoW78W7gNnMnxhoi7/66HyEj46GLzLjNB
         rEXqVybTNZBWCO60EuWtp34Wu18BnPXGDJ8QujFJVWzHatSopGoUgnTPJTc53NWGKwi/
         BhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=IIH0mWEOKsrcmUy6W4S6vhOIAF99APXeNHDFU0+OuwU=;
        b=H3ew6NcqEySe0oI/GUz7xMaYoA9+K2WxOopmwMO+BUfaIdkaK5UrIE26We8B0QJKnq
         jcquBQBAYRvThxaEPHEZlHIMsIqOEILYU6utkD6kBhX2R+bNO2HIUnaocN8T+TC3G4iU
         ddhOwVzfvzKiMWLc/9FPG2iOEQg3OTZ1/kL5knLG1S52FS1AGaspvSN2SxxUTq4lTpid
         QkxSOLQP5gzD30T01qt7z2f2Y17M2Wl0kHj3Fdwff6kOx5wttaCI9HgzuzQhgtfizHwu
         2qDppis3yexx+LzFEuAIb3AO4SCIZ7E+/moBQ7TlVE0SllnmIIhpKYTPvVZLwLGTp/UB
         uaXA==
X-Gm-Message-State: APjAAAXjHq+Gm3teHiOBvzGxr9QPtoXCIylyjRynt1/lxGI+5OLL5Klj
        JW5yMFeRYjv9TMwFYzzzGP8TuA==
X-Google-Smtp-Source: APXvYqxzV/mu35PgMYvXJ8tR4re+h252qjg9YNYgXGnvNKzHqxJjS+0qR0RPmVMaDkNSG+YYcc0pGA==
X-Received: by 2002:a63:3245:: with SMTP id y66mr20161392pgy.234.1575917002492;
        Mon, 09 Dec 2019 10:43:22 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:e2:ee2:815a:30c4? ([2601:646:c200:1ef2:e2:ee2:815a:30c4])
        by smtp.gmail.com with ESMTPSA id a2sm200336pfg.90.2019.12.09.10.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 10:43:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: recvfrom/recvmsg performance and CONFIG_HARDENED_USERCOPY
Date:   Mon, 9 Dec 2019 10:43:19 -0800
Message-Id: <F6840B11-060A-48F2-9FFE-774E73C50765@amacapital.net>
References: <efffc167eff1475f94f745f733171d59@AcuMS.aculab.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <efffc167eff1475f94f745f733171d59@AcuMS.aculab.com>
To:     David Laight <David.Laight@aculab.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 9, 2019, at 3:01 AM, David Laight <David.Laight@aculab.com> wrote:
>=20
> =EF=BB=BFFrom: Eric Dumazet
>> Sent: 06 December 2019 14:22
> ...
>> Real question is : Do you actually need to use recvmsg() instead of recvf=
rom() ?
>> If recvmsg() provides additional cmsg, this is not surprising it is more e=
xpensive.
>=20
> Except I'm not passing in a buffer for it.
> The reason I'm looking at recvmsg is that I'd like to use recvmmsg it orde=
r to
> read out more than one message from a socket without doing an extra poll()=
.
> Note that I don't expect there to be a second message most of the time and=

> almost never a third one.
>=20
> Although I think that will only ever 'win' if recvmmsg() called vfs_poll()=
 to find
> if there was more data to read before doing any of the copy_from_user() et=
c

I would suggest a more general improvement: add a -EAGAIN fast path to recvm=
sg().  If the socket is nonblocking and has no data to read, then there shou=
ldn=E2=80=99t be a need to process the iovec at all.=
