Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64092C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE762081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljy/8d3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfCHAEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:04:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46339 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCHAEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:04:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id 196so12573883pgf.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 16:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tsVzEHkWwvehOdkIdjjF1GTyTAyLfCHX5dPLG40EVmE=;
        b=ljy/8d3AhJljd5mmxbwKDuR8HXOGANvMLtcC9L5oNFoHfqKuPJcj6HMjJ5bKTKKeRW
         Bppk89z9AmgHYkSh+1MSXoGz+XIkjUKncz5SZUTQEGJPK7mPRtR17v0mapf8DxzBByPj
         tL247/SUN0BSXfziD6HZfJkY8Lcoauw89JJg//GMUIvuty5QwpsxBzBJrEF2pWAzU9SC
         8gY74bNaO/UjeicyeFWEHNLcin1Gjq9BV1OnVyNzJhyss2W38GyNYNusaqi6aTNzPHAI
         JdLLqU9xTOWoMCj9taU0Y6eLoDVUmbaFvq6/CAMUkitDsesJxb2G6XulxtWUWfgLUTqH
         Snjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsVzEHkWwvehOdkIdjjF1GTyTAyLfCHX5dPLG40EVmE=;
        b=lRypipPVX9qckA6nuWb82buiJzRLZ+Na6SZp6ShTR+lfgm5cm+8QBvy4kupyx934Q4
         5aNd/tsmCBNX0b5EhFkp72XFCPrl2Cdk4aGIifIj28DquKUsjGYCRPmDN6UHMW2W08FQ
         VM0h2Ojo6YgN4FuAI5nFtQ1YTJgUwrJOSqi2sSS7U0QBantCnGTtEEOBYhTGrICLAIOR
         hsJvVx+4x4jqiqeGE58QGr8464xsWJUna5asBtzQHk3KwwoAwQY6YTtUgF9LhE1KRvJS
         opA/3WAoV0yKK4oqA83ZOcaxIPOL594Ag/2hpyF6WpFPIuds7BByMRldcu3TxGVlhVfT
         LPJA==
X-Gm-Message-State: APjAAAUN7Xf7QEfNYYykKqVbFgKEQzrMgH7n030SuOrkVK6WLSsFXQgd
        w5e4Z8s/aA35EChP8WHAw8lhbHtTfK6m/s2znOasTw==
X-Google-Smtp-Source: APXvYqxq2TmfmvV8AIedu1i7bbmS+YwDsxzwYb1cuJcoDSTRVTvaAzVs0jjY+SsnMtXywBdPhux5zYWBlChvKB8X9W4=
X-Received: by 2002:a63:5506:: with SMTP id j6mr13879486pgb.202.1552003474330;
 Thu, 07 Mar 2019 16:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <20190307091514.2489338-2-arnd@arndb.de>
 <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com> <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk>
In-Reply-To: <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 16:04:23 -0800
Message-ID: <CAKwvOdnTLSUmuwtJTGqZpiu9DfRoK8NW88CaouezqZ-y8RDmmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Mikael Pettersson <mikpe@it.uu.se>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 3:49 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Mar 07, 2019 at 11:39:08AM -0800, Nick Desaulniers wrote:
> > Underspecification of constraints to extended inline assembly is a
> > common issue exposed by other compilers (and possibly but in-effect
> > infrequently compiler upgrades).
>
> I don't see what is "underspecified" in the original constraints.
> Please explain.

From the link:

The problem is that in the T(streq) insn, %3 and %4 MUST be different registers,
but nothing in the asm() constrains them to be different.

> > >  "One way of fixing this is to make uaddr an input/output register, since
> > >  "that prevents it from overlapping any other input or output."

-- 
Thanks,
~Nick Desaulniers
