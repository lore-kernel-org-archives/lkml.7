Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C158AC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C35217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfTkhjmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbfDRBzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 21:55:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38348 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbfDRBzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 21:55:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so337803pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 18:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=hRag2r+cRQClvnbXFRGifKjpch/VB6yXiPd+MKpC/OI=;
        b=HfTkhjmiPibg78nX7rz+t//QBE0dtUWyFpG2qsbR+7T6k1NxDW7Wcww4EkaWRCwWuI
         4t6n/XR7YKhU6Ip7uJcS4Jdp4v4O8QR5IUOTsz+r/qXNIEDlQwFbRg8VjOrBAvrbMowj
         vNF3b94lIHyNeJlcYW5YZfYNzTEbtLl6feJXmZaGePfGHM/2HTnSu/YQIgENM99PENOn
         55rH17hWB9tNbF3xJYl9HZfeXhTZIT72G09/zQMsggdmQdruuSaEwxvhrZ5NXoe85lWQ
         bWjIUCHNNMSgsjXAB2ssI31LELp8oh6A9v83Jmuj9cOTzkkY4FubJvXYsobUdFCvcWd+
         Dm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=hRag2r+cRQClvnbXFRGifKjpch/VB6yXiPd+MKpC/OI=;
        b=tFLHp82AN4/kcgmVnz0uCEIr0cqf72Pk0hiWKhSQYf4H6+ZyPwQhApFwe7h1PAQsQ+
         zrUI0yir/QPZVGarVehUaLtU/jGhBKke3j1gSdBCNvZjy9jnsz7bajdeUiIHfFqw18vG
         /3lrlE6k8W5mtM1oUB7+7IDi5TFsvVA4P44WGb9qPivZ8iOQhDujUHWpy7dh0qeh0pOA
         8fFxse30HqjdLVjneCMzpHImPyj1V/eGS7N7YLrYAV9FiN1lJmIuTSGFbD0Cc/qufQ3d
         OzEa1yiB83mMtybJtlPnPirTRQlouhfn7xBT6F0VpPEatZBZ+KD3J+/EAbSsB21Ekx/H
         FT2w==
X-Gm-Message-State: APjAAAWEFnvpB04fyxtnWCU6Avbn1Pa/4ZK4ppEvpt/GtSanrEwLulFk
        MHzVO+ADMNt5kbClhrBHLQO6G4l3
X-Google-Smtp-Source: APXvYqyHjfF93x3cbVWeXKbtshSYY17+rtsxNfJ8sSQorfiydS6oA2SxUH+sZLHd4xB5kswQ1rmvdQ==
X-Received: by 2002:a63:195e:: with SMTP id 30mr85422621pgz.312.1555552512900;
        Wed, 17 Apr 2019 18:55:12 -0700 (PDT)
Received: from localhost (14-202-58-58.tpgi.com.au. [14.202.58.58])
        by smtp.gmail.com with ESMTPSA id k79sm791108pfj.28.2019.04.17.18.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 18:55:11 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:55:06 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3] powerpc/pseries: Only wait for dying CPU after call to
 rtas_stop_self()
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <20190311193517.23756-1-bauerman@linux.ibm.com>
        <87bm1dfog4.fsf@morokweng.localdomain>
        <1555389147.okxbj1prw2.astroid@bobo.none>
        <87r2a0jffq.fsf@morokweng.localdomain>
In-Reply-To: <87r2a0jffq.fsf@morokweng.localdomain>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555552271.zy2w4ddjqe.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thiago Jung Bauermann's on April 18, 2019 11:00 am:
>=20
> Hello Nick,
>=20
> Thank you very much for reviewing this patch!
>=20
> Nicholas Piggin <npiggin@gmail.com> writes:
>=20
>> Thiago Jung Bauermann's on April 11, 2019 9:08 am:
>>>
>>> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>>>
>>>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/power=
pc/platforms/pseries/hotplug-cpu.c
>>>> index 97feb6e79f1a..ac6dc35ab829 100644
>>>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>>>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>>>> @@ -214,13 +214,22 @@ static void pseries_cpu_die(unsigned int cpu)
>>>>  			msleep(1);
>>>>  		}
>>>>  	} else if (get_preferred_offline_state(cpu) =3D=3D CPU_STATE_OFFLINE=
) {
>>>> +		/*
>>>> +		 * If the current state is not offline yet, it means that the
>>>> +		 * dying CPU (which is either in pseries_mach_cpu_die() or in
>>>> +		 * the process of getting there) didn't have a chance yet to
>>>> +		 * call rtas_stop_self() and therefore it's too early to query
>>>> +		 * if the CPU is stopped.
>>>> +		 */
>>>> +		spin_event_timeout(get_cpu_current_state(cpu) =3D=3D CPU_STATE_OFFL=
INE,
>>>> +				   100000, 100);
>>
>> If the CPU state does not go to offline here, you should give up and
>> return online, right? Otherwise I think query-cpu-stopped-state can
>> get confused by CPUs in idle and you get a false positive.
>=20
> Can it get confused? My impression from reading the definition for
> query-cpu-stopped-state in the PAPR is that it will simply return a
> CPU_status value of 2 in that case, meaning that "the processor thread
> is not in the RTAS stopped state", but I don't know much about this.

In QEMU (non-KVM) mode, qcss I think may get confused between H_CEDE
and rtas-stop-self. KVM mode may be okay because H_CEDE is handled in
the kernel.

>> That race can still happen, we would really need a sequence count check
>> over current CPU state to ensure we got a race-free qcss value, but at
>> least a check here should make the race implausible to hit.
>=20
> Actually, since rtas_stop_self() panics if the processor fails to stop
> and also since callers of pseries_cpu_die()=C2=B9 already assume that it =
is
> going to succeed in stopping the CPU (given that the function returns
> void and can't signal an error), a more straightforward way of
> eliminating the race is to simply do this:
>=20
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/=
platforms/pseries/hotplug-cpu.c
> index 97feb6e79f1a..2331a609f48f 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -215,7 +215,7 @@ static void pseries_cpu_die(unsigned int cpu)
>                 }
>         } else if (get_preferred_offline_state(cpu) =3D=3D CPU_STATE_OFFL=
INE) {
>=20
> -               for (tries =3D 0; tries < 25; tries++) {
> +               while (true) {
>                         cpu_status =3D smp_query_cpu_stopped(pcpu);
>                         if (cpu_status =3D=3D QCSS_STOPPED ||
>                             cpu_status =3D=3D QCSS_HARDWARE_ERROR)
>=20
>=20
> What do you think?

Yeah I think that may be a good idea, just makes things much simpler.

Thanks,
Nick

=
