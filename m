Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE1C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1462077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BkUbQrGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfLJSGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:06:25 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36308 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfLJSGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:06:24 -0500
Received: by mail-qk1-f194.google.com with SMTP id a203so7090051qkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 10:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ej5zHVJ46gFguDpJo2p0qEQYTYjkQo4T7UxAGTynAo0=;
        b=BkUbQrGTe2NeMZ1ydN+rHkRp8gFZuTlahiy0oMc0nQR7SczMlE2pdmUqMBDQF0wfOv
         lY5aQukfs723omxPmof90KoRoLZ2YvVpB5X8n4nz7lyTGe3IGaEpXGZr6syNEkyAu7Ea
         lzX4NUL0g1dLgfJUzXlRaLcyVktQ81l1J8ywPnwZws0QafJtytTrmmreENsJ1gULy6eP
         VD6qGIXaEtKwUPpc9u/gyCEvGCfPld8Efn4dVW/39Wkr1zjBYhQlmC9jpqYHjtGPuAwf
         6EK3nSSYP5z2gw4YREcu5ebJS3uUB0sI2tAJ+S0tr4DBi7qVTCVF5ptIOK/YwZPhlZGL
         +u1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ej5zHVJ46gFguDpJo2p0qEQYTYjkQo4T7UxAGTynAo0=;
        b=ZFNNivtvMKK1If5EPpshKtej5/v4fSUDAHi7HghTTUQ7bNY5AfZx13uUP8v8OFMrNM
         duqWR5l3jiHcYuty2M4RnE1QQvwIFFRSi3JC7r2rClan3QrchxCVy0/8q3mEmtqtXG/f
         y9tuAWwYSL2wTq6buPZs7PxOO8lQBpoqoy+3GiP1sYCroNJKl2roFQlkbgaa+/ayI20E
         kAG8yGiE+lVVcTQOPVuHNreHUCwBzgZYNm41DvyHFu51rJGejMRX0T+x3iwdlNOOXi1R
         iTHcLgIKZGIZ1G2NPlP5A1EHpBkWrZ3LJgslvECfoldBo1/cN+4jgPG1o51/ZhkGZ3k3
         5C4Q==
X-Gm-Message-State: APjAAAWDwSfvnDrAYxEEjI+HL8SNIz86qM4pRHTSa/WEas/f0JS7ElNL
        4js0RVuhJOGyDUHIvRQeS0cOgw==
X-Google-Smtp-Source: APXvYqxBE8HQ4QZHjqE3+HueaVZOo7oHQh1eWnPai3uY+CoeEL9zi484ciCITTPE9GaUkuHgHX+xeQ==
X-Received: by 2002:a37:6087:: with SMTP id u129mr33281505qkb.219.1576001183308;
        Tue, 10 Dec 2019 10:06:23 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c6sm1139390qka.111.2019.12.10.10.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 10:06:22 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] x86/resctrl: fix an imbalance in domain_remove_cpu
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CADjb_WRmyE3rRN2sLAh9ZOqAg0E3WeCkj9SwSM9dorvx4TGC2A@mail.gmail.com>
Date:   Tue, 10 Dec 2019 13:06:20 -0500
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        Tony Luck <tony.luck@intel.com>, tj@kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9061BAA-DF55-402D-967C-33CF332B10EE@lca.pw>
References: <20191208041318.3702-1-cai@lca.pw>
 <CADjb_WRmyE3rRN2sLAh9ZOqAg0E3WeCkj9SwSM9dorvx4TGC2A@mail.gmail.com>
