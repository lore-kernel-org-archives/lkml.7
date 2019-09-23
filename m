Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFDEC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6290C20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W1akfRBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfIWPgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:36:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46450 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfIWPgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:36:31 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so21310920ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=giOjH0e1+Va7zF2km7iWPR2tjwuOyQDUdxfszpw7LBI=;
        b=W1akfRBTIQi/Yu602zJ+J+cmVzk+bDRreA4SeyTFjAYb08P+3gBic98jasS/hmmw9p
         XDGLdYtDJVumghJvStKdUnxMo/zVPf79ptQds8PH8aVOa6/J8yenqKipvssFUBrGT4l6
         +57S66axARoIwbAlZAeCNYIOK1q76gf3TyLNRYKFG8DV6SOEETjaJ+VkvS1Co6cxR7d1
         TP/B395inKk9JvVShp+3VswuGkcbt2qLHnTL5HxTveEjol1kXXhPq9K9hlbVnV38EeO/
         9CElfQE+CTb4kol1tQOyrgI6kh+hzokHd2P4nwDlyyLhlKGjWXtqawsbj+8xNtwRPYwG
         5BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=giOjH0e1+Va7zF2km7iWPR2tjwuOyQDUdxfszpw7LBI=;
        b=kHzznC44bag3BbRHpMKc3U2dJ0Gp2WWbmzTt/oTCK3IWFxKy6D7rXYfSfwHab8kCcd
         uRVGB6GBO3QSJ/H5RKcjo3PQcmBFgva7W7ok4phiOT0UZOR7HZyTbySSiPnd1xv0naOy
         uIttqDa/rfOy4hfNCObW0HhjvG0e/oT4S495pS30lsacu8W4CmOTTY67m7FEc/KRHmXV
         S5EgKVkzu5KhqfJqjdtJK44slLqIHti+VoqwQa02OYldeWhqLXCksR6iL60rl6p7cSPX
         7MwZcy1qFE3uapo+f1rmpZCsvPjMQ2SZywEU3X413O7n5eXKmnq1XgV984FR1r+1LbmN
         HV1w==
X-Gm-Message-State: APjAAAUzsYGYOp3fYugNqCdVGj4ybtZEhQIIpXeuVoxIINW0kVqAKPpz
        y7AwDXTBEX2aoiRLROFL5Oiw/Q==
X-Google-Smtp-Source: APXvYqyyeaV/OyAPAqNs2hYQiUiDuqJkFJdUHUadcPjHwBqQTyy/QJlYetTj8pSmsVvgbE3+nY2hWQ==
X-Received: by 2002:a6b:fe0f:: with SMTP id x15mr2644657ioh.188.1569252990417;
        Mon, 23 Sep 2019 08:36:30 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f12sm13027077iob.58.2019.09.23.08.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 08:36:29 -0700 (PDT)
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <CAHk-=whmCZvYcR10Pe9fEy912fc8xywbiP9mn054Jg_9+0TqCg@mail.gmail.com>
 <CAHk-=wi+G1MfSu79Ayi-yxbmhdyuLnZ5e1tmBTc69v9Zvd-NKg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1882a6da-a599-b820-6257-11bbac02b220@kernel.dk>
Date:   Mon, 23 Sep 2019 09:36:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi+G1MfSu79Ayi-yxbmhdyuLnZ5e1tmBTc69v9Zvd-NKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/19 5:10 PM, Linus Torvalds wrote:
> On Fri, Sep 20, 2019 at 4:05 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>>
>> Now, I hear you say "those are so small these days that it doesn't
>> matter". And maybe you're right. But particularly for slow media,
>> triggering good streaming write behavior has been a problem in the
>> past.
> 
> Which reminds me: the writebehind trigger should likely be tied to the
> estimate of the bdi write speed.
> 
> We _do_ have that avg_write_bandwidth thing in the bdi_writeback
> structure, it sounds like a potentially good idea to try to use that
> to estimate when to do writebehind.
> 
> No?

I really like the feature, and agree it should be tied to the bdi write
speed. How about just making the tunable acceptable time of write behind
dirty? Eg if write_behind_msec is 1000, allow 1s of pending dirty before
starting writbeack.

-- 
Jens Axboe

