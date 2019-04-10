Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFD9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD802082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="prWWO71w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfDJWEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:04:16 -0400
Received: from mail.efficios.com ([167.114.142.138]:44532 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJWEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:04:16 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7A6061D6EC4;
        Wed, 10 Apr 2019 18:04:14 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id UKkLdQt7k0IP; Wed, 10 Apr 2019 18:04:14 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DD78D1D6EBC;
        Wed, 10 Apr 2019 18:04:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DD78D1D6EBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554933853;
        bh=zXHo3ascIvnn6Gi8Rh+uqbICiFkpyNMt9L4NLn8wBjQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=prWWO71wYyz/ZbqR7PMsRA3g1mONVt3dv3+vihTTquv+XaM35n81jkR98FO7t4qq4
         op6kwJfSkOzZDf98o87AqztB+crKGxsDzQe2ei6R8T5FVWbfXpk3bS7JECHWD5d/Zf
         H5osmt8uaOmiiFX6qTcMCMcZp6IEwLvpkCO5/A6adULwWIilXiFF4MDb5+V0qgm7Ap
         Xc0k/mGBKTFlI/5qbtZktX893FNTfJZJMi1bHYzUWFxmj3oc0AM+Wz9msXilKnGrT1
         DQLBMqJKfxeDNK3Q2ebnoZV/bFp1SuP2lkpgALJvOOMnRvswfA1sozOtf+l05IKdhb
         L/Qa5bYbFm5vQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id MQ6eOleVNaJO; Wed, 10 Apr 2019 18:04:13 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id BB2C21D6EB5;
        Wed, 10 Apr 2019 18:04:13 -0400 (EDT)
Date:   Wed, 10 Apr 2019 18:04:13 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>, gor <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
Message-ID: <1603884360.3426.1554933853589.JavaMail.zimbra@efficios.com>
In-Reply-To: <a9508cc3-3385-256e-2f27-c1e0a770ba69@kernel.org>
References: <20190410212627.29514-1-okaya@kernel.org> <CAGXu5j+uBuPjDc+gGcxW_QoJJi7sQZ8m=Zg-Q2wKDxyTt7yGvg@mail.gmail.com> <a9508cc3-3385-256e-2f27-c1e0a770ba69@kernel.org>
Subject: Re: [PATCH v1] init: Do not select DEBUG_KERNEL by default
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: init: Do not select DEBUG_KERNEL by default
Thread-Index: t/tBgzHoDIbXdXv4lUazlpV8CgqggA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 10, 2019, at 5:53 PM, Sinan Kaya Okaya@kernel.org wrote:

> On 4/10/2019 5:45 PM, Kees Cook wrote:
>> On Wed, Apr 10, 2019 at 2:26 PM Sinan Kaya <okaya@kernel.org> wrote:
>>>
>>> We can't seem to have a kernel with CONFIG_EXPERT set but
>>> CONFIG_DEBUG_KERNEL unset these days.
>>>
>>> While some of the features under the CONFIG_EXPERT require
>>> CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
>>>
>>> The meaning of CONFIG_EXPERT and CONFIG_DEBUG_KERNEL has been
>>> mixed here.
>> 
>> I don't agree: the point of EXPERT is to show _everything_, which
>> means DEBUG_KERNEL should be selected to show those options as well. I
>> think this is fine as-is. What is the problem you want to solve?
>> 
>> I think of it as low (nothing selected) medium (DEBUG_KERNEL) and high
>> (EXPERT and DEBUG_KERNEL). So EXPERT enables DEBUG_KERNEL too.
>> 
> 
> Sure, let's see if there is a better option.
> 
> I don't want any of the debug features in my kernel but still
> need all the expert features. My kernel is considered a production
> kernel. I don't really want to ship all the good debug enables.
> 
> On the other hand, I need the features under CONFIG_EXPERT to have
> a functional system.
> 
> Let's take "multiple users" as an example.
> 
> What's the point of having a kernel without multiple users? :)
> 
> I don't see the relationship between CONFIG_DEBUG and CONFIG_EXPERT
> as none of the features except KALLSYMS depend on it. If there was
> a compile time dependency, I'd say move it to the things that need
> it as this patch suggests.
> 
> P.S. I found a circular dependency now. I can respin the patch based
> on feedback.

I think part of the issue here is that a few .c/.S files use CONFIG_DEBUG_KERNEL
as #ifdef directly, which I'm not sure was meant to be. For instance:

arch/powerpc/kernel/sysfs.c:

#ifdef CONFIG_DEBUG_KERNEL
SYSFS_SPRSETUP(hid0, SPRN_HID0);
SYSFS_SPRSETUP(hid1, SPRN_HID1);
SYSFS_SPRSETUP(hid4, SPRN_HID4);
SYSFS_SPRSETUP(hid5, SPRN_HID5);
SYSFS_SPRSETUP(ima0, SPRN_PA6T_IMA0);
SYSFS_SPRSETUP(ima1, SPRN_PA6T_IMA1);
SYSFS_SPRSETUP(ima2, SPRN_PA6T_IMA2);
SYSFS_SPRSETUP(ima3, SPRN_PA6T_IMA3);
SYSFS_SPRSETUP(ima4, SPRN_PA6T_IMA4);
SYSFS_SPRSETUP(ima5, SPRN_PA6T_IMA5);
SYSFS_SPRSETUP(ima6, SPRN_PA6T_IMA6);
SYSFS_SPRSETUP(ima7, SPRN_PA6T_IMA7);
SYSFS_SPRSETUP(ima8, SPRN_PA6T_IMA8);
SYSFS_SPRSETUP(ima9, SPRN_PA6T_IMA9);
SYSFS_SPRSETUP(imaat, SPRN_PA6T_IMAAT);
SYSFS_SPRSETUP(btcr, SPRN_PA6T_BTCR);
SYSFS_SPRSETUP(pccr, SPRN_PA6T_PCCR);
SYSFS_SPRSETUP(rpccr, SPRN_PA6T_RPCCR);
SYSFS_SPRSETUP(der, SPRN_PA6T_DER);
SYSFS_SPRSETUP(mer, SPRN_PA6T_MER);
SYSFS_SPRSETUP(ber, SPRN_PA6T_BER);
SYSFS_SPRSETUP(ier, SPRN_PA6T_IER);
SYSFS_SPRSETUP(sier, SPRN_PA6T_SIER);
SYSFS_SPRSETUP(siar, SPRN_PA6T_SIAR);
SYSFS_SPRSETUP(tsr0, SPRN_PA6T_TSR0);
SYSFS_SPRSETUP(tsr1, SPRN_PA6T_TSR1);
SYSFS_SPRSETUP(tsr2, SPRN_PA6T_TSR2);
SYSFS_SPRSETUP(tsr3, SPRN_PA6T_TSR3);
#endif /* CONFIG_DEBUG_KERNEL */


arch/mips/kernel/setup.c:

#if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
                /*
                 * This information is necessary when debugging the kernel
                 * But is a security vulnerability otherwise!
                 */
                show_kernel_relocation(KERN_INFO);
#endif

net/netfilter/core.c:

static void hooks_validate(const struct nf_hook_entries *hooks)
{
#ifdef CONFIG_DEBUG_KERNEL
        struct nf_hook_ops **orig_ops;
        int prio = INT_MIN;
        size_t i = 0;

        orig_ops = nf_hook_entries_get_hook_ops(hooks);

        for (i = 0; i < hooks->num_hook_entries; i++) {
                if (orig_ops[i] == &dummy_ops)
                        continue;

                WARN_ON(orig_ops[i]->priority < prio);

                if (orig_ops[i]->priority > prio)
                        prio = orig_ops[i]->priority;
        }
#endif
}

and also:
arch/xtensa/kernel/smp.c
arch/xtensa/kernel/entry.S

I was under the impression that config DEBUG_KERNEL was only making a
"group" of menu entries visible without any direct impact on the code,
but it does not appear to be the case for a few exceptions. Perhaps this
is the actual issue ? (and lack of documentation of this Kconfig entry)

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