To:     Ryan Chen <yu.chen.surf@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 10, 2019, at 2:55 AM, Ryan Chen <yu.chen.surf@gmail.com> wrote:
>=20
> Hi Qian,
>=20
> On Sun, Dec 8, 2019 at 12:14 PM Qian Cai <cai@lca.pw> wrote:
>>=20
>> domain_add_cpu() calls domain_setup_mon_state() only when =
r->mon_capable
>> is true where it will initialize d->mbm_over. However,
>> domain_remove_cpu() calls cancel_delayed_work(&d->mbm_over) without
>> checking r->mon_capable. Hence, it triggers a debugobjects warning =
when
>> offlining CPUs because those timer debugobjects are never =
initialized.
>>=20
> Could you elaborate a little more on the failure symptom?
> If I understand correctly, the error you described was  due to
> r->mon_capable set to false while is_mbm_enabled() returns true?
> Which means on this platform rdt_mon_features is non zero?
> And in get_rdt_mon_resources() it will invoke rdt_get_mon_l3_config(),
> however the only possible failure to do not set r->mon_capable is that =
it
> failed in dom_data_init() due to kcalloc() failure?  Then the logic in
> get_rdt_resources() is that it will ignore the return error if rdt =
allocate
> feature is supported on this platform?  If this is the case, the =
r->mon_capable
> is not an indicator for whether the overflow thread has been created, =
right?
> Can we simply remove the check of r->mon_capable in domain_add_cpu() =
and
> invoke  domain_setup_mon_state() directly?

Actually,

domain_add_cpu r->name =3D L3, r->alloc_capable =3D 1, r->mon_capable =3D =
1
domain_add_cpu r->name =3D L3DATA, r->alloc_capable =3D 1, =
r->mon_capable =3D 0
domain_add_cpu r->name =3D L3CODE, r->alloc_capable =3D 1, =
r->mon_capable =3D 0

rdt_get_mon_l3_config() will only set r->mon_capable =3D 1 for L3.

>> ODEBUG: assert_init not available (active state 0) object type:
>> timer_list hint: 0x0
>> WARNING: CPU: 143 PID: 789 at lib/debugobjects.c:484
>> debug_print_object+0xfe/0x140
>> Hardware name: HP Synergy 680 Gen9/Synergy 680 Gen9 Compute Module, =
BIOS
>> I40 05/23/2018
>> RIP: 0010:debug_print_object+0xfe/0x140
>> Call Trace:
>> debug_object_assert_init+0x1f5/0x240
>> del_timer+0x6f/0xf0
>> try_to_grab_pending+0x42/0x3c0
>> cancel_delayed_work+0x7d/0x150
>> resctrl_offline_cpu+0x3c0/0x520
>> cpuhp_invoke_callback+0x197/0x1120
>> cpuhp_thread_fun+0x252/0x2f0
>> smpboot_thread_fn+0x255/0x440
>> kthread+0x1e6/0x210
>> ret_from_fork+0x3a/0x50
>>=20
>> Fixes: e33026831bdb ("x86/intel_rdt/mbm: Handle counter overflow")
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> arch/x86/kernel/cpu/resctrl/core.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c =
b/arch/x86/kernel/cpu/resctrl/core.c
>> index 03eb90d00af0..89049b343c7a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -618,7 +618,7 @@ static void domain_remove_cpu(int cpu, struct =
rdt_resource *r)
>>                if (static_branch_unlikely(&rdt_mon_enable_key))
>>                        rmdir_mondata_subdir_allrdtgrp(r, d->id);
>>                list_del(&d->list);
>> -               if (is_mbm_enabled())
>> +               if (r->mon_capable && is_mbm_enabled())
>>                        cancel_delayed_work(&d->mbm_over);
> Humm, it looks like there are two places within this function
> invoked cancel_delayed_work(&d->mbm_over),
> why not adding the check for both of them?

Here it only check L3, so it will skip correctly for L3DATA and L3CODE
to not call cancel_delayed_work(). Recalled the above that only L3 will
have r->capable set.

if (r =3D=3D &rdt_resources_all[RDT_RESOURCE_L3]) {
	if (is_mbm_enabled() && cpu =3D=3D d->mbm_work_cpu) {		=09=

		cancel_delayed_work(&d->mbm_over);

Hence, r->mon_capable check seems redundant here.

