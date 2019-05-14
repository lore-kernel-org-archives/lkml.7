Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7436AC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4582F2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557828664;
	bh=jlWbnQBxZ9xCp08E3Yubccw20rKZyvNNaAwyi3W29vI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hITWgdzUfpxD1bgrwLtupoOcb08JpOeYnxfxmpqamk5teCb6wkebAwBmLAeLLivKT
	 eDF3z8Ji99mIVEfaIiIQ9oE3X1v+FqXs+S3GOMNU8GEi2e0gxYygX+7cG+38DDywEC
	 JygB4SC4hb11alkDehWDSRM4Dde361PoICNt2Tp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfENKLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfENKLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:11:02 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 374DD2085A;
        Tue, 14 May 2019 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557828662;
        bh=jlWbnQBxZ9xCp08E3Yubccw20rKZyvNNaAwyi3W29vI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hpFI1RcexuQ35O6fl/2JOafxJ4nD6iY0+LUl6Ybc+WKECWVQJjbr5rI44ZDwb8oIS
         9vb2H5H6CI8d/rECNds1H3RKWuipl9LpXoPzP6F5E/z2428iboSpj8Tg7H0HChKbma
         QkKdAyZWmCbW7sJRgdwxvMP9//ElI9PHK5kQK3kQ=
Date:   Tue, 14 May 2019 19:10:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: Re: [PATCH -tip v8 3/6] tracing/probe: Add ustring type for
 user-space string
Message-Id: <20190514191055.311470dbf67d3cc5ac64cdfb@kernel.org>
In-Reply-To: <20190514072426.GB18949@gmail.com>
References: <155741476971.28419.15837024173365724167.stgit@devnote2>
        <155741481560.28419.14407082249601887394.stgit@devnote2>
        <20190514072426.GB18949@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 09:24:26 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > +/* Return the length of string -- including null terminal byte */
> > +static nokprobe_inline int
> > +fetch_store_strlen_user(unsigned long addr)
> > +{
> > +	return strnlen_unsafe_user((__force const void __user *)addr,
> > +				   MAX_STRING_SIZE);
> 
> Pointless line break that doesn't improve readability.

OK.

> 
> > +/*
> > + * Fetch a null-terminated string from user. Caller MUST set *(u32 *)buf
> > + * with max length and relative data location.
> > + */
> > +static nokprobe_inline int
> > +fetch_store_string_user(unsigned long addr, void *dest, void *base)
> > +{
> > +	const void __user *uaddr =  (__force const void __user *)addr;
> > +	int maxlen = get_loc_len(*(u32 *)dest);
> > +	u8 *dst = get_loc_data(dest, base);
> > +	long ret;
> > +
> > +	if (unlikely(!maxlen))
> > +		return -ENOMEM;
> > +	ret = strncpy_from_unsafe_user(dst, uaddr, maxlen);
> > +
> > +	if (ret >= 0)
> > +		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
> > +
> >  	return ret;
> 
> Firstly, why is there a 'dest' and a 'dst' variable name as well - the 
> two are very similar and the difference not explained at all.

Agreed. My bad habit, maybe '__dest' would better.

> Secondly, a style nit: if you group statements then please group 
> statements based on the usual logic - which is the group them by the flow 
> of logic. In the above case you grouped the 'maxlen' check with the 
> strncpy_from_unsafe_user() call, while the grouping should be the other 
> way around:
> 
> 	if (unlikely(!maxlen))
> 		return -ENOMEM;
> 
> 	ret = strncpy_from_unsafe_user(dst, uaddr, maxlen);
> 	if (ret >= 0)
> 		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
> 
> 	return ret;

OK.

> 
> Third, hiding the get_loc_data() call within variable initialization is 
> bad style - we usually only put 'trivial' (constant) initializations 
> there.

Hmm, it just decodes the location address from offset and start address.
Shouldn't it a trivial?
 
> Fourth, 'dst' is independent of 'maxlen', so it should probably 
> calculated *after* maxlen.

Ah, OK. I see what you pointed.

> 
> I.e. the whole sequence should be:
> 
> 
> 	maxlen = get_loc_len(*(u32 *)dest);
> 	if (unlikely(!maxlen))
> 		return -ENOMEM;
> 
> 	dst = get_loc_data(dest, base);

OK, in this case we can skip this conversion if maxlen == 0.

> 
> 	ret = strncpy_from_unsafe_user(dst, uaddr, maxlen);
> 	if (ret >= 0)
> 		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
> 
> 	return ret;
> 
> Fifth, we don't actually dereference 'dst', do we? So the whole type 
> casting to 'void *' could be avoided by declaring 'dst' (or whatever its 
> new, clearer name is) not as u8 *, but as void *.

OK, I'll use void* for that.

> 
> I.e. these are five problems in a short sequence of code, which it sad to 
> see in a v8 submission. :-/
> 
> Please review the other patches and the whole code base for similar 
> mishaps and small details as well.

OK, I'll update others too.

Thank you,

> 
> Thanks,
> 
> 	Ingo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
