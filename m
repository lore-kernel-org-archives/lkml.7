Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AEEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEEC2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MKT4yReb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbfB1Uo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:44:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45972 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732794AbfB1UoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:44:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id d24so18123369ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 12:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VA5nzNT5SRcMaUMBhDsz42bvVihu0EYjwSEkOG9g5Q=;
        b=MKT4yRebQ3XFwrUgwZj0QnrXisDJlO0UL9Q7vtfrKVi31aTJqkFhmffN4noz3wl8I7
         pwB5dNW0mTF7qpEuFPA4c8BoOCxpMB0G7qFHbP9Fb2QTeJ407bwlyj8py0jYNEOPbk/w
         JP7OB8Bm79VW37NCiFqhk7JvkyN68p3U2b4wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VA5nzNT5SRcMaUMBhDsz42bvVihu0EYjwSEkOG9g5Q=;
        b=gkE1Eh7V9Z/1sZLhvl45oyU3k9xEX31KUMMdgcQLYiHKEHjnKS/ZZmUYAXnjzsa57V
         DzzJVcLjb7onYl13zZSe0XT0+U4IKe13KX8xQA48HQfnQRLQMmU48zfvhDAWTbdywRQk
         b1QwMpxn+tv/jizSPflZ9gUuRKRDNkxF8pxX37Ys6ALpFjeVYInlN208wHuLnv3Eicwl
         ek74BEfv+yuUbzzFKNVHjLEkAt4fW9PtpJa6FsbrUmE8CWP08E0orMVJN96OBur7btLw
         ZaYTLlOayJlRqMceEriBD4El3Xex5rGi6ZSGPEZLAarcqCqCrTICBRve3O9BBHsbGZ4K
         ioVA==
X-Gm-Message-State: APjAAAXApfDz+erD6Bk7HvHPVoBLER0On7hIDzMbooOEQbn5UOAMkNXV
        QrqtG9Z3xfJknZ1Au0FLjbb0wlE/9T3EpgRRKTw7pg==
X-Google-Smtp-Source: APXvYqzBBm1yK2JYH5eWv9lzdZCgL9Lkv88x06FsAmXGa8ej5GpmBjOnhYOz2GJz3sxj58nqy26GwNPGX1VWzB93b3g=
X-Received: by 2002:a2e:850a:: with SMTP id j10mr555683lji.102.1551386663347;
 Thu, 28 Feb 2019 12:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20190226091314.18446-1-osalvador@suse.de> <20190226140428.3e7c8188eda6a54f9da08c43@linux-foundation.org>
 <20190227213205.5wdjucqdgfqx33tr@d104.suse.de> <5edcfeb8-4f53-0fe6-1e5b-c1e485f91d0d@suse.cz>
In-Reply-To: <5edcfeb8-4f53-0fe6-1e5b-c1e485f91d0d@suse.cz>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 28 Feb 2019 12:44:11 -0800
Message-ID: <CAEXW_YQFDJUjHmjE+aF6RkBxO8fzF2j5M1Tufj12MUuvouyOsA@mail.gmail.com>
Subject: Re: [PATCH] mm,mremap: Bail out earlier in mremap_to under map pressure
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, jglisse@redhat.com,
        Yang Shi <yang.shi@linux.alibaba.com>,
        mgorman@techsingularity.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 12:06 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 2/27/19 10:32 PM, Oscar Salvador wrote:
> > On Tue, Feb 26, 2019 at 02:04:28PM -0800, Andrew Morton wrote:
> >> How is this going to affect existing userspace which is aware of the
> >> current behaviour?
> >
> > Well, current behavior is not really predictable.
> > Our customer was "surprised" that the call to mremap() failed, but the regions
> > got unmapped nevertheless.
> > They found it the hard way when they got a segfault when trying to write to those
> > regions when cleaning up.
> >
> > As I said in the changelog, the possibility for false positives exists, due to
> > the fact that we might get rid of several vma's when unmapping, but I do not
> > expect existing userspace applications to start failing.
> > Should be that the case, we can revert the patch, it is not that it adds a lot
> > of churn.
>
> Hopefully the only program that would start failing would be a LTP test
> testing the current behavior near the limit (if such test exists). And
> that can be adjusted.
>

IMO the original behavior is itself probably not a big issue because
if userspace wanted to mremap over something, it was prepared to lose
the "over something" mapping anyway. So it does seem to be a stretch
to call the behavior a "bug". Still I agree with the patch that mremap
should not leave any side effects after returning error.

thanks,

 - Joel
