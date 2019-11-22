Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B639CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB11206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="OjE96Svw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKVCNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:13:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46345 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKVCNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 21:13:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id r18so2563178pgu.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 18:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=1nM290Esy7Uqp7BbINVlXuraHnSu6AJkW/DhkP1Ld/0=;
        b=OjE96SvwrAsA4U87NunnoAOxE+pGxo/rM2M47bdljHcsEazCjyKOjhYVIPDH3sUVrp
         ceyXjVuGibiCrUbr4wDEKnf5WYEkkWocpRXZje2oQMWpFRlUKcMdxx3NgANz/3C90EjB
         y98zEFwajYRWKQtWwXZsjZhYu5R5qeFtQBQzd97bENO1KrSraZvywGwh9hP681CX3akz
         +oZ0eqjaRbFZpM0tAyx2DA84K685rqaari0+YwgFw0TmBZFJdutogxVIP23RCegesbXN
         NkO3/gRpNOqirnbi58nwQSi+5NtH/i2GW0fAK9XHWCju+IHuaqgWNHflsz60wsjioklo
         0h8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=1nM290Esy7Uqp7BbINVlXuraHnSu6AJkW/DhkP1Ld/0=;
        b=h1/Uh6t2SqC4ZaQaxk0ktCj+h6W20008VEN5OzJAJESZK4iWthN01bIHmxKrx73Lqp
         pxvCcs92tGjb7tqmRGAUFxwBeOzIghNjj/ubS6+MRYHubUHoAZ69+DeYHDJfWooaWUeB
         g/JP8BtqC4Pn1b/aQ5Ubmb51kA1hbeIe2DkBvDQElFUsVDpuPgCQaf5d+LT0+8wy4wlo
         DY4DeT+3rrTGU2Kq+Rh31QHM5QryZejCU6VBE3iBWiguZrNcMEsTfV6LbmkcEAbOHeSW
         MQTqORrZbT4O3HdR47bAcEhI1k1vYNWinNSt2d2Bg4OYdZuiP4ilC3hQ+gdwWhc++1rT
         H8dA==
X-Gm-Message-State: APjAAAWSMr10gumcIRv8Q1Qpjbfsn4SMAcxcv5l6sG/SKFy86yC+dkww
        2KZ9Y8jjdzGXvOUgJcZB8byFCg==
X-Google-Smtp-Source: APXvYqxjKbUvPdABXRjxDnr2V9kmHUFrp4dRPfgurcbJzVTLfuGhzprq0awCLS0FiILsKpBDqZ4bww==
X-Received: by 2002:a63:ec03:: with SMTP id j3mr13364348pgh.212.1574388800381;
        Thu, 21 Nov 2019 18:13:20 -0800 (PST)
Received: from ?IPv6:2600:1010:b062:827f:f4a7:a1e:b790:5671? ([2600:1010:b062:827f:f4a7:a1e:b790:5671])
        by smtp.gmail.com with ESMTPSA id r33sm806663pjb.5.2019.11.21.18.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 18:13:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v10 4/6] x86/split_lock: Enumerate split lock detection if the IA32_CORE_CAPABILITIES MSR is not supported
Date:   Thu, 21 Nov 2019 18:13:18 -0800
Message-Id: <5A85615E-EFFF-4DF3-A1A5-DB8532451A42@amacapital.net>
References: <20191122003754.GF199273@romley-ivt3.sc.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
In-Reply-To: <20191122003754.GF199273@romley-ivt3.sc.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 21, 2019, at 4:25 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
>=20
> =EF=BB=BFOn Thu, Nov 21, 2019 at 02:07:38PM -0800, Andy Lutomirski wrote:
>>=20
>>=20
>>>> On Nov 20, 2019, at 5:45 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
>>>=20
>>> =EF=BB=BFArchitecturally the split lock detection feature is enumerated b=
y
>>> IA32_CORE_CAPABILITIES MSR and future CPU models will indicate presence
>>> of the feature by setting bit 5. But the feature is present in a few
>>> older models where split lock detection is enumerated by the CPU models.=

>>>=20
>>> Use a "x86_cpu_id" table to list the older CPU models with the feature.
>>>=20
>>=20
>> This may need to be disabled if the HYPERVISOR bit is set.
>=20
> How about just keeping this patch set as basic enabling code and
> keep HYPERVISOR out of scope as of now? KVM folks will have better
> handling of split lock in KVM once this patch set is available in
> the kernel.
>=20
>=20

You seem to be assuming that certain model CPUs have this feature even if no=
t enumerated. You need to make sure you don=E2=80=99t try to use it in a VM w=
ithout the hypervisor giving you an indication that it=E2=80=99s available a=
nd permitted. My suggestion is to disable model-based enumeration if HYPERVI=
SOR is set.  You should also consider probing the MSR to double check even i=
f you don=E2=80=99t think you have a hypervisor.=
