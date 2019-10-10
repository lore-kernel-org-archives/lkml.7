Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE78ECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E46218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="m4iCbyyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfJJAnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:43:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35544 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732555AbfJJAnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:43:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id c3so1903425plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 17:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XTaq5/1iuX7y8HNzbxl3CPoidWluv+Gq3TUzaOzRrgc=;
        b=m4iCbyyuGcBMekG4jEeTZ+JSwscPAmHNJrKiyykzCU1YYzbgLoypNsggMRiKoIm+nq
         S94I27UoURdArgHG6X2igS+CAXa4Fex07lm5t/Gak6VIgPLHp4AhbQBSr1I9gD/yScq1
         sX3jOQ4l8OhZyiYgWGZ3s2KKWz5jWGoWQdUfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XTaq5/1iuX7y8HNzbxl3CPoidWluv+Gq3TUzaOzRrgc=;
        b=bzx11+dkbo6NTcdqoLdW2dOQ46jP1Oam/X7cAQENk/kF9bLS0LHzteRrwGKqjCcdMz
         eC6tiem+9UGujMumbPmdHwNFKyQ/U8ImCuu1KEeja7RoY6ocgZfUTnPEkIB6eZECXKlI
         btGll4jNq2B4yt7h1UGszK0hocCa9CgOjhfh4Hpf14hFQlPK4iRPtG6zFGUZlZhX8qTD
         s8Fz7Rkr/s6m3Kj77X5SAfFerEonc421tR1bMgf7wp+XZbonzGQRXDd8IgupntWlMQTN
         0AxaHuhcosiXA2NPRnosONm7rE54aI4ukvBBLv411dssKsjmi2dcfJ3FacKn6w38xt/s
         RMkQ==
X-Gm-Message-State: APjAAAXH9zHDFtmpJdXD5Tr5zqP46wvMdkk0yX/Cu6YdE32jf90Guedr
        9beVHV4pvrmp9hmfGYDVp1m2eQ==
X-Google-Smtp-Source: APXvYqwYcwFV08f82JUgcEcWcaOEQCDSgJsWNG9DOwYNRCdMDvFp2biCtXO4IjsvieIMMljYoBvAyQ==
X-Received: by 2002:a17:902:524:: with SMTP id 33mr6045429plf.123.1570668234782;
        Wed, 09 Oct 2019 17:43:54 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d76sm3624114pfd.185.2019.10.09.17.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 17:43:54 -0700 (PDT)
Date:   Wed, 9 Oct 2019 20:43:53 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
Message-ID: <20191010004353.GD96813@google.com>
References: <20191009203657.6070-1-joel@joelfernandes.org>
 <alpine.LRH.2.21.1910100908260.29840@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1910100908260.29840@namei.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 09:11:39AM +1100, James Morris wrote:
> On Wed, 9 Oct 2019, Joel Fernandes (Google) wrote:
> 
> >  
> > +#ifdef CONFIG_SECURITY
> > +	err = security_perf_event_alloc(event);
> > +	if (err)
> > +		goto err_security;
> > +#endif
> 
> You should not need this ifdef.

Fixed.

> > diff --git a/security/security.c b/security/security.c
> > index 1bc000f834e2..7639bca1db59 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2373,26 +2373,32 @@ int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
> >  {
> >  	return call_int_hook(bpf, 0, cmd, attr, size);
> >  }
> > +
> >  int security_bpf_map(struct bpf_map *map, fmode_t fmode)
> >  {
> >  	return call_int_hook(bpf_map, 0, map, fmode);
> >  }
> > +
> >  int security_bpf_prog(struct bpf_prog *prog)
> >  {
> >  	return call_int_hook(bpf_prog, 0, prog);
> >  }
> > +
> >  int security_bpf_map_alloc(struct bpf_map *map)
> >  {
> >  	return call_int_hook(bpf_map_alloc_security, 0, map);
> >  }
> > +
> >  int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
> >  {
> >  	return call_int_hook(bpf_prog_alloc_security, 0, aux);
> >  }
> > +
> >  void security_bpf_map_free(struct bpf_map *map)
> >  {
> >  	call_void_hook(bpf_map_free_security, map);
> >  }
> > +
> >  void security_bpf_prog_free(struct bpf_prog_aux *aux)
> >  {
> >  	call_void_hook(bpf_prog_free_security, aux);
> > @@ -2404,3 +2410,30 @@ int security_locked_down(enum lockdown_reason what)
> >  	return call_int_hook(locked_down, 0, what);
> >  }
> >  EXPORT_SYMBOL(security_locked_down);
> 
> Please avoid unrelated whitespace changes.

The author of the BPF security hooks forgot to add a newline between function
definitions and I was just cleaning the style issue since it is very close to
the parts I touched. But I will drop it from the patch per your suggestion.

thanks,

 - Joel

