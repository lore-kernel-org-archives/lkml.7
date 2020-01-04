Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482F9C32767
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 05:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2724217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 05:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="qxFotJ6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgADFwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 00:52:11 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33105 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgADFwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 00:52:10 -0500
Received: by mail-pj1-f66.google.com with SMTP id u63so3275821pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 21:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=lsjJu+EGZojghLrX4ddsw+K5AnhnZ8PjIQovTm/oOmU=;
        b=qxFotJ6x1F4rGcRSERuDHRyqE7DBaXL3SH79DzRupTipxGDHuAXiqUnZhJq9ndjsu9
         2bf7r2R/IgO9l9e7G72q2Db4fEbz/XVh/YTalI0uQCjXoipjAylw+h+0ZPuiWjagEzuz
         EUskdvGdVLB6WhlB45xyrK9602eohnjyuetJBzYSCIiXsvhbYtIV3NTQSfVFwWCHSFRf
         nDH2okBELCvx9PqSnyqueAuAJ23qXLenkOaj0H910xnShH7HH+oWrMjjzx2iM7tH5XqN
         xI1N+y2W+f5rumgYi7HZJNFQqljQ+mEt0c1gGnGttu9R38uAzs2BN7xrluzwIFmDztQv
         v6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=lsjJu+EGZojghLrX4ddsw+K5AnhnZ8PjIQovTm/oOmU=;
        b=K9irWouNDDFQR1XD4iJ6XKVfn1OJFnYWDslLAtQycLWDREEPk6cdl78P7r4HxmhafI
         A7uzHlQwjt/H8j/5winDaYVeiyN3okpy6k0UTg9VYba+feItdWo/RpxWPJm6lHPn1d9j
         w66RtNbHxsVukQRQsFHn1OyfQTf9Jsxu4LALBMQym7pjNzVDa8io2daCI/a/12j+rpaZ
         EH7toTeXCX5j5SzAjmBeQPBQUYDRSWfCNdDLfbT77Guj6GDT5F0nHQrsOllQ7N9N9kep
         UcvrQi10MGoDqlg7mZumk7adX/vhTpctXm9HLwrmzYsI9pUu9bR1RJtTbgfRu3T2dEac
         V2jw==
X-Gm-Message-State: APjAAAXg3gWZKNkxf47RL3hHOWdV0IwwoEWfGqqddgGb7ry176J2z2UP
        TmjYWHbxE4Nk/KLSiNzgkM7dzA==
X-Google-Smtp-Source: APXvYqxDUza2vBLfx8WAKGyjzbrpILbRtIRJnsUK2U3N3tk5x+03IayI4U7f/qILlO+0FZ3sWtC5HQ==
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr92696786plq.79.1578117129583;
        Fri, 03 Jan 2020 21:52:09 -0800 (PST)
Received: from [25.171.60.22] ([172.58.27.167])
        by smtp.gmail.com with ESMTPSA id b128sm65193420pga.43.2020.01.03.21.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 21:52:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 0/1] mount: universally disallow mounting over symlinks
Date:   Sat, 4 Jan 2020 14:52:03 +0900
Message-Id: <52B30961-5933-46D4-87A7-4056892959E8@amacapital.net>
References: <20200101144407.ugjwzk7zxrucaa6a@yavin.dot.cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>, dev@opencontainers.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200101144407.ugjwzk7zxrucaa6a@yavin.dot.cyphar.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 1, 2020, at 11:44 PM, Aleksa Sarai <cyphar@cyphar.com> wrote:
>=20
> =EF=BB=BFOn 2020-01-01, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>> On Wed, Jan 01, 2020 at 12:54:46AM +0000, Al Viro wrote:
>>> Note, BTW, that lookup_last() (aka walk_component()) does just
>>> that - we only hit step_into() on LAST_NORM.  The same goes
>>> for do_last().  mountpoint_last() not doing the same is _not_
>>> intentional - it's definitely a bug.
>>>=20
>>> Consider your testcase; link points to . here.  So the only
>>> thing you could expect from trying to follow it would be
>>> the directory 'link' lives in.  And you don't have it
>>> when you reach the fscker via /proc/self/fd/3; what happens
>>> instead is nd->path set to ./link (by nd_jump_link()) *AND*
>>> step_into() called, pushing the same ./link onto stack.
>>> It violates all kinds of assumptions made by fs/namei.c -
>>> when pushing a symlink onto stack nd->path is expected to
>>> contain the base directory for resolving it.
>>>=20
>>> I'm fairly sure that this is the cause of at least some
>>> of the insanity you've caught; there always could be
>>> something else, of course, but this hole needs to be
>>> closed in any case.
>>=20
>> ... and with removal of now unused local variable, that's
>>=20
>> mountpoint_last(): fix the treatment of LAST_BIND
>>=20
>> step_into() should be attempted only in LAST_NORM
>> case, when we have the parent directory (in nd->path).
>> We get away with that for LAST_DOT and LOST_DOTDOT,
>> since those can't be symlinks, making step_init() and
>> equivalent of path_to_nameidata() - we do a bit of
>> useless work, but that's it.  For LAST_BIND (i.e.
>> the case when we'd just followed a procfs-style
>> symlink) we really can't go there - result might
>> be a symlink and we really can't attempt following
>> it.
>>=20
>> lookup_last() and do_last() do handle that properly;
>> mountpoint_last() should do the same.
>>=20
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>=20
> Thanks, this fixes the issue for me (and also fixes another reproducer I
> found -- mounting a symlink on top of itself then trying to umount it).
>=20
> Reported-by: Aleksa Sarai <cyphar@cyphar.com>
> Tested-by: Aleksa Sarai <cyphar@cyphar.com>
>=20
> As for the original topic of bind-mounting symlinks -- given this is a
> supported feature, would you be okay with me sending an updated
> O_EMPTYPATH series?

FWIW, I have an actual use case for mounting over a symlink: replacing /etc/=
resolv.conf.  My virtme tool is presented with somewhat arbitrary crud in /e=
tc, where /etc/resolv.conf might be a plain file or a symlink, but, regardle=
ss, has inappropriate contents. If it=E2=80=99s a file, I can mount a new fi=
le over it. If it=E2=80=99s a symlink and the kernel properly supported it, I=
 could also mount over it.

Yes, I could also use overlayfs.  Maybe I should regardless.
