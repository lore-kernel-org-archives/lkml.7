Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C37C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCF122C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA9HlS2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbfGYOVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:21:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44207 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387419AbfGYOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:21:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so1675922otl.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0zCRge4IyR2wlfjUSbezvebKIU/ZeQqbglizi25Hnc=;
        b=fA9HlS2NA+mqlLSk8D6kP778L1e3wK4+NbKw7veEzErPD2TgOeK3SY+5AXDqI8qkok
         6xoRISMUNVjk3vANwDKjwCLy8Grl5UaqrIpDyDMwYSb9aKRg0Cv5yeVQCORdHWHQLuZj
         O1TBBjM5fbgumkoW9ecLGcude/8nHJa54JktiPhZTagj37GJHLwvwXNLfxiTwhMmnped
         mYHWRpmvr6PwPAtfwIoCGsv9bn06rejj2xLY280jWBQaXI7A3CbGaR2lnH9IXX/m+iSv
         926o5fJKEbVpp1C4wpXSiyvRKtwfAZxVY6joaUzc4DrY+LYkXMR4KXs1E5V6Fmk8n2f3
         GNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0zCRge4IyR2wlfjUSbezvebKIU/ZeQqbglizi25Hnc=;
        b=RJ0q2GmFWKtn5KjYuYD1FQdc1SgVDlJTHPpQk6yYupjGceXP98wKkQ/Rrim8Y+J9b2
         0iDS6CqQZh5iBUYcAEzNvk7LVSZVL1cQs6CyRBXd0OkLCcYY2Y8ylPoAH4z7jhWct4yk
         dmzyNfFwNbcnAjtTKdbjzK+Id3hdxZCmO9hoNPeC85e1jvSEXtwlO+tZASlCeZMGptLe
         Uy0Ca2I/MA6wsEshbzyUHc9p88V/jGF62o+4cgZEWUpNh+uNjhXeBP08hjHU2x5UWUts
         KoXrANTZ3ARWe5bvnvZlR2bdqLFpyC7Gv8pGztiop4TV/mQnnP4PSkbQ0l9uD7ZQeNty
         gwbg==
X-Gm-Message-State: APjAAAWol9bqa5a42EXAaINYe2DrZdqmt0dVqapeg5FdCT6y/8skgGAv
        Uy2j5pDdR8O8aoEbc76jxJOKpX4InQ+/mhf1iGM=
X-Google-Smtp-Source: APXvYqwmXc5yVMJE6L7+bhpGYYiXCwSadkoyKo4JYb9tEs1Es0bf1DgrK5Xaxq2GT032GnRfxzVy/ElYYbZfmB8Qy/w=
X-Received: by 2002:a9d:73c4:: with SMTP id m4mr38862075otk.369.1564064506211;
 Thu, 25 Jul 2019 07:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190716152656.12255-1-lpf.vector@gmail.com> <20190716152656.12255-2-lpf.vector@gmail.com>
 <20190724193637.44ced3b82dd76649df28ecf5@linux-foundation.org>
In-Reply-To: <20190724193637.44ced3b82dd76649df28ecf5@linux-foundation.org>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Thu, 25 Jul 2019 22:21:34 +0800
Message-ID: <CAD7_sbEGno-o=zh=VJQOXPZ=ppcTF3h_UWAXo6dXFnBJcTNTrA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm/vmalloc: do not keep unpurged areas in the busy tree
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>, rpenyaev@suse.de,
        peterz@infradead.org, guro@fb.com, rick.p.edgecombe@intel.com,
        rppt@linux.ibm.com, aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>

On Thu, Jul 25, 2019 at 10:36 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 16 Jul 2019 23:26:55 +0800 Pengfei Li <lpf.vector@gmail.com> wrote:
>
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> >
> > The busy tree can be quite big, even though the area is freed
> > or unmapped it still stays there until "purge" logic removes
> > it.
> >
> > 1) Optimize and reduce the size of "busy" tree by removing a
> > node from it right away as soon as user triggers free paths.
> > It is possible to do so, because the allocation is done using
> > another augmented tree.
> >
> > The vmalloc test driver shows the difference, for example the
> > "fix_size_alloc_test" is ~11% better comparing with default
> > configuration:
> >
> > sudo ./test_vmalloc.sh performance
> >
> > <default>
> > Summary: fix_size_alloc_test loops: 1000000 avg: 993985 usec
> > Summary: full_fit_alloc_test loops: 1000000 avg: 973554 usec
> > Summary: long_busy_list_alloc_test loops: 1000000 avg: 12617652 usec
> > <default>
> >
> > <this patch>
> > Summary: fix_size_alloc_test loops: 1000000 avg: 882263 usec
> > Summary: full_fit_alloc_test loops: 1000000 avg: 973407 usec
> > Summary: long_busy_list_alloc_test loops: 1000000 avg: 12593929 usec
> > <this patch>
> >
> > 2) Since the busy tree now contains allocated areas only and does
> > not interfere with lazily free nodes, introduce the new function
> > show_purge_info() that dumps "unpurged" areas that is propagated
> > through "/proc/vmallocinfo".
> >
> > 3) Eliminate VM_LAZY_FREE flag.
> >
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>
> This should have included your signed-off-by, since you were on the
> patch delivery path.  (Documentation/process/submitting-patches.rst,
> section 11).
>
> Please send along your signed-off-by?
