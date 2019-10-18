Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D73CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 23:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7552A21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 23:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="iRgnRoiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfJRXMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 19:12:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34743 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfJRXMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 19:12:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id 83so6624095oii.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 16:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LG5mtPGY98QkEsSFwWtnXL/ah69Lb+RuUfP4f3yut5c=;
        b=iRgnRoiyWhuVYKScQU1EUUBj9SAQggmJSx1lqnfH79UM+KhZWiBFpRGkZPT+FoI24s
         rNiGuOA4828mM5RiW5KQDGn3B4wIKJk5jigQO8F5uPQlG0DZao8n2WwwlwIIhQ91+kE0
         yfPK0De6IcJ369t6CxCZI+VLyBrFaxdJl921WLd+mXlj0z2MWnXSPnGbAR8ep/FkW6S/
         p4eAmO7of8K/7I+JTt+Cd5E3SOdwG5NWsYJdjnmm4pkSkeWva6AQfaSSKrTuGfFSsU3+
         TIa+g9AlDgKhpeIRpVNgnpWnkGszAVWI3xqtmDHKqlKZPc2FJwNLuKjyy4mRo/vF8a0I
         NS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LG5mtPGY98QkEsSFwWtnXL/ah69Lb+RuUfP4f3yut5c=;
        b=lnfE5NhoDlU4ulU3U+rtCX69oN5jhPuK2iQyXA5ffy1CsiUDkgJyUFYBdTgFzSFgBk
         Voplez0d+3zm6AJtnEuC/aTCFJE7fN+VLsN1BeVmz16HFWklcljg6ki8+7mOHaJdL+DE
         D4q/7fBznwwATuHBW8LhjlqsJuKN5LXdDxCd2STh36hnTa/DUcdEueKJXlKZNACjz0s9
         sMmXSBLqH5/Qo6Of1PCx5o49JI4TPXlpxICj+0oJfH6Vdt7/DdfXvB5y4u6Y4HmXwkES
         4ydsJGmivchG+WUbBHOxF7NKQ5C9CQhbv0Z1EOqms3cRDFd10Orn/OXwJauvqyx0pr0W
         Tipg==
X-Gm-Message-State: APjAAAW5NicF6Bilg9nczcfRm//GXWc4jgOTCb1KSusI+cg37dByOY/E
        Hjgdu/6xLUkI1+RrjoODzUBaLEjdPJXVd8Nl4d1+W24W
X-Google-Smtp-Source: APXvYqx+l3J9Z5dyG0kp74OJpHiYKU8uW2txO74LFYJXiLc5NyULMYmNckFHj4n1GLftMrpa3VrQHLpBauE8W8Stuzs=
X-Received: by 2002:a05:6808:7cd:: with SMTP id f13mr9418587oij.70.1571440334999;
 Fri, 18 Oct 2019 16:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191018082354.GA9296@shao2-debian> <20191018094810.GB18593@quack2.suse.cz>
In-Reply-To: <20191018094810.GB18593@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Oct 2019 16:12:03 -0700
Message-ID: <CAPcyv4jjfT4xOQTrckEmX0Z_o6MbsmHz-qvCLAGSOPEe3-X0QA@mail.gmail.com>
Subject: Re: [dax] 23c84eb783: fio.write_bw_MBps -61.6% regression
To:     Jan Kara <jack@suse.cz>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Robert Barror <robert.barror@intel.com>,
        Seema Pandit <seema.pandit@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 2:48 AM Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> On Fri 18-10-19 16:23:54, kernel test robot wrote:
> > FYI, we noticed a -61.6% regression of fio.write_bw_MBps due to commit:
> >
> >
> > commit: 23c84eb7837514e16d79ed6d849b13745e0ce688 ("dax: Fix missed wakeup with PMD faults")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> Thanks for report! Please check whether commit 61c30c98ef17 "dax: Fix
> missed wakeup in put_unlocked_entry()" influences the throughput. Because
> without that fix, the identified commit may result in processes sleeping
> unnecessarily long on entry locks.

I've got several reports of v5.3 performance regressions tracking back
to this change. I instrumented the ndctl "dax.sh" unit test to
validate that it is getting huge page faults and it always falls back
to 4K starting with these commits. It looks like the xa_is_internal()
returns true for any DAX_LOCKED entry.
