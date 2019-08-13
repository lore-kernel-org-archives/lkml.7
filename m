Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5B9C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFC620840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfHMNUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:20:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51392 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfHMNUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:20:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so1499188wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s52NghQ7NeF3Ht+jwObNJp7TLBzdVRHeXL6recC2EpY=;
        b=SfjO6RqqAvUtcEWzy17YzEdk6zYC2lsojb7ag5/00m6i4bDQQJiWqAaxWanHI/fJD8
         AJ+jq2ym+Mq+FCGDdEx9NP4cZtfFEQIEAwoBy/XlSe4noY6CSfRltZPPBFtQTm3V4ZLs
         nXyNItTWJFxQFIYt+vQ5EEUj0bIxKjipB9BZ7VtYmwhmXZ6p0GRtRzp9IOnh25jiPE5G
         qgLwBMEOGgI1Eo6H7FwIp51wxtDK13jtWs845GEkWC/cZZocsIeDfxB5nBjcCtt8DUEd
         Griex2l6Tuw1Zvg63Nhtp9HCOvSSwFwhIUYHcj75Xu5nGXuUD7Z5JkfnLTkswbPFHTPi
         go1g==
X-Gm-Message-State: APjAAAV6hbpXx9kJg7S4+HrgLvYtstgBYaj+1kpQ+L5FSAogrr5qTLNI
        6owFogKHX7I9zaoEAWIDsY3bzA==
X-Google-Smtp-Source: APXvYqwD7cPfb0fLaT9AvChqI7gm4G4sobvA99O8eWj5zAXkuHUDriH2zxRg6z82xfANdvYWReMImQ==
X-Received: by 2002:a1c:39c5:: with SMTP id g188mr3078732wma.167.1565702399361;
        Tue, 13 Aug 2019 06:19:59 -0700 (PDT)
Received: from localhost.localdomain ([151.38.194.123])
        by smtp.gmail.com with ESMTPSA id t14sm14870951wrv.12.2019.08.13.06.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 06:19:58 -0700 (PDT)
Date:   Tue, 13 Aug 2019 15:19:55 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com
Subject: Re: [RT PATCH] sched/deadline: Make inactive timer run in hardirq
 context
Message-ID: <20190813131955.GC4959@localhost.localdomain>
References: <20190731103715.4047-1-juri.lelli@redhat.com>
 <20190813130934.g37ob6wr4br4rkwg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190813130934.g37ob6wr4br4rkwg@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/19 15:09, Sebastian Andrzej Siewior wrote:
> On 2019-07-31 12:37:15 [+0200], Juri Lelli wrote:
> > Hi,
> Hi,
> 
> > Both v4.19-rt and v5.2-rt need this.
> > 
> > Mainline "sched: Mark hrtimers to expire in hard interrupt context"
> > series needs this as well (20190726185753.077004842@linutronix.de in
> > particular). Do I need to send out a separate patch for it?
> 
> time will show. I applied it now to my tree and will ping tglx later…

Thanks. tglx actually already applied it to tip (with a fixup):

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=4394ba872c36255d25c6bde151b061f04655ebfb

Best,

Juri
