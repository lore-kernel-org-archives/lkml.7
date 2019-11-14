Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861F4C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E50120709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ElTRMVV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfKNUVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 15:21:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39068 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfKNUVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:21:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id 29so4499110pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 12:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X9HJcC+dDI+SMIjHb3TSTTEdvzoA4CpSNR8pt2+xQ9g=;
        b=ElTRMVV53tLxyamUmm5DqL/W3Istv4Uiy/Q1mKVmgCoTyNRjIOAI28alvfINoPTaKT
         ddIdonmcp67HXtp+LPSAaeHdhy6c5L5ZPLxZ8U7pxlVeHdGB146Z7JfN2ia7z3fFVWRi
         kS2M4+ccb1TvLkWTSx596GrajOg55/ZgoL6ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X9HJcC+dDI+SMIjHb3TSTTEdvzoA4CpSNR8pt2+xQ9g=;
        b=QjvaUATnSrRxUNM9RAPL9LOE/FKflfTCPJJv5WybyGxcRNnRt+kSu41U8L7fM6fYCK
         gt6M/A4Z2YikC/W6TEhYYTQlueODbBhDwhMv/9GMdXfHL7xV9XHqdpSUTordibYfdzUD
         3tggvODZM4GUy70WX67MudNa4pBj2ilYbVfOuQ4Vj7upEQvw/RS2/Xcd+ZQd3jGF/i2+
         WR9kSf/Ow3W/24ScYhMb67Uvh7qHsPx33tJcXpqAvQTEQDazfv1cC2wU2x7YbqynqYYj
         AM+SMvjjxdkkqC0yJTYidIkTHOtFQNymCcBVhiynBJHjMsnRyu1BNygIxLdpjf9o1Y5L
         MqpA==
X-Gm-Message-State: APjAAAWd0h/uPVZAuBN4HF6ypJ/ja9H7d1xVfwdzGE1Uzs13+3npMHDy
        67iMzCh8j6yxSgh/ookxnWsPFg==
X-Google-Smtp-Source: APXvYqzTq1VOazEL+8iLqVK2oIGJkKAQy0KwKQaSFyK8gFQBdJmCUDZ2sXLkLsVQ6H93AgBeXZdFew==
X-Received: by 2002:aa7:87c5:: with SMTP id i5mr12945500pfo.60.1573762861161;
        Thu, 14 Nov 2019 12:21:01 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v189sm8084763pfv.133.2019.11.14.12.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:21:00 -0800 (PST)
Date:   Thu, 14 Nov 2019 15:20:59 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [RFC 1/2] docs: ftrace: Clarify the RAM impact of buffer_size_kb
Message-ID: <20191114202059.GC186056@google.com>
References: <cover.1573661658.git.frank@generalsoftwareinc.com>
 <0e4a803c3e24140172855748b4a275c31920e208.1573661658.git.frank@generalsoftwareinc.com>
 <20191113113730.213ddd72@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113113730.213ddd72@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:37:30AM -0500, Steven Rostedt wrote:
> On Wed, 13 Nov 2019 11:32:36 -0500
> "Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:
[snip]
> > +
> > +        The number of pages allocated for each CPU buffer may not
> > +        be the same than the round up of the division:
> > +        buffer_size_kb / PAGE_SIZE. This is because part of each page is
> > +        used to store a page header with metadata. E.g. with
> > +        buffer_size_kb=4096 (kilobytes), a PAGE_SIZE=4096 bytes and a
> > +        BUF_PAGE_HDR_SIZE=16 bytes (BUF_PAGE_HDR_SIZE is the size of the
> > +        page header with metadata) the number of pages allocated for each
> > +        CPU buffer is 1029, not 1024. The formula for calculating the
> > +        number of pages allocated for each CPU buffer is the round up of:
> > +        buffer_size_kb / (PAGE_SIZE - BUF_PAGE_HDR_SIZE).
> 
> I have no problem with this patch, but the concern of documenting the
> implementation here, which will most likely not be updated if the
> implementation is ever changed, which is why I was vague to begin with.
> 
> But it may never be changed as that code has been like that for a
> decade now.

Agreed. To give some context, Frank is an outreachy intern I am working with and
one of his starter tasks was to understand the ring buffer's basics.  I asked
him to send a patch since I thought he mentioned there was an error in the
documnentation. It looks like all that was missing is some explanation which
the deleted text in brackets above should already cover.

Steve, your call if you want this patch. Looks like Frank understands the
page header taking up some space, so one of the goals of the exercise is
accomplished ;-)

thanks,

 - Joel

