Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E301AECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA702173B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Lu5t9332"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbfJHNX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:23:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39731 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHNXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:23:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id n7so25241501qtb.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Q4s6NaffGbR5MTwYJR6kw9AA12T9aVl8HZYwAcmo7U=;
        b=Lu5t9332sw3rkpQ77idM5uwOZSTizPp/2c2Rp1i2nsuuZRt+0OoReF8QYw4QrIkH9j
         MocrxC3BarR1EMhUfZbA1OmqvVpDV5ilFiIj3vaOwLWimihWr6R/umtjBG89Ky+w6Uth
         mncmokFAaWDQMdXs6dq9yzQUE/EXTPE55IfIBVFlvVxHV1xgKArsQxxcgAbLKrlJIhQN
         sxK5OsyOFD9hOeNp3NEq7TnK9DcREo7ruUau94/ECzT0gFxJr71oAxt1GUXnqImp5QVB
         /bmtw95UKHmFKWZpK6dgTvbYS+S6yn/kidr6teEzqqTgZSTN/0byuo6uH2havtCNoCML
         iwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Q4s6NaffGbR5MTwYJR6kw9AA12T9aVl8HZYwAcmo7U=;
        b=XM1iuTCP1scef5EgAcntiFQpEHq4pyV2V5Gnet9gC6wH13J6nKxH9mNc4YqF4jgTF8
         UeB/2kqUpj2TsIjf9ZrjxZNUvXacvp6wpT4sq+6qPhduWQIhWs5Oj0gbjonZtg6QEzdk
         mbF28yakdyHu0Lzkwn+uHueD5meMjt/S5Q1QMwsgWns/CVbkHXQ7FJ/dmMhYiXClbqc9
         eIE0NchvyqGMDfyM4AXhDyY9a0ObwqkeG+A5HCno0uOze74KaB5vDhBu2dRX5VeD3u/O
         w+chAQhc1VdBxNTV+W6ciP5p6cUrnyK8cftkXKOy4SJ7ztaW+csFo1MoPzM78LmD057B
         QM6Q==
X-Gm-Message-State: APjAAAVStI1BdtYc+1AafdM8kv+nznXH+JthursmfQX5E9oK7tUPxCGX
        iA4k4T3IAVPthPV22c5E/KvKlw==
X-Google-Smtp-Source: APXvYqyqj9bfnctaJsILCG/S8S9eIkRiOJXvoK9od3JlzBHgJYL8rQe3cIU9ce69hQodM7iUFmpHJw==
X-Received: by 2002:ac8:4594:: with SMTP id l20mr35506879qtn.286.1570541034449;
        Tue, 08 Oct 2019 06:23:54 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e7sm9048646qtb.94.2019.10.08.06.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 06:23:53 -0700 (PDT)
Message-ID: <1570541032.5576.297.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
        linux-mm@kvack.org, john.ogness@linutronix.de,
        akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Oct 2019 09:23:52 -0400
In-Reply-To: <20191008091349.6195830d@gandalf.local.home>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
         <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
         <1570460350.5576.290.camel@lca.pw> <20191007151237.GP2381@dhcp22.suse.cz>
         <1570462407.5576.292.camel@lca.pw>
         <20191008081510.ptwmb7zflqiup5py@pathway.suse.cz>
         <20191008091349.6195830d@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 09:13 -0400, Steven Rostedt wrote:
> On Tue, 8 Oct 2019 10:15:10 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > There are basically three possibilities:
> > 
> > 1. Do crazy exercises with locks all around the kernel to
> >    avoid the deadlocks. It is usually not worth it. And
> >    it is a "whack a mole" approach.
> > 
> > 2. Use printk_deferred() in problematic code paths. It is
> >    a "whack a mole" approach as well. And we would end up
> >    with printk_deferred() used almost everywhere.
> > 
> > 3. Always deffer the console handling in printk(). This would
> >    help also to avoid soft lockups. Several people pushed
> >    against this last few years because it might reduce
> >    the chance to see the message in case of system crash.
> > 
> > As I said, there has finally been agreement to always do
> > the offload few weeks ago. John Ogness is working on it.
> > So we might have the systematic solution for these deadlocks
> > rather sooner than later.
> 
> Another solution is to add the printk_deferred() in these places that
> cause lockdep splats, and when John's work is done, it would be easy to
> grep for them and remove them as they would no longer be needed.
> 
> This way we don't play whack-a-mole forever (only until we have a
> proper solution) and everyone is happy that we no longer have these
> false positive or I-don't-care lockdep splats which hide real lockdep
> splats because lockdep shuts off as soon as it discovers its first
> splat.

I feel like that is what I trying to do, but there seems a lot of resistances
with that approach where pragmatism met with perfectionism.
