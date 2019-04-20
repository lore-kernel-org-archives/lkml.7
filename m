Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DF1C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C39A21479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="GX3SLxns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfDTBqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 21:46:47 -0400
Received: from mta-p3.oit.umn.edu ([134.84.196.203]:38870 "EHLO
        mta-p3.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDTBqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 21:46:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p3.oit.umn.edu (Postfix) with ESMTP id C394EA0A
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 01:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1555724804; x=1557539205; bh=1+gEhSVO0m
        qrkUVP5FD21Tqp3hcyyuecKeWAxa/2ht0=; b=GX3SLxnsFw0VcCcAKnceeCge8U
        tveGtEkcEGTviiCFiHzUvVOfgxcfccYTjnW+vG8Db0Eq39VHp7nV5FnsGlEeXZoR
        DXrCdefFWN+91ISG9SrnrAS8/vrTb2q8l/8kL2ojCracw26m2wjmHRq0e8Z2pBWg
        VClHAsgA4aS6FLgnRFMxNbA/yFACcLU2o1I2smP6B5aio/p+4BB6sz3E6Is/ryIV
        Z1JGuWQ2/gDR0oh+X7zDF8bw5cTHQx78cUVQqr8ihWvY4EukUfX5Rz7284JC52VK
        U3F5IhpQTc7Q4ModeGO7ZiHCXkgIydVaucgrsdPRePeDNWwhslOyncYbvTgw==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p3.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p3.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 99s9eJjCOjAL for <linux-kernel@vger.kernel.org>;
        Fri, 19 Apr 2019 20:46:44 -0500 (CDT)
Received: from mail-it1-f169.google.com (mail-it1-f169.google.com [209.85.166.169])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p3.oit.umn.edu (Postfix) with ESMTPSA id 8657A9AB
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 20:46:44 -0500 (CDT)
Received: by mail-it1-f169.google.com with SMTP id f22so10689473ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 18:46:44 -0700 (PDT)
X-Gm-Message-State: APjAAAW576wzCuMByu36q7nMcfLuLWHYvuvnskPUn9bkVcnY6tDdCkDe
        Esm5NYh8tn2LVVmdQRF8EEWNlql5bBFoXTNp5nU=
X-Google-Smtp-Source: APXvYqwWMWBEQFyTSdV91s/tHN4WOJrsUQJB9QVhOT252q6+PHM26QfrTCDEqDvqR3jQuY8I9z5OdfT4sOIIQy6CyKg=
X-Received: by 2002:a05:6638:26e:: with SMTP id x14mr5083193jaq.32.1555724804305;
 Fri, 19 Apr 2019 18:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <1555686587-13866-1-git-send-email-wang6495@umn.edu> <CAHC9VhQNGiw_+KhZPC7DhzS83u3gi+Ch1AKCeZitsFg=98gUDA@mail.gmail.com>
In-Reply-To: <CAHC9VhQNGiw_+KhZPC7DhzS83u3gi+Ch1AKCeZitsFg=98gUDA@mail.gmail.com>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Fri, 19 Apr 2019 20:46:08 -0500
X-Gmail-Original-Message-ID: <CAAa=b7dvEwg_6YJO5m4JaTdPcsaCOmDACCrof2o=7sw=Ew+OHA@mail.gmail.com>
Message-ID: <CAAa=b7dvEwg_6YJO5m4JaTdPcsaCOmDACCrof2o=7sw=Ew+OHA@mail.gmail.com>
Subject: Re: [PATCH v2] audit: fix a memory leak bug
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

On Fri, Apr 19, 2019 at 2:28 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Apr 19, 2019 at 11:10 AM Wenwen Wang <wang6495@umn.edu> wrote:
> >
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
> > To fix this issue, only allocate the tree when the type is AUDIT_ADD_RULE
> > or AUDIT_DEL_RULE.
> >
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > ---
> >  kernel/auditfilter.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
>
> This looks good, it just needs some minor vertical whitespace fixes (see below).
>
> > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > index 63f8b3f..923b858 100644
> > --- a/kernel/auditfilter.c
> > +++ b/kernel/auditfilter.c
> > @@ -1114,22 +1114,28 @@ int audit_rule_change(int type, int seq, void *data, size_t datasz)
> >         int err = 0;
> >         struct audit_entry *entry;
> >
> > -       entry = audit_data_to_entry(data, datasz);
> > -       if (IS_ERR(entry))
> > -               return PTR_ERR(entry);
> > -
> >         switch (type) {
> >         case AUDIT_ADD_RULE:
> > +               entry = audit_data_to_entry(data, datasz);
> > +               if (IS_ERR(entry))
> > +                       return PTR_ERR(entry);
> > +
>
> I realize you are taking the blank line from the code above, but we
> probably don't need it here.
>
> >                 err = audit_add_rule(entry);
> >                 audit_log_rule_change("add_rule", &entry->rule, !err);
> >                 break;
> > +
>
> Definitely do not add this blank line.
>
> >         case AUDIT_DEL_RULE:
> > +               entry = audit_data_to_entry(data, datasz);
> > +               if (IS_ERR(entry))
> > +                       return PTR_ERR(entry);
> > +
> >                 err = audit_del_rule(entry);
> >                 audit_log_rule_change("remove_rule", &entry->rule, !err);
> >                 break;
> > +
>
> Same here.
>
Thanks for your comments. I will remove the blank lines.

Wenwen
