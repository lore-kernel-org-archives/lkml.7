Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD541C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEB820859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Uty0cYCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390419AbfFJNle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:41:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42668 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390156AbfFJNle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:41:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so5326264pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ErGbE0m83drl7dTry1xy777Y6e0hhPDAZgr47/W8iV4=;
        b=Uty0cYCcUyTPhGivuo38Ob2kXf+Xu8/9JLqYha/HPU0lFdVNvXgIrI5qKDzyoArMC2
         Vc2oLjOqZ1cu0c46mcrYCP5JRGpkQSGkji0rpT3UEQQO4bmFKKcDlY981G6xAPXDiGaL
         L8XAZo4FW4ndKyGqSFL2IUBPuH3g54z6ze3awEbnHv+Dt1eq9mvqlHCgD2ZHmeZrZY4w
         tpD+VKWLApK4Vg36ZsHLXyzJ5398zSnxUbdpEKl+vXzxEUAlhHP8L1rbicREAq0D52nn
         p5wVO7MAhcMIVLCvxAfdLdHFbC1NMIiXzx+GznqPILCgnHPi9jj6EU0k4sF49zPhlUsh
         99+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ErGbE0m83drl7dTry1xy777Y6e0hhPDAZgr47/W8iV4=;
        b=LxPmCT7BE06dH9lgHXz2Ham7cF6kmqRW+vQOPgFBExLdB/5HrYZ3FOoeD7OCHbYGAj
         v+WGVClfel5S9RfpgW7pVEoX5mInHi3x2ESBA4nUxRTsppe1Wfnh++v27ldZ8JWRdJoT
         XY3Xapgt3zl1ndVD+4qDCfyXo5x/iuD8dtz3GuvRY8EEB0KwJzCNiRL5jpW2SXlMclU2
         rLtLRVMbxtFv6ia4JjcieEFMmMT32bC16eE5SH8nSdrreg3NWYhl4IpZ5hEuJSDrxpfN
         1MX0D9jifJWJ+xPzX07eJFS5pMu64JBPPoj7E1HRH9EbWCVlXvQ5pJQuxGUdqHNNVUhk
         udzw==
X-Gm-Message-State: APjAAAVMa2bsc5Zkw5qGsorEujPBhKETxAL80EG62jUU7ddypxHuHCmn
        GpYwYcgZ/vm0oVNxvuSpqM3wyw==
