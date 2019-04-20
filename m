Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B787C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4CA20850
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tB2wm3wN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfDTLjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 07:39:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38043 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfDTLjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 07:39:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id g1so4144539qki.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 04:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OsDcQdZeF4Hg0g3DvskuWeoRBxlX3x0h8DSFWh8g77A=;
        b=tB2wm3wN5sca1OGJ1NXKXSbdNdgY10r6JxAD1wiGhXms3/1Tm0H9mV5Mvte+abaj47
         jLmhffjlqU2/invqray1awTRIVaHE8C2wqqRhTwXykaqFTa2JtHOnSLnWSQk+Yb2QKKK
         RhLO44tDpXiSDHkifVCguPAKKQTD7fmYU7p4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OsDcQdZeF4Hg0g3DvskuWeoRBxlX3x0h8DSFWh8g77A=;
        b=jANoALDJQM9nBAeKEy2DEQMEHZugawaQqjYw07JGPEpDAAp2kBP/efh6iC4X6hTR7Q
         HIOdToVLrB0fVYsuM4xYl4MlqQ84ntyCPSaeCL9siGKBWuJvwnuOlmoEVgXpcxmJaVTY
         D/0a1qhpOnV8y5vSV18X3ypOoWaaNfehFyYgx/8LslXNi5afy3exfxT0waN7qq2nt+bu
         nhpkNay1im7sQxvjqTdJnwBxlSWfxzG2ZSErjufvZN8Yzr0jM/XwoVyPH6ecYSgKCRqU
         MjU8e2ZxMnX5FIIG00t8dYurs5VXP+svLqTRTAxyq5cg6/78HZOShmJaeGJoPJ9+1ZXm
         8M7A==
X-Gm-Message-State: APjAAAUwdL6H23stctWpgHS8SUPplATDbx3sDUpwI8vmmPf/hoMeEeCa
        WKnC8oCHqo/7CrsRzUgA6CGQZg==
X-Google-Smtp-Source: APXvYqyLGqkjonz4aCz/+g8/U4M0XUI9Z2qmO5Y8UVUkr6H2TGM28TtLwYJ9crLkNO5jQGx3jgP2pA==
X-Received: by 2002:a37:de04:: with SMTP id h4mr6745862qkj.196.1555760340410;
        Sat, 20 Apr 2019 04:39:00 -0700 (PDT)
Received: from localhost (c-73-216-90-110.hsd1.va.comcast.net. [73.216.90.110])
        by smtp.gmail.com with ESMTPSA id u190sm3362335qkf.91.2019.04.20.04.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 04:38:59 -0700 (PDT)
Date:   Sat, 20 Apr 2019 11:38:58 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/3] module: Make __tracepoints_ptrs as read-only
Message-ID: <20190420113858.GA1058@localhost>
References: <20190410195708.162185-1-joel@joelfernandes.org>
 <20190410195708.162185-3-joel@joelfernandes.org>
 <20190410161112.540017d9@gandalf.local.home>
 <20190410202902.GA167446@google.com>
 <20190410204401.62f928ca@gandalf.local.home>
 <20190417151618.GD17099@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417151618.GD17099@linux-8ccs>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 05:16:18PM +0200, Jessica Yu wrote:
> +++ Steven Rostedt [10/04/19 20:44 -0400]:
> > On Wed, 10 Apr 2019 16:29:02 -0400
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > The srcu structure pointer array is modified at module load time because the
> > > array is fixed up by the module loader at load-time with the final locations
> > > of the tracepoints right?  Basically relocation fixups. At compile time, I
> > > believe it is not know what the values in the ptr array are. I believe same
> > > is true for the tracepoint ptrs array.
> > > 
> > > Also it needs to be in a separate __tracepoint_ptrs so that this code works:
> > > 
> > > 
> > > #ifdef CONFIG_TRACEPOINTS
> > > 	mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
> > > 					     sizeof(*mod->tracepoints_ptrs),
> > > 					     &mod->num_tracepoints);
> > > #endif
> > > 
> > > Did I  miss some point? Thanks,
> > 
> > But there's a lot of others too. Hmm, does this mean that the RO data
> > sections that are in modules are not set to RO?
> > 
> > There's a bunch of separate sections that are RO. Just look in
> > include/asm-generic/vmlinux.lds.h under the RO_DATA_SECTION() macro.
> > 
> > A lot of the sections saved in module.c:find_module_sections() are in
> > that RO_DATA when compiled as a builtin. Are they not RO when loaded via
> > a module?
> 
> Unlike the kernel, the module loader does not rely on a linker script
> to determine which sections get what protections. On module load, all
> sections in a module are looped through and those sections without the
> SHF_WRITE flag will be set to RO. For example, when there is a section
> filled with structs declared as const or if the section was explicitly
> given only the SHF_ALLOC attribute, those will be read-only. As long
> as the sections were given the correct section attributes for
> read-only, it'll have read-only protection. I see this is already the
> case for __param and  __ksymtab*/__kcrctab* sections, but I agree that
> a full audit would be useful to be consistent with builtin RO
> protections.

Thanks a lot for the explanations. Yes we dropped the patches because const
worked. This is good to know for future such ventures as well ;-)

Best,

- Joel

> Jessica
