Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E0FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB0221841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jy0SZCi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDKIVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:21:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34563 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:21:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so3111210pfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x5h7Quj0tXRxd/SE7AiT7s6wXF43oR7OzHUqvZjnKpQ=;
        b=jy0SZCi+pWx8uB8ma2UCLVI1vz/EEA1BX4dttD6LhF5h6sC3eegLKfm+Al5eNnKU8U
         +1sXc+kTWa2l837J1+O9t43gLGWhj0lRJwNGJ7OXwOdRhd7hzM6UK5Zc/SrgaFEGs+GP
         AABoYa83ejAeqjyImNz4uQZ9oNScEIdlwd3/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5h7Quj0tXRxd/SE7AiT7s6wXF43oR7OzHUqvZjnKpQ=;
        b=HLHya/s7upJyBCg2F/YeQgxogFej26sRQGdV26t9h+XEi3C5kxw+IbSLkrxKECo0hW
         xzVuFKGjxu76Ht5Y6wAXnu1H8dlgukcE63e4Y6yyANG1ZgaRiXFuZ2To1NQQjkwQPjQa
         JfUnH2jOiKnhq6mrp5O/Qc2jdGQWZgDgJMxo/OsXwl2tCsyjYiLn7CLFpezm25hbVVOC
         R4Va0gVDr6ELUuH+owvE2z4O4wEtRrNwvfRYmvzQeTFiDng8tSD4atLzFhzUasVQ8iF/
         TQ3Y3mZQi53fIr9+3+pP0Z649W7+hlxcsIQ1nmcj9S48FqY4kjbC4+1sQ3FyG0h0AecA
         +91g==
X-Gm-Message-State: APjAAAV9/QNgJsDdnaAbM0DiWjkUeWIAIe1JAgID7aNGb6+uqJjRdsGp
        YeTnxGCzKArTDVTHzZsy1bxpKg==
X-Google-Smtp-Source: APXvYqwfeRrQdXvS90QIzygIy3ETIzzbat7CcN8LrjMjTK0kqhCovtqx+tq1IR2mmUsewEzS2ZmUsA==
X-Received: by 2002:a62:4602:: with SMTP id t2mr48196429pfa.26.1554970868650;
        Thu, 11 Apr 2019 01:21:08 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h187sm69552922pfc.52.2019.04.11.01.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 01:21:07 -0700 (PDT)
Date:   Thu, 11 Apr 2019 04:21:06 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, mathieu.desnoyers@efficios.com,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/3] module: Make __tracepoints_ptrs as read-only
Message-ID: <20190411082106.GB167446@google.com>
References: <20190410195708.162185-1-joel@joelfernandes.org>
 <20190410195708.162185-3-joel@joelfernandes.org>
 <20190410161112.540017d9@gandalf.local.home>
 <20190410202902.GA167446@google.com>
 <20190410204401.62f928ca@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410204401.62f928ca@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 08:44:01PM -0400, Steven Rostedt wrote:
> On Wed, 10 Apr 2019 16:29:02 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > The srcu structure pointer array is modified at module load time because the
> > array is fixed up by the module loader at load-time with the final locations
> > of the tracepoints right?  Basically relocation fixups. At compile time, I
> > believe it is not know what the values in the ptr array are. I believe same
> > is true for the tracepoint ptrs array.
> > 
> > Also it needs to be in a separate __tracepoint_ptrs so that this code works:
> > 
> > 
> > #ifdef CONFIG_TRACEPOINTS
> > 	mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
> > 					     sizeof(*mod->tracepoints_ptrs),
> > 					     &mod->num_tracepoints);
> > #endif
> > 
> > Did I  miss some point? Thanks,
> 
> But there's a lot of others too. Hmm, does this mean that the RO data
> sections that are in modules are not set to RO?
> 
> There's a bunch of separate sections that are RO. Just look in
> include/asm-generic/vmlinux.lds.h under the RO_DATA_SECTION() macro.
> 
> A lot of the sections saved in module.c:find_module_sections() are in
> that RO_DATA when compiled as a builtin. Are they not RO when loaded via
> a module?
> 
> If this is the case, there probably is going to be a lot more sections
> added to your list.

Hi Steven,

You are right. It turns out that this patch for tracepoint is not needed
since each tracepoint pointer is marked as a const which automatically makes
the section non-writable after relocations..

#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
typedef const int tracepoint_ptr_t;
#else
typedef struct tracepoint * const tracepoint_ptr_t;
#endif

So the fix for SRCU could just be the following. I verified with the change
that the ELF section section is marked only with the ALLOCATE flag, not the
WRITE flag which should automatically put the srcu pointer array in rodata.
I'll test this out tomorrow.

Patch 2/3 and 3/3 would not be nececessary if this works out. 1/3 may be a
nice clean up but is not something urgent and we could do that in the future
if needed.

Any thoughts? Thanks a lot for the review!

(I believe it is still worth auditing other sections in built-in RODATA and
making sure they are non-writable for modules as well).

---8<-----------------------

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 8af1824c46a8..9cfcc8a756ae 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -123,7 +123,7 @@ struct srcu_struct {
 #ifdef MODULE
 # define __DEFINE_SRCU(name, is_static)					\
 	is_static struct srcu_struct name;				\
-	struct srcu_struct *__srcu_struct_##name			\
+	struct srcu_struct * const __srcu_struct_##name			\
 		__section("___srcu_struct_ptrs") = &name
 #else
 # define __DEFINE_SRCU(name, is_static)					\

