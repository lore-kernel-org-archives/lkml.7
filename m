Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29578C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F197220833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="u6pokYYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfLDPkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:40:02 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:44107 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfLDPkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:40:01 -0500
Received: by mail-pj1-f65.google.com with SMTP id w5so3129660pjh.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yf0/AyAbsCQScuwSh0FkTQfwVgWv8tTjAbyxzK0zN18=;
        b=u6pokYYSDBN0Rp74jlq4km9163s/bxCbqqwQgKLvwLLq7hphPCk1dgf878+h0qVVmM
         oV7Vue9ENHkWIJGRL7X1hXiu7FUUrbQYBpuBn1nz9Kjrd62+TdmBaVDPebDuggsEami0
         S0WXUL9OT1MT+WRt/jL2wKJFluZcb3sg62uSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yf0/AyAbsCQScuwSh0FkTQfwVgWv8tTjAbyxzK0zN18=;
        b=VcAtFn18PlhHQk1ASiwQhCCdnFkS60dpv2AQ+mlol9pkTKztbkB5c8PFg74iMP8noD
         VB9s0kAh5leQaVfCzJk78+E1MN9vAPK/+YAROvTbzOBgvjLZ0VhgXBthjhbMAcbim8PW
         p3OupjLph8bvnpw5DP6dUW061wtswrVYaex0jmK0gKcIORLIxJgclNnR9XAgIbgCHkjl
         s+kFxMFMcmMJIDlSy3m5S480tNoqj9bRC/4qEj4f2mmTxYQz8eKftSTtjuGWgX9SEdbs
         8Ne8wDvB8WZDies+DMShHHyk30Hi75KXoOUXQ7aI1BrvhZjceYA9lMfsnPjzpM77nayG
         t67g==
X-Gm-Message-State: APjAAAVpZk0e2kL7YIzoA7lIVAVAZrXY9EfO/SjrQSoTETw+RaElQRzS
        fed5E/4VUB2dxR0VNytDZOZ3Ww==
X-Google-Smtp-Source: APXvYqydWvp2jT88+hxu6Hv9v4Gi45t2Z6QCPGmLhAy/GxOqbXhW3/mndI4tvMOl+WYPILBjfEd8DQ==
X-Received: by 2002:a17:90a:9bc6:: with SMTP id b6mr3975479pjw.77.1575474000054;
        Wed, 04 Dec 2019 07:40:00 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u3sm7370858pjn.0.2019.12.04.07.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:39:59 -0800 (PST)
Date:   Wed, 4 Dec 2019 10:39:58 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Amol Grover <frextrite@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH] doc: listRCU: Add some more listRCU patterns in the
 kernel
Message-ID: <20191204153958.GA17404@google.com>
References: <20191203063941.6981-1-frextrite@gmail.com>
 <20191203064132.38d75348@lwn.net>
 <20191204082412.GA6959@workstation-kernel-dev>
 <20191204074833.44bcc079@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204074833.44bcc079@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 07:48:33AM -0700, Jonathan Corbet wrote:
> On Wed, 4 Dec 2019 13:54:12 +0530
> Amol Grover <frextrite@gmail.com> wrote:
> 
> > The cross-reference of the functions should be done automatically by sphinx
> > while generating HTML, right? But when compiled none of the functions were
> > cross-referenced hence "``" was added around the methods (and other symbols)
> > to distinguish them from normal text.

Amol, when I tried your patch -- some functions were cross-referenced. Some
were not. I don't think all were not cross referenced.

> 
> If there's nothing to cross-reference to (i.e. no kerneldoc comments)
> then the reference obviously won't be generated.  I would still ask that
> you leave out the literal markers; they will block linking to any docs
> added in the future, and they clutter up the text - the plain-text reading
> experience is important too.

Actually I had asked Amol privately to add the backticks. It appeared super
weird in my browser when some function calls were rendered monospace while
others weren't. Not all functions were successfully cross referenced for me.
May be it is my kernel version?

Amol, do as Jon said and send a v2. Then I will test your patch again.

thanks,

 - Joel

