Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABF4C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F31A2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="R53bfuj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfLSGGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:06:05 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41275 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfLSGGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:06:05 -0500
Received: by mail-qk1-f195.google.com with SMTP id x129so3718898qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 22:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hh8KccvDtoxQ5iuVrGchqXmublC0voHoq882to+xc8w=;
        b=R53bfuj7F9qGYPrLECK10byImpR4yK7ldvvpoKHT/U0eDHOLw1wcoFq8sEaN7V8dMv
         RTI4OvZHrc3f4vy7R3joPd+QbgejX5prA8699eMCN0SdjkV+ay4zyheL8hzyrR8j0Hz/
         FSbhiR/D9Lrz4TPHD8PeiGOFQ05PJAOuxG6io4ksDgI2GAlOBrgWNi2fNQDz/0dj13ry
         xOkX2z5MAPFOPxMcQ00gmYTQjXZzcFH/t4p8AlNidMVPXMdT+a607AbRmiRnMrMkMMp1
         PtBjaGGkRJkB+xuc08WFU+jIhx9Qq1CE8ukBh1PQfVnawhwdWOVj8zlTfERE9/nPXNUG
         lVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hh8KccvDtoxQ5iuVrGchqXmublC0voHoq882to+xc8w=;
        b=tMRuIPYEWASzs+Wmbuy/pJlCRcCT3diosKLIn0HTf2zkwmPnoYJ0PK2OZ/Y/rThAtC
         BXUNK9oxwG+7Nmy6KYCyLHY8xOFKDaKJc6Bi7PNsSzoCWdYtANMqsmAeqcLH82Rn8FHx
         gW29kZPMQliq+xyy0g/7lMetEKniJQFOmlISlPRe//d13czAkmd7G9S3bc1/Z5yTy+To
         UDn7M9L/gziGGtPp6dDlYGUMV1q3qK+80QfipinzhSWX8zjUFl3XMVJgB1cI6tjt4jL/
         d7OD9upCD5JTo9FDv2ejqpvkmFILwOrv6/47PLg0E6/mcGfkbbyLVS50uKiY9j7GuuP3
         lFJg==
X-Gm-Message-State: APjAAAUJ00qXpr7zuRZTXNzKpIntG3QdGkTj43FRHrbuQkCasHP0q+5j
        L2TW3X1pewT3o+ngwPXxOS7lHQ==
X-Google-Smtp-Source: APXvYqx76XeZmAMheUFNFZOiIvYT9bf+9MmsIr9SMAoK2rMgm3C8UxDFIykW+8QWnhd7emRgbJAyHw==
X-Received: by 2002:a37:7c6:: with SMTP id 189mr6850205qkh.408.1576735563755;
        Wed, 18 Dec 2019 22:06:03 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 4sm1453127qki.51.2019.12.18.22.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 22:06:03 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: "ftrace: Rework event_create_dir()" triggers boot error messages
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20191218233101.73044ce3@rorschach.local.home>
Date:   Thu, 19 Dec 2019 01:06:02 -0500
Cc:     Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7CC42C4D-8DD3-48E5-BB68-752BAB98DB56@lca.pw>
References: <0FA8C6E3-D9F5-416D-A1B0-5E4CD583A101@lca.pw>
 <20191218233101.73044ce3@rorschach.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 18, 2019, at 11:31 PM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
>=20
> On Wed, 18 Dec 2019 22:58:23 -0500
> Qian Cai <cai@lca.pw> wrote:
>=20
>> The linux-next commit "ftrace: Rework event_create_dir()=E2=80=9D [1] =
triggers boot warnings
>> for Clang-build (Clang version 8.0.1) kernels (reproduced on both =
arm64 and powerpc).
>> Reverted it (with trivial conflict fixes) on the top of today=E2=80=99s=
 linux-next fixed the issue.
>>=20
>> configs:
>> https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
>> =
https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
>>=20
>> [1] =
https://lore.kernel.org/lkml/20191111132458.342979914@infradead.org/
>>=20
>> [  115.799327][    T1] Registered efivars operations
>> [  115.849770][    T1] clocksource: Switched to clocksource =
arch_sys_counter
>> [  115.901145][    T1] Could not initialize trace point =
events/sys_enter_rt_sigreturn
>> [  115.908854][    T1] Could not create directory for event =
sys_enter_rt_sigreturn
>> [  115.998949][    T1] Could not initialize trace point =
events/sys_enter_restart_syscall
>> [  116.006802][    T1] Could not create directory for event =
sys_enter_restart_syscall
>> [  116.062702][    T1] Could not initialize trace point =
events/sys_enter_getpid
>> [  116.069828][    T1] Could not create directory for event =
sys_enter_getpid
>> [  116.078058][    T1] Could not initialize trace point =
events/sys_enter_gettid
>> [  116.085181][    T1] Could not create directory for event =
sys_enter_gettid
>> [  116.093405][    T1] Could not initialize trace point =
events/sys_enter_getppid
>> [  116.100612][    T1] Could not create directory for event =
sys_enter_getppid
>> [  116.108989][    T1] Could not initialize trace point =
events/sys_enter_getuid
>> [  116.116058][    T1] Could not create directory for event =
sys_enter_getuid
>> [  116.124250][    T1] Could not initialize trace point =
events/sys_enter_geteuid
>> [  116.131457][    T1] Could not create directory for event =
sys_enter_geteuid
>> [  116.139840][    T1] Could not initialize trace point =
events/sys_enter_getgid
>> [  116.146908][    T1] Could not create directory for event =
sys_enter_getgid
>> [  116.155163][    T1] Could not initialize trace point =
events/sys_enter_getegid
>> [  116.162370][    T1] Could not create directory for event =
sys_enter_getegid
>> [  116.178015][    T1] Could not initialize trace point =
events/sys_enter_setsid
>> [  116.185138][    T1] Could not create directory for event =
sys_enter_setsid
>> [  116.269307][    T1] Could not initialize trace point =
events/sys_enter_sched_yield
>> [  116.276811][    T1] Could not create directory for event =
sys_enter_sched_yield
>> [  116.527652][    T1] Could not initialize trace point =
events/sys_enter_munlockall
>> [  116.535126][    T1] Could not create directory for event =
sys_enter_munlockall
>> [  116.622096][    T1] Could not initialize trace point =
events/sys_enter_vhangup
>> [  116.629307][    T1] Could not create directory for event =
sys_enter_vhangup
>> [  116.783867][    T1] Could not initialize trace point =
events/sys_enter_sync
>> [  116.790819][    T1] Could not create directory for event =
sys_enter_sync
>> [  117.723402][    T1] pnp: PnP ACPI init
>=20
> I noticed that all of the above have zero parameters. Does the
> following patch fix it?

Yes, it works.

>=20
> (note, I prefer "ret" and "i" on different lines anyway)
>=20
> -- Steve
>=20
> diff --git a/kernel/trace/trace_syscalls.c =
b/kernel/trace/trace_syscalls.c
> index 53935259f701..abb70c71fe60 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -269,7 +269,8 @@ static int __init =
syscall_enter_define_fields(struct trace_event_call *call)
> 	struct syscall_trace_enter trace;
> 	struct syscall_metadata *meta =3D call->data;
> 	int offset =3D offsetof(typeof(trace), args);
> -	int ret, i;
> +	int ret =3D 0;
> +	int i;
>=20
> 	for (i =3D 0; i < meta->nb_args; i++) {
> 		ret =3D trace_define_field(call, meta->types[i],

