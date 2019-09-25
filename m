Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760E3C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CAA21D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SgDZIWjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392447AbfIYUX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:23:59 -0400
Received: from mail.efficios.com ([167.114.142.138]:55638 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfIYUX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:23:58 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 003A3335761;
        Wed, 25 Sep 2019 16:23:57 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id LBlHnJZpY0h7; Wed, 25 Sep 2019 16:23:56 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8065233575E;
        Wed, 25 Sep 2019 16:23:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8065233575E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1569443036;
        bh=ViKW4NzIpnswzyjiD1653WROYeCjcGtkwj41YVwFB/M=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=SgDZIWjzmmgfVf335HcyRdKeRrcfgoZQI6WjgcDGKhUqNSdug72+wmrC37F8Y2AA4
         xKex3AtS3W+gi9eOqhWI8ReO1921WWq+8DiiqqowV1Bx+cotKJCvpnRfFRc3YBB2L0
         N96qhigu664dehfLIpCV2yxFFSoOuE1ti48SK7qkM1/v2clivYM+Rickftsy2VdbcR
         2c9zTP9GZYufhUuwai3Df6XpdFTFkdVziZzpZvHYy72DjoM/JzeBfJmQkfaIFfDt4C
         R5aGOLTXXz7P6+4y+xYImCAAFDgxcGVh2K0wwsgLl/Yl1RFPe5r8q688SUwCuEGZJA
         VCtt0EjeLMvfA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 4IoldEnO1V9B; Wed, 25 Sep 2019 16:23:56 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 69333335752;
        Wed, 25 Sep 2019 16:23:56 -0400 (EDT)
Date:   Wed, 25 Sep 2019 16:23:56 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeremie Galarneau <jeremie.galarneau@efficios.com>,
        s mesoraca16 <s.mesoraca16@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        dan carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        solar@openwall.com
Message-ID: <602562877.4777.1569443036262.JavaMail.zimbra@efficios.com>
In-Reply-To: <201909251307.B970AF1E7@keescook>
References: <CA+jJMxvkqjXHy3DnV5MVhFTL2RUhg0WQ-XVFW3ngDQOdkFq0PA@mail.gmail.com> <201909251307.B970AF1E7@keescook>
Subject: Re: Unmerged patches adding audit when protected_regular/fifos
 sysctl causes EACCES
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3847 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3847)
Thread-Topic: Unmerged patches adding audit when protected_regular/fifos sysctl causes EACCES
Thread-Index: WBhNDG+Gy0sph7FpgfF4D4INXFyLlw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 25, 2019, at 4:12 PM, Kees Cook keescook@chromium.org wrote:

> On Wed, Sep 25, 2019 at 02:58:28PM -0400, J=C3=A9r=C3=A9mie Galarneau wro=
te:
>> Hi Kees,
>>=20
>> I have noticed that the two top-most patches of your protected-creat
>> branch were never merged upstream [1]. Those patches add audit logs
>> whenever the protected_regular or protected_fifo sysctl prevent the
>> creation of a file/fifo.
>>=20
>> They were mentioned in the v4 thread [2] of the "main" patch and
>> seemed acceptable, but they were no longer mentioned in v5 [3], which
>> was merged.
>>=20
>> Now that systemd enables those sysctls by default (v241+), I got
>> bitten pretty hard by this check and it took me a while to figure out
>> what was happening [4]. I ended up catching it by adding a bunch of
>> printk(), including where you proposed to add an audit log statement.
>>=20
>> I just found your two patches while implementing what you proposed almos=
t 1:1.
>>=20
>> Was there a reason why those were abandoned? Otherwise, would you mind
>> resubmitting them?
>=20
> Hi!
>=20
> There was concern about getting buy-in from the audit folks delaying
> things even more. Instead of waiting for that, as it had already taken
> a long time to get consensus even on the functionality, they were
> dropped.
>=20
> I'll rebase them and send them out again; thanks for the ping!

If you need additional justification for why those are needed, here are
a few problematic scenarios we're observing in the current situation.
Feel free to use those if you need to add extra justification for your
audit patches commit messages.

A first scenario is a host with containers, where a container runs
userspace processes which depend on the open() behavior changed
by those sysctl. If the host is updated to systemd 241+, which enables
those sysctl by default, those containers will start misbehaving, and
figuring out the culprit without any hint in the kernel dmesg is far
from obvious.

A similar situation happens for non-containerized deployments. If an
application depends on this open() ABI behavior tweaked by those sysctl,
the application will start failing if it happens to run on a system
with systemd 241+. Again, without any dmesg printout, it's rather hard
to diagnose.

Thanks!

Mathieu


>=20
> -Kees
>=20
>>=20
>> Thanks!
>> J=C3=A9r=C3=A9mie
>>=20
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=3D=
kspp/userspace/protected-creat
>> [2] https://lkml.org/lkml/2018/4/10/840
>> [3] https://lore.kernel.org/lkml/20180416175918.GA13494@beast/
>> [4]
>> https://github.com/lttng/lttng-tools/commit/cf86ff2c4ababd01fea7ab2c9c28=
9cb7c0a1bcd5
>>=20
>> --
>> J=C3=A9r=C3=A9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>=20
> --
> Kees Cook

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
