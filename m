Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DD7C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F1921473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfFNIGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:06:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53591 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfFNIGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:06:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so1328391wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 01:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=brjrLWL4JqGzja9isRfXWMtKybZ6QGrjuL4EguZLxds=;
        b=s+t2LHQQuol89n0buvKllnixe4I4XDf1m2cX3MvArab4E7EbCo8yUvj51VjCroBzYE
         6wPLIH4PyF0qVd+KudWttGuxZO8Cr2w0bqV+c7wq58n+5YnolUSrQBV2QvUh+1Y6aTDo
         Sxy0N8huRipK2zaUMS85senUYn+gye7sbtN1uhWFMuTASVjZtJBj2XROhuf6Y11ZnNi4
         n2WPRDXMuMVe53Aw76Fs+9rZ9+tSfrm3lmhwNdIu4h5IcsiW3RK7YKBhyA4MhyAccpeQ
         ayZpuPTmZND9oJbleI572NuiDrPz7tFkMRG50vvrSc+ayD6s1gYzgY4JtAZMnfbjtFBX
         imtA==
X-Gm-Message-State: APjAAAXfEKiwusv3WATNq6jJ6moXpRYP3JCzLpgJXl5lxFqokyq6aX7b
        65BAcLNjUfVhz0RBl1Ziwz8+Qg==
X-Google-Smtp-Source: APXvYqwHJDyTaSrq4WgrXVTA7Ep8ta1CbNp62od8lhVoOZy25e7JaJ95qKwKmYFkG2m/gFo3I4gJSg==
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr6838905wmc.169.1560499605862;
        Fri, 14 Jun 2019 01:06:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x8sm3073690wmc.5.2019.06.14.01.06.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 01:06:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Prasanna Panchamukhi <panchamukhi@arista.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Cathy Avery <cavery@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        devel@linuxdriverproject.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/hyperv: Disable preemption while setting reenlightenment vector
In-Reply-To: <alpine.DEB.2.21.1906132059020.1791@nanos.tec.linutronix.de>
References: <20190611212003.26382-1-dima@arista.com> <8736kff6q3.fsf@vitty.brq.redhat.com> <alpine.DEB.2.21.1906132059020.1791@nanos.tec.linutronix.de>
Date:   Fri, 14 Jun 2019 10:06:43 +0200
Message-ID: <87a7ek7fqk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, 12 Jun 2019, Vitaly Kuznetsov wrote:
>> Dmitry Safonov <dima@arista.com> writes:
>> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> > index 1608050e9df9..0bdd79ecbff8 100644
>> > --- a/arch/x86/hyperv/hv_init.c
>> > +++ b/arch/x86/hyperv/hv_init.c
>> > @@ -91,7 +91,7 @@ EXPORT_SYMBOL_GPL(hv_max_vp_index);
>> >  static int hv_cpu_init(unsigned int cpu)
>> >  {
>> >  	u64 msr_vp_index;
>> > -	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
>> > +	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
>> >  	void **input_arg;
>> >  	struct page *pg;
>> >  
>> > @@ -103,7 +103,7 @@ static int hv_cpu_init(unsigned int cpu)
>> >  
>> >  	hv_get_vp_index(msr_vp_index);
>> >  
>> > -	hv_vp_index[smp_processor_id()] = msr_vp_index;
>> > +	hv_vp_index[cpu] = msr_vp_index;
>> >  
>> >  	if (msr_vp_index > hv_max_vp_index)
>> >  		hv_max_vp_index = msr_vp_index;
>> 
>> The above is unrelated cleanup (as cpu == smp_processor_id() for
>> CPUHP_AP_ONLINE_DYN callbacks), right? As I'm pretty sure these can'd be
>> preempted.
>
> They can be preempted, but they are guaranteed to run on the upcoming CPU,
> i.e. smp_processor_id() is allowed even in preemptible context as the task
> cannot migrate.
>

Ah, right, thanks! The guarantee that they don't migrate should be enough.

-- 
Vitaly
