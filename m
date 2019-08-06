Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02FDC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FF220C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z0mI1c0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfHFLxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:53:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40845 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfHFLxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:53:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so62595962qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 04:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eo4243fxJunv120eldJ+yINhsaoHQ/b07ic+MhyUnUY=;
        b=Z0mI1c0biLAyuHhq5HIH9liJ9V9NmYB6TCZCXG/MS5n6b7MXngGDqXWAvW9Q3wU70f
         Yuj4Gf5hmNpwIefJdv3jpcVqzwrm17rlQpqCpa8h75KznnlVcHW+bOQ8mi52XzW32i5X
         xMyKUlZMHS1zgPqQftCrIwo83eGAnrddpriXhq4ERkbDt3WwCS0upZb4/WtoahuAO8kW
         rLLLe/brCqzVyuGIKUWxPpcJJrKlwgWXPRE3jAKSeJ2mD0cdUXjpM0rJYi2yNTADYoYQ
         aDzSN7ZZQHTrS2/K7nALIkgZpt7+fyciFkxjLncICC8fqlQT1qsJ9jdY2CtN6k6kVuIQ
         kuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eo4243fxJunv120eldJ+yINhsaoHQ/b07ic+MhyUnUY=;
        b=T8aFqzjoqPBOxkk5gxNY1G+QEn7NZ3EytTSXnxccO9HY4FEPR5LDm9b4Wc3wjhKdYw
         JGR06mI3suJI2t0ZBfCSajVwz9CNyg+mqQS1/xIVGZHc51Difr/a0pp8YunP6uE0gAck
         Kf0a4hDaG4luJ24wfQfueRR35uCv6YH4XTc3mw+pelnulM3sW/lppKFu16RCf+HcLbcA
         OdymSdUPKWioT4Eqx5K/DBh+F4Xe43fAIaV57lDwdmvt6FqoM4mT4v3kuEeg/nlFrFCC
         dMqeJtdxT1cqacfkZo7kqkDhqLOH3sJLix6+/qPKlJL8CRbIlc5PfIRc8pYfeL/3iS/e
         9VOQ==
X-Gm-Message-State: APjAAAXwKwJNv49TbpFN2bY3I28DbPTia+JYznH30rhAWeBwvBiu+CmB
        Mn8l29YRqPvtWsg4WqAb0vrjWw==
X-Google-Smtp-Source: APXvYqw8Kp97Codo4loFeh85jsMCmVqW5Bh1vzUEuORvgfGzgHvIynQzybQA5mb0rqsqpydwn040qg==
X-Received: by 2002:a05:620a:127c:: with SMTP id b28mr2606352qkl.299.1565092399391;
        Tue, 06 Aug 2019 04:53:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r14sm40128814qke.47.2019.08.06.04.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 04:53:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1huy1l-0003cs-Vr; Tue, 06 Aug 2019 08:53:17 -0300
Date:   Tue, 6 Aug 2019 08:53:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 7/9] vhost: do not use RCU to synchronize MMU notifier
 with worker
Message-ID: <20190806115317.GA11627@ziepe.ca>
References: <20190731193057.GG3946@ziepe.ca>
 <a3bde826-6329-68e4-2826-8a9de4c5bd1e@redhat.com>
 <20190801141512.GB23899@ziepe.ca>
 <42ead87b-1749-4c73-cbe4-29dbeb945041@redhat.com>
 <20190802124613.GA11245@ziepe.ca>
 <20190802100414-mutt-send-email-mst@kernel.org>
 <20190802172418.GB11245@ziepe.ca>
 <20190803172944-mutt-send-email-mst@kernel.org>
 <20190804001400.GA25543@ziepe.ca>
 <20190804040034-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190804040034-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 04:07:17AM -0400, Michael S. Tsirkin wrote:
> > > > Also, why can't this just permanently GUP the pages? In fact, where
> > > > does it put_page them anyhow? Worrying that 7f466 adds a get_user page
> > > > but does not add a put_page??
> > 
> > You didn't answer this.. Why not just use GUP?
> > 
> > Jason
> 
> Sorry I misunderstood the question. Permanent GUP breaks lots of
> functionality we need such as THP and numa balancing.

Really? It doesn't look like that many pages are involved..

Jason
