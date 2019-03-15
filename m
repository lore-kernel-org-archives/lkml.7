Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16D5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86453218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMHN7eQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbfCOHQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:16:08 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:40239 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfCOHQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:16:07 -0400
Received: by mail-ua1-f45.google.com with SMTP id b8so1141710uaq.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9i4AzHW0MH0ZDB5buB5KEKmToorPnidW06kcEbyQqc=;
        b=MMHN7eQkY4x5vQV6Z2SOg0PrFZqhICi/9d6qUII4uy+TUIhnOtKKWBHd0lEhF4J/45
         za9SJebjCcUeaqQ4ZhWCMvO0RwKf4taJBs2+weK91McaOYlKSIM0hU1sQmRR1fWatPX/
         UZQxbTw4L5zY0+3Y6ZWXi9mPGZMmie6PmwkfjAGoZ0T/iMQVI/KeA6hGunE/E0AZQiIX
         GVUOB/iiUFjv58nnTMf7+WRN3DtK+YmouCQ2F1zk2R7gUHNe+DDhkrVWn2Jlct2vAg6R
         eUdPpJPKwUEvg9hizkkDDSNlh2MfMIssAG5YmRQ8FiTQ3bDm7aR8PaYJFGU9vQEcp4i1
         TjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9i4AzHW0MH0ZDB5buB5KEKmToorPnidW06kcEbyQqc=;
        b=QvGRQaIALBnAt4M8+9iEP+Ako1fz4Zjd4XZ1nu/TIhl9giXKjIUamLImglgVTsQBcw
         T7psIZRYbSvE/f5VdQ944nzsWuhw/y7RUW1uhhQrHImwSauAzAq2gUGU0LhcgJ4Xr7gK
         8j0S+NLdeeD51F523NWIvWVpAJoxFBFhoXljxm3ZwLSInHNz6JrzwaBXIrP2pWsjiANm
         N5DvX5eKP7OSzJrIgqK41k8x6muhkbWQjKUP6779t3m/L8QolPFOazy4dTX75BE2usmU
         c2DJf8c3wQs1iJIgDgsv35p6YWAqsvj54MT6Zyag1BypoeyHp8RVYGI5UUqd5X0nSiXo
         QtaA==
X-Gm-Message-State: APjAAAXidYfpmhqeQqyaWPxp6uOOCzCIN8B9rV4TIH8Zluf/TeDYP0A2
        wU0c5BwIYnUCFzhOXsKz/V5AiTVF8/QRmRiGlI1wtA==
X-Google-Smtp-Source: APXvYqzwrUCVxzMK0z7obW1nmTmO4/dEm8x4p5wGhVR2uRiNwdTnsHQJCdfur8NezfTVfEuHu0HcJhYLkUUaTE+QLyA=
X-Received: by 2002:ab0:560e:: with SMTP id y14mr27706467uaa.132.1552634166465;
 Fri, 15 Mar 2019 00:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org> <CABPqkBT9_ayhH2puPtLiemtM=VOXxNhC4AXrKkOaDMatWifLxQ@mail.gmail.com>
In-Reply-To: <CABPqkBT9_ayhH2puPtLiemtM=VOXxNhC4AXrKkOaDMatWifLxQ@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 15 Mar 2019 00:15:55 -0700
Message-ID: <CABPqkBRkPQewqJQsNtEESd9Jo2qd8iVG7KDzbQRK_Lg_21p-bA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/8] perf/x86: event scheduling cleanups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 12:15 AM Stephane Eranian <eranian@google.com> wrote:
>
> On Thu, Mar 14, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > These here patches are the result of chasing a bug in the TSX Force Abort
> > patches.
> >
> > The first patch is simple and fixes the issue and should be marked /urgent and
> > backported.
> >
> > The rest is the result of having a hard look at how all that event scheduling
> > stuff worked while trying to figure out wth was going wrong.
> >
> > Stephane, since you were involved with writing much of that code, can you
> > please have a good look? I _think_ I got it, but... :-)
> >
> Will do today.
> But you did not send me PATCH 1/8 apparently.

Correction : I got it. Mail client had just moved it somewhere else!
