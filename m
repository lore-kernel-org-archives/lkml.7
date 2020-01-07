Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A1C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 00:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968882073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 00:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="m5nCqznl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgAGAQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 19:16:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44311 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgAGAQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 19:16:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so13005509wrm.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 16:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uGk27tieF5qc3+4BsLtXvy4RIdrTncxHg+KG4kUOS9s=;
        b=m5nCqznlM4JSZCk8W7Cx425R6aY8G01X2cjR/HweAPIu+lsEDl9b5iJKdJslYHErz/
         dXghDYg096xzvAyL+PV03IGKgAEJz3PCZdKlSNYz7b/mwBVjyDQEG0fWiD5YJzRgzARu
         CT4nt5aT6dj6zI1WL63GDxnLIt4036XiK2Ypo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uGk27tieF5qc3+4BsLtXvy4RIdrTncxHg+KG4kUOS9s=;
        b=dt9QjkKaWfd3kXTUT1yEk5bfh2ljMC5wFmcAbyBj5PjNws/xIdqs/tiZtmDn5pNTW8
         0smVuy4H9Dk/eXpNikysMWrenQmw/e3nLAtsuoCHQgEXpcuuth0k2WElQLYi/nBqPTJX
         JGWl3ZnCPWJIEXFZT3/UVyozx1zwhuUwvnOrE0YlmEeRjvezEQnM6Y42iJwLN8VqJed6
         Hy1vi1IciE0spFKsmgB5Si2Z391rHzsT2tl8eEmzx1nqtGk/4bVfiq9aVvEFQbqzLC/U
         +hodk3/ndXdx1z1/CPepcg9dCzLIhVvVPOWeW1fdnmg6/ztX55iVejrauM39Yc4wHHjE
         djXA==
X-Gm-Message-State: APjAAAUpSAwpgp0rH0YEdfVpyDs9jRwce6i7H+VNrEbKgBMiRIxLA9fs
        Kz2TgFsf0lVkE0EKQGMtzNXGnA==
X-Google-Smtp-Source: APXvYqwEnlHAHFnlhdcoAURhVkhVhX/fSGgeDovIudqAqXXQpqBFeY9oaowcMHxtXYpvG862TBzKtQ==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr108384665wrt.267.1578356204280;
        Mon, 06 Jan 2020 16:16:44 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:2344])
        by smtp.gmail.com with ESMTPSA id a133sm24612835wme.29.2020.01.06.16.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 16:16:43 -0800 (PST)
Date:   Tue, 7 Jan 2020 00:16:43 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
Message-ID: <20200107001643.GA485121@chrisdown.name>
References: <cover.1578225806.git.chris@chrisdown.name>
 <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name>
 <20200107001039.GM23195@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200107001039.GM23195@dread.disaster.area>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Chinner writes:
>It took 15 years for us to be able to essentially deprecate
>inode32 (inode64 is the default behaviour), and we were very happy
>to get that albatross off our necks.  In reality, almost everything
>out there in the world handles 64 bit inodes correctly
>including 32 bit machines and 32bit binaries on 64 bit machines.
>And, IMNSHO, there no excuse these days for 32 bit binaries that
>don't using the *64() syscall variants directly and hence support
>64 bit inodes correctlyi out of the box on all platforms.
>
>I don't think we should be repeating past mistakes by trying to
>cater for broken 32 bit applications on 64 bit machines in this day
>and age.

I'm very glad to hear that. I strongly support moving to 64-bit inums in all 
cases if there is precedent that it's not a compatibility issue, but from the 
comments on my original[0] patch (especially that they strayed from the 
original patches' change to use ino_t directly into slab reuse), I'd been given 
the impression that it was known to be one.

 From my perspective I have no evidence that inode32 is needed other than the 
comment from Jeff above get_next_ino. If that turns out not to be a problem, I 
am more than happy to just wholesale migrate 64-bit inodes per-sb in tmpfs.

0: https://lore.kernel.org/patchwork/patch/1170963/
