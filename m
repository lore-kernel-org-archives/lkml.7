Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406E4C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 01:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CE92084F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 01:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fpye/1uO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfIOBkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 21:40:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45130 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfIOBkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 21:40:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33so1304055edh.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 18:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6+RN58I3uX4e+kxMi088PxHU4GRRAfQ1h2bRXfJjpgg=;
        b=fpye/1uOdA27CI+WiVSAHY2FFj0ygzyL96vbWVl2S0f00HcwfRnuO9dwtmh4CWpGmh
         bn3/omY1ogZSmhi4eBKZTcohOx8sxu+ykLP8fnFJLIUewNLErExGvR3+kDs7yXubDKHS
         6OUFmTvFK8vyYZU2AaDF+x2URUFpcweSxpwrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6+RN58I3uX4e+kxMi088PxHU4GRRAfQ1h2bRXfJjpgg=;
        b=aZ/+V2oJ/6wi/A37tuouH4GQTVwj8RpRU1nh7AbqWyg071d8ijYhwYDTH7kcqwta7W
         hT9+3D90qXzdpzg4x9/pbJ+isamMvClZoXvkFB408jVYC1Asi3f8yUp4G7ns7ACkPliM
         NbiaxjQuLb//eKo4DUEulgzO7ZFSrEk2m/10q3L0lC9r7Sr3cJWQ/DqOPzklHrSPJwWg
         ZMAHOpjq/v+0nfnBwsrflwmlntEmPjBoPSN0iry2jciNuphJlHTUuSkTFSlWTfk+7QYv
         S8BE7aHBsx9pVVw2YlH1yRA4eSRwaw6YNkB+krTMk4dmM44BwTxIz/0Xj8Ma/yA9wQsx
         LJrg==
X-Gm-Message-State: APjAAAUJNs+McMnLzk1qfGnDx6puIXgQSXayzKv++0MCaV8aoH9GtGQO
        go/YPqAjDI1mEsBwO9gszPjitQ==
X-Google-Smtp-Source: APXvYqyhZyZG0Zk5f8gVKMuZRujiMstXJrPgbNBawziA4crFGm086w3dnaUv3BJXoER6Ghim5DuCMg==
X-Received: by 2002:a17:907:423e:: with SMTP id oi22mr34778743ejb.311.1568511611420;
        Sat, 14 Sep 2019 18:40:11 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id 60sm6175120edg.10.2019.09.14.18.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 18:40:10 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Sun, 15 Sep 2019 03:40:08 +0200
To:     Yonghong Song <yhs@fb.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [RFC v1 14/14] krsi: Pin arg pages only when needed
Message-ID: <20190915014008.GA19558@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
 <20190910115527.5235-15-kpsingh@chromium.org>
 <d9b7b968-c3a7-48a4-2eb0-85d5ac9dd196@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b7b968-c3a7-48a4-2eb0-85d5ac9dd196@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-Sep 00:33, Yonghong Song wrote:
