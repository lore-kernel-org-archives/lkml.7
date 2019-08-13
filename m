Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70B5C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A04F20665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Wt6ztQ2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfHMXtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 19:49:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40318 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfHMXtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 19:49:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so49868006pla.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 16:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yL2GiSxONyR1+wf+cPEJ785qgYB8kzY/mss0H7pGC9M=;
        b=Wt6ztQ2X+fWJO0FTPgcX9A+51Mq8+dTZ9Ad+A3iCM8ClCkHgqKWJ2Drcvb3RRKr7tY
         erf0TC5YpqS2Portj7ZVBheih5czwyWoynvvG+OcmmO4kYKcTGfe2f3XrwTEAsq4mi21
         F50sQEzYTRfQKIDH+vxbJVarJg8gOG8ti6o2Fc+g1ZQKwAv93sQYllOrj4oWJ0zUPD+X
         OhZHWL3rBvb7RYeJg5DrjtfulYBGFzk0abwLsjlwIA2YbLnzPETAHKm0OIYnmu8wnuCN
         S6zZGySHxEitvDXRzvENqoZpHDohSYEySTt2GO05uL68b4/lXRsTldj/46PsM5r7KGQH
         nhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yL2GiSxONyR1+wf+cPEJ785qgYB8kzY/mss0H7pGC9M=;
        b=QFG2Xw8HnSvEcTRuWqQXuwz6r++Vq5QrXIabGVqbB/eDA4w9Jh5doNq+nNN/PfUutE
         Ybqm9HVCnemSGTzwpj0FiL/a6a/PaWJQEjNPhDXEV0UNR59nFMSrTLqj/u5uoFpRIhe4
         nI+cYKbC7g75bgX0OQ1/Z/SyWe0WvCquCGpPiNX1t/5sB1z6TuIn5uaGK1gvzbn+kyZ5
         3RJUSFkpO0ZwaVHV3zyK6E7Mm4B+1w94VTag++AAPgejm0FOAngJ7tLcTQfC+Wb//Cph
         3DjPB3aZhqlYN/XMhB00r19u5fJjFx1n1Q4tErOiclAbblga99m9tsAliI+pRhWk52Jk
         eoaw==
X-Gm-Message-State: APjAAAXqrARVHnF2ImSY8POio736f1Y3/IwIenhlHAu6TdIN+E3vCOAV
        5Rg/Bjxvh59paRwxg61VDZuhAg==
X-Google-Smtp-Source: APXvYqziYoxNMLaC/s1uQ9IVzw788DhInlAx7eBm4/seDB4Szhev8YYMyLyUEb33esQFu71+edIwvw==
X-Received: by 2002:a17:902:2ac7:: with SMTP id j65mr40372077plb.242.1565740171253;
        Tue, 13 Aug 2019 16:49:31 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:6cf1:fbba:cb42:db60? ([2601:646:c200:1ef2:6cf1:fbba:cb42:db60])
        by smtp.gmail.com with ESMTPSA id bt18sm3110564pjb.1.2019.08.13.16.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 16:49:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v8 11/27] x86/mm: Introduce _PAGE_DIRTY_SW
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G77)
In-Reply-To: <dac2d62b-9045-4767-87dd-eac12e7abafd@intel.com>
Date:   Tue, 13 Aug 2019 16:49:29 -0700
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <08A983E6-7B9C-4BDF-887A-F57734FADC9E@amacapital.net>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com> <20190813205225.12032-12-yu-cheng.yu@intel.com> <dac2d62b-9045-4767-87dd-eac12e7abafd@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Aug 13, 2019, at 4:02 PM, Dave Hansen <dave.hansen@intel.com> wrote:

>>=20
>> static inline pte_t pte_mkwrite(pte_t pte)
>> {
>> +    pte =3D pte_move_flags(pte, _PAGE_DIRTY_SW, _PAGE_DIRTY_HW);
>>    return pte_set_flags(pte, _PAGE_RW);
>> }
>=20
> It also isn't clear to me why this *must* move bits here.  Its doubly
> unclear why you would need to do this on systems when shadow stacks are
> compiled in but disabled.

Why is it conditional at all?  ISTM, in x86, RO+dirty has been effectively r=
epurposed. To avoid having extra things that can conditionally break, I thin=
k this code should be unconditional.=20

That being said, I=E2=80=99m not at all sure that pte_mkwrite on a shadow st=
ack page makes any sense.

> <snip>
>=20
> Same comments for pmds and puds.

Wasn=E2=80=99t Kirill working on a rework if the whole page table system to j=
ust have integer page table levels?=
