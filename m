Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F68CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5112087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+ASarVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbfJ2NiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:38:03 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41681 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388578AbfJ2NiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:38:02 -0400
Received: by mail-wr1-f52.google.com with SMTP id p4so13678780wrm.8;
        Tue, 29 Oct 2019 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xiMDm1ky06nmshR0GScrWBxrzoPoulophvZ9wLbseww=;
        b=e+ASarVjckjzvyw0nQ7ljwc0J5bn9wwd19sEw98XUVM0LbXK6CZOfT6hSi0t9l37LO
         m9dRkbrsROVqUv6+7SYo5AzV+iKMdixExYZYLJ6NxlU3fhiny4GQ8vdS1h+197N73lW7
         rArv8yKBuDLKVOwUiV83yyqe4llt/avnVYp2VVkJXkh5wUKPUj1WGooV/HfmqZ2PWKL2
         4K7D0idXeb3gJ8dOtjgjkTwVOSSNawi5+VFalyGAetWILpS1fnUMJAQDAS7OtryydDXP
         LW946YNqADyO/INrnjFOfErLFxF2hq3kNAjzSflmRnud/63zA0+hWojEmyFIyAS0/jnK
         RvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xiMDm1ky06nmshR0GScrWBxrzoPoulophvZ9wLbseww=;
        b=rkqioeXmhPvhNMnczHQll0jycIJxCr1VHNhl4ZK0gRTedopjguW4c/tDL4WLwZ8egJ
         /hNB5AsAWWRZwhyQbZgQEFZPQY8h/N3O0eZkv8/0WQssHwThQ49aibxgGBcAA6vaGf+A
         G1aPaXOolf2oRA1GeqWVfuzAkcmmRvEnbAYly1w1KY1YCKyZGmxfxrtCQMZ3futDELxM
         nnaJXfYnmo4l0YHnARXtm2SVxv9UT/5y0tTs7NpzHSXXIj0lDp33KOJ/Be+nH8JT013R
         NSAoky+CynTYQcH+4o3lQ9kjYj7z/ZRD0v9iS9sPXNn3XcmbrBwHSMq7CRtO0CywQTMb
         emAw==
X-Gm-Message-State: APjAAAXUkYgD6MJnwOJEhFcIRz/3rQDg6hj4Vo2MLh6IEOWDk4YqTMxA
        Q1y5N3J5tNV+fuR2zV8fUhdKwt+I
X-Google-Smtp-Source: APXvYqwZmxqAvuKLjtKOvJ9JlC2VKqvB/zQ62QrheplfgaFIHh3wC+cKc+/QwCG8bpX5Tx1TPo/cvA==
X-Received: by 2002:a5d:5383:: with SMTP id d3mr18655697wrv.55.1572356280195;
        Tue, 29 Oct 2019 06:38:00 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40ac:ce00:e50c:dda6:99a6:2dfe])
        by smtp.gmail.com with ESMTPSA id o15sm14429536wrv.76.2019.10.29.06.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 06:37:59 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:37:57 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dan Carpenter <dan.carpenter@oracle.co>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: detecting misuse of of_get_property
Message-ID: <20191029133756.qpqk5vf6txapqm35@ltop.local>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
 <20191029104917.GI1944@kadam>
 <20191029114750.a7inago2vd2o4lzl@ltop.local>
 <20191029125519.GA1705@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029125519.GA1705@kadam>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 03:55:19PM +0300, Dan Carpenter wrote:
> On Tue, Oct 29, 2019 at 12:47:50PM +0100, Luc Van Oostenryck wrote:
> > On Tue, Oct 29, 2019 at 01:50:58PM +0300, Dan Carpenter wrote:
> > > +static void match_of_get_property(const char *fn, struct expression *expr, void *unused)
> > > +{
> > > +	struct expression *left = expr->left;
> > > +	struct symbol *type;
> > > +
> > > +	type = get_type(left);
> > > +	if (!type || type->type != SYM_PTR)
> > > +		return;
> > > +	type = get_base_type(type);
> > > +	if (type_bits(type) == 8)
> > > +		return;
> > > +	if (type->type == SYM_RESTRICT)
> > > +		return;
> > 
> > Wouldn't this also silently accept assignments to any bitwise
> > type: __le32, __be16, ... ? 
> 
> It does, yes.  I'm not sure how big of an issue that is...

Probably not much if it's just a one shot for Rasmus and
probably not much more otherwise.

> I always
> just throw a check together and test it before I decide if it's worth
> investing more time into it.

Sure, but I was thinking about false negatives here.

Regards,
-- Luc
