Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4600FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C50B227BF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EsRBtjZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgACWeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:34:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45168 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbgACWeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:34:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so24096706pfg.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 14:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h60rRNccMZJTfBCOaaZOGtPzFnUj3qhlo+KAwuFhXj4=;
        b=EsRBtjZirRTdy5HMs9mwnGgaerFsPYYqRUS6NlbsMnBCmQrRX1WHLJ5Jibwv3bCb6C
         b/j2ylwjseFZg2SwJs2fmnkeAgR+TkDBirvihpi8deTA2+TiyHIkwJwg7yAcK9VQRbFb
         xwlU5L/2ocVUSa4PgbN+se/k9FeMGbca7sX3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h60rRNccMZJTfBCOaaZOGtPzFnUj3qhlo+KAwuFhXj4=;
        b=Su/4D8o7yleB8dEL78xMGTA3fVrakS/WWApVs/DMIJvk7GpsX+C0sYxvy1wZqVILiP
         IXaBzQXoxrbxykbObW/NYifVPKpiyiYTjy1EclLX9/pSGY+AG03NBPy4NQ8iRYuZWCwS
         tHPUipBdtdTT/5L20M921bdxx0JswKZu38CtFdartjeHurfT+SVTiRu0irhPEaRzP3UP
         PGMayDuri36BMbsKRx5r89YLuyPEHdVQ2gE1sT4KDGgXigE5oObweRohhr+x9b1ZnEZ6
         C2uYtd++971U36/Mu/tzCD/vgg07tXq0IYJ4KD2CnKEuBJ5cdNqRoYYWBzdvVITkPheB
         cN8Q==
X-Gm-Message-State: APjAAAUTcvM0YazQFmWIz8psJLnHmd0U6LWlRGKR5rAh7Ljdty7ZQVkt
        ndDnh9uPFHwJnqx0cy+tXR6xlg==
X-Google-Smtp-Source: APXvYqy1YUoGW3Za8vGr40ZH9+xrVnbTaEXYDDClQiRfun8PIdxUTxNeSYtOh1+mbI40AVtXs68Jsg==
X-Received: by 2002:a63:e545:: with SMTP id z5mr97558800pgj.209.1578090875439;
        Fri, 03 Jan 2020 14:34:35 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g18sm65172822pfi.80.2020.01.03.14.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 14:34:34 -0800 (PST)
Date:   Fri, 3 Jan 2020 17:34:33 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com, rdunlap@infradead.org
Subject: Re: [PATCH v3 0/3] docs: ftrace: Fix minor issues in the doc
Message-ID: <20200103223433.GB189259@google.com>
References: <cover.1577231751.git.frank@generalsoftwareinc.com>
 <20200103114828.15581051@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103114828.15581051@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 11:48:28AM -0500, Steven Rostedt wrote:
> On Tue, 24 Dec 2019 19:05:38 -0500
> "Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:
> 
> > I didn't want to be pushy with these minor fixes but occur to me
> > now that, even all seem to be clear in the latest version of the
> > RFC (v2) related to these fixes, a clean patchset could be expected
> > after such RFC. So here we go:
> > 
> > Clarifies the RAM footprint of buffer_size_kb without getting into
> > implementation details.
> > 
> > Fix typos and a small notation mistakes in the doc.
> > 
> 
> Jon,
> 
> Can you take these in your tree?
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> Thanks!
> 
> -- Steve
