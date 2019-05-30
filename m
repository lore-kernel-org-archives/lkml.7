Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADE9C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A3A243AD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559176737;
	bh=aQUSuCugDNtQOLZKf50zIDTg2Xs7Dv8luTHLUHYFDaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EFNAF2PmLLOomHFFUwkUssn7waLzfKBT088LSPg4g4uY/aMw2iz3A52ZtdVtKIlgn
	 9Nv5kHWqdg/BROFgMbKAthm+rAJkIyQko3XI7lWSK9tnMmb//3kGr7wNNdHE9uu40i
	 /uQK4dbVQbC9c6fPcCYYWNlqy432eurBqRkOFIss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfE3Ai4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 20:38:56 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:37690 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3Aiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 20:38:55 -0400
Received: by mail-pg1-f173.google.com with SMTP id 20so898656pgr.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 17:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PmTxsZkl/AZl4brRAQiwifi011qlZsWSQ/8ZgN8xMbA=;
        b=Pc5nQ4KY0u/WJH6JmIuktS4PiaBLd3d+GzXGFZ+KrPViWEtma9wJOSCNqwN5t/mqOg
         +cP8gofnO/oGiMt4Yso0+ueXxLmNQAo+3DI8bBHgdRmB6cWzFfYn/estnRkmIEgL34Iu
         vNsVg3gLlFRiNRUHEGUwGHOJ+MgM02/Bgiom8sULebTAcK4gYgHCQQEZWnietnZ8rEbx
         uKBZt7DgnbgcUMa2UhhYq8B4HUXrPVfMvY12OW5jDZ6RbviAqEK/3BnvbIhjeshVsKIE
         SQp8nN2CO8XBSeZT7eT0GEetoyJOK4SA9UVyF0KE/m8i2OH4eD1GRSAwAeD0KXg07acD
         TqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PmTxsZkl/AZl4brRAQiwifi011qlZsWSQ/8ZgN8xMbA=;
        b=U+jTbfro9jDMOIX2liRbvUMEX84ShwL5JpA7Oi+tGq8tZC85h0AlwqEFlezg4Ga4jt
         iaK/HtMTMfrEQcx3gifYpqAdTW6VCCI1jlHBSvGFjbtWNE9AN9ataemF1NHeU6/cyMMB
         l/hgAbBavWV223XfBOeZLfoPcBVeCdZ/XV6N2bM42mxqxU4rPFvIDEOpAEyRoruOlpFf
         GfhGkaOsl6JkJjc5IV1IV1G1E/kM5K984LsqlPl/3fgijnRjA6TwNAa013lmJjUUy8iH
         sWkDse+GDptf/mOpn7S+pAIc0sAi0PuLn9944LiiY83LuABIck3X7iD6M3MQtJdyIxtR
         xMlQ==
X-Gm-Message-State: APjAAAVhDp+N3lGt1/k28VTqxCA/7FSS69isa7/f+vF7CDFjW0p7YayE
        rU2Cn1m9ThNCvNUt0OAJGh4vr+Jj
X-Google-Smtp-Source: APXvYqzw5AlJSHjj40ImNWg/oZ+XB0d+TgUm/he7O0X2LAPW67NhA2ViCotOlWQo5ntazwv6Ff5Zgw==
X-Received: by 2002:a17:90a:6348:: with SMTP id v8mr826412pjs.34.1559176734933;
        Wed, 29 May 2019 17:38:54 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id 4sm867780pfj.111.2019.05.29.17.38.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 17:38:53 -0700 (PDT)
Date:   Thu, 30 May 2019 09:38:48 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 5/7] mm: introduce external memory hinting API
Message-ID: <20190530003848.GB229459@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-6-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520035254.57579-6-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 11:41:23AM +0800, Hillf Danton wrote:
> 
> On Mon, 20 May 2019 12:52:52 +0900 Minchan Kim wrote:
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -355,6 +355,7 @@
> >  425	common	io_uring_setup		__x64_sys_io_uring_setup
> >  426	common	io_uring_enter		__x64_sys_io_uring_enter
> >  427	common	io_uring_register	__x64_sys_io_uring_register
> > +428	common	process_madvise		__x64_sys_process_madvise
> >  
> Much better if something similar is added for arm64.

I will port every architecture once we figure out RFC and reaches the
conclusion for right interface.

> 
> >  #
> >  # x32-specific system call numbers start at 512 to avoid cache impact
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -832,6 +832,8 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
> >  __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
> >  #define __NR_io_uring_register 427
> >  __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
> > +#define __NR_process_madvise 428
> > +__SYSCALL(__NR_process_madvise, sys_process_madvise)
> >  
> >  #undef __NR_syscalls
> >  #define __NR_syscalls 428
> 
> Seems __NR_syscalls needs to increment by one.

Thanks. I will fix it.
