Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11184CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F97222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="W4C6i/ND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfJRVzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 17:55:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38678 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfJRVzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 17:55:23 -0400
Received: by mail-oi1-f194.google.com with SMTP id d140so2170907oib.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tyLVKIt7fjiqKhGVwZeZKRmV2ktkcmCU7XGltvDQ4Q=;
        b=W4C6i/NDHXV4LLEEcdB1w1FdhP89pXSPKd2RgTguGpRoA0RN+eJfpijKXmMkoMu7uE
         8zXAPl1V6RsLuTk3j3JFviHk8fFjb4BwsCDZ0PtGFFk7Zj+Xy+hlQXCJn28kbLjwSf8A
         TJMtBFv+uAaOjsrYKHGK2vfazgo86mlD4PQj52Wsd+pTOx/5fCPk219aQrYfk4OYQOUk
         HgfmZJQYmbtiqHIYlg6Qws7HbGjUDr1iYJQmMdS1lgDVGqMZxmKsKRU/KqAW57ON50ms
         V76vXWR+JiMA0mcdN6nZh0At9rdNNNwrD6ufyycGKkHUsODex8SYQzXnhgQDgutegrkG
         m+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tyLVKIt7fjiqKhGVwZeZKRmV2ktkcmCU7XGltvDQ4Q=;
        b=hhBDAB0BgH1o54V/9ncAPPwLCgLFeT7kfqVMwXw8K++4XhsLoPA3pyH7cBqaWyy0lm
         KmbmPKXG1B9nkg6j/kNE5vRNsSzSEtnOTeAdBmYjBwR9+pN7j7M44BgxUkx/uqiRJxJF
         kSlRY19gg/sVlvD52we+ktawdrGS9r++5+hEN/gW1tEeNqp/Vt72okevB4b1aFsBRfK1
         oH5kClfFFuccSnzQEb83NZ9jHPnDwduzVc8J8hS1MWTXFr2zPgdAODmR6BU+3BmMX3Zb
         NE1bujGHcfWerQnaLkuYSFyyvhZkAUm/hT4Z1dg51Fh470V+jsWoFLieCE9JJYiUQZph
         xWHg==
X-Gm-Message-State: APjAAAXw4mQ7813JMRxolOTV70AFMGxG5oip/dztU1MD1Hy2IL++yAnD
        4UHo/x4luGAyw54v/ozcTnH8nAn52zLECzKtIfFqdQ==
X-Google-Smtp-Source: APXvYqwPrLJc1RKs4wL7hY5OVAhRvD33SHPKSYPl2GR1GyyYLqGRZmB2kxuweWXNo7u69Brz3dEU3JReHhozkB8NYEY=
X-Received: by 2002:aca:6087:: with SMTP id u129mr10127312oib.149.1571435722239;
 Fri, 18 Oct 2019 14:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191016221148.F9CCD155@viggo.jf.intel.com> <20191018074411.GC5017@dhcp22.suse.cz>
 <0b05c135-4762-e745-5289-58ee84cc8c3e@intel.com> <CAHbLzkq3h1u=EUXeR3+S7D4fru7U15Tw+5Am8BE_FUkpHQTuWg@mail.gmail.com>
In-Reply-To: <CAHbLzkq3h1u=EUXeR3+S7D4fru7U15Tw+5Am8BE_FUkpHQTuWg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Oct 2019 14:55:11 -0700
Message-ID: <CAPcyv4ji6cnAK8h2NvBWf1i6bWP-Xh8y3c5drUUbWooN0VC65w@mail.gmail.com>
Subject: Re: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
To:     Yang Shi <shy828301@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 2:40 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Fri, Oct 18, 2019 at 7:54 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 10/18/19 12:44 AM, Michal Hocko wrote:
> > > How does this compare to
> > > http://lkml.kernel.org/r/1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com
> >
> > It's a _bit_ more tied to persistent memory and it appears a bit more
> > tied to two tiers rather something arbitrarily deep.  They're pretty
> > similar conceptually although there are quite a few differences.
>
> My patches do assume two tiers for now but it is not hard to extend to
> multiple tiers. Since it is a RFC so I didn't make it that
> complicated.
>
> However, IMHO I really don't think supporting multiple tiers by making
> the migration path configurable to admins or users is a good choice.

It's an optional override not a user requirement.

> Memory migration caused by compaction or reclaim (not via syscall)
> should be transparent to the users, it is the kernel internal
> activity. It shouldn't be exposed to the end users.
>
> I prefer firmware or OS build the migration path personally.

The OS can't, it can only trust platform firmware to tell it the
memory properties.

The BIOS likely gets the tables right most of the time, and the OS can
assume they are correct, but when things inevitably go wrong a user
override is needed. That override is more usable as an explicit
migration path rather than requiring users to manually craft and
inject custom ACPI tables. I otherwise do not see the substance behind
this objection to a migration path override.
