Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1DCECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744E12086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n5fjg1bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389933AbfJAQ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:28:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44190 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfJAQ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:28:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id i14so9973256pgt.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i0vYOnNzNl23wM5oAHQgXQknCy7kFcbZ26kS9YCoHBU=;
        b=n5fjg1bqcekd+hNTKhsmR269yN2JoDYT7RNHZANM0CG3KvJR4l0sKewNwj5Cl+7/R4
         lAyx5LnFBIt1px6L05UmEZPA9i2zOAJkpjn/cjD7aaFAwAdjVxTREahP7BB/PM3xPtIp
         zjjyDFWC3J3WfPK3n+0rHoaP3GdV6ByAiWF14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i0vYOnNzNl23wM5oAHQgXQknCy7kFcbZ26kS9YCoHBU=;
        b=i8aIXOt+MCZHZQlgM5K7yxh7wzXUIuvy1ammLSBvPJviflGm4YFKWaQKv88xEWc+k6
         yjKSzuZIfXQ1yuK3aA9xVjybhHzN4A5RL0l4jv6eRnaLo0a2g1JqN+KW6Ir/eI1YHOQW
         JR5qcyIBZqvUk2ieJRveIQaXt2E9BWdSPg/rS36MHDeC6/+AnQkqHu7wDW80ZRQfQPOv
         Lz4gvCIoGpRehRM8UtZ0ZW+j3HqsZ5IhCFa/D4VfMKyB0DKgB8G/0y3N0UqsOjJqFGUZ
         OkQLqV7sms6Rj8xVZYhiPgTMqxeSMWzp3tUedYfYPkXbZnMjQf+mFMuQJM2EQsIy8Rjw
         xpNg==
X-Gm-Message-State: APjAAAW2uyMm2dE21Vb4K9yTtEliD57mJP00HNCO6SYidZLAsI8lgW0+
        qgSxB736S0JgJGijdWAedSr46Q==
X-Google-Smtp-Source: APXvYqxsBvaB4PwyrQX1efSVDTYBbjVuirkKmUqj8X/jNHPZhagjzfCPkrTmQzSXjn9MZFUDVhtoTQ==
X-Received: by 2002:a63:cb:: with SMTP id 194mr30303545pga.172.1569947330613;
        Tue, 01 Oct 2019 09:28:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i6sm26975081pfq.20.2019.10.01.09.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 09:28:49 -0700 (PDT)
Date:   Tue, 1 Oct 2019 09:28:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <201910010928.243849D@keescook>
References: <20191001011055.19283-1-cyphar@cyphar.com>
 <20191001011055.19283-2-cyphar@cyphar.com>
 <201909301856.01255535BD@keescook>
 <20191001023126.qhzeiwmtoo4agy7t@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001023126.qhzeiwmtoo4agy7t@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 04:31:27AM +0200, Christian Brauner wrote:
> On Mon, Sep 30, 2019 at 06:58:39PM -0700, Kees Cook wrote:
> > On Tue, Oct 01, 2019 at 11:10:52AM +1000, Aleksa Sarai wrote:
> > > +static __always_inline
> > > +int copy_struct_from_user(void *dst, size_t ksize,
> > > +			  const void __user *src, size_t usize)
> > 
> > And of course I forgot to realize both this and check_zeroed_user()
> > should also have the __must_check attribute. Sorry for forgetting that
> > earlier!
> 
> Just said to Aleksa that I'll just fix this up when I apply so he
> doesn't have to resend. You ok with this, Kees?

Yup; that's totally fine. Thanks!

-- 
Kees Cook
