Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477A1C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E49218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Zmts+InM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390402AbfGWNrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:47:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36521 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390379AbfGWNrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:47:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so19468709pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Y4bJNUBVZG75Wm6fTCb90iILIxIQdsm+YFE3cN2CDj8=;
        b=Zmts+InMHsGjlJGme/8wFfX+TuhCwWTW+otdQ5V8txyciEL0cqRu54oilSH2RbNNAF
         VWdY0Y/WyGvj48CrXvtBZLJzvdZFqixczAL7t2xx2vgMiD6TpktWsVIczAVKZN0pibRE
         X3xgb5a1uRr0Khp6dguCzf7wxkuf0OkwWPAOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y4bJNUBVZG75Wm6fTCb90iILIxIQdsm+YFE3cN2CDj8=;
        b=qltKFAG/lqMlo1WdPiOA7cls20PiWP2b/VrixlLzbDffGx7mBCBlomSniFK8aACdaB
         ePFrZtQs5YuAagiSbBT0BnHjNTsz/ach7fRZNR+Izj1AYakus/NQ370++8NbkXoKldd8
         r80zLHLNb0jfH5qJkF6O1NyUfDC3r5N5aVGEIi+3gu/SGAFnf5qu9dZqVz19zjUequZi
         U+MW7Wm9vQe7R2y9A/pGN3WNO6fzQM4dv3mrsWdYXJlCRuqHKKMeq8S6fsIBi6B56+Zc
         RwsEFzUUI6COqH2cizQBkT9ozKOfmgvIxFautbQOnmDdOe+V+14/b28DP23N0+Lo7hju
         STcA==
X-Gm-Message-State: APjAAAX+TG1qUyPLkwbR0zB51paVbsOCLBie/MRg5llsQHBGbSM4Walz
        hYWRuXYrAqj3LpFUbDBQzMs=
X-Google-Smtp-Source: APXvYqy1yaJdw72Q0Nn6ojy3Q+rfO8ub0HIQhJmz+v+fs5k97MSDA2l1FqDyB6T38VJefPW//aW01A==
X-Received: by 2002:a63:20d:: with SMTP id 13mr65441358pgc.253.1563889668469;
        Tue, 23 Jul 2019 06:47:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v126sm11955926pgb.23.2019.07.23.06.47.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 06:47:47 -0700 (PDT)
Date:   Tue, 23 Jul 2019 09:47:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, vdavydov.dev@gmail.com,
        Brendan Gregg <bgregg@netflix.com>, kernel-team@android.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        carmenjackson@google.com, Christian Hansen <chansen3@cisco.com>,
        Colin Ian King <colin.king@canonical.com>, dancol@google.com,
        David Howells <dhowells@redhat.com>, fmayer@google.com,
        joaodias@google.com, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@google.com,
        minchan@kernel.org, namhyung@google.com, sspatil@google.com,
        surenb@google.com, Thomas Gleixner <tglx@linutronix.de>,
        timmurray@google.com, tkjos@google.com,
        Vlastimil Babka <vbabka@suse.cz>, wvw@google.com
Subject: Re: [PATCH v1 1/2] mm/page_idle: Add support for per-pid page_idle
 using virtual indexing
Message-ID: <20190723134746.GB104199@google.com>
References: <20190722213205.140845-1-joel@joelfernandes.org>
 <01568524-ed97-36c9-61f7-e95084658f5b@yandex-team.ru>
 <8b15dac6-f776-ac9a-8377-ae38f5c9007f@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b15dac6-f776-ac9a-8377-ae38f5c9007f@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 01:10:05PM +0300, Konstantin Khlebnikov wrote:
> On 23.07.2019 11:43, Konstantin Khlebnikov wrote:
> > On 23.07.2019 0:32, Joel Fernandes (Google) wrote:
> > > The page_idle tracking feature currently requires looking up the pagemap
> > > for a process followed by interacting with /sys/kernel/mm/page_idle.
> > > This is quite cumbersome and can be error-prone too. If between
> > > accessing the per-PID pagemap and the global page_idle bitmap, if
> > > something changes with the page then the information is not accurate.
> > > More over looking up PFN from pagemap in Android devices is not
> > > supported by unprivileged process and requires SYS_ADMIN and gives 0 for
> > > the PFN.
> > > 
> > > This patch adds support to directly interact with page_idle tracking at
> > > the PID level by introducing a /proc/<pid>/page_idle file. This
> > > eliminates the need for userspace to calculate the mapping of the page.
> > > It follows the exact same semantics as the global
> > > /sys/kernel/mm/page_idle, however it is easier to use for some usecases
> > > where looking up PFN is not needed and also does not require SYS_ADMIN.
> > > It ended up simplifying userspace code, solving the security issue
> > > mentioned and works quite well. SELinux does not need to be turned off
> > > since no pagemap look up is needed.
> > > 
> > > In Android, we are using this for the heap profiler (heapprofd) which
> > > profiles and pin points code paths which allocates and leaves memory
> > > idle for long periods of time.
> > > 
> > > Documentation material:
> > > The idle page tracking API for virtual address indexing using virtual page
> > > frame numbers (VFN) is located at /proc/<pid>/page_idle. It is a bitmap
> > > that follows the same semantics as /sys/kernel/mm/page_idle/bitmap
> > > except that it uses virtual instead of physical frame numbers.
> > > 
> > > This idle page tracking API can be simpler to use than physical address
> > > indexing, since the pagemap for a process does not need to be looked up
> > > to mark or read a page's idle bit. It is also more accurate than
> > > physical address indexing since in physical address indexing, address
> > > space changes can occur between reading the pagemap and reading the
> > > bitmap. In virtual address indexing, the process's mmap_sem is held for
> > > the duration of the access.
> > 
> > Maybe integrate this into existing interface: /proc/pid/clear_refs and
> > /proc/pid/pagemap ?
> > 
> > I.e.  echo X > /proc/pid/clear_refs clears reference bits in ptes and
> > marks pages idle only for pages mapped in this process.
> > And idle bit in /proc/pid/pagemap tells that page is still idle in this process.
> > This is faster - we don't need to walk whole rmap for that.
> 
> Moreover, this is so cheap so could be counted and shown in smaps.
> Unlike to clearing real access bits this does not disrupt memory reclaimer.
> Killer feature.

I replied to your patch:
https://lore.kernel.org/lkml/20190723134647.GA104199@google.com/T/#med8992e75c32d9c47f95b119d24a43ded36420bc

