Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83461C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAFE206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ny9ymfcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfDPTRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:17:05 -0400
Received: from mail.efficios.com ([167.114.142.138]:36594 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfDPTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:17:04 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B91C81D625B;
        Tue, 16 Apr 2019 15:17:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id kZGn4XvgNP51; Tue, 16 Apr 2019 15:17:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1A5A21D622E;
        Tue, 16 Apr 2019 15:17:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1A5A21D622E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555442222;
        bh=y/6N6tbNfJm0364HbI4/b5Uu1IsbPKgzPwlLxHc9JQc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ny9ymfcIdZ0opHt9w3c4f3RcjiFi8jvn5tnJgSlLUHNn48r7QSuUSjNf2AP4L5+zy
         sj/TytOeBHIDYfKQ2iHkTAQacyU74+o2lV68tHHLPpt/dvhINYDTh2B/dvb+rN8hy+
         kV9J3+L6OlFZ2dtUNl2FYmUeRWzX3droKbZ7JNV8vwAxnpIghT1vXwD4T+zR/i4IRr
         ziKvycnQZWpNgvFDZdrLghABh7zq3u0I5zLUbGoJX+KpszV91YH3bUQwUT0Q/bXKcr
         HsZ6v/kG++EQqu7qff+eiKRpnfQ2UyjT7Ia8+DHNWm2SDOKB9Hci3GMJOehPWMPcyc
         jxxbCobJHhUZQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id A8w8loTdhUNO; Tue, 16 Apr 2019 15:17:01 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id DD9B31D621C;
        Tue, 16 Apr 2019 15:17:01 -0400 (EDT)
Date:   Tue, 16 Apr 2019 15:17:01 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Guenter Roeck <groeck@google.com>,
        Kees Cook <keescook@chromium.org>, kernelci@groups.io,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Reber <adrian@lisas.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-mm <linux-mm@kvack.org>,
        Richard Guy Briggs <rgb@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, info@kernelci.org,
        rostedt <rostedt@goodmis.org>, Jason Baron <jbaron@redhat.com>,
        Rabin Vincent <rabin@rab.in>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Message-ID: <1444448267.2739.1555442221738.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAPcyv4gxk9xbsP3YSKzxu5Yp9FTefyxHc6xC33GwZ3Zf9_eeKA@mail.gmail.com>
References: <20190215185151.GG7897@sirena.org.uk> <CAGXu5jLAPKBE-EdfXkg2AK5P=qZktW6ow4kN5Yzc0WU2rtG8LQ@mail.gmail.com> <CABXOdTdVvFn=Nbd_Anhz7zR1H-9QeGByF3HFg4ZFt58R8=H6zA@mail.gmail.com> <CAGXu5j+Sw2FyMc8L+8hTpEKbOsySFGrCmFtVP5gt9y2pJhYVUw@mail.gmail.com> <CABXOdTcXWf9iReoocaj9rZ7z17zt-62iPDuvQQSrQRtMeeZNiA@mail.gmail.com> <CAPcyv4i8xhA6B5e=YBq2Z5kooyUpYZ8Bv9qov-mvqm4Uz=KLWQ@mail.gmail.com> <CABXOdTc5=J7ZFgbiwahVind-SNt7+G_-TVO=v-Y5SBVPLdUFog@mail.gmail.com> <CAPcyv4gxk9xbsP3YSKzxu5Yp9FTefyxHc6xC33GwZ3Zf9_eeKA@mail.gmail.com>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: next/master boot bisection: next-20190215 on beaglebone-black
Thread-Index: o2XfqTzgA9kPUT1d7tzJPHm/yG+fqA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Apr 16, 2019, at 2:54 PM, Dan Williams dan.j.williams@intel.com wrote:

> On Thu, Apr 11, 2019 at 1:54 PM Guenter Roeck <groeck@google.com> wrote:
> [..]
>> > > Boot tests report
>> > >
>> > > Qemu test results:
>> > >     total: 345 pass: 345 fail: 0
>> > >
>> > > This is on top of next-20190410 with CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
>> > > and the known crashes fixed.
>> >
>> > In addition to CONFIG_SHUFFLE_PAGE_ALLOCATOR=y you also need the
>> > kernel command line option "page_alloc.shuffle=1"
>> >
>> > ...so I doubt you are running with shuffling enabled. Another way to
>> > double check is:
>> >
>> >    cat /sys/module/page_alloc/parameters/shuffle
>>
>> Yes, you are right. Because, with it enabled, I see:
>>
>> Kernel command line: rdinit=/sbin/init page_alloc.shuffle=1 panic=-1
>> console=ttyAMA0,115200 page_alloc.shuffle=1
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 0 at ./include/linux/jump_label.h:303
>> page_alloc_shuffle+0x12c/0x1ac
>> static_key_enable(): static key 'page_alloc_shuffle_key+0x0/0x4' used
>> before call to jump_label_init()
> 
> This looks to be specific to ARM never having had to deal with
> DEFINE_STATIC_KEY_TRUE in the past.
> 
> I am able to avoid this warning by simply not enabling JUMP_LABEL
> support in my build.

How large is your kernel image in memory ? Is it larger than 32MB
by any chance ?

On arm, the arch_static_branch() uses a "nop" instruction, which seems
fine. However, I have a concern wrt arch_static_branch_jump():

arch/arm/include/asm/jump_label.h defines:

static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
{
        asm_volatile_goto("1:\n\t"
                 WASM(b) " %l[l_yes]\n\t"
                 ".pushsection __jump_table,  \"aw\"\n\t"
                 ".word 1b, %l[l_yes], %c0\n\t"
                 ".popsection\n\t"
                 : :  "i" (&((char *)key)[branch]) :  : l_yes);

        return false;
l_yes:
        return true;
}

Which should work fine as long as the branch target is within +/-32MB range of
the branch instruction. However, based on http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0489e/Cihfddaf.html :

"Extending branch ranges

Machine-level B and BL instructions have restricted ranges from the address of the current instruction. However, you can use these instructions even if label is out of range. Often you do not know where the linker places label. When necessary, the linker adds code to enable longer branches. The added code is called a veneer."

So if by an odd chance this branch is turned into a longer branch by the linker, then
the code pattern would be completely unexpected by arch/arm/kernel/jump_label.c.

Can you try with the following (untested) patch ?

diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
index e12d7d096fc0..b183f5bbf2e0 100644
--- a/arch/arm/include/asm/jump_label.h
+++ b/arch/arm/include/asm/jump_label.h
@@ -23,12 +23,18 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
        return true;
 }
 
+/*
+ * The linker adds veneer code if target of the branch is beyond +/-32MB
+ * range, so ensure we never patch a branch instruction.
+ */
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
        asm_volatile_goto("1:\n\t"
+                WASM(nop) "\n\t"
                 WASM(b) " %l[l_yes]\n\t"
+               "2:\n\t"
                 ".pushsection __jump_table,  \"aw\"\n\t"
-                ".word 1b, %l[l_yes], %c0\n\t"
+                ".word 1b, 2b, %c0\n\t"
                 ".popsection\n\t"
                 : :  "i" (&((char *)key)[branch]) :  : l_yes);

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
