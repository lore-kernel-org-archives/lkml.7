Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB03DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 22:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814EE2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 22:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574721685;
	bh=ZZjooJ33XLKr7eSHTXnAD3oKFG/d8kNZ0cKpNyMW/ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TNtkj/ZQQeIjrF1zFUgZaNhrx6fmgsHaIK4VZwzgp54wYH0I6WovVxkSN3eMfWITv
	 87GeK8N1ifN/yIasYi/3LZ76Ya6NlPYQ4UfTv2VRapX6xzXywGLtRn5aQ+3TU0sWCA
	 fezZ1CGquPNrqCQuiVyEvXoioRN+9z1WFV9vLDM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfKYWlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:41:24 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44470 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfKYWlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 17:41:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id m16so14376644qki.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 14:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q3hL+mhvMKtQdk1PWTs3KdMciCCix20V4ciU42QvLSs=;
        b=cbxRGVQ5MQzpVRqAv7Rvt/zeJOgAeAuisvRTR1y8nM0l8pGSvHElg7q2A7bwYUN+1w
         xPhQ/9K5XQFKbHMTmeM9EcG6ruFbyZBzzh5RY/Pk3IcnwwRFW02fqLLKWEUKOYTztQsc
         8D+bneRRVw3IHdeGZ6a9slSVh5FaTU7gFwjiS38yMVj4rO6kiKwqFpWaOASxBFOGhrXg
         KTXI7O7GEKaFBM7cgWOBqCLn2anmpGBD3pbazWccqM28DeAcdiaAdJTPUFpWVAIY9fVP
         EI/C0pwyiImB7/aykA2lP4VTXGWtRJMdxkF4/lCGV0B7Rqf180WxnbiVuy0IhUaWq5/A
         /kmg==
X-Gm-Message-State: APjAAAXEVdcP2+B/EvatbxW9f6ebhj96Q+b46yuqG5zQxONvJ8sZtURM
        hj+3ZpzeAnOjhllNvg5jZvg=
X-Google-Smtp-Source: APXvYqxcrWZDJgLEW6CjSQP+kqVtJnpLIirlkLFcgJgeSnrq0L2j9zQRMkHFw8sVKWWvY7VYiHvKzw==
X-Received: by 2002:a37:64a:: with SMTP id 71mr28528362qkg.50.1574721682681;
        Mon, 25 Nov 2019 14:41:22 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::2:6080])
        by smtp.gmail.com with ESMTPSA id o139sm4054924qke.95.2019.11.25.14.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:41:22 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:41:19 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: add __percpu to SHIFT_PERCPU_PTR
Message-ID: <20191125224119.GA37611@dennisz-mbp.dhcp.thefacebook.com>
References: <20191015102615.11430-1-ben.dooks@codethink.co.uk>
 <20191017181301.GA32546@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017181301.GA32546@dennisz-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 02:13:01PM -0400, Dennis Zhou wrote:
> On Tue, Oct 15, 2019 at 11:26:15AM +0100, Ben Dooks wrote:
> > The SHIFT_PERCPU_PTR() returns a pointer used by a number
> > of functions that expect the pointer to be __percpu annotated
> > (sparse address space 3). Adding __percpu to this makes the
> > following sparse warnings go away.
> > 
> > Note, this then creates the problem the __percup is marked
> > as noderef, which may need removing for some of the internal
> > functions, or to remove other warnings.
> > 
> > mm/vmstat.c:385:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:385:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:385:13:    got signed char *
> > mm/vmstat.c:385:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:385:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:385:13:    got signed char *
> > mm/vmstat.c:385:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:385:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:385:13:    got signed char *
> > mm/vmstat.c:385:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:385:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:385:13:    got signed char *
> > mm/vmstat.c:401:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:401:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:401:13:    got signed char *
> > mm/vmstat.c:401:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:401:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:401:13:    got signed char *
> > mm/vmstat.c:401:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:401:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:401:13:    got signed char *
> > mm/vmstat.c:401:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:401:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:401:13:    got signed char *
> > mm/vmstat.c:429:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:429:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:429:13:    got signed char *
> > mm/vmstat.c:429:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:429:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:429:13:    got signed char *
> > mm/vmstat.c:429:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:429:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:429:13:    got signed char *
> > mm/vmstat.c:429:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:429:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:429:13:    got signed char *
> > mm/vmstat.c:445:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:445:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:445:13:    got signed char *
> > mm/vmstat.c:445:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:445:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:445:13:    got signed char *
> > mm/vmstat.c:445:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:445:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:445:13:    got signed char *
> > mm/vmstat.c:445:13: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:445:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> > mm/vmstat.c:445:13:    got signed char *
> > mm/vmstat.c:763:29: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:763:29:    expected signed char [noderef] <asn:3> *__p
> > mm/vmstat.c:763:29:    got signed char *
> > mm/vmstat.c:763:29: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:763:29:    expected signed char [noderef] <asn:3> *__p
> > mm/vmstat.c:763:29:    got signed char *
> > mm/vmstat.c:763:29: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:763:29:    expected signed char [noderef] <asn:3> *__p
> > mm/vmstat.c:763:29:    got signed char *
> > mm/vmstat.c:763:29: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:763:29:    expected signed char [noderef] <asn:3> *__p
> > mm/vmstat.c:763:29:    got signed char *
> > mm/vmstat.c:825:29: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:825:29:    expected signed char [noderef] <asn:3> *__p
> > mm/vmstat.c:825:29:    got signed char *
> > mm/vmstat.c:825:29: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:825:29:    expected signed char [noderef] <asn:3> *__p
> > mm/vmstat.c:825:29:    got signed char *
> > mm/vmstat.c:825:29: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:825:29:    expected signed char [noderef] <asn:3> *__p
> > mm/vmstat.c:825:29:    got signed char *
> > mm/vmstat.c:825:29: warning: incorrect type in initializer (different address spaces)
> > mm/vmstat.c:825:29:    expected signed char [noderef] <asn:3> *__p
> > mm/vmstat.c:825:29:    got signed char *
> > 
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > ---
> > Cc: Dennis Zhou <dennis@kernel.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  include/linux/percpu-defs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> > index a6fabd865211..a49b6c702598 100644
> > --- a/include/linux/percpu-defs.h
> > +++ b/include/linux/percpu-defs.h
> > @@ -229,7 +229,7 @@ do {									\
> >   * pointer value.  The weird cast keeps both GCC and sparse happy.
> >   */
> >  #define SHIFT_PERCPU_PTR(__p, __offset)					\
> > -	RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
> > +	RELOC_HIDE((typeof(*(__p)) __kernel __percpu __force *)(__p), (__offset))
> >  
> >  #define per_cpu_ptr(ptr, cpu)						\
> >  ({									\
> > -- 
> > 2.23.0
> > 
> 
> Hello,
> 
> I've applied it for-5.5.
> 
> Thanks,
> Dennis

Hi Ben,

I've reverted this commit. After spending a little more time on it, I
don't think this is the fix we want because after we call RELOC_HIDE,
we are shifting from __percpu to __kernel address spaces as we're adding
the offset here.

Thanks,
Dennis
