Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E663CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0DB216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="e1W5PQo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbfHFKrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:47:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35030 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbfHFKrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:47:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so37717088plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 03:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=781gQFojuZXlLR9f0Rnz2BsSQ1xNulNQY/lDauCDdSA=;
        b=e1W5PQo6UI3vE5fsYo9GNTQns85aj/gUpDhLx9+3D64tPpFl02X83oJkMy9XzTBNmf
         x7k9LQX1mYX3Ou3y4IWdZK6NAO3h5S7a8ijztUPEK9VYoOKSdCKcExDxxqYFFPD7vS3L
         s8MA9DjsMd/kXQN1m2atBXnvStSWMRuGddxJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=781gQFojuZXlLR9f0Rnz2BsSQ1xNulNQY/lDauCDdSA=;
        b=D/OBf9lhZSKqtQH3+vvsOCnnuz9ADmjoplOTi7EbNvYZoFvn91VOGjI0jjPZMOzEhw
         qm2K/ufCVpSyJTch5ueqxb3Z5WyAyTzx/UX/XI95jTm1XNdnCJqnHHDCh33aTd2AUj7/
         O/PD8iOOMY6TR8RxLa8QFtJLwo/gy4zFVYvI6R3lLDQI9uyW1vRHoeKQedQ8CuUBYFqL
         gKNV6aepM0LSLFhhTIs2Rk+5cOuzMNWnFF8Y+6TQ1eF6ac7Pw/BAPKWardR/17kaMQK5
         2mUpbNIG9M8hjJGm+/F/6aLKMKh4yFI8pHq4Zo7OEeI2jRyFMGk/0q9mKXOcexwFMtV5
         CGZw==
X-Gm-Message-State: APjAAAUDxICGbt/nz3m+lnYtUWeh5Uu2Babj+ZAmWfKtNMih7zK+q4G5
        FrU5My7Q5OrlaFvtxiqAgDCHYQ==
X-Google-Smtp-Source: APXvYqyckGHtBm2UKAu71b4v/ySxM/JXAjxm9Txb7Dg6O/cihgtEDSFSoalvYdEzzWgdgOHwA+AgNw==
X-Received: by 2002:a17:902:654f:: with SMTP id d15mr2365106pln.253.1565088438061;
        Tue, 06 Aug 2019 03:47:18 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a21sm95934459pfi.27.2019.08.06.03.47.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 03:47:17 -0700 (PDT)
Date:   Tue, 6 Aug 2019 06:47:15 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 1/5] mm/page_idle: Add per-pid idle page tracking
 using virtual indexing
Message-ID: <20190806104715.GC218260@google.com>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190806085605.GL11812@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806085605.GL11812@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 10:56:05AM +0200, Michal Hocko wrote:
> On Mon 05-08-19 13:04:47, Joel Fernandes (Google) wrote:
> > The page_idle tracking feature currently requires looking up the pagemap
> > for a process followed by interacting with /sys/kernel/mm/page_idle.
> > Looking up PFN from pagemap in Android devices is not supported by
> > unprivileged process and requires SYS_ADMIN and gives 0 for the PFN.
> > 
> > This patch adds support to directly interact with page_idle tracking at
> > the PID level by introducing a /proc/<pid>/page_idle file.  It follows
> > the exact same semantics as the global /sys/kernel/mm/page_idle, but now
> > looking up PFN through pagemap is not needed since the interface uses
> > virtual frame numbers, and at the same time also does not require
> > SYS_ADMIN.
> > 
> > In Android, we are using this for the heap profiler (heapprofd) which
> > profiles and pin points code paths which allocates and leaves memory
> > idle for long periods of time. This method solves the security issue
> > with userspace learning the PFN, and while at it is also shown to yield
> > better results than the pagemap lookup, the theory being that the window
> > where the address space can change is reduced by eliminating the
> > intermediate pagemap look up stage. In virtual address indexing, the
> > process's mmap_sem is held for the duration of the access.
> 
> As already mentioned in one of the previous versions. The interface
> seems sane and the usecase as well. So I do not really have high level
> objections.

That is great to know.

> From a quick look at the patch I would just object to pulling swap idle
> tracking into this patch because it makes the review harder and it is
> essentially a dead code until a later patch. I am also not sure whether
> that is really necessary and it really begs for an explicit
> justification.

Ok I will split it out, and also expand on the need for it a bit more.

> 
> I will try to go through the patch more carefully later as time allows.

Thanks a lot.

> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> -- 
> Michal Hocko
> SUSE Labs

 - Joel

