Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1088CC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 05:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BCD206DB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 05:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5J7CiQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfLGFHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 00:07:10 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41619 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfLGFHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 00:07:10 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so1786755oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 21:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4tYSfmjncZwEgCZUipa3ucgtSA2eOj9nUIydr2BkTA=;
        b=g5J7CiQ+iLVs9qjGqBq2nRjqCcnEPWmflZbN7T+ibgaMFk4q8PHYCjtbCB+tKbVA/i
         AGtHvOLcity2+891sMcGcvY9PrD/n2I+JmVQg/VP1Xn+tfACTHtWqAySuo3pabHHSVIp
         RurSSEgtr34D6hkyT7uTW+4yPLZuyL1TJ6DWRSwVRn+UWGu3FFEHNUiUQEJftWSa8QYW
         /jOsjG7obXFHIa4eEFHHfM+EfQjIla1V5RJ6+u57Hw+JZ4++k0OD95HxylTdn2ezur1r
         dITR+blvkf9ELTwCgIp0BLSfxHZKA3GMbJPz7FyqgOpw3q7VhipxC8uXXp34jDl2xQC3
         TJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4tYSfmjncZwEgCZUipa3ucgtSA2eOj9nUIydr2BkTA=;
        b=Xbsmdi+ZjjQIYppUD9PDgjYndwhK7tTPRsy1JFejvF9GLazdG0DtaVhterA7RjRZjJ
         6oHepWcv9OCqGegaB/xdZrnx1ODRbypj/hdXORWhgMVbaDFyJC/ns27AriVOZrOCn2Qq
         xva4qC0qmX9mpKqAK0moAzcZeEefpRT5pcN9JLWiSG8UThSTPt68JDxImhZeugSF46Dp
         NJURpV53ghDQkfPlP7yubrHHMGB0STSmko178G856cHmCEST458Q9pRL13yG/cjZiyO+
         dLP0R0zT/TY5i5hy/xnIi6/I+gjK2MbcONuc7pKWIEo4MMpiL48fRypvRATSZ3ApLcdr
         neSw==
X-Gm-Message-State: APjAAAVbIX7g+p0fxZmlVKYTO05X+wVBXq7yXjJg8dhFQf3czIxbpFuf
        AR6Y5DlNy1QUGGXLg0HJ0s6jQuIRhNJXV9dxOM/4VA==
X-Google-Smtp-Source: APXvYqx24PqGbVO1GPEP0uwg9cyIo63VU9b8+5UR5JHIYO6n9OX8LIpimcrl/xuAFCktaGiPTfPNAm0B3Xqo2gtJS7c=
X-Received: by 2002:a54:451a:: with SMTP id l26mr15984300oil.69.1575695229213;
 Fri, 06 Dec 2019 21:07:09 -0800 (PST)
MIME-Version: 1.0
References: <20191205223721.40034-1-shakeelb@google.com> <20191206161321.35ec9a9dc0ed50222a06fee3@linux-foundation.org>
In-Reply-To: <20191206161321.35ec9a9dc0ed50222a06fee3@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 Dec 2019 21:06:58 -0800
Message-ID: <CALvZod6deN4tGhcWygDGOrUaozAY7ikjdrECS=EyNLqGz7VPYQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: account security cred as well to kmemcg
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 4:13 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu,  5 Dec 2019 14:37:21 -0800 Shakeel Butt <shakeelb@google.com> wrote:
>
> > The cred_jar kmem_cache is already memcg accounted in the current
> > kernel but cred->security is not. Account cred->security to kmemcg.
> >
> > Recently we saw high root slab usage on our production and on further
> > inspection, we found a buggy application leaking processes. Though that
> > buggy application was contained within its memcg but we observe much
> > more system memory overhead, couple of GiBs, during that period. This
> > overhead can adversely impact the isolation on the system. One of source
> > of high overhead, we found was cred->secuity objects.
>
> A bit of an oversight and the fix is simple.  Is it worth a cc:stable?

Yes, I think it is simple and safe enough for stable.
