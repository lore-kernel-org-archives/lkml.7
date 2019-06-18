Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DDCC31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A722133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfFRIBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:01:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37435 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRIBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:01:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so14193320qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 01:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELlMVonpbEABBkseUdTxSk6vYaA7MdUkuNEpzt+TAlo=;
        b=gfkLRYFxATadm93Lgu4d5Qrt3vKxEBDMzY/Z6wXu+OZDZubJLkH0qprYVBRLNkydT8
         ZxQUSwChvf9KSSFhC6QWkOAv4/j7EtXD2fhPfSDM26LvZeBHT23jKKF+MkMO+TVTevC6
         yIPBm6+xdBKGSkAjCBOC3iYRRNJGOwt9bUc20De+QFQnxULmwWEd8izVodWvTGKMwqIE
         ri1hj3qC6y4DHX6HsZwlYW1vDllbUy+LtviFWp6olBj5LzCgiKsoQU2GDVxSVOR/xR4a
         8F+FR4uNCK6tTs5AYHPT7AcAsP0rCSbaMTs//cmBtaivZDUb+G2WwBzmweAdmtNWR67J
         LKYQ==
X-Gm-Message-State: APjAAAVIR+KheVIyEUdyvGSbHKdxFo0yHoi5msEgqxvlRWgYhnhWvbzG
        s9k14M9lQFLsjjxcGYU/DPGRNeMMEYNRZAHjhw4=
X-Google-Smtp-Source: APXvYqynQ5w36BP/oae5cSk/XmTmxDHjsYOb6nmmK9VfbUuACv+qzschtpJZO5zjFMzBPDMzYItF9huO7MOjqr8Yc28=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr93398121qtf.204.1560844903063;
 Tue, 18 Jun 2019 01:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190617121427.77565-1-arnd@arndb.de> <20190617141244.5x22nrylw7hodafp@pc636>
 <CAK8P3a3sjuyeQBUprGFGCXUSDAJN_+c+2z=pCR5J05rByBVByQ@mail.gmail.com>
 <CAK8P3a0pnEnzfMkCi7Nb97-nG4vnAj7fOepfOaW0OtywP8TLpw@mail.gmail.com>
 <20190617165730.5l7z47n3vg73q7mp@pc636> <CAK8P3a1Ab2MVVgSh4EW0Yef_BsxcRbkxarknMzV7tOA+s79qsA@mail.gmail.com>
In-Reply-To: <CAK8P3a1Ab2MVVgSh4EW0Yef_BsxcRbkxarknMzV7tOA+s79qsA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Jun 2019 10:01:26 +0200
Message-ID: <CAK8P3a0965MhQfpygCqxqnocLt9f4L80-mF-UgoP5OdAoLCCqw@mail.gmail.com>
Subject: Re: [BUG]: mm/vmalloc: uninitialized variable access in pcpu_get_vm_areas
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Penyaev <rpenyaev@suse.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 9:29 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 17, 2019 at 6:57 PM Uladzislau Rezki <urezki@gmail.com> wrote:

> Using switch/case makes it easier for the compiler because it
> seems to turn this into a single conditional instead of a set of
> conditions. It also seems to be the much more common style
> in the kernel.

Nevermind, the warning came back after all. It's now down to
one out of 2000 randconfig builds I tested, but that's not good
enough. I'll send a patch the way you suggested.

      Arnd