X-Google-Smtp-Source: APXvYqxhrxiUVcfVbGUTiO4KPhdvKgUKhNT7d2fxHa6SxCJAGIsN24f0nBxpYU55AxdD6B0MWAaRtQ==
X-Received: by 2002:aa7:8b12:: with SMTP id f18mr73733166pfd.178.1560174093464;
        Mon, 10 Jun 2019 06:41:33 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:40ea:1a58:6516:d6f2? ([2601:646:c200:1ef2:40ea:1a58:6516:d6f2])
        by smtp.gmail.com with ESMTPSA id m20sm10718928pjn.16.2019.06.10.06.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 06:41:32 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait C0.2 state
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <20190610060234.GD162238@romley-ivt3.sc.intel.com>
Date:   Mon, 10 Jun 2019 06:41:31 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F021B947-90E9-450A-9196-531B7EE965F1@amacapital.net>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com> <1559944837-149589-4-git-send-email-fenghua.yu@intel.com> <CALCETrXEqqc3cKyJ5guRV3T6LP9dpSExk3a7dvR4PF8TDgD_OA@mail.gmail.com> <20190610035302.GA162238@romley-ivt3.sc.intel.com> <CALCETrUSpk+_FDaPpA3a-duajUdF8kOK64AQJjsr7Pm0Gi04OA@mail.gmail.com> <20190610060234.GD162238@romley-ivt3.sc.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 9, 2019, at 11:02 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
>=20
>> On Sun, Jun 09, 2019 at 09:24:18PM -0700, Andy Lutomirski wrote:
>>> On Sun, Jun 9, 2019 at 9:02 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>>>=20
>>>> On Sat, Jun 08, 2019 at 03:50:32PM -0700, Andy Lutomirski wrote:
>>>>> On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote=
:
>>>>>=20
>>>>> C0.2 state in umwait and tpause instructions can be enabled or disable=
d
>>>>> on a processor through IA32_UMWAIT_CONTROL MSR register.
>>>>>=20
>>>>> By default, C0.2 is enabled and the user wait instructions result in
>>>>> lower power consumption with slower wakeup time.
>>>>>=20
>>>>> But in real time systems which require faster wakeup time although pow=
er
>>>>> savings could be smaller, the administrator needs to disable C0.2 and a=
ll
>>>>> C0.2 requests from user applications revert to C0.1.
>>>>>=20
>>>>> A sysfs interface "/sys/devices/system/cpu/umwait_control/enable_c02" i=
s
>>>>> created to allow the administrator to control C0.2 state during run ti=
me.
>>>>=20
>>>> This looks better than the previous version.  I think the locking is
>>>> still rather confused.  You have a mutex that you hold while changing
>>>> the value, which is entirely reasonable.  But, of the code paths that
>>>> write the MSR, only one takes the mutex.
>>>>=20
>>>> I think you should consider making a function that just does:
>>>>=20
>>>> wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
>>>>=20
>>>> and using it in all the places that update the MSR.  The only thing
>>>> that should need the lock is the sysfs code to avoid accidentally
>>>> corrupting the value, but that code should also use WRITE_ONCE to do
>>>> its update.
>>>=20
>>> Based on the comment, the illustrative CPU online and enable_c02 store
>>> functions would be:
>>>=20
>>> umwait_cpu_online()
>>> {
>>>        wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0=
);
>>>        return 0;
>>> }
>>>=20
>>> enable_c02_store()
>>> {
>>>       mutex_lock(&umwait_lock);
>>>       umwait_control_c02 =3D (u32)!c02_enabled;
>>>       WRITE_ONCE(umwait_control_cached, 2 | get_umwait_control_max_time(=
));
>>>       on_each_cpu(umwait_control_msr_update, NULL, 1);
>>>       mutex_unlock(&umwait_lock);
>>> }
>>>=20
>>> Then suppose umwait_control_cached =3D 100000 initially and only CPU0 is=

>>> running. Admin change bit 0 in MSR from 0 to 1 to disable C0.2 and is
>>> onlining CPU1 in the same time:
>>>=20
>>> 1. On CPU1, read umwait_control_cached to eax as 100000 in
>>> umwait_cpu_online()
>>> 2. On CPU0, write 100001 to umwait_control_cached in enable_c02_store()
>>> 3. On CPU1, wrmsr with eax=3D100000 in umwaint_cpu_online()
>>> 4. On CPU0, wrmsr with 100001 in enabled_c02_store()
>>>=20
>>> The result is CPU0 and CPU1 have different MSR values.
>>=20
>> Yes, but only transiently, because you didn't finish your example.
>>=20
>> Step 5: enable_c02_store() does on_each_cpu(), and CPU 1 gets updated.
>=20
> There is no sync on wrmsr on CPU0 and CPU1.

What do you mean by sync?

> So a better sequence to
> describe the problem is changing the order of wrmsr:
>=20
> 1. On CPU1, read umwait_control_cached to eax as 100000 in
> umwait_cpu_online()
> 2. On CPU0, write 100001 to umwait_control_cached in enable_c02_store()
> 3. On CPU0, wrmsr with 100001 in on_each_cpu() in enabled_c02_store()
> 4. On CPU1, wrmsr with eax=3D100000 in umwaint_cpu_online()
>=20
> So CPU1 and CPU0 have different MSR values. This won't be transient.

You are still ignoring the wrmsr on CPU1 due to on_each_cpu().

