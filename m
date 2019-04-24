Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80852C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E6F2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MkCahJzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbfDXTdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:33:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38626 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfDXTdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:33:24 -0400
Received: by mail-io1-f67.google.com with SMTP id y6so9212299ior.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wflHOq/5T+ZXCjWUuQ+Otw4+acC/CT36CLZGEdvvwaE=;
        b=MkCahJznroJgkW0oElWPSJZfpPCaob0MRXbne3p3BT20DPsC6WzDWFDMguURI7KEUc
         eANX+vUFF7XOTjHjzkp4FeIoH0JkOadAa4TE/mga9BWwa5PLIMpcbSpg/bJZFOSwVKCV
         4Q7yDEfqH7zZT5ycivz/8LjKPa/uL3SuZxwEwYaUJLUsO5HviFOpxD7/3PxprCQCp6QS
         0Z/oojm96tqPir32wttihXjEo7Ts9fdxtgme0APOa5EClsFWIwjfz8ARQdsqd7l8fN8h
         JlnEj4rUMmtRngVS+A9XBCncRgF9xq4HnyQYmm8OF5ZHrqmmgl7tApaprI1Y8fuIB/Md
         T67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wflHOq/5T+ZXCjWUuQ+Otw4+acC/CT36CLZGEdvvwaE=;
        b=q4UnXScI5ENOYCUq2hXkrC0mfhcSnDW1nyDrWdvbSYP9x0ZDOPbagd1hIzth59iDUC
         VLudfr5yjX6fqsaqy1k3TPF60SaHGEWLY5kaWlgjcvkQqZ2tf5NC7ADTLEkLQDVn5C8e
         YifajaCSheLr+OvJx6sNB8bpHqkulF4BULHoUB8sD/ZWx07EnEtkyTDUF2jbveAdr4Q3
         qaE10ercKTFpaNSiXinGzoK5YvOGff4094p6MG7bQpWfnj47QNDk6Gv37zEIcLnCJUgb
         1q9rcsXKMZoRESaMkaKTPi4GJDG7OiF5tU+LKOgQ0jSwdhHH6eYaM1AU1A7YH2gI1hMb
         9j9g==
X-Gm-Message-State: APjAAAU4XXWGEuGQWbqu1qnny2Z8CJwHyggpXLFcs2y2Bz8cuVxBncBH
        y/P5vpH68DRq6jfcqT65z3wNzeiQ+nnZz/uhIlfFINeofCs=
X-Google-Smtp-Source: APXvYqyZ6gkVfnPB+2Wm+lmoiD9i9oQZ/3gTK2G6IZU6rxzaYekMVKzu1A48tZlKywRxbPgn3/pfxDfejrLw0asL8wg=
X-Received: by 2002:a5e:8348:: with SMTP id y8mr21067935iom.88.1556134403324;
 Wed, 24 Apr 2019 12:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190424191440.170422-1-matthewgarrett@google.com> <20190424192812.GG19031@bombadil.infradead.org>
In-Reply-To: <20190424192812.GG19031@bombadil.infradead.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 24 Apr 2019 12:33:11 -0700
Message-ID: <CACdnJutj4K1kQj7yXcCNVWM_hmrUwMfZ-JBi=FHkBvYFfbJNZA@mail.gmail.com>
Subject: Re: [PATCH] mm: Allow userland to request that the kernel clear
 memory on release
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:28 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Apr 24, 2019 at 12:14:40PM -0700, Matthew Garrett wrote:
> > Unfortunately, if an application exits uncleanly, its secrets may still be
> > present in RAM. This can't be easily fixed in userland (eg, if the OOM
> > killer decides to kill a process holding secrets, we're not going to be able
> > to avoid that), so this patch adds a new flag to madvise() to allow userland
> > to request that the kernel clear the covered pages whenever the page
> > reference count hits zero. Since vm_flags is already full on 32-bit, it
> > will only work on 64-bit systems.
>
> Your request seems reasonable to me.
>
> > +++ b/include/linux/page-flags.h
> > @@ -118,6 +118,7 @@ enum pageflags {
> >       PG_reclaim,             /* To be reclaimed asap */
> >       PG_swapbacked,          /* Page is backed by RAM/swap */
> >       PG_unevictable,         /* Page is "unevictable"  */
> > +     PG_wipeonrelease,
>
> But you can't have a new PageFlag.  Can you instead zero the memory in
> unmap_single_vma() where we call uprobe_munmap() and untrack_pfn() today?

Is there any way the page could be referenced by something other than
a VMA at this point? If so we probably don't want to zero it here, but
we do want to zero it when the page is finally released (which is why
I went with a page flag)
