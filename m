Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0261C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850D820645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nMVpZ6t6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbfFXPwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:52:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45109 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbfFXPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:52:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id s22so10084654qkj.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Px55vsxlWUa+5ZAUavHWxhk2yXQs9ETqoP8b6WxOkms=;
        b=nMVpZ6t6yvkRI8JTB2fGMerawDsRhL0/iqvwIvHdoVXopMnMqU5PI/pn1syMvLqGms
         Rw2EcKCOL3MuPgQ97OgUvIP4Ut8lxtGkmBXc55ysvSxoamyi1P4HLcsx39d+QMyY81xQ
         2PQDgpcf2DGfbHVXO4YLvpkFB0G8WZeBEyQNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Px55vsxlWUa+5ZAUavHWxhk2yXQs9ETqoP8b6WxOkms=;
        b=Bbk/Uh9X2J5VDbMrUPT5/thkaJbcy+MTiZWW3toBIWW5p865RxumNUrbgeLDcn6rmc
         nIot73xnZk3djpyCQJ5qiMTr1KU3A1p0mPrUr1OSsiF7tmsQ0kqnedKWaIKZ5rHlo5s5
         vxEhASkKXhGAjqmsbTlcz9ynBN1maulkg/FCvLdtDbQx7qpMMHr2vOGIU257HS9Dl5W1
         WQes1z9w0FVYshdNkMa20Q/Lxs/XY7AKj1XU+19JlETZJWA5BzfDfpfbcAumIdF9aRxY
         +YyceX1dxIS6MpUvyeEYv2CX5K6xfh+aCApNjiYfIiiXtP/6WOg5l2FvGn7B5h7fSLyE
         LI8Q==
X-Gm-Message-State: APjAAAVhnm1j7gTufiWYNqAgs2CuX2zdaTKfX5SIXh0yBaolT3xA0fRm
        EQtMEkBLrLXIy2w18jrR87KYig==
X-Google-Smtp-Source: APXvYqz62x1HJVduMVLToA+9rhh8i9WHHNxECpdrbrsdb/x4cV/E3lswnR5g/BIEwSHX7AR5Oxy1Rg==
X-Received: by 2002:a37:ac14:: with SMTP id e20mr120205143qkm.243.1561391535368;
        Mon, 24 Jun 2019 08:52:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k58sm7173879qtc.38.2019.06.24.08.52.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 08:52:14 -0700 (PDT)
Date:   Mon, 24 Jun 2019 11:52:13 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Frank Ch. Eigler" <fche@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, jikos@kernel.org,
        mbenes@suse.cz, Petr Mladek <pmladek@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        paulmck <paulmck@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        oprofile-list@lists.sf.net, netdev <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCH 2/3] module: Fix up module_notifier return values.
Message-ID: <20190624155213.GB261936@google.com>
References: <20190624091843.859714294@infradead.org>
 <20190624092109.805742823@infradead.org>
 <320564860.243.1561384864186.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <320564860.243.1561384864186.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:01:04AM -0400, Mathieu Desnoyers wrote:
> ----- On Jun 24, 2019, at 5:18 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > While auditing all module notifiers I noticed a whole bunch of fail
> > wrt the return value. Notifiers have a 'special' return semantics.
> > 
> > Cc: Robert Richter <rric@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Cc: Song Liu <songliubraving@fb.com>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: oprofile-list@lists.sf.net
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: bpf@vger.kernel.org
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks Peter for looking into this, especially considering your
> endless love for kernel modules! ;)
> 
> It's not directly related to your changes, but I notice that
> kernel/trace/trace_printk.c:hold_module_trace_bprintk_format()
> appears to leak memory. Am I missing something ?

Could you elaborate? Do you mean there is no MODULE_STATE_GOING notifier
check? If that's what you mean then I agree, there should be some place
where the format structures are freed when the module is unloaded no?

> 
> With respect to your changes:
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Looks good to me too.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Could we CC stable so that the fix is propagated to older kernels?

thanks,

 - Joel


> I have a similar erroneous module notifier return value pattern
> in lttng-modules as well. I'll go fix it right away. CCing
> Frank Eigler from SystemTAP which AFAIK use a copy of
> lttng-tracepoint.c in their project, which should be fixed
> as well. I'm pasting the lttng-modules fix below.
> 
> Thanks!
> 
> Mathieu
> 
> --
> 
> commit 5eac9d146a7d947f0f314c4f7103c92cbccaeaf3
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Mon Jun 24 09:43:45 2019 -0400
> 
>     Fix: lttng-tracepoint module notifier should return NOTIFY_OK
>     
>     Module notifiers should return NOTIFY_OK on success rather than the
>     value 0. The return value 0 does not seem to have any ill side-effects
>     in the notifier chain caller, but it is preferable to respect the API
>     requirements in case this changes in the future.
>     
>     Notifiers can encapsulate a negative errno value with
>     notifier_from_errno(), but this is not needed by the LTTng tracepoint
>     notifier.
>     
>     The approach taken in this notifier is to just print a console warning
>     on error, because tracing failure should not prevent loading a module.
>     So we definitely do not want to stop notifier iteration. Returning
>     an error without stopping iteration is not really that useful, because
>     only the return value of the last callback is returned to notifier chain
>     caller.
>     
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> diff --git a/lttng-tracepoint.c b/lttng-tracepoint.c
> index bbb2c7a4..8298b397 100644
> --- a/lttng-tracepoint.c
> +++ b/lttng-tracepoint.c
> @@ -256,7 +256,7 @@ int lttng_tracepoint_coming(struct tp_module *tp_mod)
>                 }
>         }
>         mutex_unlock(&lttng_tracepoint_mutex);
> -       return 0;
> +       return NOTIFY_OK;
>  }
>  
>  static
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
