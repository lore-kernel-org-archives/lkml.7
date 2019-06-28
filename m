Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DD6C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916442064B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfF1ObP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:31:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44312 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1ObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:31:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16so4670282wrl.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 07:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vIGColdwlEbXzgqC2nSGDJI+imgI3Vqv6hRTUWcURzQ=;
        b=IKO1lxe6F6+Eh0XtTiaxcQsNy4mX420Hr2POpi8SbBYYT2jUwSKtRR/nGTcJI1dtqP
         yIyyKy/aVEnDw39O1ZwM/gC79cROYEjZEv5y0xrEL0FZlpIlg3HOrnJzrTRjoQmxzBWM
         pqO/xK/41rPjIZPpnRvuUcBBTadxfyhKIP2Fs8B9CwBwUx6zobx4CbXjgDXrXXGcOhfH
         suz8ZMmoRgRYLDnkvMacShy3pu2QtrRFaWlxExjEmcMfucatoSx3E42AVqN9dul5CL5e
         NWWKXdlap0INbsOcex3vcPKuVAeHiSyswII8dDNe6ZTQKWN1TBfKdJdTbTAj0AaVAAGf
         k2DQ==
X-Gm-Message-State: APjAAAUnQ+YhvCl5E4nfKzRB0Uy2vT5IwDn3KJFwEO5bFgl/kHOERC3x
        ckwCjOSDkUXz7Dl45iC6i1SbEYAiQmA=
X-Google-Smtp-Source: APXvYqwx09hYWkLmHko84vnw++BV/pG5dTLGCo1wtOyMVyrIMDG9Y8/TsrSYd/185KxfT1jmBBtkAg==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr1636482wrm.100.1561732272911;
        Fri, 28 Jun 2019 07:31:12 -0700 (PDT)
Received: from localhost.localdomain ([151.29.165.245])
        by smtp.gmail.com with ESMTPSA id j7sm3290365wru.54.2019.06.28.07.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 07:31:11 -0700 (PDT)
Date:   Fri, 28 Jun 2019 16:31:09 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v8 5/8] cgroup/cpuset: convert cpuset_mutex to
 percpu_rwsem
Message-ID: <20190628143109.GX26005@localhost.localdomain>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-6-juri.lelli@redhat.com>
 <20190628124553.GT3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628124553.GT3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/06/19 14:45, Peter Zijlstra wrote:
> On Fri, Jun 28, 2019 at 10:06:15AM +0200, Juri Lelli wrote:
> > @@ -2154,7 +2154,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
> >  	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
> >  	cs = css_cs(css);
> >  
> > -	mutex_lock(&cpuset_mutex);
> > +	percpu_down_read(&cpuset_rwsem);
> >  
> >  	/* allow moving tasks into an empty cpuset if on default hierarchy */
> >  	ret = -ENOSPC;
> > @@ -2178,7 +2178,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
> >  	cs->attach_in_progress++;
> >  	ret = 0;
> >  out_unlock:
> > -	mutex_unlock(&cpuset_mutex);
> > +	percpu_up_read(&cpuset_rwsem);
> >  	return ret;
> >  }
> >  
> > @@ -2188,9 +2188,9 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
> >  
> >  	cgroup_taskset_first(tset, &css);
> >  
> > -	mutex_lock(&cpuset_mutex);
> > +	percpu_down_read(&cpuset_rwsem);
> >  	css_cs(css)->attach_in_progress--;
> > -	mutex_unlock(&cpuset_mutex);
> > +	percpu_up_read(&cpuset_rwsem);
> >  }
> 
> These are the only percpu_down_read()s introduced in this patch; are we
> sure this is correct? Specifically, what serializes
> ->attach_in_progress?

No, I think it's wrong, sorry. I'll change to the write variant in next
version.

Thanks,

Juri
