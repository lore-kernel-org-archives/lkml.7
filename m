Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CCEC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 10:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736E32072B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 10:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="Rq4LsVBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfLUKQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 05:16:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55190 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfLUKQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 05:16:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so11281648wmj.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 02:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w7EMZsX1P6p24D8oxJ5lDhfZGtIC/1lVYlrnNXeuQH4=;
        b=Rq4LsVBwxYKw74dI8FSDPQwHMWSyqhrfuDWib+CxcFiQE+kws197g+JzT+PxYDTmD5
         FMcelA158Vpx3rW0QMRhO9CsMd4cyy1sKDhJe80scYqoBrsxroKFfwk1JZpGhXoa5apQ
         MXFmF0Y3+qIxm+ClyYCqMHx9AnYAefTs7VmVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w7EMZsX1P6p24D8oxJ5lDhfZGtIC/1lVYlrnNXeuQH4=;
        b=DK9xhUEAvuc3yYKSOuiN2C6SUGCS281zB7SLNFsvolu/D8J9dPjPvMWdi/g5SKtKzg
         IqVJCTYQ3Kfs5mDLqKSbQ/2fFmH5Bhe62JtTeB2bADlAyQlmuo1YxWcUeqvjmUd/PDuY
         572bpmRGoZmISj/mn75Gh/P7HBXYXyx6nu2fHvVVcrnTVttysrwTS9VVaVw7PfTYip6k
         PWuNotIqIXCryNo/8jX7qFaxJvGYop4KI/6NITg+4Uf/VqcOTozb0ru3iqgV4ZTFnvMK
         yuwobBgWD1m6O9izn/YH/YChhdxzfhERy5PdmcGcQiIX3YSx25hMsMFZB8KxVOZEw/Mq
         1fIw==
X-Gm-Message-State: APjAAAVJNYoVQauUGIXhhq/UW6UIvceoS8uFuE39qJd5jubJj//Uwb/t
        P+82QDrcNzKFAMe/1Lf+X8hZHg==
X-Google-Smtp-Source: APXvYqyL77witqgEbMqthpAjN1mJkW/ygtn87eZ9je+eLTRHWAOroHYyJnM+yA9gXhnLyAAobryETA==
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr21587689wme.148.1576923414062;
        Sat, 21 Dec 2019 02:16:54 -0800 (PST)
Received: from localhost ([185.69.145.42])
        by smtp.gmail.com with ESMTPSA id f127sm11114118wma.4.2019.12.21.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 02:16:53 -0800 (PST)
Date:   Sat, 21 Dec 2019 10:16:52 +0000
From:   Chris Down <chris@chrisdown.name>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
Message-ID: <20191221101652.GA494948@chrisdown.name>
References: <20191220024936.GA380394@chrisdown.name>
 <20191220213052.GB7476@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191220213052.GB7476@magnolia>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong writes:
>On Fri, Dec 20, 2019 at 02:49:36AM +0000, Chris Down wrote:
>> In Facebook production we are seeing heavy inode number wraparounds on
>> tmpfs. On affected tiers, in excess of 10% of hosts show multiple files
>> with different content and the same inode number, with some servers even
>> having as many as 150 duplicated inode numbers with differing file
>> content.
>>
>> This causes actual, tangible problems in production. For example, we
>> have complaints from those working on remote caches that their
>> application is reporting cache corruptions because it uses (device,
>> inodenum) to establish the identity of a particular cache object, but
>
>...but you cannot delete the (dev, inum) tuple from the cache index when
>you remove a cache object??

There are some cache objects which may be long-lived. In these kinds of cases, 
the cache objects aren't removed until they're conclusively not needed.

Since tmpfs shares the i_ino counter with every other user of get_next_ino, 
it's then entirely possible that we can thrash through 2^32 inodes within a 
period that it's possible for a single cache file to exist.

>> because it's not unique any more, the application refuses to continue
>> and reports cache corruption. Even worse, sometimes applications may not
>> even detect the corruption but may continue anyway, causing phantom and
>> hard to debug behaviour.
>>
>> In general, userspace applications expect that (device, inodenum) should
>> be enough to be uniquely point to one inode, which seems fair enough.
>
>Except that it's not.  (dev, inum, generation) uniquely points to an
>instance of an inode from creation to the last unlink.

I didn't mention generation because, even though it's set on tmpfs (to 
prandom_u32()), it's not possible to evaluate it from userspace since `ioctl` 
returns ENOTTY. We can't ask userspace applications to introspect on an inode 
attribute that they can't even access :-)
