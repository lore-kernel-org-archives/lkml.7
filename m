Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1942FC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CA921D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YD04qUB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfJBQfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:35:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55140 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbfJBQff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570034133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FM5LLs+TvzKar5DtD/uYlq9MCr5zVbaGblcCYtiEdvs=;
        b=YD04qUB/reAvsEmnbfatR1lUtefSeZwfNr1panAv0+EytllD/CqNRkTfpoF8ZI5OY8qvCx
        kt2NvoHMffd4kGaRHjGpA/qOJA5+TGeJnT+TMOhgHaO7sGMOX5WEC3JCZn5jeveugCd6fX
        I7uZS9l46F9ddL98ax8EF+mrtiIlWmA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-kToxjK3ZNQufjNuS8czAdQ-1; Wed, 02 Oct 2019 12:35:30 -0400
Received: by mail-wr1-f71.google.com with SMTP id k2so2539968wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Knb2soKexzlZkH783c0E4ARVm3Fc1i2D/HhO5ZHPcso=;
        b=qOeucLycuLTmABpnk+kPbpXNaVOBX5w9/YrBe3Habzc97qKEdGkkq2+Ksz9OKee/IB
         4b/mxYtGC1hN9pjXgnscVO7uDygcKiddRVZ7gMgkDFGp72pVn7rhr9aAjmZs5NApQDmv
         u2TVqDhCpKKGfNtx6OEVBjLBmwcQ+aHqaDkXqRxKc8/tYKxrvSqn+kxE19hbclFjZ0u+
         zE1seWeuI5u8EApjYFJhfsK9DmCmUh1gojByxJfEYxbhiqIQXt1xnItU6CxRYDDUoX7b
         KXFVCFp+7oDWIRDQ7Rf8R3vmPD1SxRqY4Lsndtkcxavj42RkZ68INsnicJ6tNaUKvbLR
         IISw==
X-Gm-Message-State: APjAAAVFSCHjcZDnAAyiQ9eu95UIrh8OSp6iDkwH1wtuU3fWW4LMKfiy
        qkyKr2kWL91EcCIAlwP2GhW1OBBADaCTETXbQw0H6x0VsBn6+wxbvuCeKQgQFLeDYxwbNjjdca/
        knTX1MSJk6jnH7HGmNzx20DNS
X-Received: by 2002:a5d:44d2:: with SMTP id z18mr3557036wrr.122.1570034128801;
        Wed, 02 Oct 2019 09:35:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyZs3AXg7s1WNYsPo0OvtodR9a/ku/xMwyUfKYMkL7b3kdutTnWdQti4qPCwGPLzHRRujFYAA==
X-Received: by 2002:a5d:44d2:: with SMTP id z18mr3556998wrr.122.1570034128324;
        Wed, 02 Oct 2019 09:35:28 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.82.15])
        by smtp.gmail.com with ESMTPSA id f18sm6972282wmh.43.2019.10.02.09.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 09:35:27 -0700 (PDT)
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
To:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.166658077@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
Date:   Wed, 2 Oct 2019 18:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190827181147.166658077@infradead.org>
Content-Language: en-US
X-MC-Unique: kToxjK3ZNQufjNuS8czAdQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2019 20:06, Peter Zijlstra wrote:
> Move ftrace over to using the generic x86 text_poke functions; this
> avoids having a second/different copy of that code around.
>=20
> This also avoids ftrace violating the (new) W^X rule and avoids
> fragmenting the kernel text page-tables, due to no longer having to
> toggle them RW.

I tested this patch, and it works... but it generates more IPIs than the
previous one.

> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/ftrace.h |    2=20
>  arch/x86/kernel/alternative.c |    4=20
>  arch/x86/kernel/ftrace.c      |  630 ++++++-----------------------------=
-------
>  arch/x86/kernel/traps.c       |    9=20
>  4 files changed, 93 insertions(+), 552 deletions(-)
>=20
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h

[ ... jumping to the point ...]

