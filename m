Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459CEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 06:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6A32084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 06:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YBWFagRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfHOGw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 02:52:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45377 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfHOGw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 02:52:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id x19so1273784eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 23:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AdThTK4irWjRHbKRNPRojupEGI8CuxNqyMHUGO6haU0=;
        b=YBWFagRxj3AfoQNeT1UBuJe04QemjMpngCbeoAlxYRV7G8aAfyWVf43ySnd4OGigxl
         Ns4xbcsW7Azu5FyzHwpJgyFbWPQVJjetlQmlGonoYkSnreGT+4qCoMjbqjRsUQV31Hvp
         z9jyRdBKqwQdDr3jRTT1T/yIfgsHR8yJHCyq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AdThTK4irWjRHbKRNPRojupEGI8CuxNqyMHUGO6haU0=;
        b=j0D72ASffdqk9F3nlMVnPfcC6N2XPZ3glgI7wZQJlgyV2Oc50wfC8byAdTcKqjnPRx
         cOWicgu4T7QXjAbzb7cA74yk9JOpt0MXt8vB2AF4yb+CpjYa7lhnVG1TQ/j6ONbQRbPm
         cD++tlrku+r6Tp3n4tufRel86DMBCELXRBp8XKa0g4EMJWh5RGdIBYTsB0GLCsY2klMm
         WKGDek/FOImNT3yZfS37eYyvX64xrJiYC15s9v/+1ICYpirhkN1k9uXu6K1CBwA8b4vl
         U3lrtUmwGVuIb4AjNaaXMgViwYHwDgtxucfQMUEAUAy/TcYocNBFWlFMLrcdvFGuDIu6
         eUnA==
X-Gm-Message-State: APjAAAVK0cRS2Kvj2yfkxfsDJDxmHiIz0AY443ia9REOZSygY0dBmh+/
        3L5KqHPzRHK9zAntN+fPVxoKKQ==
X-Google-Smtp-Source: APXvYqzKfh04I5n5jqpFb/od47twmHRq+smHNDBFxhta5k8M0iVd0qgYIIokvl2AA/0YJfkhp6dXOw==
X-Received: by 2002:a50:a485:: with SMTP id w5mr3690508edb.277.1565851944641;
        Wed, 14 Aug 2019 23:52:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w3sm391183edu.4.2019.08.14.23.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 23:52:23 -0700 (PDT)
Date:   Thu, 15 Aug 2019 08:52:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190815065221.GZ7444@phenom.ffwll.local>
Mail-Followup-To: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
        Feng Tang <feng.tang@intel.com>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-3-daniel.vetter@ffwll.ch>
 <20190814134558.fe659b1a9a169c0150c3e57c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814134558.fe659b1a9a169c0150c3e57c@linux-foundation.org>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 01:45:58PM -0700, Andrew Morton wrote:
> On Wed, 14 Aug 2019 22:20:24 +0200 Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> 
> > In some special cases we must not block, but there's not a
> > spinlock, preempt-off, irqs-off or similar critical section already
> > that arms the might_sleep() debug checks. Add a non_block_start/end()
> > pair to annotate these.
> > 
> > This will be used in the oom paths of mmu-notifiers, where blocking is
> > not allowed to make sure there's forward progress. Quoting Michal:
> > 
> > "The notifier is called from quite a restricted context - oom_reaper -
> > which shouldn't depend on any locks or sleepable conditionals. The code
> > should be swift as well but we mostly do care about it to make a forward
> > progress. Checking for sleepable context is the best thing we could come
> > up with that would describe these demands at least partially."
> > 
> > Peter also asked whether we want to catch spinlocks on top, but Michal
> > said those are less of a problem because spinlocks can't have an
> > indirect dependency upon the page allocator and hence close the loop
> > with the oom reaper.
> 
> I continue to struggle with this.  It introduces a new kernel state
> "running preemptibly but must not call schedule()".  How does this make
> any sense?
> 
> Perhaps a much, much more detailed description of the oom_reaper
> situation would help out.

I agree on both points, but I guess I'm not the expert to explain why we
have this. All I'm trying to do is that drivers hold up their side. If you
want to have better documentation for why the oom case needs this special
new mode, you're looking at the wrong guy for that :-)

Of course if you folks all decide that you just don't want to be
remembered about that I guess we can drop this one here, but you're just
shooting the messenger I think.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
