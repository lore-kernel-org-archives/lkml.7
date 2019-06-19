Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18501C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35E6208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbfFSMeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:34:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42533 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731653AbfFSMeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:34:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id x17so3186250wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zkomWHfm2nE4Ls9LrFCC/lbq6EDt2hSMOozA/jG6M0g=;
        b=fiGw7O31FhJVxqU+t9pw/RP6J9niRaueQ7iIhmJEFeu+iKM4T96BkbHSu8tM+KFgvB
         0fPrC+3ya+pxibmHpcr7DJ1vnjGSd/aLz34k9NJuhQ0pE1IpKBvza98umQu+gPkUJrRg
         3ghClTEwjP5BNK656jxsJPnQc2TCU0jvem3fhg3cYdY7sOYSkRgeQv5P9S/p73X17n9Q
         1vj/0U6BejnNBh3YPv/AjFLXRKPHQ1JXygHV1r/Uh8u0J6sj8LGDDEOSt/blcsikIuyb
         7M3OGPAhcJ6xpTm2Qkr+MH7vdiisVsW24tMns/3khP+TPom5T/Dl++Ftli4rcsgGWt0D
         PtQQ==
X-Gm-Message-State: APjAAAUH1S2Yow9n3vOqjxJ590BWySXK8w3JscXOcaJkxFnof4/fsMn1
        4yoMkbetKIXrL5ApJCaVF8XZ2w==
X-Google-Smtp-Source: APXvYqx7v2CxZ8iyadpYL/pvPW+etAFEjWdVabNUMX4QKPf6eO0WEPIHMZvCJedse968+c6i885NOw==
X-Received: by 2002:a5d:488b:: with SMTP id g11mr9807590wrq.72.1560947648011;
        Wed, 19 Jun 2019 05:34:08 -0700 (PDT)
Received: from localhost.localdomain ([151.29.165.245])
        by smtp.gmail.com with ESMTPSA id 72sm13469223wrk.22.2019.06.19.05.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 05:34:07 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:34:05 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        lizefan@huawei.com, tj@kernel.org, bristot@redhat.com,
        luca.abeni@santannapisa.it, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Fix cpu controller for !RT_GROUP_SCHED
Message-ID: <20190619123405.GN26005@localhost.localdomain>
References: <20190605114935.7683-1-juri.lelli@redhat.com>
 <20190605142003.GD4255@blackbody.suse.cz>
 <20190619092904.GB28937@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619092904.GB28937@blackbody.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/06/19 11:29, Michal Koutný wrote:
> On Wed, Jun 05, 2019 at 04:20:03PM +0200, Michal Koutný <mkoutny@suse.com> wrote:
> > I considered relaxing the check to non-root cgroups only, however, as
> > your example shows, it doesn't prevent reaching the avoided state by
> > other paths. I'm not that familiar with RT sched to tell whether
> > RT-priority tasks in different task_groups break any assumptions.
> So I had another look and the check is bogus.
> 
> The RT sched with !CONFIG_RT_GROUP_SCHED works only with the struct
> rt_rq embedded in the generic struct rq -- regardless of the task's
> membership in the cpu controller hierarchy.

Yep.

> Perhaps, the commit message may mention this also prevents enabling cpu
> controller on unified hierarchy (if there are any (kernel) RT tasks to
> migrate).

Sure. Can add such a comment.

> Reviewed-by: Michal Koutný <mkoutny@suse.com>

Thanks!

Peter?

Best,

Juri
