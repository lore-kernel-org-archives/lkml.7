Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F4AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 01:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFAC23774
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 01:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qo53S/FN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfHaByz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 21:54:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38890 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfHaByy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 21:54:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id e11so4385681pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 18:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pdFBtfEznPzYI1PZUuaXzJOVce4Il2s8BFPZI5Emkrs=;
        b=qo53S/FNZr+IQ3+9ohhcRqe1gNSAm0HXkjiVkJFeMf4dbCvyC0ILd7IuD3YC50/SYZ
         KxZeEzNojwCkoAQyQvwqeo4NcoO5h5mHLabpBAgGNp/hC6E+Uej2NuAATxNTzBtuSjNJ
         C7Zk7oT7SkfFOOsXSkABL6o56pEwVoF2caYJTQKMdQX99LEnB+ox/91o4LQ05scNzPAA
         RqeFBqMjtxwXPSvNAW2AvhmyCFP0qX5566MibaxQg4El5ABx8fqo5YGWnQ3FavjDe8v+
         r37UWF8vkvFurQacu0r1FZnZa5TRtOOlaT0A+dVsvNbdror8/djmDvVmHs4ja57rHtF8
         Mvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pdFBtfEznPzYI1PZUuaXzJOVce4Il2s8BFPZI5Emkrs=;
        b=qojSoBMh0lnZ9xZL9ajor0tH0pxmz4iWp7vlJosmUoCUHCR8qxK0KQFhGXLRRGWYG/
         bYyc0AbsAIOtJfQDMrXA0FvzOBPuRCE4rpaomq7LZsVx0GBDQxBobAvdnUhUdWCh9foI
         PB2IHGdz2IwEmmBxbNRe4x+pt4kcXFR/c9BrCWvnCia1II4vthrxdrSyQgKKUaLAVLxS
         KFPlPvsPo6RTGqQ+ZNZBvcLsfO2x7/GHlpiJTrcIzF0N8CBFd/h/WpvAxIAz94DaDpo5
         UHvc669pQXSf1G23pwxcBfl3E0cx+5bz3wNZ0mh1rPAJYB9+yIE/pfstornuP5Dy/IHq
         XOsg==
X-Gm-Message-State: APjAAAVUKoySHQNYP9LMsaN3cSXg/MVBy1Fhb/Y1yznaCjMGDT5jlD2/
        tKDOz9YCh8UxxpFroLxoacKKaQ==
X-Google-Smtp-Source: APXvYqw2S4KTFPVmA9LgtP64jK14mKKXmjtAdtsF/lDQXhHqirbJzkENNc8Ufk7eww2P4kgAb4pU/w==
X-Received: by 2002:a65:6108:: with SMTP id z8mr15345981pgu.289.1567216493739;
        Fri, 30 Aug 2019 18:54:53 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id o130sm11871570pfg.171.2019.08.30.18.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 18:54:52 -0700 (PDT)
Subject: Re: [block/for-next] writeback: don't access page->mapping directly
 in track_foreign_dirty TP
To:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20190830233954.GC2263813@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ec4d9155-76bc-2586-7a56-d8f495537b80@kernel.dk>
Date:   Fri, 30 Aug 2019 19:54:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830233954.GC2263813@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/19 5:39 PM, Tejun Heo wrote:
> page->mapping may encode different values in it and page_mapping()
> should always be used to access the mapping pointer.
> track_foreign_dirty tracepoint was incorrectly accessing page->mapping
> directly.  Use page_mapping() instead.  Also, add NULL checks while at
> it.

Applied, thanks.

-- 
Jens Axboe

