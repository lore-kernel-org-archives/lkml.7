Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD6BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A4A204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="AQhooiIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfDSSdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:33:08 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:49622 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfDSSdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:33:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p4.oit.umn.edu (Postfix) with ESMTP id 7EB369D2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1555685638; x=1557500039; bh=31oGmTi/8q
        5ICv6csH/a0i3xHhtcR0M4GwKNTKNZs8o=; b=AQhooiIgZD2YL20ymMhnu4gseZ
        nwzdh+MZgsDfA9N59TEvZEspOSwvy6h+cYNLVXyqYuGeBQlxeHREMmZkbwWcdny/
        Vfdbd9d1WH2HWwQdOXI+z8zH+7a7YKP+4YoQEIqIvvo+aF6MMZop9co+8Ajmc61M
        ASb8DhBdct7FgNwRXSpd98qjYWlGQHvMspqLlUBrNpU7jP+Qz5UEjonMH5RD2/q0
        RK8LSvwqFpnUJ4QXIkD37oxE31Mpe2Mp2arvmihAEfXBSAKZEPt8HQwly60gyUB8
        zypQ+NNnVfrZ6i8X/D3EUZnc4Ndn2YdTVf1cm+QLXam6XQOFfKq/sn8LrZwg==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p4.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p4.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TeA9b8UNA3WR for <linux-kernel@vger.kernel.org>;
        Fri, 19 Apr 2019 09:53:58 -0500 (CDT)
Received: from mail-it1-f182.google.com (mail-it1-f182.google.com [209.85.166.182])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p4.oit.umn.edu (Postfix) with ESMTPSA id 5B133985
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 09:53:58 -0500 (CDT)
Received: by mail-it1-f182.google.com with SMTP id 139so8565361ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 07:53:58 -0700 (PDT)
X-Gm-Message-State: APjAAAXfSu8HoVOTVEm8t/tEKOs+MiJFBf3gdKergUyq/Hy6Uv4Fw0jg
        jzxukEFkIYXsB7fNlp1ActsIwW5LWgzUt0gd0LQ=
X-Google-Smtp-Source: APXvYqxV2aP3c/cbPbYDpJE2olJf0EuotN1NT1ZtDqaMXO9vgo6nSBHvB8aAFSby+Nd0BqCMv/oeelij4ZpjmkG/u/Q=
X-Received: by 2002:a02:1006:: with SMTP id 6mr3021565jay.47.1555685638125;
 Fri, 19 Apr 2019 07:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <1555609155-11934-1-git-send-email-wang6495@umn.edu> <CAHC9VhT-9JDNVVQfh-uYcck=eRX3aRRG4CaMkidgLQ3Z1MHrRg@mail.gmail.com>
In-Reply-To: <CAHC9VhT-9JDNVVQfh-uYcck=eRX3aRRG4CaMkidgLQ3Z1MHrRg@mail.gmail.com>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Fri, 19 Apr 2019 09:53:22 -0500
X-Gmail-Original-Message-ID: <CAAa=b7c_n1zU=22_Wi=+BkbMF61jEYACwq8NXXY2DKSgqo8BWA@mail.gmail.com>
Message-ID: <CAAa=b7c_n1zU=22_Wi=+BkbMF61jEYACwq8NXXY2DKSgqo8BWA@mail.gmail.com>
Subject: Re: [PATCH] audit: fix a memory leak bug
To:     Paul Moore <paul@paul-moore.com>
Cc:     Eric Paris <eparis@redhat.com>,
        "moderated list:AUDIT SUBSYSTEM" <linux-audit@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 4:52 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Apr 18, 2019 at 1:39 PM Wenwen Wang <wang6495@umn.edu> wrote:
> > In audit_rule_change(), audit_data_to_entry() is firstly invoked to
> > translate the payload data to the kernel's rule representation. In
> > audit_data_to_entry(), depending on the audit field type, an audit tree may
> > be created in audit_make_tree(), which eventually invokes kmalloc() to
> > allocate the tree.  Since this tree is a temporary tree, it will be then
> > freed in the following execution, e.g., audit_add_rule() if the message
> > type is AUDIT_ADD_RULE or audit_del_rule() if the message type is
> > AUDIT_DEL_RULE. However, if the message type is neither AUDIT_ADD_RULE nor
> > AUDIT_DEL_RULE, i.e., the default case of the switch statement, this
> > temporary tree is not freed.
> >
> > To fix this issue, free the allocated tree in the default case.
> >
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > ---
> >  kernel/auditfilter.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > index 63f8b3f..70a34db 100644
> > --- a/kernel/auditfilter.c
> > +++ b/kernel/auditfilter.c
> > @@ -1128,6 +1128,8 @@ int audit_rule_change(int type, int seq, void *data, size_t datasz)
> >                 audit_log_rule_change("remove_rule", &entry->rule, !err);
> >                 break;
> >         default:
> > +               if (entry->rule.tree)
> > +                       audit_put_tree(entry->rule.tree);
> >                 err = -EINVAL;
> >                 WARN_ON(1);
> >         }
>
> Since there are only two "types" (_ADD_RULE and _DEL_RULE) and the
> allocation is only three lines (audit_data_to_entry() + two lines for
> error handling), maybe it makes more sense to duplicate the
> audit_data_to_entry() call into the individual case statements so we
> are only doing the allocations when we have a valid "type"?
>
This sounds reasonable to me. I will rework the patch. Thanks!

Wenwen
