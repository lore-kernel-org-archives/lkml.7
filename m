Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D30FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FAC20863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553025294;
	bh=+USuLGAVfj14nrnBqSIcBSk7vFbU2E8ZesZxqqH4cEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ijz7VQXkBNf4e9FSNawYuzH3OlYsFy/fpPLjw8b3liKcLPHh2gEPtl65Ffi5ydbSE
	 mp/l28A6HklBZV1zgScjIE6AlJf4lniZTl6bHNJwrh3KJ53/zq48ArFTx2sChjiWFm
	 suvqaM/t8hzJcCf3SpEbhbnqnoZdVy46R3FSa9nI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfCSTyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbfCSTyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:54:52 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2FB2075C;
        Tue, 19 Mar 2019 19:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553025291;
        bh=+USuLGAVfj14nrnBqSIcBSk7vFbU2E8ZesZxqqH4cEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJ1Okd/PYOkUgkbR/iUGyt4k369MptFf1PmSSdUE7mxvMof0KCwjc1wuYqhv0w4oF
         9bZRkzSUnARPXhNosSWp0M/f2TZW2lIF/k6qVWD+0KJr2BGYKp59nlyuu6LMze0Lb/
         hxK35lScQlBDmpZmFzqkato2hAAXgHaO0NaIkIF0=
Date:   Tue, 19 Mar 2019 15:54:48 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH AUTOSEL 4.14 22/33] kasan, slab: make freelist stored
 without tags
Message-ID: <20190319195448.GA25262@sasha-vm>
References: <20190313191506.159677-1-sashal@kernel.org>
 <20190313191506.159677-22-sashal@kernel.org>
 <CAAeHK+xMxX3Baou=W914tbbPhuPGCBd4wJdgS3O459JEwxw5OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAAeHK+xMxX3Baou=W914tbbPhuPGCBd4wJdgS3O459JEwxw5OQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 08:18:24PM +0100, Andrey Konovalov wrote:
>On Wed, Mar 13, 2019 at 8:16 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Andrey Konovalov <andreyknvl@google.com>
>>
>> [ Upstream commit 51dedad06b5f6c3eea7ec1069631b1ef7796912a ]
>
>Hi Sasha,
>
>None of the 4.9, 4.14, 4.19 or 4.20 have tag-based KASAN, so
>backporting these 3 KASAN related patches doesn't make much sense.
>
>Thanks!

Dropped, thank you!

--
Thanks,
Sasha
