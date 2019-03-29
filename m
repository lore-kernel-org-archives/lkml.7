Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4183C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7094B218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAzDjCxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfC2XMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:12:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34292 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfC2XMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 19:12:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id x14so3426334eds.1;
        Fri, 29 Mar 2019 16:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fDyGpF/9Mj1E7uZBT7JAO2NyCtHEAfKnCS3IefcEly8=;
        b=FAzDjCxaxIvppDyOiUwcp6iYGSpET0iW7UPERR2Ro9RfL5FWkzTbM5gJcV3yuOtUWw
         iOtkPkFCqrKMrcxHKp+D3pRzAjsNEP1Fm0Y0Hs2XBe9DymgXEGQZRrsObj6ZGZe2N+jh
         i3p2dWZFhyFxm/siAKrxR/nTE03jU+onpHiP/1kmwoNR+arbpz/iX9qY3sqGkR9hQnvV
         bwamUlW+jzdkRFVsVGk/c1OjnNlX1ZnByhTAsqQ4Dr2qQzn6XcvTI9uHW2blbClUCQMT
         9cd+3qn9BsuYRS4K5+qLldaJzr6ZeHCqIIayJD0LTm9P226uIZKgNMWY0/yNoU2DRLNI
         sEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fDyGpF/9Mj1E7uZBT7JAO2NyCtHEAfKnCS3IefcEly8=;
        b=cm1QgYwbBuRdBfVIJ8jdbt9gvSMKOlntDo3mZ+dPFwftXlFJYJxx3lNPjBQ3a49EP8
         kM1dkIu2fWUCxJ37TlzSJtR3sYsKLRbqUkYykeIKFsjlexajVi7DoZysuDsZFaLr5xzE
         W62vovEfmNB783kB4MNckn2HZ9z9Pjcdn9Suqqoz5xOHtgmnRP/RttcPQXDJ2slyo4QW
         Zl3nCKdrflIkc5O6OdsxgWmIzibRUdItjJwN/nSaF0a6a48bx0oD/p9tSR5EVQLco8Sc
         35qL8ZI237YxroryGRWcJ8P6r46y3iqylXlEpg0Ck1Nk/tvUm65V2wrU8mcfO8oobc2D
         zviQ==
X-Gm-Message-State: APjAAAVQK+MENhAGZGht3nm1+o3b4AdD11NAvNpEAr7Vla88kb390pml
        ovBBBcIJSgcnfsJEw5Ax9b35xNeT
X-Google-Smtp-Source: APXvYqxWDgDPu8VroVyK5LF85OWikYxd8c9uksEN0RYz1q9VqF2Lpz/FEJy4wB5TRArFSl+8nTO90g==
X-Received: by 2002:a17:906:5014:: with SMTP id s20mr28981200ejj.174.1553901154926;
        Fri, 29 Mar 2019 16:12:34 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4079:2f00:a405:18aa:2541:8cdc])
        by smtp.gmail.com with ESMTPSA id f5sm998586ede.94.2019.03.29.16.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 16:12:33 -0700 (PDT)
Date:   Sat, 30 Mar 2019 00:12:32 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>, mingo@redhat.com,
        roopa@cumulusnetworks.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Subject: Re: [PATCH] trace: events: fix  error directive in argument list
Message-ID: <20190329231231.suwcypwnyunvysyd@ltop.local>
References: <20190325195303.GA20629@hari-Inspiron-1545>
 <20190327115330.04b5b481@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327115330.04b5b481@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:53:30AM -0400, Steven Rostedt wrote:
> On Tue, 26 Mar 2019 01:23:03 +0530
> Hariprasad Kelam <hariprasad.kelam@gmail.com> wrote:
> 
> > This patch fixes below spare errors.
> > 
> > Sparse error:
> > make C=2 CF=-D__CHECK_ENDIAN__ M=net/core
> > ./include/trace/events/neigh.h:73:1: error: directive in argument list
> > ./include/trace/events/neigh.h:78:1: error: directive in argument list
> > ./include/trace/events/neigh.h:150:1: error: directive in argument list
> > ./include/trace/events/neigh.h:155:1: error: directive in argument list
> > 
> 
> I have nothing really against these patches, but why is the current
> code considered wrong?
> 
> Note, TRACE_EVENTS() are "special macros". They hold structure
> definitions and full code inside the argument list. There should be no
> reason that this is causing a warning.

The problem is that #ifdefs at line 73 & 150 are inside TRACE_EVENT()'s
invocation and this is undefined behaviour. From the standard:
	... If there are sequences of preprocessing tokens within the
	list of arguments that would otherwise act as preprocessing
	directives, the behavior is undefined. 

	[C90 6.8.3, C99 & C11 6.10.3p11]

GCC can handle it (and sparse too) but yes sparse complains about it.

-- Luc Van Oostenryck
