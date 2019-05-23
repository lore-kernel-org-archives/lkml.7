Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A2C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE5320863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QvFUo3Ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfEWOyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:54:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35336 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbfEWOyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:54:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so6635614wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 07:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uICNnoyMa7zu41WyaprLWKlNVl3pnLzjAASM3iT/1Zs=;
        b=QvFUo3Ah2WlhLzZRZE+1Phswo1nDdbeYh8VGoQFlMFw51Ij3aka9mP8fEdpc3aYYmH
         B35ZOV+94cDR1f6AQUV+bWXhCxvi0eAiUzP37Wh8IqMQXWLrHOh1MgJCvEXmSa4D9H3t
         IItga6/wj7g8fSvvu8VREy7RgTxEJES08ymTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uICNnoyMa7zu41WyaprLWKlNVl3pnLzjAASM3iT/1Zs=;
        b=oiR+0x7+rilyV9m3OE8ZMphva1rwatDJJK5aLAT9Zk4AWUotmVG5+nmtaILj8WCyhh
         8VtuUOrkxJ+ErTfghrMkK6K6qzBsVOOb6yZPpI4elVjtpop3Np9mSK/Ec1yjh2VPsLCE
         wruReyf0rcBPbHZrWZVhjcZ8uNm/qK7IbUMdhcyka37Yp4dTZiHCIe04aHcF0c98Beeu
         xabQr57Osa7tNUuQwFgg25yXdp0avLLw0ewjC2zlbn4CAcM9K/ZuE3MPCgxlQA6DlpvE
         mdCstPy6Orm4Uf7RgOKx5CetEPnxIjSTesot9xgQnBISfxbSgXRby+1Pkp0/0I4S6i4Q
         uYNQ==
X-Gm-Message-State: APjAAAWLOJwtKii7ODmo4mtjYjiRdl93jQbHuqCi6/B/8A5uUONoJm4i
        b4zubhbdALPivVneW8NSA33Hpg==
X-Google-Smtp-Source: APXvYqzFcsbsy7Svm9PtOh17bUdfvueOtWIYPOsWNvkHMRwBrk+3HvYZLR1+MMzjL67U3tGhI938OQ==
X-Received: by 2002:adf:e649:: with SMTP id b9mr14112520wrn.195.1558623277660;
        Thu, 23 May 2019 07:54:37 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id x187sm11554224wmg.11.2019.05.23.07.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 07:54:37 -0700 (PDT)
Date:   Thu, 23 May 2019 16:54:34 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] rcu: Make 'rcu_assign_pointer(p, v)' of type
 'typeof(p)'
Message-ID: <20190523145434.GB18692@andrea>
References: <1558618340-17254-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190523135013.GL28207@linux.ibm.com>
 <20190523141851.GA7523@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523141851.GA7523@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > TBH, I'm not sure this is 'the right patch' (hence the RFC...): in
> > > fact, I'm currently missing the motivations for allowing assignments
> > > such as the "r0 = ..." assignment above in generic code.  (BTW, it's
> > > not currently possible to use such assignments in litmus tests...)
> > 
> > Given that a quick (and perhaps error-prone) search of the uses of
> > rcu_assign_pointer() in v5.1 didn't find a single use of the return
> > value, let's please instead change the documentation and implementation
> > to eliminate the return value.
> 
> FWIW, I completely agree, and for similar reasons I'd say we should do
> the same to WRITE_ONCE(), where this 'cool feature' has been inherited
> from.
> 
> For WRITE_ONCE() there's at least one user that needs to be cleaned up
> first (relying on non-portable implementation detaisl of atomic*_set()),
> but I suspect rcu_assign_pointer() isn't used as much as a building
> block for low-level macros.

Thanks for the confirmation, Mark.

I can look at the WRITE_ONCE() issues (user and implementation); it will
probably be a separate patchset...

Thanks,
  Andrea
