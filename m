Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D57C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A4620700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfDEMxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:53:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45713 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDEMxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:53:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so7825249wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 05:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OqoLdziHSEu6DYBl2hUx025VWynIi2G0T48ShRGwesw=;
        b=WqnimKmFKSb4Dg5m2oqUjrPBqi559oV/nI25Ij/wzxyqLJsP3EHFxK8xnMuaKh6HOL
         8qAdxptjK3ANqAlVHwB0WZSKF7sFrZa6wLodYNoik6+hJZBoykHZiUS/CRUHvIetdjN+
         CxfQiv0hcSEAxynKc7JX+uPbyUm+oIP5jT2EPJibDy7EhhZCZrpdeqHQKeu+nSVPYOLY
         PbajHOWxkwTxGTiueIZ0PYSOAeYGRgxLqQtItY73HtNw1Z+v3YAGsg6hgoPTIxBsWruL
         F4N/VVgVA46RInwDf9atHRNne5ZdEAKTEfwLsxdnrv7B6y8Y8bwIdhcwViNSV/NOkiAJ
         oWlw==
X-Gm-Message-State: APjAAAUWs4LdxeKWC+Emvxs/elyG0Vpg8x8BzJqI5PPoRSQongidWHI8
        oGGpo0BRCqrlJCw0MlpZwXtP9g==
X-Google-Smtp-Source: APXvYqwLojOCdHMClFxB4bA1tXEx+ELpPs4ctGTf3RHk8QEzmT3WB/dknuj6SYr8D2R0EJJ4EpvGNA==
X-Received: by 2002:adf:e443:: with SMTP id t3mr7153324wrm.257.1554468799264;
        Fri, 05 Apr 2019 05:53:19 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id t15sm2715103wmt.2.2019.04.05.05.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 05:53:18 -0700 (PDT)
Date:   Fri, 5 Apr 2019 14:53:15 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v7 4/7] sched/core: Prevent race condition between cpuset
 and __sched_setscheduler()
Message-ID: <20190405125315.GC5453@localhost.localdomain>
References: <20190403084650.4414-1-juri.lelli@redhat.com>
 <20190403084650.4414-5-juri.lelli@redhat.com>
 <20190405123645.GT12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405123645.GT12232@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/04/19 14:36, Peter Zijlstra wrote:
> On Wed, Apr 03, 2019 at 10:46:47AM +0200, Juri Lelli wrote:
> > +static inline void cpuset_read_only_lock(unsigned long *flags)
> > +{
> > +	local_irq_save(*flags);
> > +	preempt_disable();
> > +}
> > +
> > +static inline void cpuset_read_only_unlock(unsigned long *flags)
> > +{
> > +	local_irq_restore(*flags);
> > +	preempt_enable();
> > +}
> 
> You can ditch the preempt stuff. IRQs disabled already very much implies
> !preemptible.

OK.

Thanks,

- Juri
