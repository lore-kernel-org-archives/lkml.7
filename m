Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C7C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC2720872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562855983;
	bh=yf/l1b+WnsdaAQ2WLuFErpShgZDrJzy46Zq/tr7SuvU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0Sxx5GpUAlrtib666Tpi5ieWNjIwREYz9tvVJjxLi+IYxbXpvWhk6MDZ/ecovCu8J
	 mkEj8SD1xALRNDlp57qYHvQ3Qg+em9miknu8xAh7cxmBhUPiUpHSu+N5MzFFWpSX29
	 bdQZ7LcNnjaZBoQEXkrWjnb5FrWI5bjdI9wnjlEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfGKOjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 10:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfGKOjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:39:42 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E387520872
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562855981;
        bh=yf/l1b+WnsdaAQ2WLuFErpShgZDrJzy46Zq/tr7SuvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yX9CWv+lRLgAbbP1gRnAIhvcii36NmPewby/Spu8HqZEjDyJKqS2ygTZ9/yaGZemA
         kW0ghZJSU8voSgt83mUzQPlYrnkmb4q1oDrsIWkKM9UnVGTPFSRnq2lu8qMH4COw2d
         og78WtohyDeyyoxgp/BPwbsZBYzjKghhRQ51/w54=
Received: by mail-wm1-f50.google.com with SMTP id 207so5966376wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 07:39:40 -0700 (PDT)
X-Gm-Message-State: APjAAAVRiWU7ChD6XciCMG3tnQHJvHOreNXAa/dWAeG6w0eRDEJNlN/Z
        XO+GeJOX/OzK84dp/YTdLwKEUmGRKbG4k7V3+97NkQ==
X-Google-Smtp-Source: APXvYqz8N1dZdg83jxlzHPt+dQ4ZrsrdoZi9iTRkIKVAnzyTcdv1fVeD13J+YEiEh/ES5agsUMp+6L5SwFNx1NmcdNU=
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr4687433wmk.79.1562855979520;
 Thu, 11 Jul 2019 07:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
In-Reply-To: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Jul 2019 07:39:28 -0700
X-Gmail-Original-Message-ID: <CALCETrXKgVMiqSfaWoBoM+WCZGHDihV8frSOdG5BFsRr2=mGJw@mail.gmail.com>
Message-ID: <CALCETrXKgVMiqSfaWoBoM+WCZGHDihV8frSOdG5BFsRr2=mGJw@mail.gmail.com>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop targets
To:     Uros Bizjak <ubizjak@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 1:13 AM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Recent patch [1] disabled a self-snoop feature on a list of processor
> models with a known errata, so we are confident that the feature
> should work on remaining models also for other purposes than to speed
> up MTRR programming.
>
> I would like to resurrect an old patch [2] that avoids calling clflush
> and wbinvd
> to invalidate caches when CPU supports selfsnoop.

The big question here is: what are all the reasons that we might need
to flush?  Certainly, for stuff like SEV and MKTME, we need to flush
regardless of any self-snoop capability.
