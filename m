Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACE8C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1682054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LhftYKUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEFOAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:00:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35098 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfEFOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:00:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so6436483plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 07:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MbsZIl3ArB5wEdByvk9rAkhe7aFmbknUmqiIp7u42Ng=;
        b=LhftYKUl9AlNvf4VZqvgbwBPxpgUgibHvvGfFBJck7yL7q8JqiiTpSivC9g3C2AFl4
         4JUYNszhcoDNOslLs5nZ4G2pJUjBS7WrbJjFZRKG5kiO9v/Y4utk1M6fHTclgYYg7XkA
         TYdf2hqusC/TGIjs1k3Ap64OeIAylNxoGi+XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MbsZIl3ArB5wEdByvk9rAkhe7aFmbknUmqiIp7u42Ng=;
        b=Ne8/psSdGnGslfE6wozxJX08bj1GXrOCaMI5Bfyt3MlxPyLhifpvuvZIv/+b6dmKwu
         DVONCifDg/2oT2cqf1vq89SWCSbDuGkrL4d5qKIMtA6nNMAj2j1LKF9LgbY199HH2uHN
         x/Fdgj2YE3fld+VQ1Ok7Jkqqhy4TnI3E6A50E92iKDwSZLHzRVVMcLMNGEnx6lAeMuCu
         fiy1ZYDo2cU74oXf7VBQ28Og4HYqSCSTqcb1RZSDwnmBfjNNEr5s89MgWPnwG4lzHaYb
         xVdG6lw6oc4NxfH5hBjPZMHGxUdQmf9pPrZW+dnh6plrcpluX1p8OVVcfTUUemKlto2i
         qheg==
X-Gm-Message-State: APjAAAUlyk/3d6qpp7rs5AphV2Gzd2MFCj8A6JKVb6LcQURrA3NBiw4j
        JJuZnfi112T5rSQixKFQkVWuvA==
X-Google-Smtp-Source: APXvYqzPlaGBL9bRnL5IaA1pHdnIdt0qf3kR4PAAdxPyMLDsxAogkCmgpD0uGJF9NCNvxLGa6Ne/gQ==
X-Received: by 2002:a17:902:8f88:: with SMTP id z8mr31603828plo.54.1557151232688;
        Mon, 06 May 2019 07:00:32 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 124sm11882126pfe.124.2019.05.06.07.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 07:00:31 -0700 (PDT)
Date:   Mon, 6 May 2019 10:00:30 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ftrace: Implement fs notification for
 preempt/irqsoff tracers
Message-ID: <20190506140030.GA234965@google.com>
References: <20190504164710.GA55790@google.com>
 <20190505223915.4569-1-viktor.rosendahl@gmail.com>
 <20190505190133.49b5ea46@oasis.local.home>
 <b415ea04-e078-a73c-3609-56fb195841c3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b415ea04-e078-a73c-3609-56fb195841c3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 01:54:04AM +0200, Viktor Rosendahl wrote:
> On 5/6/19 1:01 AM, Steven Rostedt wrote:
[snip]
> > Hmm, what about adding a notifier to tracing_max_latency instead? And
> > do it not as a config option, but have it always enabled. It would send a
> > notification when it changes, and that only happens when there's a new
> > max latency. Would that work for you?

That sounds like a much better approach. thanks,

 - Joel

