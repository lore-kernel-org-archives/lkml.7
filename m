Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DDAC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAA2227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF7bDpOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfGXIjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:39:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44785 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfGXIjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:39:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so21697533plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FHqgO2p/z4I2u+XDD6yNn9utWVx0yPtM3/euHmctUQU=;
        b=PF7bDpOUSvUfcZE50JvweWysDPjyF/Qv/PEVriZozOdZQjP2h7VYVvzXjz0ztERp2C
         2zIMOZnXV2SuszB/aSRatlvoelfp2hOjXrFKdr30yX7ZqujNkkESGBslr+wTBB3mZR6+
         MiLBgpdbb1kxn3L1Xd+zPZos5PPh/9GrG2jUQpZYONa7CdGPK8Uz52LtJDFsWRhn55Rs
         Qk/MuT5PeTXbk6wK0yDPzsjrTYepsbEuAvx+JbrPxjNdcRqCkvXn7N8RWbeKygMpD7yv
         f5qZ4wlM1X5xe2++lDW0nPxPLrdiqnBPtRpwEf9iJeP+E6JhmRPqYucf4OGXjk9Z/4CR
         tWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FHqgO2p/z4I2u+XDD6yNn9utWVx0yPtM3/euHmctUQU=;
        b=ZedYdZqA+LY0AS9Gt6S2gjbvow6tp0LLl8cevAW6SGWR0QUATusvpBYSdyrnB+vmeN
         98eJ/LiZDQMaDt1/uGHQj9R+diaCjOcjDTzwUgtkyQrjLSOIt0kOarN/IXLs7IzPduWC
         t91vbiq5B/U23JIjdVt2L4/yKWLhAd/QI7LTm61Uz8rIVAMawWonZ/oH+dNrB76KCUOa
         PeUrMVDOrqeJusDVcJlW6HbwuVQd/5P/UoY4DolIjn8GrTrmhV+y4+MiD3j3l9JZXLPj
         uugM3kCwe5hK+ypmLqTfs5H1EdZndsLvH6DMovt8HYyiidQT1S1KwejpaImTb3fiKuAq
         vPxg==
X-Gm-Message-State: APjAAAWenQabWc9RZkd9S/a7CTm4hAkyQCpB5pqnfuh9rRr/LNXXXOAC
        gttlDoE77IpXyN1/rNaOFQ==
X-Google-Smtp-Source: APXvYqygTJ317D87I9rtHMsauMlA4/8fZnFWKCpWspKF9OVEpuyQNXlzYsJmw5/VsqljlqCuLFmvWQ==
X-Received: by 2002:a17:902:9b94:: with SMTP id y20mr84534023plp.260.1563957587766;
        Wed, 24 Jul 2019 01:39:47 -0700 (PDT)
Received: from dhcp-128-55.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g92sm57950183pje.11.2019.07.24.01.39.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 01:39:47 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:39:36 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp: force all cpu to boot once under maxcpus option
Message-ID: <20190724083936.GA3965@dhcp-128-55.nay.redhat.com>
References: <1562747823-16972-1-git-send-email-kernelfans@gmail.com>
 <alpine.DEB.2.21.1907221137090.1782@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907221137090.1782@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:41:29AM +0200, Thomas Gleixner wrote:
> On Wed, 10 Jul 2019, Pingfan Liu wrote:
> >  
> > +static inline bool maxcpus_allowed(unsigned int cpu)
> > +{
> > +	/* maxcpus only takes effect during system bootup */
> > +	if (smp_boot_done)
> > +		return true;
> > +	if (num_online_cpus() < setup_max_cpus)
> > +		return true;
> > +	/*
> > +	 * maxcpus should allow cpu to set CR4.MCE asap, otherwise the set may
> > +	 * be deferred indefinitely.
> > +	 */
> > +	if (!per_cpu(cpuhp_state, cpu).booted_once)
> > +		return true;
> 
> As this is a x86 only issue, you cannot inflict this magic on every
> architecture.
OK.
In my developing patch which fixes nr_cpus issue, I takes the following way:
(I am diverted to other things, have not finished test yet, hope to
turn back soon.)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 362dd89..c009169 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -956,6 +956,87 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
        return 0;
 }

+void __init bring_capped_cpu_steady(void)
+{
[...]
+}
+
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
diff --git a/kernel/smp.c b/kernel/smp.c
index d155374..b04961c 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -560,6 +560,10 @@ void __init setup_nr_cpu_ids(void)
        nr_cpu_ids = find_last_bit(cpumask_bits(cpu_possible_mask),NR_CPUS) + 1;
 }

+void __weak bring_capped_cpu_steady(void)
+{
+}
+
 /* Called by boot processor to activate the rest. */
 void __init smp_init(void)
 {
@@ -579,6 +583,8 @@ void __init smp_init(void)
                        cpu_up(cpu);
        }

+       /* force cpus capped by nr_cpus option into steady state */
+       bring_capped_cpu_steady();
        num_nodes = num_online_nodes();


The initial motivation is to step around percpu area required by cpu hotplug
framework. But it also provide the abstraction of archs.

What do you think about resolving maxcpus by the similar abstraction?

> 
> Aside of that this does not solve the problem at all because smp_init()
> still does:
> 
>         for_each_present_cpu(cpu) {
>                 if (num_online_cpus() >= setup_max_cpus)
>                         break;
Yes, this logic should be removed, then maxcpus_allowed() can take effect. But
now, it may take a quite different way to resolve it.

Thanks for your kindly review.

Regards,
  Pingfan
>                 if (!cpu_online(cpu))
>                         cpu_up(cpu);
>         }
> 
> So the remaining CPUs are not onlined at all.
> 
> Thanks,
> 
> 	tglx
