Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22B6CA9EC9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF92521835
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="2SHbxw9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfJ3QIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:08:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37602 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ3QIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:08:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id p13so1195118pll.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=CgvHwbo+NNRECegWRGyqCvpNWgkabG1Mje5YCQX5qTY=;
        b=2SHbxw9J5M7HFw9jDPEI0KMR76luYm9dP3fkBGJuU4hBe2siNSP0VsR8nNUskGLQOl
         ChmcEnGsLS423KRh7rS7id0EBAgntELZDtsLjyLEmk06umElsJn8I1wgz/t4+5Oe3z/K
         cGi20pgETz94OedP5LcS6dIZEQ0eSMwyoD/uWTpHkKVWR0yDuvMPdE4fkZVVTHoX7CBY
         PnYZ5PQeCf8XNUDv4H5x7k0HVmnyA/4NBs91YM8eADKf5EbkLe8uYpFeYcoWBQPFpZ4c
         Oo1OTiVS1ipggsNhDtv27IMl86AonjGT8eP7mvGo+woiuQxRJqVGvY4AY1c91brQFez6
         rsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=CgvHwbo+NNRECegWRGyqCvpNWgkabG1Mje5YCQX5qTY=;
        b=KCCjx0WQ27bPj4Vn6S1nNn0A6r9alOq2p7DPIG8Hq04ialcmCLR88HJki+FH8YNL02
         u3k3BV6tNgIH7LZxYuWgCbf7CW0AzoZXfB3BKzZCfN6mYXn9Zj2TJgCMcZwkasK/bUqX
         zKDW5fXi8Y62okGbdpQ9hT08sSVWbUYD9IBnHr8whU0Iy66ex9tO+/Ko69uYNHtPXUCk
         GjFq2hUCMjqVXS2QPR9daXg8tJIloK5WUo5Il9PGDWCeTNQJyLl1XYteb7yUnlkbVMZW
         sPG1DHx6i1iBilHmcE27QhcHw4hs1KxeC1Zis6WlCamur+Gl9EWXl82NWJT8QVfYhPdg
         a0kA==
X-Gm-Message-State: APjAAAXctg37rEdAr0RXX09/WUFUQD8iGnjJAXPxdt0LDfD5csQB7D5s
        7R+lpekLEo7A3SoLPj13c+Xnow==
X-Google-Smtp-Source: APXvYqwwjqQ8Oi2GybXK7D8rcwOQ5HxrbNH6VEiB87AdrxMXPFeMNnxfgE1DKzTu/irG5TXC6u7rSw==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr820305plp.221.1572451703249;
        Wed, 30 Oct 2019 09:08:23 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id f21sm267514pgh.85.2019.10.30.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 09:08:23 -0700 (PDT)
Date:   Wed, 30 Oct 2019 09:08:19 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net,
        glider@google.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+9e3b178624a8a2f8fa28@syzkaller.appspotmail.com>
Subject: Re: [net/tls] Re: KMSAN: uninit-value in aes_encrypt (2)
Message-ID: <20191030090819.27b8c169@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20191024172353.GA740@sol.localdomain>
References: <00000000000065ef5f0595aafe71@google.com>
        <20191024172353.GA740@sol.localdomain>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 10:23:53 -0700, Eric Biggers wrote:
> [+TLS maintainers]
>=20
> This is a net/tls bug, and probably a duplicate of:
>=20
> KMSAN: uninit-value in gf128mul_4k_lle (3)
> 	https://lkml.kernel.org/linux-crypto/000000000000bf2457057b5ccda3@google=
.com/T/#u
> =09
> KMSAN: uninit-value in aesti_encrypt
> 	https://lkml.kernel.org/linux-crypto/000000000000a97a15058c50c52e@google=
.com/T/#u
>=20
> See analysis from Alexander Potapenko here which shows that uninitialized=
 memory
> is being passed from TLS subsystem into crypto subsystem:
>=20
> 	https://lkml.kernel.org/linux-crypto/CAG_fn=3DUGCoDk04tL2vB981JmXgo6+-RU=
PmrTa3dSsK5UbZaTjA@mail.gmail.com/
>=20
> That was a year ago, with C reproducer, and I've sent several reminders f=
or this
> already.  What's the ETA on a fix?  Or is TLS subsystem de facto unmainta=
ined?

Re: maintainers it may actually be that the bug is so old the people
who pay attention weren't in the MAINTAINERS yet ;) That'd explain why
Alexander didn't CC us.

Fix posted now:

net/tls: fix sk_msg trim on fallback to copy mode

=F0=9F=A4=9E
