Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3055C46470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE6720989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ps6UOT3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfEMDnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 23:43:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33223 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfEMDnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 23:43:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id y3so5732650plp.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 20:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ezchhs2/JcNwmQ6qp2kyJmiYA74has20Z3uFmOgfa5o=;
        b=ps6UOT3THA5KJfxvls/ZxlAY0ZVXlFvwiLLmm8vGbvHiwP97A9THs/tJmi9C1snr3Z
         VtpUeqIDBspGhzwpC9q+IZM/sodI1PAEtn5bUUO2H4TB+yWFSf7cuXh/53LCrq/8KAhO
         wqpPJ6ribAqXxGm7ZBeMgtqtdepH5mq8Y40x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ezchhs2/JcNwmQ6qp2kyJmiYA74has20Z3uFmOgfa5o=;
        b=OmtyvhG6So73tZzxZ18i1YEbfzwRLSJHdDIWP6+5MRwKLFPEnB6Dj2tW+xvDnyfB/e
         2AyyIIMV/MSfJblTsRxn8u6AWhpe5P73cXmIq3+tXFq0WXEl8FkaqH/6i5A94e8XowNv
         I0UIBJhF+R0Jx+QfUsRRXCb44AFhlX09KFCrxxnhpely2Q50iUA9vSuAwXlVaRNoHwTZ
         7zrK5F1C+1coRr+4yILTcuQDL11nSQAfEHr3lCTeZEeqvqm+TfZMdVOqatwxNEDamEJZ
         6qhRvukVRmTAXasL1NcZBGpqfbCwH7NNc0276oulfKB5xe8yqtjil/LdZPfkjJR/G9A1
         xrzA==
X-Gm-Message-State: APjAAAXUpO0/Xjx0ok8JCAYRcgNDkWxJVjzgllaHBurFx4ILVxqBH1Rk
        VTJnywoVmkWYLjVfFa4rYYBLiQ==
X-Google-Smtp-Source: APXvYqzu8bwp2HEMw1jeBMsjNTdVpYVsHSFDeS4qrd+rWPWpdK86pmXbnbAHdWIgUhUzZtxJrOJ/EA==
X-Received: by 2002:a17:902:e785:: with SMTP id cp5mr9385277plb.167.1557718987582;
        Sun, 12 May 2019 20:43:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l68sm20321949pfb.20.2019.05.12.20.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 20:43:06 -0700 (PDT)
Date:   Sun, 12 May 2019 23:43:05 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/rcu: Correct field_count field naming in examples
Message-ID: <20190513034305.GB96252@google.com>
References: <20190505020328.165839-1-joel@joelfernandes.org>
 <20190507000453.GB3923@linux.ibm.com>
 <20190508162635.GD187505@google.com>
 <20190508181638.GY3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508181638.GY3923@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 11:16:38AM -0700, Paul E. McKenney wrote:
[snip]
> > The other example could be dentry look up which uses seqlocks for the
> > RCU-walk case? But that could be too complex. This is also something I first
> > learnt from the paper and then the excellent path-lookup.rst document in
> > kernel sources.
> 
> This is a great example, but it would need serious simplification for
> use in the Documentation/RCU directory.  Note that dcache uses it to
> gain very limited and targeted consistency -- only a few types of updates
> acquire the write-side of that seqlock.
> 
> Might be quite worthwhile to have a simplified example, though!
> Perhaps a trivial hash table where write-side sequence lock is acquired
> only when moving an element from one chain to another?

Here you meant "moving from one chain to another" in the case of
hashtable-resizing right? I could not think of another reason why an element
is moved between 2 hash chains.

I just finished reading the main parts of Josh's relativistic hashtable paper
[1] and it is very cool indeed. The whole wait-for-readers application for
hashtable expansion is so well thought. I am planning to go over more papers
and code and can certainly update this example with a read-mostly hashtable
example as well as you are suggesting. :-)

[1] https://www.usenix.org/legacy/event/atc11/tech/final_files/Triplett.pdf

thanks,

 - Joel

