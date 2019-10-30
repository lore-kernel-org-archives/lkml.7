Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBAECA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0D320866
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijhbZvY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfJ3BP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 21:15:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35308 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfJ3BP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 21:15:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id n16so582317oig.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LiqlPgdWNA9PRH5nALR1HXVaery8pdVvA3tw4kzK/YM=;
        b=ijhbZvY9UqNfl0f+NlEf8kzcArGh2+O1V9Qyky+fDyrgw8qLP+bg/s3HN8MX+NgmFB
         6ctonOUgLG+wTHzSpztuBoRdS0j54g1mHoCUILtMOFrbAxGLzGLHrSkzQUTAiFxmFkFj
         3K1QzMK204kj5hxRODEPadXlLDnQh7EhcScbGDIYs+Aaoen4DZ3FUeva+HtFFAwiJwXG
         tCSu1/ACld++aea1lShqC9oBbwZRFkDo+nMkk4b+hkKrL4ZjzXEo0hAkvRq4zJPNmxd/
         QpvtC5qB+hCjmQLyhrsoHmf1a/NJM5Lvb3kUurBZu4oxL07nAopxGqf9ctSUP1Y3WxaU
         JjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LiqlPgdWNA9PRH5nALR1HXVaery8pdVvA3tw4kzK/YM=;
        b=DRCjCYwn9qE0br9jJfsojYnKge/ubDQsxG7gku9TN4wBGSWnEfNBTcM0IMtOHTGk5D
         51EPdtq3nIxNS9uGQMgiSV0ogzSrPRW1I6u4t+GF8Eov7sN4D8cyeeIdNwMmx3iXNLdx
         NFCA50Iemca2EkU9f698vDhk2h55TCivG8/9XUeyzQRfJ5/b1VgGIgrp1df8nr6FYpNR
         L2H6RcQepa04m0B3kUDKK/+VTsdQOMWOgF7wdRuAGkDeJBYsXBbonngMGY1frM3lz005
         f3pevoM/RXQfYFidqPo39PRyieVoFQCXDE5smE/xzdv9eRGptm5nBjihpkGXyQvib+r5
         mzCg==
X-Gm-Message-State: APjAAAXiEIr5ZBPRNdwdWkXRNZmZxODxN3buiAn+IMPxVT8OliYV0H82
        hnZbdpfeMqzDYUUMnpjzoP6k1tPynuCJYZN+t8x5cA==
X-Google-Smtp-Source: APXvYqxTGzbhYMHFytIpfUMi/ukV5/jH9kboBUiKZ1WFs7zogXKc9XtsF+q5eu/WJlvrcJe/MwmVgS+vqiIjiRFYCRs=
X-Received: by 2002:aca:180e:: with SMTP id h14mr6309696oih.142.1572398156861;
 Tue, 29 Oct 2019 18:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191029234753.224143-1-shakeelb@google.com> <20191029175459.b3bfed9326559e69acdd2e35@linux-foundation.org>
In-Reply-To: <20191029175459.b3bfed9326559e69acdd2e35@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 29 Oct 2019 18:15:45 -0700
Message-ID: <CALvZod6DB0h93bDoTFdY9bU8fnxjBJphpf+AWr_u5r2SBo_isA@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: memcontrol: remove mem_cgroup_select_victim_node()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 5:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 29 Oct 2019 16:47:53 -0700 Shakeel Butt <shakeelb@google.com> wrote:
>
> > Since commit 1ba6fc9af35b ("mm: vmscan: do not share cgroup iteration
> > between reclaimers"), the memcg reclaim does not bail out earlier based
> > on sc->nr_reclaimed and will traverse all the nodes. All the reclaimable
> > pages of the memcg on all the nodes will be scanned relative to the
> > reclaim priority. So, there is no need to maintain state regarding which
> > node to start the memcg reclaim from. Also KCSAN complains data races in
> > the code maintaining the state.
> >
> > This patch effectively reverts the commit 889976dbcb12 ("memcg: reclaim
> > memory from nodes in round-robin order") and the commit 453a9bf347f1
> > ("memcg: fix numa scan information update to be triggered by memory
> > event").
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > Reported-by: <syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com>
>
> I can't find the original sysbot email.  Help?
>
> iirc the incidentally-fixed issue is a rather theoretical data race and
> the patch isn't a high priority thing?
>

Let me check why the link is not working. However you are right that
the fix is for a theoretical data race and no need to be backported to
stable trees.

Shakeel
