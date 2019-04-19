Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E6AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033C320663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9Rm0/wR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfDSS4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:56:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44152 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfDSS4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:56:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id h18so4613484lfj.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=68TXNoe1+xM5JQ/u4eCzVp2M/QEoCEujrVbcsex5r28=;
        b=R9Rm0/wRIy6/5g6TMnj5RvD7oL5Z51FEI8yYWeCQp8SKio/6jsveYvyBotprga0fIT
         GxNPo/Io7TAGAgnz7SMXSJsNXlxRqbeEHGIho8101KfEky4Y9jZqKRpr4BEl69Ng0A1N
         nqsOsy3vTkt/jjsjqtaAl4GJGtkfm1EG7hQ9dFztX9Kfkss2+7a9l0ZrZGeAqWCl1Xnm
         iQixh7ALVZDnZ7NQw2ekj0797Z6AsouXXwwoY3mpiOknEvbljywaoBV5k8RD5DLEKgl/
         A7iTZxc3jlZ21jEejuFSgq/VPygySuNRuKy5rJlfKoMiCasMhg84QnvCgZvH311j/42E
         n5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=68TXNoe1+xM5JQ/u4eCzVp2M/QEoCEujrVbcsex5r28=;
        b=Ng57vjadchKrrvlIEb6HIoUgZhz/FBztbVatg/DZ03vkWlVe4a/oBUF6rRCxMXXSGn
         TlNHq4bEhzdZ8O0ApUYH8JAJMHFc37okd0ktZgF7r59tM328nb2vfrVF6IPZqEGZ0qvH
         S2TQ6jUttrOuos8Nv5+y+QXiZA6lEcIRf4iEWfj7fR+znqY69Ok6u1qt8QLBUdc8Nk76
         q+69C+RvUD38djbttvkwRUkbLTcY2iY4/n61O0nnsPe6rqzmhVzgpw03JPBy/yrfR0l1
         TIATnvepD5GHd/lnGmwQAUU0hK9KQevZyQzyZxSIBsQEChkl98Afiw1lJLswa/uIc48B
         PizQ==
X-Gm-Message-State: APjAAAXreOMdOoDcy7OFHXby0edamYtbBexXJTkVn3AjvSKCP8JEH7JL
        H/nEgoCnE8FpHaRXgi9EBr+xEbv+0yA=
X-Google-Smtp-Source: APXvYqz5m5b6ag++LflCKpSfnwHSA+V0arpZSnsFvvtqZcfLD+mGsb6oWAHL2itIJoeyMsn0oGqd2g==
X-Received: by 2002:a19:f50e:: with SMTP id j14mr1081673lfb.11.1555672025313;
        Fri, 19 Apr 2019 04:07:05 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id g79sm992924lje.25.2019.04.19.04.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 04:07:04 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 19 Apr 2019 13:06:56 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] lib/test_vmalloc: do not create cpumask_t variable
 on stack
Message-ID: <20190419110656.znni5hdojf42iq5k@pc636>
References: <20190418193925.9361-1-urezki@gmail.com>
 <20190418151033.9e46ec06c1d7482e6dee14bc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418151033.9e46ec06c1d7482e6dee14bc@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:10:33PM -0700, Andrew Morton wrote:
> On Thu, 18 Apr 2019 21:39:25 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > On my "Intel(R) Xeon(R) W-2135 CPU @ 3.70GHz" system(12 CPUs)
> > i get the warning from the compiler about frame size:
> > 
> > <snip>
> > warning: the frame size of 1096 bytes is larger than 1024 bytes
> > [-Wframe-larger-than=]
> > <snip>
> > 
> > the size of cpumask_t depends on number of CPUs, therefore just
> > make use of cpumask_of() in set_cpus_allowed_ptr() as a second
> > argument.
> > 
> > ...
> L
> > --- a/lib/test_vmalloc.c
> > +++ b/lib/test_vmalloc.c
> > @@ -383,14 +383,14 @@ static void shuffle_array(int *arr, int n)
> >  static int test_func(void *private)
> >  {
> >  	struct test_driver *t = private;
> > -	cpumask_t newmask = CPU_MASK_NONE;
> >  	int random_array[ARRAY_SIZE(test_case_array)];
> >  	int index, i, j, ret;
> >  	ktime_t kt;
> >  	u64 delta;
> >  
> > -	cpumask_set_cpu(t->cpu, &newmask);
> > -	set_cpus_allowed_ptr(current, &newmask);
> > +	ret = set_cpus_allowed_ptr(current, cpumask_of(t->cpu));
> > +	if (ret < 0)
> > +		pr_err("Failed to set affinity to %d CPU\n", t->cpu);
> >  
> >  	for (i = 0; i < ARRAY_SIZE(test_case_array); i++)
> >  		random_array[i] = i;
> 
> lgtm.
> 
> While we're in there...
> 
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: lib/test_vmalloc.c:test_func(): eliminate local `ret'
> 
> Local 'ret' is unneeded and was poorly named: the variable `ret' generally
> means the "the value which this function will return".
> 
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Thomas Garnier <thgarnie@google.com>
> Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  lib/test_vmalloc.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> --- a/lib/test_vmalloc.c~a
> +++ a/lib/test_vmalloc.c
> @@ -384,12 +384,11 @@ static int test_func(void *private)
>  {
>  	struct test_driver *t = private;
>  	int random_array[ARRAY_SIZE(test_case_array)];
> -	int index, i, j, ret;
> +	int index, i, j;
>  	ktime_t kt;
>  	u64 delta;
>  
> -	ret = set_cpus_allowed_ptr(current, cpumask_of(t->cpu));
> -	if (ret < 0)
> +	if (set_cpus_allowed_ptr(current, cpumask_of(t->cpu)) < 0)
>  		pr_err("Failed to set affinity to %d CPU\n", t->cpu);
>  
>  	for (i = 0; i < ARRAY_SIZE(test_case_array); i++)
> @@ -415,8 +414,7 @@ static int test_func(void *private)
>  
>  		kt = ktime_get();
>  		for (j = 0; j < test_repeat_count; j++) {
> -			ret = test_case_array[index].test_func();
> -			if (!ret)
> +			if (!test_case_array[index].test_func())
>  				per_cpu_test_data[t->cpu][index].test_passed++;
>  			else
>  				per_cpu_test_data[t->cpu][index].test_failed++;
> _
> 
Agree with your slight update.

Thank you!

--
Vlad Rezki
