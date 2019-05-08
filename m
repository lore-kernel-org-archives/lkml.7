Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8D8C46460
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C861C20644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEHIBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:01:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38484 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHIBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:01:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so5747673wru.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qA0Yc9JEsajyNVp94ZanoqlO08a0Z8R0wevUOSzCv6s=;
        b=X6/6/6CYXSi6D69TLdGxrocX1NA3NLXmbcziv1gSzx5YUzyneHsWj2DbyN/gezyI01
         CpWQxG5lMPViHNSUbNZJLB/Z/BzMcXHoTtiCISM4yYribga3kdnLelLQCfGREAtksD8A
         0oUEXJMU2qCABqTenl5ufXahcXlnGDd+5A9YO3UeZiWqmYF+LKdhBZqnlouWvZwWy/vs
         7PoinFjXSdILA2uLUoymPvwOttaI21w0suq6On7M6a9QwTo3KAgkoWKggeOtbnr1X/MS
         DENTZHSuiTdDvwDMNOP7KspGI9v19tABu5hqlhKySROnJ631GqknYAwsERwnWBb9xC2H
         4ieA==
X-Gm-Message-State: APjAAAXJq/lsf5WWqc2RWKhmijrTQlBo2rGmMQKMEDfuXH0qvmWIXOT8
        6mXAHQfvx6kN7MDuJdmnEC6o6A==
X-Google-Smtp-Source: APXvYqw/wfVBYOyr3xQ5mwH+YvFWtFixwEkdSV32RlMZiFZQuRJkHIuPQ237e12ZjYZw9+YDN2frOQ==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr1814707wrs.243.1557302479659;
        Wed, 08 May 2019 01:01:19 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id b10sm27630443wrh.59.2019.05.08.01.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:01:18 -0700 (PDT)
Date:   Wed, 8 May 2019 10:01:16 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Luca Abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 3/6] sched/dl: Try better placement even for deadline
 tasks that do not block
Message-ID: <20190508080116.GE6551@localhost.localdomain>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-4-luca.abeni@santannapisa.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506044836.2914-4-luca.abeni@santannapisa.it>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On 06/05/19 06:48, Luca Abeni wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Currently, the scheduler tries to find a proper placement for
> SCHED_DEADLINE tasks when they are pushed out of a core or when
> they wake up. Hence, if there is a single SCHED_DEADLINE task
> that never blocks and wakes up, such a task is never migrated to
> an appropriate CPU core, but continues to execute on its original
> core.
> 
> This commit addresses the issue by trying to migrate a SCHED_DEADLINE
> task (searching for an appropriate CPU core) the first time it is
> throttled.

Why we failed to put the task on a CPU with enough (max) capacity right
after it passed admission control? The very first time the task was
scheduled I mean.

Thanks,

- Juri
