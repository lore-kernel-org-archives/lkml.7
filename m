Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947D1C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F4E2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565886372;
	bh=1G8FGo5n3tN3lmTNMeYn5S3oNOHbIP02ThCHH8jcIJA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BVHl7t+yqG5ZlyVTmdxT/gHWYJxy5Y+KXO2OQf9jBQ+/SXo99Mm75OOFJzGHFWA9z
	 xpFXjTb6jiWpPrIi8CKKVuKaxnBtsg778lICgS2gvc1WfnFzdCfw6T6RJFIOTL5Z+N
	 bx+yGLgBgSvbhxU0TlqNWQ03sHDrQjtwtbDx0tmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfHOQ0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:26:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37900 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731752AbfHOQ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:26:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so2741576ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Io8f1bPaeNDioMtOu6b9FaHz1PaQCP05A6nz5CudSE=;
        b=GdUTEFZxtX4Lqzwngdfr2kBTyvwT41GJPNn6kb81iJMXzazObo52enBgWkwrOOq3lr
         fcNdZi8U6UPgNqNDEBWhKZKeMiP71ad8QufdLOLqaXmVo1Qm1ZJcKLGCfWYtcR0rwDEt
         373s5sBtHdFaBBHWllHqZ5/T8eYXJ/Nx4+edw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Io8f1bPaeNDioMtOu6b9FaHz1PaQCP05A6nz5CudSE=;
        b=acNjXtthLVMpXEZibUmmO6cdz6uPluGP2QuphL2g7w6MUoBKTzK3+Bpijq+GQgD98s
         48bEZZFHaMJ1LWv4TZRZmTr8uyS2wFg4x4m7qeHCXcG/8P+lqz1KNM7cN4UrMSZw84A7
         HbKewOxSIqIyrX2kAuDg0C0IeLDUDwxYr2i/K5huWqdCAD3+pIUBHc8uvH21WJnAjd8K
         E+M0aME67ovuxKIikzNM1C1fnK6Ze+PDRbQlyerHXqWADXJ5ubPvz7yJ13pNOJqAZK0R
         E+Nu8SbKwAsdVwNZXijFxAXL9/eH5ejsx0Bym091MAhCKM9RV4djlbVmrEKw6uHFDHfy
         mgQw==
X-Gm-Message-State: APjAAAVKb2x/wWZcyeB07ZDhEGiZDFUoDV71y9855EcpGDWSu+LHz+pf
        /7UUvmDX7qQu+hs8bCRry7GJIRTZIXg=
X-Google-Smtp-Source: APXvYqzqK7bbzOWCFAEXn0DgYcooTS9AU6DgJXT4mjEY05l92ddVOJOtdVgXKFRkCUQJvhYrjcBNHw==
X-Received: by 2002:a2e:894d:: with SMTP id b13mr2493587ljk.38.1565886363820;
        Thu, 15 Aug 2019 09:26:03 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id f22sm551445ljh.22.2019.08.15.09.26.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 09:26:03 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id t3so2705360ljj.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:26:03 -0700 (PDT)
X-Received: by 2002:a2e:9192:: with SMTP id f18mr3104005ljg.52.1565885908392;
 Thu, 15 Aug 2019 09:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190815044155.88483-1-gaoxiang25@huawei.com> <20190815090603.GD4938@kroah.com>
In-Reply-To: <20190815090603.GD4938@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Aug 2019 09:18:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKz7JLd=mj0w2LUiWC2_VOeNWhTTrw1j-i-KyEHH5g5w@mail.gmail.com>
Message-ID: <CAHk-=wjKz7JLd=mj0w2LUiWC2_VOeNWhTTrw1j-i-KyEHH5g5w@mail.gmail.com>
Subject: Re: [PATCH v8 00/24] erofs: promote erofs from staging v8
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Pavel Machek <pavel@denx.de>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        David Sterba <dsterba@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 2:06 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I know everyone is busy, but given the length this has been in staging,
> and the constant good progress toward cleaning it all up that has been
> happening, I want to get this moved out of staging soon.

Since it doesn't touch anything outside of its own filesystem, I have
no real objections. We've never had huge problems with odd
filesystems.

I read through the patches to look for syntactic stuff (ie very much
*not* looking at actual code working or not), and had only one
comment. It's not critical, but it would be nice to do as part of (or
before) the "get it out of staging".

                 Linus
