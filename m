Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B22C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A12120657
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390462AbfGYJ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:26:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42098 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389918AbfGYJ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:26:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so47314764lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 02:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GCmOCyjK5WrhQsCbejjo2462bOGQ6L/5cOfaaGLgDg=;
        b=c9pV8UL+mL5nlgdsd/fjCXQuc2KZyoMpEMxu1qWOzHcmDkGknSSxLNIeu80EAMUTwC
         xqfI2vdfHVuSZYtnipL1mjzgzGNkl2G+/SXHz0KUiy7rGHYFSTdMf8eCQFnFUF/pSpP8
         226uKcKjeqclTyIo9z+SIHPMavD8O/AULZ/yOP03LsozhKqTLLv1T4Pz0AYK140rqvDx
         d2yksfvnBGeCrmYMyG6kMUJQy1Xpf3r4vElKn19qiRj87bOYAaDPv8vZZAEGgR5mPf6/
         T125Z7JieGPO7hzOxzf2F7UdyYdVRzzGaEpm7eZdvPjy8DR5mAvCU2zt5AqASjpW5+oL
         CDNg==
X-Gm-Message-State: APjAAAVh++iECCbt/zdKTPP36MgDoZSaXqk5o+o9Uao6xDMSwUGfjthO
        n1pSLrz7Y/zvk4fiQirotR2RND+u9F1orX1pKg9jBQ==
X-Google-Smtp-Source: APXvYqwRG7HTMj4WmOHj8byk7iSG1IjeeqoSftepzfzH3eGWhAWTZ3P7laDX//gn+/Aa6Sgo8W7IqPXF6cxyni0C3Vg=
X-Received: by 2002:a2e:3e01:: with SMTP id l1mr23821763lja.208.1564046800872;
 Thu, 25 Jul 2019 02:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190711001640.13398-1-mcroce@redhat.com> <20190724200707.2ba88e3affd73de1ce64fab6@linux-foundation.org>
In-Reply-To: <20190724200707.2ba88e3affd73de1ce64fab6@linux-foundation.org>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 25 Jul 2019 11:26:04 +0200
Message-ID: <CAGnkfhxZUw7wUgE6FRetc52HywgwnucZpqcvg3MTUU0M8O158w@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch.pl: warn on invalid commit id
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 5:07 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> What does it do if we're not operating in a git directory? For example,
> I work in /usr/src/25 and my git repo is in ../git26.
>

If .git is not found, the check is disabled

> Also, what happens relatively often is that someone quotes a linux-next
> or long-term-stable hash.  If the user has those trees in the git repo,
> I assume they won't be informed of the inappropriate hash?
>

In this case it won't warn, but this should not be a problem, as the
hash doesn't change following a merge.
The problem is just if the other tree gets rebased, or if the other
tree gets never merged, e.g. stable/linux-*

Cheers,


--
Matteo Croce
per aspera ad upstream
