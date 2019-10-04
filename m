Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13187C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA93E222C5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+HIkB/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfJDLge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 07:36:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40815 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfJDLgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 07:36:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id d22so3011433pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 04:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nOCYZTp0wlW16jrmBzFl+zhQm0PaZWf4IPrpoghz8Yo=;
        b=K+HIkB/DaYwobnDZtGi3XYvBspVWPMRJiBUETqqpwYTvQp9tFBZOt4UE5me6R4KH5S
         Mpx9ZDpyd8o1w0mVzmm8xGfSJnTlB+fk7/XqioTy3S4hbK3Z5kH0ZqyrjIOzsB8/tH4D
         pfUcTKQjyTZzSqwORuc9ZViuQQAwesVIU9ynZ29agbbAhvnjEeoO4Q3XkX0ZgukyrWyx
         OlvSrz0HxL/0J8NRos64LcHFpCF7MEyzvjVw1ZWrt38q+v1BvfwltyrXUM8IdBp68K2O
         qjUllfapLPCmx63lB2GJHG7VgeZVpYLRyL6TEoYakOevapQZBNzNwj6pu5yuCvW2iDrV
         mrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nOCYZTp0wlW16jrmBzFl+zhQm0PaZWf4IPrpoghz8Yo=;
        b=uS3M3hEJLODruVpJV+1TNlhMvNMO1ZfUvpFFK+Wd2/hDNcqfcfkqo3G21muLs4ZZMY
         5daZeXzuxeX6Nzsk9qAtCTi6IQUbGTIZtbfUIjC2g9pKY+c1bBx4pKGPWu5hb0/QGryc
         OE2eeq1h2NKkxth4qMtWjxPicOb9ZQOf5mvGv7uCOhJdpdprTXJqH86SLLBKqo5I3Cbx
         fAGtsf0k7NPlSuOX0qbxEwM9ULDXrWmF3Wavf4V688lOZbhgxMkCk6ZPQHFsNzFkT5u/
         Jyy0fViAdN+fDB05MCHt8IDx20MChDds1ICjsxyHOgRyeldYTb4/dtSnq+C8VCKFIMuX
         ZOEQ==
X-Gm-Message-State: APjAAAVbwv6iz9+B1ftGR+gSwmXxG76b5gS/c31fRKkPcxMloNngEhkz
        IZJ0xALqfpDAIsI7agmWWvC6mw==
X-Google-Smtp-Source: APXvYqycHeOHIdMYTzA5mukhrOH4bcwhg8D6NWJcmxV+oLSJ8CZYEOinQHT3+LzyKtJ5O8kGHo7eRg==
X-Received: by 2002:a17:902:6b4c:: with SMTP id g12mr15170702plt.80.1570188992416;
        Fri, 04 Oct 2019 04:36:32 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id ev20sm5730991pjb.19.2019.10.04.04.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 04:36:30 -0700 (PDT)
Date:   Fri, 4 Oct 2019 04:36:28 -0700
From:   Michel Lespinasse <walken@google.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 03/11] drm/amdgpu: convert amdgpu_vm_it to half closed
 intervals
Message-ID: <20191004113628.GA260828@google.com>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-4-dave@stgolabs.net>
 <dc9cc8c4-7275-43be-5bed-91384e3246ae@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc9cc8c4-7275-43be-5bed-91384e3246ae@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 06:54:54AM +0000, Koenig, Christian wrote:
> Am 03.10.19 um 22:18 schrieb Davidlohr Bueso:
> > The amdgpu_vm interval tree really wants [a, b) intervals,
> 
> NAK, we explicitly do need an [a, b[ interval here.

Hi Christian,

Just wanted to confirm where you stand on this patch, since I think
you reconsidered your initial position after first looking at 9/11
from this series.

I do not know the amdgpu code well, but I think the changes should be
fine - in struct amdgpu_bo_va_mapping, the "end" field will hold what
was previously stored in the "last" field, plus one. The expectation
is that overflows should not be an issue there, as "end" is explicitly
declared as an uint64, and as the code was previously computing
"last + 1" in many places.

Does that seem workable to you ?

Thanks,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
