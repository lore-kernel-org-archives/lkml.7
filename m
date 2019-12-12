Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98379C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A2522527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="BzKhVTSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfLLQCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:02:16 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:43708 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfLLQCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:02:16 -0500
Received: by mail-pj1-f68.google.com with SMTP id g4so1196363pjs.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 08:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=beXsVnBCg65xtUboT75oX9AtZcA8LYYNBSRgmS4rw1c=;
        b=BzKhVTSlGuNyeBMHGRoibZUGNaJADrOyA/geMiSI5zz4CL7FspuNuY3+tcMVKuplhH
         GNjmWlJCQ2J75hPY2BaqO3toa054NHUqKbljgXRPEwqWw2ygX4nT3G5le3u+TclHCQrM
         v97ERCKgcxf20sEjQHKdpL+8t4PfWEip7808LrpGXrACv/wOjl2M0qulLRrvhsvyUH16
         /C8c22rL2nJc7qUbOAscSEK+edP0L3IoiBfUNusiagp35oZh0YtEwiVOiOVZV56GA4gW
         zoXixR6n8/EbSeBI9CWH799fUk2lQz+mxjKxwe+eYSCpXDCLADWL9p8d4oG+hp6qW6Oz
         syMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=beXsVnBCg65xtUboT75oX9AtZcA8LYYNBSRgmS4rw1c=;
        b=sc697GXXj1p/hX23wHawCbbP2gTRJgwyyT/BIJJw5ixCgRs6sLE1oeY+3aRF/dFjwD
         FotR94neMDhwK+n7z15GfcLuzXZP42xA4ZLBt94QNMwXN4wlcvd7BuQZ66BzxrZW0H0+
         0KvXC1diaTPpjF7r/8uJ8kbvNAAZ5meP0tWdKkR47lMWhPXMdZWGCsshRWoDOXJYI5cz
         L5V4s8J2cJiQ0D8g2ASt79qCcId/TNC79UKawkOgBlzFwKF2+BF7pgGyBp3aYOteUO3b
         8sMIvVSChwsNbJ0OUNv75oALJ6XnDS6PB+MjV6leG+1yZedZG5PxBPDmgr4J6wk74+Yz
         F4ww==
X-Gm-Message-State: APjAAAV5xQqn0uepBz9D19YuLYYAnTKRO6ozeKgn27+zZB5QM36gvtXZ
        sRKWQUi0KBD9T2N+H7Qc6El7LA==
X-Google-Smtp-Source: APXvYqwIwU0H+tvv98uCyQroi8q7RvdBL5iWRjY0MBXot4LFIrf4rEuaURngQwuchvJpVVFB9uot0Q==
X-Received: by 2002:a17:90a:86c2:: with SMTP id y2mr10998665pjv.72.1576166535330;
        Thu, 12 Dec 2019 08:02:15 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:51bf:c5fc:5a97:2793? ([2601:646:c200:1ef2:51bf:c5fc:5a97:2793])
        by smtp.gmail.com with ESMTPSA id h6sm7089643pgq.61.2019.12.12.08.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 08:02:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by kernel parameter
Date:   Thu, 12 Dec 2019 08:02:13 -0800
Message-Id: <A1D491D5-0079-487C-A834-FB504EDD8782@amacapital.net>
References: <20191212130421.GX2827@hirez.programming.kicks-ass.net>
Cc:     David Laight <David.Laight@aculab.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Will Deacon <will@kernel.org>
In-Reply-To: <20191212130421.GX2827@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 12, 2019, at 5:04 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> Waiting for a store-buffer drain is *expensive*.
>=20
> Try timing:
>=20
>    LOCK INC (ptr);
>=20
> vs
>=20
>    LOCK INC (ptr);
>    MFENCE
>=20
> My guess is the second one *far* more expensive. MFENCE drains (and waits
> for completion thereof) the store-buffer -- it must since it fences
> against non-coherent stuff.

MFENCE also implies LFENCE, and LFENCE is fairly slow despite having no arch=
itectural semantics other than blocking speculative execution. AFAICT, in th=
e absence of side channels timing oddities, there is no code whatsoever that=
 would be correct with LFENCE but incorrect without it. =E2=80=9CSerializati=
on=E2=80=9D is, to some extent, a weaker example of this =E2=80=94 MOV to CR=
2 is *much* slower than MFENCE or LOCK despite the fact that, as far as the m=
emory model is concerned, it doesn=E2=80=99t do a whole lot more.

So the fact that draining some buffer or stalling some superscalar thingy is=
 expensive doesn=E2=80=99t necessarily mean that the lack of said draining i=
s observable in the memory model.

(LFENCE before RDTSC counts as =E2=80=9Ctiming=E2=80=9D here.)
