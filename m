Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E977DC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BEE20692
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="kg+BFRLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKVCVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:21:24 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39806 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKVCVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 21:21:24 -0500
Received: by mail-pj1-f66.google.com with SMTP id t103so2367424pjb.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 18:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=2Y9eO3Yb3+HdxO8v8hLVbBr0Cjg6GQipkleKftryi7Q=;
        b=kg+BFRLriNvhauNKWsV4sIQVWAlyPIv2wOPLZFiypxprc3qD/WMtaJZwjMKB7DbATN
         zxcSpKC63UvArsP9Aqdx9AOK99/udPsHpIimWJ1qFMnyPiiifcEu+Akj4qcfNibfr4ZO
         OwTYFnjWv2XmVIyLOlgkHrc7AlAy4pIJDGB1yXBpETJ3EPqKgd+b/L8X62Tby9iNXFlz
         AJYB76I6gk0UZJih+WfAje/BYsIjQa7NEX97GhGbpSi2C5jgODYMqBeRdDLt6lyNqrif
         BVHH0O45rWlEPUgA4O1PknCxC2jFi5A09cwaJ3UeXd8gK6ui5Y5RInTOX+xNPk1ttyX+
         exdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=2Y9eO3Yb3+HdxO8v8hLVbBr0Cjg6GQipkleKftryi7Q=;
        b=mkeQpqQtGUGKS5IaVU/Rj55+emMa6PZkJAONSR8Q8otpo2OZvieUGlDhmY8O+D/ID4
         2NgdfyU5aOmhxKtpcxC4iYrBQq/pBfYKPd3TwuIOC7TVx0Uy1XfFL+c/sxJ5DGSKU8Bc
         7w7Hvkn1Z2AJRXp8XQBzdWN7J+5SbtNysUbj9qh0jzqRtnE1HWOLOhSgawhn+3QfNgpQ
         Yh502L9dCeQmiDOz6cT/HuE7F0B0FEhNPn/nq66Xl53VFYcHwWxUeSa/lN/jJEYYxWer
         cXR7q5WE/LzthFBelMy1+MsQ8ism1KHp5N90s3E33sGKgSEGelpW7KrIkNO4hzFZEqDI
         rwpg==
X-Gm-Message-State: APjAAAXwc5ZS6I1WTOOzljy3adQ0R2IR96cug3ToE6FIrfn1imHJnZm1
        huCULSvOvFxwFrlttaOdtuaYTQ==
X-Google-Smtp-Source: APXvYqxqisg8UDcPWbPcbtprGiMVFUBSQZYDBe7wV8HDqUWiJvPwAf1b3fMpG4MMJOJEsXbMrrWAoA==
X-Received: by 2002:a17:902:a408:: with SMTP id p8mr12082431plq.266.1574389283326;
        Thu, 21 Nov 2019 18:21:23 -0800 (PST)
Received: from [100.111.14.2] (50.sub-174-194-197.myvzw.com. [174.194.197.50])
        by smtp.gmail.com with ESMTPSA id 81sm4981095pfx.142.2019.11.21.18.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 18:21:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by kernel parameter
Date:   Thu, 21 Nov 2019 18:21:20 -0800
Message-Id: <81CEB9B7-79EA-4B02-A79C-C9113331A28A@amacapital.net>
References: <20191122015225.GG16617@linux.intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
In-Reply-To: <20191122015225.GG16617@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 21, 2019, at 5:52 PM, Sean Christopherson <sean.j.christopherson@in=
tel.com> wrote:
>=20
> =EF=BB=BFOn Thu, Nov 21, 2019 at 03:53:29PM -0800, Fenghua Yu wrote:
>>> On Thu, Nov 21, 2019 at 03:18:46PM -0800, Andy Lutomirski wrote:
>>>=20
>>>> On Nov 21, 2019, at 2:29 PM, Luck, Tony <tony.luck@intel.com> wrote:
>>>>=20
>>>>> It would be really, really nice if we could pass this feature through t=
o a VM. Can we?
>>>>=20
>>>> It's hard because the MSR is core scoped rather than thread scoped.  So=
 on an HT
>>>> enabled system a pair of logical processors gets enabled/disabled toget=
her.
>>>>=20
>>>=20
>>> Well that sucks.
>>>=20
>>> Could we pass it through if the host has no HT?  Debugging is *so* much
>>> easier in a VM.  And HT is a bit dubious these days anyway.
>>=20
>> I think it's doable to pass it through to KVM. The difficulty is to disab=
le
>> split lock detection in KVM because that will disable split lock on the w=
hole
>> core including threads for the host. Without disabling split lock in KVM,=

>> it's doable to debug split lock in KVM.
>>=20
>> Sean and Xiaoyao are working on split lock for KVM (in separate patch set=
).
>> They may have insight on how to do this.
>=20
> Yes, with SMT off KVM could allow the guest to enable split lock #AC, but
> for the initial implementation we'd want to allow it if and only if split
> lock #AC is disabled in the host kernel.  Otherwise we have to pull in the=

> logic to control whether or not a guest can disable split lock #AC, what
> to do if a split lock #AC happens when it's enabled by the host but
> disabled by the guest, etc...

What=E2=80=99s the actual issue?  There=E2=80=99s a window around entry and e=
xit when a split lock in the host might not give #AC, but as long as no user=
 code is run, this doesn=E2=80=99t seem like a big problem.=
