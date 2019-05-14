Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668FCC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345DE206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557818673;
	bh=OZOGw17C5y7P4QyBq+KymGT53tFnUaLISyz6+l2ybpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iPxitVccxeRibl+eyUXhbvnwYAw5NH57hYalO5KPEXmy9xmSdmzQ5ffS06L0orJPK
	 2plxSWtzl0kg3gPNuPTOzffH1WswjV5wwaAsnU+ukw/1mWRgovQIfoG0BvG3M0hz1F
	 cn9Acl2k4tiB81MEYJFDhqN4CrtiEBvPnLzb04rY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfENHYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 03:24:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35740 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfENHYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:24:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id q15so1630736wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 00:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PMBiH0fOhoCzthvDFi4qFPlUhsDPVegxAJCzU1U6rjc=;
        b=YztrRTcrskZTvrbwYDF0cLS3u7TdUzLSXncRP92BMnh34+TLU+G98+w2ytkJPyU4eo
         GxVnT0MIPTUN6ocHPS4fV5phR3Caq3nowIt/hD3X/cGUSzeIRUBCjowpXuulJ3LvWKMl
         iYCW9JaUN+O2bUAppkUtaQS9si4znEO9fT2cv4GheHYJJs9VRyIL+DIO8uFcvBdrRllO
         sY5NVGMcAUZTT+WTD9pYdmkgTlwf2phAR1DOMo/YfEv3z3SEx0VKe+a9VxDdz57MhFmX
         GZ6fhpiWjaowvU68Whsow8DJb2qmcF+zJY6Lfm/cZywl8xqLq58tARs3rP9iT9ZCA45U
         Eesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PMBiH0fOhoCzthvDFi4qFPlUhsDPVegxAJCzU1U6rjc=;
        b=i+xsJF+XVroTfz0rYvStvv6UYPHY8Iw10eQ21BqQV/6iZN3lV9Y2LEySpgpMnhmBpS
         avHvu7I6fU6gZIO08ZGEHUymzuJn11eA+BJumRGdBvXv3nx0M4RdxpnRG/h1HElHtGDT
         cNFrwSH4+1kQ6ujA7feIccFFynZGtt1Y7NDvxywBFCGqdrUr5UUa0+SsbgmCK4c64kMk
         +HCPb8R+TPbmRJFbgghRiQJjbkal+F3oCPx/1QGzEhuGx126aTakZk+I+ayhpFEsIU9T
         zD6t9C7liyV0ekB5vltfd/tEFqpWvuJcrnjzSK2EPuMOvSH+EBGo+Q7v3X2NCgWN8RyK
         bKQw==
X-Gm-Message-State: APjAAAXqIpCGFb0ipRIu3RxIwoQJn7biBwbFK1eyWg+yBVLiMhnN/G6h
        NrNExWBarlUmu+skkuas4uA=
X-Google-Smtp-Source: APXvYqwTbsuUQu9esDd3Exdlor65xhGZroKkipycR8gB2EwgOawhHxRXpCNhBahhv/XlnunrpzbAiQ==
X-Received: by 2002:a05:600c:21d2:: with SMTP id x18mr18084274wmj.81.1557818669221;
        Tue, 14 May 2019 00:24:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i185sm1851459wmg.32.2019.05.14.00.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 00:24:28 -0700 (PDT)
Date:   Tue, 14 May 2019 09:24:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20190514072426.GB18949@gmail.com>
References: <155741476971.28419.15837024173365724167.stgit@devnote2>
 <155741481560.28419.14407082249601887394.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155741481560.28419.14407082249601887394.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> +/* Return the length of string -- including null terminal byte */
> +static nokprobe_inline int
> +fetch_store_strlen_user(unsigned long addr)
> +{
> +	return strnlen_unsafe_user((__force const void __user *)addr,
> +				   MAX_STRING_SIZE);

Pointless line break that doesn't improve readability.

> +/*
> + * Fetch a null-terminated string from user. Caller MUST set *(u32 *)buf
> + * with max length and relative data location.
> + */
> +static nokprobe_inline int
> +fetch_store_string_user(unsigned long addr, void *dest, void *base)
> +{
> +	const void __user *uaddr =  (__force const void __user *)addr;
> +	int maxlen = get_loc_len(*(u32 *)dest);
> +	u8 *dst = get_loc_data(dest, base);
> +	long ret;
> +
> +	if (unlikely(!maxlen))
> +		return -ENOMEM;
> +	ret = strncpy_from_unsafe_user(dst, uaddr, maxlen);
> +
> +	if (ret >= 0)
> +		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
> +
>  	return ret;

Firstly, why is there a 'dest' and a 'dst' variable name as well - the 
two are very similar and the difference not explained at all.

Secondly, a style nit: if you group statements then please group 
statements based on the usual logic - which is the group them by the flow 
of logic. In the above case you grouped the 'maxlen' check with the 
strncpy_from_unsafe_user() call, while the grouping should be the other 
way around:

	if (unlikely(!maxlen))
		return -ENOMEM;

	ret = strncpy_from_unsafe_user(dst, uaddr, maxlen);
	if (ret >= 0)
		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);

	return ret;

Third, hiding the get_loc_data() call within variable initialization is 
bad style - we usually only put 'trivial' (constant) initializations 
there.

Fourth, 'dst' is independent of 'maxlen', so it should probably 
calculated *after* maxlen.

I.e. the whole sequence should be:


	maxlen = get_loc_len(*(u32 *)dest);
	if (unlikely(!maxlen))
		return -ENOMEM;

	dst = get_loc_data(dest, base);

	ret = strncpy_from_unsafe_user(dst, uaddr, maxlen);
	if (ret >= 0)
		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);

	return ret;

Fifth, we don't actually dereference 'dst', do we? So the whole type 
casting to 'void *' could be avoided by declaring 'dst' (or whatever its 
new, clearer name is) not as u8 *, but as void *.

I.e. these are five problems in a short sequence of code, which it sad to 
see in a v8 submission. :-/

Please review the other patches and the whole code base for similar 
mishaps and small details as well.

Thanks,

	Ingo