> 
> 
> On 9/10/19 12:55 PM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > Adds a callback which is called when a new program is attached
> > to a hook. The callback registered by the process_exection hook
> > checks if a program that has calls to a helper that requires pages to
> > be pinned (eg. krsi_get_env_var).
> > 
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >   include/linux/krsi.h              |  1 +
> >   security/krsi/include/hooks.h     |  5 ++-
> >   security/krsi/include/krsi_init.h |  7 ++++
> >   security/krsi/krsi.c              | 62 ++++++++++++++++++++++++++++---
> >   security/krsi/ops.c               | 10 ++++-
> >   5 files changed, 77 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/krsi.h b/include/linux/krsi.h
> > index c7d1790d0c1f..e443d0309764 100644
> > --- a/include/linux/krsi.h
> > +++ b/include/linux/krsi.h
> > @@ -7,6 +7,7 @@
> >   
> >   #ifdef CONFIG_SECURITY_KRSI
> >   int krsi_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> > +extern const struct bpf_func_proto krsi_get_env_var_proto;
> >   #else
> >   static inline int krsi_prog_attach(const union bpf_attr *attr,
> >   				   struct bpf_prog *prog)
> > diff --git a/security/krsi/include/hooks.h b/security/krsi/include/hooks.h
> > index e070c452b5de..38293125ff99 100644
> > --- a/security/krsi/include/hooks.h
> > +++ b/security/krsi/include/hooks.h
> > @@ -8,7 +8,7 @@
> >    *
> >    * Format:
> >    *
> > - *   KRSI_HOOK_INIT(TYPE, NAME, LSM_HOOK, KRSI_HOOK_FN)
> > + *   KRSI_HOOK_INIT(TYPE, NAME, LSM_HOOK, KRSI_HOOK_FN, CALLBACK)
> >    *
> >    * KRSI adds one layer of indirection between the name of the hook and the name
> >    * it exposes to the userspace in Security FS to prevent the userspace from
> > @@ -18,4 +18,5 @@
> >   KRSI_HOOK_INIT(PROCESS_EXECUTION,
> >   	       process_execution,
> >   	       bprm_check_security,
> > -	       krsi_process_execution)
> > +	       krsi_process_execution,
> > +	       krsi_process_execution_cb)
> > diff --git a/security/krsi/include/krsi_init.h b/security/krsi/include/krsi_init.h
> > index 6152847c3b08..99801d5b273a 100644
> > --- a/security/krsi/include/krsi_init.h
> > +++ b/security/krsi/include/krsi_init.h
> > @@ -31,6 +31,8 @@ struct krsi_ctx {
> >   	};
> >   };
> >   
> > +typedef int (*krsi_prog_attach_t) (struct bpf_prog_array *);
> > +
> >   /*
> >    * The LSM creates one file per hook.
> >    *
> > @@ -61,6 +63,11 @@ struct krsi_hook {
> >   	 * The eBPF programs that are attached to this hook.
> >   	 */
> >   	struct bpf_prog_array __rcu	*progs;
> > +	/*
> > +	 * The attach callback is called before a new program is attached
> > +	 * to the hook and is passed the updated bpf_prog_array as an argument.
> > +	 */
> > +	krsi_prog_attach_t attach_callback;
> >   };
> >   
> >   extern struct krsi_hook krsi_hooks_list[];
> > diff --git a/security/krsi/krsi.c b/security/krsi/krsi.c
> > index 00a7150c1b22..a4443d7aa150 100644
> > --- a/security/krsi/krsi.c
> > +++ b/security/krsi/krsi.c
> > @@ -5,15 +5,65 @@
> >   #include <linux/bpf.h>
> >   #include <linux/binfmts.h>
> >   #include <linux/highmem.h>
> > +#include <linux/krsi.h>
> >   #include <linux/mm.h>
> >   
> >   #include "krsi_init.h"
> >   
> > +/*
> > + * need_arg_pages is only updated in bprm_check_security_cb
> > + * when a mutex on krsi_hook for bprm_check_security is already
> > + * held. need_arg_pages avoids pinning pages when no program
> > + * that needs them is attached to the hook.
> > + */
> > +static bool need_arg_pages;
> > +
> > +/*
> > + * Checks if the instruction is a BPF_CALL to an eBPF helper located
> > + * at the given address.
> > + */
> > +static inline bool bpf_is_call_to_func(struct bpf_insn *insn,
> > +				       void *func_addr)
> > +{
> > +	u8 opcode = BPF_OP(insn->code);
> > +
> > +	if (opcode != BPF_CALL)
> > +		return false;
> > +
> > +	if (insn->src_reg == BPF_PSEUDO_CALL)
> > +		return false;
> > +
> > +	/*
> > +	 * The BPF verifier updates the value of insn->imm from the
> > +	 * enum bpf_func_id to the offset of the address of helper
> > +	 * from the __bpf_call_base.
> > +	 */
> > +	return __bpf_call_base + insn->imm == func_addr;
> 
> In how many cases, krsi program does not have krsi_get_env_var() helper?

It depends, if the user does not choose to use log environment
variables or use the the value as a part of their MAC policy, the
pinning of the pages is not needed.

Also, the pinning is needed since eBPF helpers cannot run a non-atomic
context. It would not be needed if "sleepable eBPF" becomes a thing.

- KP

> 
> > +}
> > +
> > +static int krsi_process_execution_cb(struct bpf_prog_array *array)
> > +{
> > +	struct bpf_prog_array_item *item = array->items;
> > +	struct bpf_prog *p;
> > +	const struct bpf_func_proto *proto = &krsi_get_env_var_proto;
> > +	int i;
> > +
> > +	while ((p = READ_ONCE(item->prog))) {
> > +		for (i = 0; i < p->len; i++) {
> > +			if (bpf_is_call_to_func(&p->insnsi[i], proto->func))
> > +				need_arg_pages = true;
> > +		}
> > +		item++;
> > +	}
> > +	return 0;
> > +}
> > +
> >   struct krsi_hook krsi_hooks_list[] = {
> > -	#define KRSI_HOOK_INIT(TYPE, NAME, H, I) \
> > +	#define KRSI_HOOK_INIT(TYPE, NAME, H, I, CB) \
> >   		[TYPE] = { \
> >   			.h_type = TYPE, \
> >   			.name = #NAME, \
> > +			.attach_callback = CB, \
> >   		},
> >   	#include "hooks.h"
> >   	#undef KRSI_HOOK_INIT
> > @@ -75,9 +125,11 @@ static int krsi_process_execution(struct linux_binprm *bprm)
> >   		.bprm = bprm,
> >   	};
> >   
> > -	ret = pin_arg_pages(&ctx.bprm_ctx);
> > -	if (ret < 0)
> > -		goto out_arg_pages;
> > +	if (READ_ONCE(need_arg_pages)) {
> > +		ret = pin_arg_pages(&ctx.bprm_ctx);
> > +		if (ret < 0)
> > +			goto out_arg_pages;
> > +	}
> >   
> >   	ret = krsi_run_progs(PROCESS_EXECUTION, &ctx);
> >   	kfree(ctx.bprm_ctx.arg_pages);
> > @@ -87,7 +139,7 @@ static int krsi_process_execution(struct linux_binprm *bprm)
> >   }
> >   
> >   static struct security_hook_list krsi_hooks[] __lsm_ro_after_init = {
> > -	#define KRSI_HOOK_INIT(T, N, HOOK, IMPL) LSM_HOOK_INIT(HOOK, IMPL),
> > +	#define KRSI_HOOK_INIT(T, N, HOOK, IMPL, CB) LSM_HOOK_INIT(HOOK, IMPL),
> >   	#include "hooks.h"
> >   	#undef KRSI_HOOK_INIT
> >   };
> > diff --git a/security/krsi/ops.c b/security/krsi/ops.c
> > index 1db94dfaac15..2de682371eff 100644
> > --- a/security/krsi/ops.c
> > +++ b/security/krsi/ops.c
> > @@ -139,6 +139,14 @@ int krsi_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >   		goto unlock;
> >   	}
> >   
> > +	if (h->attach_callback) {
> > +		ret = h->attach_callback(new_array);
> > +		if (ret < 0) {
> > +			bpf_prog_array_free(new_array);
> > +			goto unlock;
> > +		}
> > +	}
> > +
> >   	rcu_assign_pointer(h->progs, new_array);
> >   	bpf_prog_array_free(old_array);
> >   
> > @@ -278,7 +286,7 @@ BPF_CALL_5(krsi_get_env_var, struct krsi_ctx *, ctx, char *, name, u32, n_size,
> >   	return get_env_var(ctx, name, dest, n_size, size);
> >   }
> >   
> > -static const struct bpf_func_proto krsi_get_env_var_proto = {
> > +const struct bpf_func_proto krsi_get_env_var_proto = {
> >   	.func = krsi_get_env_var,
> >   	.gpl_only = true,
> >   	.ret_type = RET_INTEGER,
> > 
