Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B739C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 22:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137DC206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 22:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iQgb6wIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfL3Wqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 17:46:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46211 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfL3Wqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 17:46:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id k8so30860791otl.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 14:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KVG0ZR5whludu2LSxTJJPsDmCMwU7s5sjwPL/Fg7FNM=;
        b=iQgb6wISYMyhiHn/Zvtp1vRHA1m4RL+tfGKtMDDGSsPpRKYEzxuC/urCzo+TDIGMuT
         f022i9b9eaKHoKP1MgQx5LEkL1ONKhqtPa8t4F2ecoT4JzINsQdmLTZPEVFAfFgsfXvo
         fpO2Rx4UH4WOqcPc0f0rCSLkfHXo4+4YgpcuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KVG0ZR5whludu2LSxTJJPsDmCMwU7s5sjwPL/Fg7FNM=;
        b=g+MN+bNdYweDsWkjVs3yPsHrK6Ed1q1T1vnqiBYIQt0HWdo50itLzsSK/PLAc9BIe/
         hIls2+I79jtn4MALpg4ZzbVYxg7O6OhN/7mBW8aFUl5TaaXuvBUrP/sfmg+byYzFCZfR
         414NuTauN4LP/ngxy9cQ20tQdR6/N0D9TBGHqGFV9qcOBkq3gR/PczvbEnUyrcx8xbpm
         GLDPRl4VROJs7tcqBxvsCh7YaP4BxK5QMjq06GlZ5mdZjgM59UNYl2ZEgo7mtHv4s9NS
         48xxPYxNwlkfGetto9DrbPWGpvSfOMadvu7BeubX10MDn+clHbdC5vygSa+kseqLojNJ
         HzpQ==
X-Gm-Message-State: APjAAAXTVaH+bgs2NhnzQKcJjUtl3AQlgc+6K5X2d61BqD6aoYE2gyOJ
        THD1snSQiGd69kgg83/t8vZ9s06s5gc=
X-Google-Smtp-Source: APXvYqx1uSAC8SMnbJijSNU/sEEjLLoG6ebIQO4DqMv6Xn/Zwp5rEtAsnVmiQlSzdP7KVkn0nzeWNA==
X-Received: by 2002:a05:6830:147:: with SMTP id j7mr78036332otp.44.1577746012664;
        Mon, 30 Dec 2019 14:46:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s83sm14220610oif.33.2019.12.30.14.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 14:46:51 -0800 (PST)
Date:   Mon, 30 Dec 2019 14:46:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, notify@kernel.org
Subject: Re: [PATCH v1 1/1] lkdtm/stackleak: Make the stack erasing test more
 verbose
Message-ID: <201912301443.9B8F6CA6@keescook>
References: <20191219145416.435508-1-alex.popov@linux.com>
 <201912301034.5C04DC89@keescook>
 <5bde4de0-875c-536b-67ec-eafebb8b9ab1@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bde4de0-875c-536b-67ec-eafebb8b9ab1@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 01:20:24AM +0300, Alexander Popov wrote:
> Hello Kees!
> 
> On 30.12.2019 21:37, Kees Cook wrote:
> > On Thu, Dec 19, 2019 at 05:54:16PM +0300, Alexander Popov wrote:
> >> Make the stack erasing test more verbose about the errors that it
> >> can detect. BUG() in case of test failure is useful when the test
> >> is running in a loop.
> > 
> > Hi! I try to keep the "success" conditions for LKDTM tests to be a
> > system exception, so doing "BUG" on a failure is actually against the
> > design. So, really, a test harness needs to know to check dmesg for the
> > results here. It almost looks like this check shouldn't live in LKDTM,
> 
> Hm, I see...
> 
> Let me explain why I've decided to use BUG() in case of a failure.
> 
> Once upon a time I noticed that the stack erasing test failed on a kernel with
> KASAN enabled. It happened only once, and all my numerous efforts to reproduce
> it failed. That's why I come with this patch. These changes provide additional
> information and allow easy detection of a failure when you run the test in a loop.
> 
> Is stackleak test the only exception of this kind in LKDTM?

Some of the refcount_t tests don't trigger a WARN(), and there are
related benchmarking tests that don't either.

> > but since it feels like other LKDTM tests, I'm happy to keep it there
> > for now.
> 
> Do you mean that you will apply this patch?

Sorry for my confusing reply! I meant that I don't want to apply the
patch, but I'm find to leave the stackleak check in LKDTM.

However, if you want to split it out into its own test, I think that
should be fine; similar to lib/test_user_copy.c if you want it to stand
alone and have its own semantics, etc.

> > I'll resend my selftests series that adds a real test harness for all
> > the LKDTM tests and CC you.
> 
> Ok!
> 
> Maybe you also see how to improve the LKDTM infrastructure and remove this
> inconsistency. Could you share your ideas?

I don't, unfortunately. The real "difficulty" is that some of the
crashes are architecture-specific (e.g. how MMU traps are reported
across different architectures), so it's not too easy to consolidate
the reporting. As a result, I've taken to trying to do best-effort on
the test running side. I'll send what I've got...

-- 
Kees Cook