> -
>  void ftrace_replace_code(int enable)
>  {
>  =09struct ftrace_rec_iter *iter;
>  =09struct dyn_ftrace *rec;
> -=09const char *report =3D "adding breakpoints";
> -=09int count =3D 0;
> +=09const char *new, *old;
>  =09int ret;
> =20
>  =09for_ftrace_rec_iter(iter) {
>  =09=09rec =3D ftrace_rec_iter_record(iter);
> =20
> -=09=09ret =3D add_breakpoints(rec, enable);
> -=09=09if (ret)
> -=09=09=09goto remove_breakpoints;
> -=09=09count++;
> -=09}
> -
> -=09run_sync();

ftrace was already batching the updates, for instance, causing 3 IPIs to en=
able
all functions. The text_poke() batching also works. But because of the limi=
ted
buffer [ see the reply to the patch 2/3 ], it is flushing the buffer during=
 the
operation, causing more IPIs than the previous code. Using the 5.4-rc1 in a=
 VM,
when enabling the function tracer, I see 250+ intermediate text_poke_finish=
()
because of a full buffer...

Would this be the case of trying to use a dynamically allocated buffer?

Thoughts?

-- Daniel

> -
> -=09report =3D "updating code";
> -=09count =3D 0;
> -
> -=09for_ftrace_rec_iter(iter) {
> -=09=09rec =3D ftrace_rec_iter_record(iter);
> -
> -=09=09ret =3D add_update(rec, enable);
> -=09=09if (ret)
> -=09=09=09goto remove_breakpoints;
> -=09=09count++;
> +=09=09switch (ftrace_test_record(rec, enable)) {
> +=09=09case FTRACE_UPDATE_IGNORE:
> +=09=09default:
> +=09=09=09continue;
> +
> +=09=09case FTRACE_UPDATE_MAKE_CALL:
> +=09=09=09old =3D ftrace_nop_replace();
> +=09=09=09break;
> +
> +=09=09case FTRACE_UPDATE_MODIFY_CALL:
> +=09=09case FTRACE_UPDATE_MAKE_NOP:
> +=09=09=09old =3D ftrace_call_replace(rec->ip, ftrace_get_addr_curr(rec))=
;
> +=09=09=09break;
> +=09=09};
> +
> +=09=09ret =3D ftrace_verify_code(rec->ip, old);
> +=09=09if (ret) {
> +=09=09=09ftrace_bug(ret, rec);
> +=09=09=09return;
> +=09=09}
>  =09}
> =20
> -=09run_sync();
> -
> -=09report =3D "removing breakpoints";
> -=09count =3D 0;
> -
>  =09for_ftrace_rec_iter(iter) {
>  =09=09rec =3D ftrace_rec_iter_record(iter);
> =20
> -=09=09ret =3D finish_update(rec, enable);
> -=09=09if (ret)
> -=09=09=09goto remove_breakpoints;
> -=09=09count++;
> -=09}
> -
> -=09run_sync();
> -
> -=09return;
> +=09=09switch (ftrace_test_record(rec, enable)) {
> +=09=09case FTRACE_UPDATE_IGNORE:
> +=09=09default:
> +=09=09=09continue;
> +
> +=09=09case FTRACE_UPDATE_MAKE_CALL:
> +=09=09case FTRACE_UPDATE_MODIFY_CALL:
> +=09=09=09new =3D ftrace_call_replace(rec->ip, ftrace_get_addr_new(rec));
> +=09=09=09break;
> +
> +=09=09case FTRACE_UPDATE_MAKE_NOP:
> +=09=09=09new =3D ftrace_nop_replace();
> +=09=09=09break;
> +=09=09};
> =20
> - remove_breakpoints:
> -=09pr_warn("Failed on %s (%d):\n", report, count);
> -=09ftrace_bug(ret, rec);
> -=09for_ftrace_rec_iter(iter) {
> -=09=09rec =3D ftrace_rec_iter_record(iter);
> -=09=09/*
> -=09=09 * Breakpoints are handled only when this function is in
> -=09=09 * progress. The system could not work with them.
> -=09=09 */
> -=09=09if (remove_breakpoint(rec))
> -=09=09=09BUG();
> +=09=09text_poke_queue((void *)rec->ip, new, MCOUNT_INSN_SIZE, NULL);
> +=09=09ftrace_update_record(rec, enable);
>  =09}
> -=09run_sync();
> -}
> -
> -static int
> -ftrace_modify_code(unsigned long ip, unsigned const char *old_code,
> -=09=09   unsigned const char *new_code)
> -{
> -=09int ret;
> -
> -=09ret =3D add_break(ip, old_code);
> -=09if (ret)
> -=09=09goto out;
> -
> -=09run_sync();
> -
> -=09ret =3D add_update_code(ip, new_code);
> -=09if (ret)
> -=09=09goto fail_update;
> -
> -=09run_sync();
> -
> -=09ret =3D ftrace_write(ip, new_code, 1);
> -=09/*
> -=09 * The breakpoint is handled only when this function is in progress.
> -=09 * The system could not work if we could not remove it.
> -=09 */
> -=09BUG_ON(ret);
> - out:
> -=09run_sync();
> -=09return ret;
> -
> - fail_update:
> -=09/* Also here the system could not work with the breakpoint */
> -=09if (ftrace_write(ip, old_code, 1))
> -=09=09BUG();
> -=09goto out;
> +=09text_poke_finish();
>  }
> =20
>  void arch_ftrace_update_code(int command)
>  {
> -=09/* See comment above by declaration of modifying_ftrace_code */
> -=09atomic_inc(&modifying_ftrace_code);
> -
>  =09ftrace_modify_all_code(command);
> -
> -=09atomic_dec(&modifying_ftrace_code);
>  }
> =20
>  int __init ftrace_dyn_arch_init(void)
> @@ -828,11 +394,7 @@ create_trampoline(struct ftrace_ops *ops
> =20
>  =09set_vm_flush_reset_perms(trampoline);
> =20
> -=09/*
> -=09 * Module allocation needs to be completed by making the page
> -=09 * executable. The page is still writable, which is a security hazard=
,
> -=09 * but anyhow ftrace breaks W^X completely.
> -=09 */
> +=09set_memory_ro((unsigned long)trampoline, npages);
>  =09set_memory_x((unsigned long)trampoline, npages);
>  =09return (unsigned long)trampoline;
>  fail:
> @@ -859,11 +421,10 @@ static unsigned long calc_trampoline_cal
>  void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
>  {
>  =09ftrace_func_t func;
> -=09unsigned char *new;
>  =09unsigned long offset;
>  =09unsigned long ip;
>  =09unsigned int size;
> -=09int ret, npages;
> +=09const char *new;
> =20
>  =09if (ops->trampoline) {
>  =09=09/*
> @@ -872,14 +433,11 @@ void arch_ftrace_update_trampoline(struc
>  =09=09 */
>  =09=09if (!(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
>  =09=09=09return;
> -=09=09npages =3D PAGE_ALIGN(ops->trampoline_size) >> PAGE_SHIFT;
> -=09=09set_memory_rw(ops->trampoline, npages);
>  =09} else {
>  =09=09ops->trampoline =3D create_trampoline(ops, &size);
>  =09=09if (!ops->trampoline)
>  =09=09=09return;
>  =09=09ops->trampoline_size =3D size;
> -=09=09npages =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
>  =09}
> =20
>  =09offset =3D calc_trampoline_call_offset(ops->flags & FTRACE_OPS_FL_SAV=
E_REGS);
> @@ -887,15 +445,11 @@ void arch_ftrace_update_trampoline(struc
> =20
>  =09func =3D ftrace_ops_get_func(ops);
> =20
> -=09ftrace_update_func_call =3D (unsigned long)func;
> -
> +=09mutex_lock(&text_mutex);
>  =09/* Do a safe modify in case the trampoline is executing */
>  =09new =3D ftrace_call_replace(ip, (unsigned long)func);
> -=09ret =3D update_ftrace_func(ip, new);
> -=09set_memory_ro(ops->trampoline, npages);
> -
> -=09/* The update should never fail */
> -=09WARN_ON(ret);
> +=09text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
> +=09mutex_unlock(&text_mutex);
>  }
> =20
>  /* Return the address of the function the trampoline calls */
> @@ -981,19 +535,18 @@ void arch_ftrace_trampoline_free(struct
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  extern void ftrace_graph_call(void);
> =20
> -static unsigned char *ftrace_jmp_replace(unsigned long ip, unsigned long=
 addr)
> +static const char *ftrace_jmp_replace(unsigned long ip, unsigned long ad=
dr)
>  {
> -=09return ftrace_text_replace(0xe9, ip, addr);
> +=09return ftrace_text_replace(JMP32_INSN_OPCODE, ip, addr);
>  }
> =20
>  static int ftrace_mod_jmp(unsigned long ip, void *func)
>  {
> -=09unsigned char *new;
> +=09const char *new;
> =20
> -=09ftrace_update_func_call =3D 0UL;
>  =09new =3D ftrace_jmp_replace(ip, (unsigned long)func);
> -
> -=09return update_ftrace_func(ip, new);
> +=09text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL); // BATCH
> +=09return 0;
>  }
> =20
>  int ftrace_enable_ftrace_graph_caller(void)
> @@ -1019,10 +572,9 @@ int ftrace_disable_ftrace_graph_caller(v
>  void prepare_ftrace_return(unsigned long self_addr, unsigned long *paren=
t,
>  =09=09=09   unsigned long frame_pointer)
>  {
> +=09unsigned long return_hooker =3D (unsigned long)&return_to_handler;
>  =09unsigned long old;
>  =09int faulted;
> -=09unsigned long return_hooker =3D (unsigned long)
> -=09=09=09=09&return_to_handler;
> =20
>  =09/*
>  =09 * When resuming from suspend-to-ram, this function can be indirectly
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -568,15 +568,6 @@ NOKPROBE_SYMBOL(do_general_protection);
> =20
>  dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code=
)
>  {
> -#ifdef CONFIG_DYNAMIC_FTRACE
> -=09/*
> -=09 * ftrace must be first, everything else may cause a recursive crash.
> -=09 * See note by declaration of modifying_ftrace_code in ftrace.c
> -=09 */
> -=09if (unlikely(atomic_read(&modifying_ftrace_code)) &&
> -=09    ftrace_int3_handler(regs))
> -=09=09return;
> -#endif
>  =09if (poke_int3_handler(regs))
>  =09=09return;
> =20
>=20
>=20

