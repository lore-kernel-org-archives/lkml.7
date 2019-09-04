Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8956C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DCF22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfIDKuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:50:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDKuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:50:44 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF9002D6A25
        for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2019 10:50:43 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id e14so11761469wrd.23
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 03:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vMzc9O6CpnL0NMnffGWsqMwxIY466vw33DVJU0S4eU4=;
        b=if1J3XSacF/pfj+QILrMBSYgeVxrJRHcWTW+qyGTZ6wEQ+wGKl6w5LXDLQp4d+9YNZ
         yIg8NOG4Dsg8yJOPZ6K2mDnoIFm7crBvXF+IGg/WZDt3W+hm99qV/N14qqf48AtJGdBZ
         WbCBIYZ7hHvpNEkQFByjvcWfksa4pWk5PEpzNgdLmL8BSNb9YIcNKHLodIFjOq8u39qw
         f1wwrSx51W7bGB0OhdOH7ugNR9jeP7wvwCl680fEb+2h9Ar4wzKDnmcwXgegmnY6CLcB
         j6T/VRydEZMn9rjYhClYJFwB0hJX4qOUWzeaDrPC497Voe0dDByumHDzNGH+j1g6+Q0R
         8QcA==
X-Gm-Message-State: APjAAAVa+Ggns26R81fk3yco5P1D7CGx+0HVCYq5yzSh1MYxZxaeLYVy
        pcYXsnkG0KBGuQ89V9u8e1os3Lh8lhSdNBt4eXKib+iEQJ/durnw3X453Q3zokOH2RQM80K1uX9
        0+fV/am5I8bGWzxN8OgSWSRUY
X-Received: by 2002:a1c:7ecf:: with SMTP id z198mr3625465wmc.175.1567594242292;
        Wed, 04 Sep 2019 03:50:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxq3mR++oySEL4Npo6OT6pwn7+hqdkcGj1UGL3xdSEpzAu6GX/b4un99WtGKpjEK1Au9bM6BA==
X-Received: by 2002:a1c:7ecf:: with SMTP id z198mr3625451wmc.175.1567594242027;
        Wed, 04 Sep 2019 03:50:42 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c09:8c01:a3c8:c747:f7af:a580])
        by smtp.gmail.com with ESMTPSA id o25sm2121683wmc.36.2019.09.04.03.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 03:50:41 -0700 (PDT)
Date:   Wed, 4 Sep 2019 12:50:37 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Alessio Balsini <balsini@android.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 00/13] SCHED_DEADLINE server infrastructure
Message-ID: <20190904105037.GE5158@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190903142732.GA35593@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903142732.GA35593@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alessio,

On 03/09/19 15:27, Alessio Balsini wrote:
> Hi Peter,
> 
> While testing your series (peterz/sched/wip-deadline 7a9e91d3fe951), I ended up
> in a panic at boot on a x86_64 kvm guest, would you please have a look?  Here
> attached the backtrace.
> Happy to test any suggestion that fixes the issue.

Are you running with latest fix by Peter?

https://lore.kernel.org/lkml/20190830112437.GD2369@hirez.programming.kicks-ass.net/

It seems that his wip tree now has d3138279c7f3 on top (and the fix
above has been merged).

Not sure it fixes also what you are seeing, though.

Thanks,

Juri
