Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDC4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C3921721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="keh+emXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfJHTf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 15:35:28 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44996 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbfJHTf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:35:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id u22so17919818qkk.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U294XgrY5OSRgdnw6gF817DzYTmjZtoT36cTsRKPdrE=;
        b=keh+emXj3JSKsBXpLQPf78AnPN/mmkUgkJHJaKvmr/4PlPgqlkB2jAS+n2nHnom6Sx
         hP+JBAL3X0BP2cuHYH1StQHwN6SpIw+nU/jHijSB8QzSr4FBr51w2cULRUtn2FF+pADf
         wtI1SdhVVzcmqUCkUVtkLYh1OH/kVdsZblmOryV/rPZ5O80SDbBnq+PeFndyzfNvkWi3
         1OjBojDjvzANcaCA1RuPJL+CoTphJVlBnwK3cEUp0JyRB6GctQHzd8hiWjeKy3KyJoMG
         wYRl0rPaQwWTGfjhFTdZa7lBmR/eteb3tPnrHu1kzZ9CwNas/9j7A+QtadSv79BJDa8Q
         3qDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U294XgrY5OSRgdnw6gF817DzYTmjZtoT36cTsRKPdrE=;
        b=gdIRXOM9e5vJaRDi0lRpGIS2YpXGDfZZTqvBRL4bapqOlIgSsrfNrS7u0KK57NtBgd
         Jtrqh4A4yyp2IOzkj0UjbDYyWsTFIL0JQ+90jbDY9xyIJ0iEsRGUjzCFeJ/DWlNmbJgd
         eC0SvpLjeRJXUTakjbJ6Pe/PJGLyhgpCmEPnIu0ZxZq8bJpA4MoRbK0zCduK0KY9EjbN
         JEWCbNjFrD7Uvm7Qa/dRlKIOglD/96vrzY+wUFGHbKm4+GCL5s0lh/dGLeeOkK/NZXF7
         A5h+SCSVKJaV/X1KjZuTlmisQ57g2dRZyPzx52paAMXUevLTYhJprwqJgvyXe24DXgC6
         +8sg==
X-Gm-Message-State: APjAAAVSSXHxIUiWVKEYhWGkZ+yDKM4hfDOYJFx9vIc2XwNeer+LTiyH
        xqyWDRYzI3tlooLQ/hzcZCIk+g==
X-Google-Smtp-Source: APXvYqxpFro7CtZp5lYLOXGlumPEmu8UiCZ66ijg6TwG039FeGh+gp5p6K5C2yMPZd05kwSM6yACRw==
X-Received: by 2002:a37:7403:: with SMTP id p3mr29160375qkc.366.1570563326734;
        Tue, 08 Oct 2019 12:35:26 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v5sm13774071qtk.66.2019.10.08.12.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 12:35:26 -0700 (PDT)
Message-ID: <1570563324.5576.309.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 08 Oct 2019 15:35:24 -0400
In-Reply-To: <20191008191728.GS6681@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
         <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
         <20191007144937.GO2381@dhcp22.suse.cz>
         <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
         <20191008082752.GB6681@dhcp22.suse.cz>
         <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
         <1570550917.5576.303.camel@lca.pw> <20191008183525.GQ6681@dhcp22.suse.cz>
         <1570561573.5576.307.camel@lca.pw> <20191008191728.GS6681@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 21:17 +0200, Michal Hocko wrote:
> On Tue 08-10-19 15:06:13, Qian Cai wrote:
> > On Tue, 2019-10-08 at 20:35 +0200, Michal Hocko wrote:
> 
> [...]
> > > I fully agree that this class of lockdep splats are annoying especially
> > > when they make the lockdep unusable but please discuss this with lockdep
> > > maintainers and try to find some solution rather than go and try to
> > > workaround the problem all over the place. If there are places that
> > > would result in a cleaner code then go for it but please do not make the
> > > code worse just because of a non existent problem flagged by a false
> > > positive.
> > 
> > It makes me wonder what make you think it is a false positive for sure.
> 
> Because this is an early init code? Because if it were a real deadlock

No, that alone does not prove it is a false positive. There are many places
could generate that lock dependency but lockdep will always save the earliest
one.

> then your system wouldn't boot to get run with the real userspace
> (remember there is zone->lock spinlock involved and that means that you
> would hit hard lock after few seconds - but I feel I am repeating
> myself).
