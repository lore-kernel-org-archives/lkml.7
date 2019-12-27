Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B5BC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 16:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C7E208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 16:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="SX5pZwz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfL0Qfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 11:35:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39231 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0Qfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 11:35:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so26514703wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 08:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RnU1BOeYz8FVvhTms+Fkiiku/tuZbADz34Lq69l79qE=;
        b=SX5pZwz8TMfcGPPnDlHnT2w9gUm067h+r/16EyGLvyTEMC8oJ+Q/uYar0ap5HDwOVN
         JYAOLWKDBsplV4NoJc/o1YHVhK8S9iyKloAX9Gx1NzrHp3Mp8rAk1i2zBVqJR8FIfMvf
         TUAlYiWSBdTyalDBaxwr45A6B7ddqa2vOwYOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RnU1BOeYz8FVvhTms+Fkiiku/tuZbADz34Lq69l79qE=;
        b=OlNFgXzkngAfzS2mCc5Byj2LM6bbQR5fxWCLwFL1BpCVXEfJWPJzJdjpY5nFwya0j3
         xo3piwcKY3o6PMjG5X9HDJ7NkH8fbPlWbvuR+xAH067807X+72Lbk+Dy6NW0cYovuZBZ
         0h1mfG/3UcoTMnDiCHPsVzPXc6LO9u7XbeHgLvQY+plnsK0g3xNPdNgAYS6fA2qHfXWh
         /GgCHBGE+NLrO84At7TfwQeaKw2qhGC37SGgP2u+5XLEI6WxmTmXjgsyPdESfVuOxes6
         QWEBsQMpDYd5gWqyiZPmfY2IuSNWKy5fdLvMmNR2tMhNbkE1iFTp8IRCiL0Qu0xGyygS
         nryw==
X-Gm-Message-State: APjAAAWANXHEKOvgPzNv3mZXv+7bjHrPgr5xttDqecoTkMMbZcE9FijQ
        9wNM+loWCujg+3He8z0BlE+nJg==
X-Google-Smtp-Source: APXvYqyjTZ6Y+LXqY5QSKkmey6zjlTT8/AV5CRIi9VJhKb+g7wpNAR89YVyRDvradWFKecm0+OTQ1w==
X-Received: by 2002:adf:a746:: with SMTP id e6mr54047037wrd.329.1577464539121;
        Fri, 27 Dec 2019 08:35:39 -0800 (PST)
Received: from localhost (host-92-23-123-10.as13285.net. [92.23.123.10])
        by smtp.gmail.com with ESMTPSA id x10sm33506811wrv.60.2019.12.27.08.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 08:35:38 -0800 (PST)
Date:   Fri, 27 Dec 2019 16:35:36 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 3/3] shmem: Add support for using full width of ino_t
Message-ID: <20191227163536.GC442424@chrisdown.name>
References: <cover.1577456898.git.chris@chrisdown.name>
 <533d188802d292fa9f7c9e66f26068000346d6c1.1577456898.git.chris@chrisdown.name>
 <CAOQ4uxhaMjn2Kusv6o6mJ36RhF7PAdmgW3kncgfov5uys=6VHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhaMjn2Kusv6o6mJ36RhF7PAdmgW3kncgfov5uys=6VHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amir Goldstein writes:
>On Fri, Dec 27, 2019 at 4:30 PM Chris Down <chris@chrisdown.name> wrote:
>>
>> The new inode64 option now uses get_next_ino_full, which always uses the
>> full width of ino_t (as opposed to get_next_ino, which always uses
>> unsigned int).
>>
>> Using inode64 makes inode number wraparound significantly less likely,
>> at the cost of making some features that rely on the underlying
>> filesystem not setting any of the highest 32 bits (eg. overlayfs' xino)
>> not usable.
>
>That's not an accurate statement. overlayfs xino just needs some high
>bits available. Therefore I never had any objection to having tmpfs use
>64bit ino values (from overlayfs perspective). My only objection is to
>use the same pool "irresponsibly" instead of per-sb pool for the heavy
>users.

Per-sb get_next_ino is fine, but seems less important if inode64 is used. Or is 
your point about people who would still be using inode32?

I think things have become quite unclear in previous discussions, so I want to 
make sure we're all on the same page here. Are you saying you would 
theoretically ack the following series?

1. Recycle volatile slabs in tmpfs/hugetlbfs
2. Make get_next_ino per-sb
3. Make get_next_ino_full (which is also per-sb)
4. Add inode{32,64} to tmpfs

To keep this thread as high signal as possible, I'll avoid sending any other 
patches until I hear back on that :-)

Thanks again,

Chris
