Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C86C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694DC20863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Sl9c/IVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbfEWOxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:53:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36454 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbfEWOxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:53:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id s17so6646601wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KuauVzjJswarfobGLMx62HbVwFkgBXXbK672bwB029A=;
        b=Sl9c/IVpkPxfdQFvyhEaxuRn1gyGyncWJpElpyHVCz0PT2Jqa0CZ78ux8e4bvp/UDK
         9VGVElVF1dfjJUkX9iP/zAXDhTRf5rhu5AkZfZwIPthOEGQLaemCwa7mO+bs7KhepM9W
         b/Q1OdXSLuvvNGxjKUhlYBAIKZPFsLK2aloT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KuauVzjJswarfobGLMx62HbVwFkgBXXbK672bwB029A=;
        b=jwaG/mpmt2Jhdj8gKtCTBbR2nPFvG+DyQj1d5uTryGwUY78tGI99EFoN61H1FFCWJz
         Zg02MYSXvnOshojAlAOalDr7J4gCtOVRUs/i40Ng2BzTXbSc9Z7umeNrXKgFmqZWgI0v
         AS1K/uh312iuVu4utf4h1QznixZjmiYnHA6vxDvkT1I+S0giNNPFAMlZ33smAXyyd6xl
         MoquwzjTKknMHgNkRjbLmVu6BielZvcNWHP8LPQhA7wCV7XRPx2OwM8kzo0rUfLx32FU
         ELyZ4co70J/xed8UGbAEEJKqjPi79GcdPgpfridwEc4XQfY3ZHqQclB0RukqTbr5JVwv
         TXpw==
X-Gm-Message-State: APjAAAUQnHhDbvNX9SklJxY6rVH739xlZIClmorU1kbqhMbUvDuZFKs/
        lHdoho7yc3vOlkQqmU7BIqlxSw==
X-Google-Smtp-Source: APXvYqzoZglxEGBUuaQVwNP9WVW+5YjppemivpSRz1xRQFi3El+oY+7xYQL+IEIzgLJn+DvEfnJcCA==
X-Received: by 2002:adf:aa09:: with SMTP id p9mr6578948wrd.59.1558623197442;
        Thu, 23 May 2019 07:53:17 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id j206sm14293686wma.47.2019.05.23.07.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 07:53:16 -0700 (PDT)
Date:   Thu, 23 May 2019 16:53:09 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH] rcu: Make 'rcu_assign_pointer(p, v)' of type
 'typeof(p)'
Message-ID: <20190523145309.GA18692@andrea>
References: <1558618340-17254-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190523135013.GL28207@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523135013.GL28207@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > TBH, I'm not sure this is 'the right patch' (hence the RFC...): in
> > fact, I'm currently missing the motivations for allowing assignments
> > such as the "r0 = ..." assignment above in generic code.  (BTW, it's
> > not currently possible to use such assignments in litmus tests...)
> 
> Given that a quick (and perhaps error-prone) search of the uses of
> rcu_assign_pointer() in v5.1 didn't find a single use of the return
> value, let's please instead change the documentation and implementation
> to eliminate the return value.

Thanks for the confirmation, Paul; I'll prepare the new patch shortly...

  Andrea
