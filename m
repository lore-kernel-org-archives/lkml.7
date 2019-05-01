Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECEFC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332A920866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9jW4+Wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfEAXMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 19:12:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44978 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfEAXMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 19:12:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id l2so101509plt.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=xkHY0Vk0CxJ06DIPyqIQG5n7Y+l7wmOyvhLV4dHGd9M=;
        b=C9jW4+Wf+dG9vgT4hlyOesCrC6DT31u4n5QFfZ4h83VmJwVBANCoa2/4T7aNfba6O/
         Knev24dh6CyFTdVrpgU/LF1LvjWfogUqgxcQpxw0jJknCi09EFFhBTFVnDBhZ1IIUjjP
         SWfdvb4gNYZInR0Poe2Cc0xZY0C+qsmoyhn/oMeSlpZ9MEor77ihhqx2bbsWLDFChWCi
         6n8XsSL6uEnRD7wSNTbC62rw8zEdy/XYk0Ri+YLGy3jMA1vuZ8JV7tMEUOkBTg8oqI2e
         0c4Cu4BdaxiN5JFG+g5yZcwZThco7XvxoXDbdR0NICQ1jIJ6yCiNagCiXWDb1oKz0UEe
         bNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=xkHY0Vk0CxJ06DIPyqIQG5n7Y+l7wmOyvhLV4dHGd9M=;
        b=HP2eYlteogQ5pz+IcR9NloftxP6DfhIpzjpPTl4JJ3cr6YTbIfcM4Vcu+MXNhHzFe8
         WTTwCZXiuRfAAZJ++EPb8lRNynWIvGxz43ik44E7VYOP4iYfM9LSPIyVR0nlz++I2NIl
         s0B/7ZcnRcwIWWeq2hgm+2sW41YTQlG1Slb0x8OaHv/iOpnI7UZzIjJkn5HYehI0JIuu
         CZWOw6vAB3qQJKtjE8FJLeHe4V4XZSlNi+9PJdm+v/OmzNbexHIVX4LhE7gz8kYfpz+j
         Ara94J16CcWxplytrkDr4RBINSuZidgK8UPjy64+WQBzKb/d37Y4UGxumyCDRIhRLQUi
         l27w==
X-Gm-Message-State: APjAAAXJcO/3BpS0pcEoyiWp3GhUHDQdFfEoEsEWhDZ6uNqF77sqYgQY
        HJSCgvP9QY+LOGNlDHXbRpTEHRvM
X-Google-Smtp-Source: APXvYqyyNUsriZFwlNNi9BYNctRtO2Ir6dekDtDCQOGJakWCRwdlJTZtC/P8pWDGVUU7/R80WMqfNQ==
X-Received: by 2002:a17:902:302:: with SMTP id 2mr275822pld.232.1556752363524;
        Wed, 01 May 2019 16:12:43 -0700 (PDT)
Received: from localhost ([61.68.7.233])
        by smtp.gmail.com with ESMTPSA id i10sm93944058pfj.7.2019.05.01.16.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 16:12:42 -0700 (PDT)
Date:   Thu, 02 May 2019 09:12:34 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4] powerpc/pseries: Remove limit in wait for dying CPU
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <20190423223914.3882-1-bauerman@linux.ibm.com>
        <877ebbsb8u.fsf@linux.ibm.com> <87v9yve02x.fsf@morokweng.localdomain>
        <8736lyrzmh.fsf@linux.ibm.com>
In-Reply-To: <8736lyrzmh.fsf@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1556752043.jyg2z3kgaw.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch's on May 2, 2019 12:57 am:
> Hi Thiago,
>=20
> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>> Nathan Lynch <nathanl@linux.ibm.com> writes:
>>> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>>>> +		while (true) {
>>>>  			cpu_status =3D smp_query_cpu_stopped(pcpu);
>>>>  			if (cpu_status =3D=3D QCSS_STOPPED ||
>>>>  			    cpu_status =3D=3D QCSS_HARDWARE_ERROR)
>>>>  				break;
>>>> -			cpu_relax();
>>>> +			udelay(100);
>>>>  		}
>>>>  	}
>>>
>>> I agree with looping indefinitely but doesn't it need a cond_resched()
>>> or similar check?
>>
>> If there's no kernel or hypervisor bug, it shouldn't take more than a
>> few tens of ms for this loop to complete (Gautham measured a maximum of
>> 10 ms on a POWER9 with an earlier version of this patch).
>=20
> 10ms is twice the default scheduler quantum...
>=20
>=20
>> In case of bugs related to CPU hotplug (either in the kernel or the
>> hypervisor), I was hoping that the resulting lockup warnings would be a
>> good indicator that something is wrong. :-)
>=20
> Not convinced we should assume something is wrong if it takes a few
> dozen ms to complete the operation.

Right, and if there is no kernel or hypervisor bug then it will stop
eventually :)

> AFAIK we don't have any guarantees
> about the maximum latency of stop-self, and it can be affected by other
> activity in the system, whether we're in shared processor mode, etc. Not
> to mention smp_query_cpu_stopped has to acquire the global RTAS lock and
> be serialized with other tasks calling into RTAS. So I am concerned
> about generating spurious warnings here.

Agreed.

>=20
> If for whatever reason the operation is taking too long, drmgr or
> whichever application is initiating the change will appear to stop
> making progress. It's not too hard to find out what's going on with
> facilities like perf or /proc/pid/stack.
>=20
>=20
>> Though perhaps adding a cond_resched() every 10 ms or so, with a
>> WARN_ON() if it loops for more than 50 ms would be better.
>=20
> A warning doesn't seem appropriate to me, and cond_resched should be
> invoked in each iteration. Or just msleep(1) in each iteration would be
> fine, I think.
>=20
> But I'd like to bring in some more context -- here is the body of
> pseries_cpu_die:
>=20
> static void pseries_cpu_die(unsigned int cpu)
> {
> 	int tries;
> 	int cpu_status =3D 1;
> 	unsigned int pcpu =3D get_hard_smp_processor_id(cpu);
>=20
> 	if (get_preferred_offline_state(cpu) =3D=3D CPU_STATE_INACTIVE) {
> 		cpu_status =3D 1;
> 		for (tries =3D 0; tries < 5000; tries++) {
> 			if (get_cpu_current_state(cpu) =3D=3D CPU_STATE_INACTIVE) {
> 				cpu_status =3D 0;
> 				break;
> 			}
> 			msleep(1);
> 		}
> 	} else if (get_preferred_offline_state(cpu) =3D=3D CPU_STATE_OFFLINE) {
>=20
> 		for (tries =3D 0; tries < 25; tries++) {
> 			cpu_status =3D smp_query_cpu_stopped(pcpu);
> 			if (cpu_status =3D=3D QCSS_STOPPED ||
> 			    cpu_status =3D=3D QCSS_HARDWARE_ERROR)
> 				break;
> 			cpu_relax();
> 		}
> }
>=20
> This patch alters the behavior of the second loop (the CPU_STATE_OFFLINE
> branch). The CPU_STATE_INACTIVE branch is used when the offline behavior
> is to use H_CEDE instead of stop-self, correct?
>=20
> And isn't entering H_CEDE expected to be quite a bit faster than
> stop-self? If so, why does that path get five whole seconds[*] while
> we're bikeshedding about tens of milliseconds for stop-self? :-)
>=20
> [*] And should it be made to retry indefinitely as well?

I think so.

Thanks,
Nick
=
