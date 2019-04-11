Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23426C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E939F20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="WCGa4p4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDKSJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:09:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51867 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKSJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:09:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so7884744wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=RyNIcjSEvWpOfhtp8Z2KIa1iEmnwUnKyV7zjTKLL414=;
        b=WCGa4p4kINepItpNdnwdTHcuJrc8Q5AWj+c4jd6L/1NAjg2aDKacOPAM3L4671+oXp
         RjtCyf+ryAecLgwpXbBlBMmPDTxiDJ+mxAQcO1zzPE/3koMsA4kXFS89KuBc4F9VYl0Q
         UioWSphj7f2HhDoU36hsf+r6pG1DMpAHq6kBIhBarzYknOmB+tBvz96Cut+8jbWdvogE
         dS1fRyQ2cAq9aYgJPDXjgq1JpFBVXUhjACgCMWFIjnMD/Yqs7i8IXKEsQ3EtzX7QoYVF
         VPQBcLHZV5rVhLrK/av8BbJ7rTdpokHEee1arLdarKW9Ge1qxmDyxQH5eIpsk8mbQBXm
         WO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=RyNIcjSEvWpOfhtp8Z2KIa1iEmnwUnKyV7zjTKLL414=;
        b=m5HzKZE6CyjoudaGVn0p4JqSHUmzJ0Y4N8FJeMapqP7uwn3IaHzMlMv+usSFBEf+pu
         pxmmrkoaivyznciaX0Zu7zs3weI/Ywa0OHu/C++FnjEargKMrKo7mEeY0gTIHTQCc2TP
         h0jB3BS6CVq2lLum+QJjnHf7/HDLIuwEW+zxVxBddk/yqTfvfzzkRiOR0rPkYbeEYZjI
         jUEpHvV2MzNpbiWIHObPB2PYGymuQf4pgTNq3NDOWL9y+NE2Tgrw+EjfUY1lY6ZNx5rm
         tq6TUKk8+Y4YDvYcihDueUZQXyfzCC3wBnyOzej4o0CuGzLCvcBiVbewBBn+sXums7d/
         tFOA==
X-Gm-Message-State: APjAAAU+X8ElmIwCA5ZerRg2kv22/ozP50VDKV7Uv3NsF2PiL/TXZOcZ
        K/k3aKvdGu/ZbcsirCTGy1nJrw==
X-Google-Smtp-Source: APXvYqwAPF289oEte+xokkZeaFqCEyQga0Bi6IGeQdw5lmJ/Od762jl6kW4qRjm87OLmssxzJobQEw==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr7187827wmh.13.1555006154579;
        Thu, 11 Apr 2019 11:09:14 -0700 (PDT)
Received: from [192.168.88.118] (x4db77fd8.dyn.telefonica.de. [77.183.127.216])
        by smtp.gmail.com with ESMTPSA id t15sm39930464wrx.22.2019.04.11.11.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:09:13 -0700 (PDT)
Date:   Thu, 11 Apr 2019 20:09:12 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wifyY+XGNW=ZC4MyTHD14w81F8JjQNH-GaGAm2RxZ_S8Q@mail.gmail.com>
References: <20190410234045.29846-1-christian@brauner.io> <CAHk-=wifyY+XGNW=ZC4MyTHD14w81F8JjQNH-GaGAm2RxZ_S8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] fork: add CLONE_PIDFD
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <645D6280-C442-4ECF-84DC-24788D1E57FF@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 11, 2019 6:50:47 PM GMT+02:00, Linus Torvalds <torvalds@linux-foun=
dation=2Eorg> wrote:
>On Wed, Apr 10, 2019 at 4:43 PM Christian Brauner
><christian@brauner=2Eio> wrote:
>>
>> RFC-2:
>> This alternative patchset uses anonymous file descriptors instead of
>> file descriptors from /proc/<pid>=2E
>
>I think I prefer this one=2E Your diffstat makes it look bigger, but
>that's because you added the example code to use this to that rfc=2E=2E

Jann and I think this is the correct way to proceed as well=2E
And this will be way more acceptable for Al too we think=2E
I have spoken to Joel just now and he's
happy to change RFC patchsets related to
pidfds he has to the anon inode approach as well=2E
I'll take care to do the necessary coordination before anything
gets sent your way before the next merge window=2E

>
>Plus making anon_inodes unconditional makes sense anyway=2E  They are
>always selected in practice to begin with=2E

Yes, indeed=2E I coordinated this with David and Al=2E
They need anonymous inodes for the mount API as well
and thus need anon inodes useable in core vfs functions=2E

Christian

