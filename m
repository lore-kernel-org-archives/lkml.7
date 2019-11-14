Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7016C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B14206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lVI9miOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfKNQq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:46:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44347 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNQq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:46:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id f19so4105502pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 08:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xfSItQbmHIg9vKuOP2TE+EcdIP4hP0Ip1ky2dhFAH0A=;
        b=lVI9miOLxeT7LcMCvYovJV1nlF5J4KeGsP9LKxSsE1qNomvh9oeW6bRopHG7RajCJw
         2zRnwzgtgffyZq2O6z8Phnm+Lq/2wzvXKGlkyPC+nXHoOs97AK14+QsSTudqfbbSmwLa
         NFFX7cG81F9LZpNYTFClH4FJ2GZ2YiXWlNsqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xfSItQbmHIg9vKuOP2TE+EcdIP4hP0Ip1ky2dhFAH0A=;
        b=ibZwDYBjWgV6T/GomVUImVZyNRmLvLoujmVsLL/8TpUmjMKA24z/UJoW1aN/PzIPMU
         L/hxNjEKCmp/IWPhkAIA9ive8v7DcoBYryyAn8i3pNX+0zwZhXddLkNEkL8+w3ze5FMH
         zyjF6cP+4z+K+CtJckNlwMdX1jFFYLil1qWtEJ/WWgHZTDP5CaPyANKBpdl0EBjhOEtG
         53XNl4RnwDV5tUyzfcZD+KgSS9uqJYEDXk2QZ4aLxAXQzRW6yz4Yet6fe55jHkPu3biN
         6g6MdBrHLeLtKUEMs1sJqlmUBA6xmk40gN1hDVLwihHQdV/btDJXUlbL4farbfRInCam
         yVQw==
X-Gm-Message-State: APjAAAWE/0G11su7U7I/Txvq+cXC1UnIeL8wdGCZvGKDVZntqx0oumGj
        M3wTNIfVFcLBRbNC73P/vT/tHg==
X-Google-Smtp-Source: APXvYqwiOKE5Sl39OXawAMAYr0cV2aDknPgxbhjFwjGZy5WGwi1E95tLb6ri9GkmVQnRnhr61K8X9Q==
X-Received: by 2002:a63:4961:: with SMTP id y33mr11380284pgk.264.1573749984806;
        Thu, 14 Nov 2019 08:46:24 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r16sm5219832pgl.77.2019.11.14.08.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 08:46:24 -0800 (PST)
Date:   Thu, 14 Nov 2019 11:46:22 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ioannis Ilkos <ilkos@google.com>,
        minchan@google.com, primiano@google.com, fmayer@google.com,
        hjd@google.com, joaodias@google.com, lalitm@google.com,
        rslawik@google.com, sspatil@google.com, timmurray@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] rss_stat: Add support to detect RSS updates of external
 mm
Message-ID: <20191114164622.GC233237@google.com>
References: <20191106024452.81923-1-joel@joelfernandes.org>
 <20191113153816.14b95acd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113153816.14b95acd@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 03:38:16PM -0500, Steven Rostedt wrote:
[snip]
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index dee8fc467fcf..401baaac1813 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -761,11 +761,34 @@ static int __init initialize_ptr_random(void)
> >  early_initcall(initialize_ptr_random);
> >  
> >  /* Maps a pointer to a 32 bit unique identifier. */
> > +int ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
> > +{
> > +	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
> > +	unsigned long hashval;
> > +
> > +	if (static_branch_unlikely(&not_filled_random_ptr_key))
> > +		return -EAGAIN;
> > +
> > +#ifdef CONFIG_64BIT
> > +	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
> > +	/*
> > +	 * Mask off the first 32 bits, this makes explicit that we have
> > +	 * modified the address (and 32 bits is plenty for a unique ID).
> > +	 */
> > +	hashval = hashval & 0xffffffff;
> > +#else
> > +	hashval = (unsigned long)siphash_1u32((u32)ptr, &ptr_key);
> > +#endif
> > +	*hashval_out = hashval;
> > +	return 0;
> > +}
> > +
> >  static char *ptr_to_id(char *buf, char *end, const void *ptr,
> >  		       struct printf_spec spec)
> >  {
> >  	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
> >  	unsigned long hashval;
> > +	int ret;
> >  
> >  	/* When debugging early boot use non-cryptographically secure hash. */
> >  	if (unlikely(debug_boot_weak_hash)) {
> > @@ -773,22 +796,13 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
> >  		return pointer_string(buf, end, (const void *)hashval, spec);
> >  	}
> >  
> > -	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
> > +	ret = ptr_to_hashval(ptr, &hashval);
> > +	if (ret) {
> 
> This is a hot path (used in trace_printk()), and you just turned a
> static_branch into a function call.
> 
> Can we make a __ptr_to_hashval() static inline, and have
> ptr_to_hashval() call that, but use the static inline here, where the
> static_branch gets called directly here?

Sure, like this?

---8<-----------------------

From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH] vsprintf: Inline call to ptr_to_hashval

There is concern that ptr_to_hashval not being inlined can cause performance
issues (unlike before where it was a static branch) with trace_printk being a
hot path for it. Just create an inline version called __ptr_to_hashval(), and
have the actual ptr_to_hashval() call it.

Link: http://lore.kernel.org/r/20191113153816.14b95acd@gandalf.local.home
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 lib/vsprintf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 405a8ca220a0..7c488a1ce318 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -761,7 +761,7 @@ static int __init initialize_ptr_random(void)
 early_initcall(initialize_ptr_random);
 
 /* Maps a pointer to a 32 bit unique identifier. */
-int ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
+static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
 {
 	unsigned long hashval;
 
@@ -782,6 +782,11 @@ int ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
 	return 0;
 }
 
+int ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
+{
+	return __ptr_to_hashval(ptr, hashval_out);
+}
+
 static char *ptr_to_id(char *buf, char *end, const void *ptr,
 		       struct printf_spec spec)
 {
@@ -795,7 +800,7 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
 		return pointer_string(buf, end, (const void *)hashval, spec);
 	}
 
-	ret = ptr_to_hashval(ptr, &hashval);
+	ret = __ptr_to_hashval(ptr, &hashval);
 	if (ret) {
 		spec.field_width = 2 * sizeof(ptr);
 		/* string length must be less than default_width */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

