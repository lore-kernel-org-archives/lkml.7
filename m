Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2972AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E0A2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ypLhQnZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391821AbfFKQEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:04:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36049 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390351AbfFKQEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:04:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id f21so1200597pgi.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fHgaF/ifDgAfQgzituzGnrDambMODchHBe1+gC1goFc=;
        b=ypLhQnZ5ihNJgwdVJWVC91xIsfiFrz9ClfznVqmlTf6ghMEcUIC04zg9Rmg2GaSMUC
         Nk/KuRk3kdeTrDCVRf22vfVsMPm0iAID5T/Fbpv2fECuSrqp81Fv/J4NjGKQPxSgIX1a
         CAxqCZgIOSxqK7yfvQ8Rjv0S+IGKDsnlAXPCK1sBhdj9d4VBis7CIQYQFwyDZAbIxeYj
         fl6BqcP3XQxDviKSOj+JizlLAFmYrz6ulfoCP0r7AgpPEUNUMBO4uOZyMAJ+XGyXjAee
         sViBcr28A2wDwGnLCO4fPnTqaI2duqe7rshzpjdidVtGX2J9Jt7FB7QSkxKZ+Zo/P8ZB
         EhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fHgaF/ifDgAfQgzituzGnrDambMODchHBe1+gC1goFc=;
        b=IaKQpxKwjDL8FfjS7inpasceApvYKh9CvhVPwAYmVjcTkgN4JmflUq2qLDC6+R5vAP
         kctYJbDNoB5Y9vm9nIlz/HCpHu2vMI/1zAZvbR//uDhS4TJWmMTu8gkfjIMavYtXFmvu
         qRvFLWq/KQ6qvixpFK2o4MVbU+juO5zlO9lMece/U77jk+PHWZuVCWxlpj0BTKhM+bpC
         RzC31/jZD8oiKcTuwGNnGPXNADAwN3tskEbHwzMRaiQRZ/NGfhLKCoa6HPoUBiBRO0XW
         Wo3bMuh7GwCDAApR6krBmx/go3/d7DIHiejmijOaCN+njJI9PcWd49HAe3kH9zRBd98c
         nEUQ==
X-Gm-Message-State: APjAAAXmU9LRZHj+ABwztT9a+65jhMaSc6LgICDhM1Djt3Xfhheu1HR3
        rdeJTpOAZhWOWr6n6ajfPe/q3Q==
X-Google-Smtp-Source: APXvYqzRdyu88HyKel/R/LqGyypz8I9fy5w87YxTteCaPn3bF6Cny2QQ1MSAtq3Cu/IjvG3qlKp68A==
X-Received: by 2002:a17:90a:bc02:: with SMTP id w2mr18114744pjr.101.1560269073381;
        Tue, 11 Jun 2019 09:04:33 -0700 (PDT)
Received: from ?IPv6:2600:1010:b062:7159:60af:2fa5:3435:5195? ([2600:1010:b062:7159:60af:2fa5:3435:5195])
        by smtp.gmail.com with ESMTPSA id s42sm3106035pjc.5.2019.06.11.09.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 09:04:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait C0.2 state
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <20190611085410.GT3436@hirez.programming.kicks-ass.net>
Date:   Tue, 11 Jun 2019 09:04:30 -0700
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D67CEAC-9710-4ECB-9248-75B48542FF82@amacapital.net>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com> <1559944837-149589-4-git-send-email-fenghua.yu@intel.com> <20190611085410.GT3436@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 11, 2019, at 1:54 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Fri, Jun 07, 2019 at 03:00:35PM -0700, Fenghua Yu wrote:
>> C0.2 state in umwait and tpause instructions can be enabled or disabled
>> on a processor through IA32_UMWAIT_CONTROL MSR register.
>>=20
>> By default, C0.2 is enabled and the user wait instructions result in
>> lower power consumption with slower wakeup time.
>>=20
>> But in real time systems which require faster wakeup time although power
>> savings could be smaller, the administrator needs to disable C0.2 and all=

>> C0.2 requests from user applications revert to C0.1.
>>=20
>> A sysfs interface "/sys/devices/system/cpu/umwait_control/enable_c02" is
>> created to allow the administrator to control C0.2 state during run time.=

>=20
> We already have an interface for applications to convey their latency
> requirements (pm-qos). We do not need another magic sys variable.

I=E2=80=99m not sure I agree.  This isn=E2=80=99t an overall latency request=
, and setting an absurdly low pm_qos will badly hurt idle power and turbo pe=
rformance.  Also, pm_qos isn=E2=80=99t exactly beautiful.

(I speak from some experience. I may be literally the only person to write a=
 driver that listens to dev_pm_qos latency requests. And, in my production b=
ox, I directly disable c states instead of messing with pm_qos.)

I do wonder whether anyone will ever use this particular control, though.=
