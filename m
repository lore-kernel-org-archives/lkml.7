Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B05EC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65160208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F60ERVd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfFQJaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:30:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52080 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfFQJaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:30:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so8463923wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hGy+FSJRzToSeoyUsvQaQYFoLBq93m5qcKw5Lz5P/as=;
        b=F60ERVd/hdyLx8RkvS+tUuVoOJCT4bbcqGeQftgadh71HU605jvy7+avRbGBSrNhoJ
         1keSHnOnl1ku6hUHqHp8Yox/P3ICEsxA7UPoWoo1f9WHKWLkV/RwfycdjI4kOzml8fQf
         5mylKL44bJ1IW0AxZ/6GNbuXkVv1WuGyoQySInYmoX141ojNSY9KSOEgJevGuL3grgY+
         bhF6o5VqoOVwA1i+XBT0tVEOOqElJwyCeeHUqyr1K+1l7DGf0VF8/RPloApCnkLXhEdU
         wUIRpnGvue7vKNzG4hqCItM5q8GYfUGHaQQs3DmutNABXH2anO0k3MpuopjZqm02RWLb
         GzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=hGy+FSJRzToSeoyUsvQaQYFoLBq93m5qcKw5Lz5P/as=;
        b=R1UdJFg/6TqRR1KnVZ/pxF3jnzLHcrZy2OIqOqzwwFRXIhDj68kX2JK1EowkdHps+6
         J4OWszvL4FUQ6JaIdM58TCuJT4viCckxhyMduj2UaAfqU/0uuYMSKygjw0kWZJW7AXyf
         HBscTRtItLzlUnMsXVOkU2gjyIKddxqSE9JriG5+bPKbzSdenrRl7Jte0/us1cCUKS0F
         7owHRmP382foWBtE1tLYSDG0k1eBJO9tosOJIgC9iRnL1VgRw+FqvoLJ5mMjzlMGa6mo
         6YzwNGGYlS3G75m8UQif8+jVDlifVxYjRb/+aflwfRDxV0fZPy1lN43Erdw4e0MlN4ui
         NF7Q==
X-Gm-Message-State: APjAAAUxz4ozTbDFBSjr7drshhKFuKEDSS690deo3/gdUNKI2W7jGUJT
        CbBJRQDlgFN/znH5EZyYoRM=
X-Google-Smtp-Source: APXvYqwdhcc9M07F72k/LDIugLL1XTkyPT3qTKjPffVGpz59oqzpHW73M+4cmRAMD4p6XlvT7Ussqw==
X-Received: by 2002:a1c:2dc2:: with SMTP id t185mr18175091wmt.52.1560763849022;
        Mon, 17 Jun 2019 02:30:49 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id z5sm9895972wrh.16.2019.06.17.02.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 02:30:48 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 3/6] drm/gem: use new ww_mutex_(un)lock_for_each macros
To:     Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        lima@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Qiang Yu <yuq825@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>
References: <20190614124125.124181-1-christian.koenig@amd.com>
 <20190614124125.124181-4-christian.koenig@amd.com>
 <20190614131916.GQ3436@hirez.programming.kicks-ass.net>
 <20190614152242.GC23020@phenom.ffwll.local>
 <094da0f7-a0f0-9ed4-d2da-8c6e6d165380@gmail.com>
 <CAKMK7uFcDCJ9sozny1RqqRATwcK39doZNq+NZekvrzuO63ap-Q@mail.gmail.com>
 <d97212dc-367c-28e9-6961-9b99110a4d2e@gmail.com>
 <20190614203040.GE23020@phenom.ffwll.local>
 <CAKMK7uFzg+e315h2e5SmDTQwYTAbgAsxB_pc09ztwA1Wa-mzxw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <16adcdac-b3e7-02f1-e56b-9b4ad68e146e@gmail.com>
Date:   Mon, 17 Jun 2019 11:30:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFzg+e315h2e5SmDTQwYTAbgAsxB_pc09ztwA1Wa-mzxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.06.19 um 15:56 schrieb Daniel Vetter:
> On Fri, Jun 14, 2019 at 10:30 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Fri, Jun 14, 2019 at 08:51:11PM +0200, Christian König wrote:
>>> Am 14.06.19 um 20:24 schrieb Daniel Vetter:
>>>> On Fri, Jun 14, 2019 at 8:10 PM Christian König <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>> [SNIP]
>>>>> WW_MUTEX_LOCK_BEGIN()
>>>>>
>>>>> lock(lru_lock);
>>>>>
>>>>> while (bo = list_first(lru)) {
>>>>>    if (kref_get_unless_zero(bo)) {
>>>>>            unlock(lru_lock);
>>>>>            WW_MUTEX_LOCK(bo->ww_mutex);
>>>>>            lock(lru_lock);
>>>>>    } else {
>>>>>            /* bo is getting freed, steal it from the freeing process
>>>>>             * or just ignore */
>>>>>    }
>>>>> }
>>>>> unlock(lru_lock)
>>>>>
>>>>> WW_MUTEX_LOCK_END;
>>> Ah, now I know what you mean. And NO, that approach doesn't work.
>>>
>>> See for the correct ww_mutex dance we need to use the iterator multiple
>>> times.
>>>
>>> Once to give us the BOs which needs to be locked and another time to give us
>>> the BOs which needs to be unlocked in case of a contention.
>>>
>>> That won't work with the approach you suggest here.
>> A right, drat.
>>
>> Maybe give up on the idea to make this work for ww_mutex in general, and
>> just for drm_gem_buffer_object? I'm just about to send out a patch series
>> which makes sure that a lot more drivers set gem_bo.resv correctly (it
>> will alias with ttm_bo.resv for ttm drivers ofc). Then we could add a
>> list_head to gem_bo (won't really matter, but not something we can do with
>> ww_mutex really), so that the unlock walking doesn't need to reuse the
>> same iterator. That should work I think ...
>>
>> Also, it would almost cover everything you want to do. For ttm we'd need
>> to make ttm_bo a subclass of gem_bo (and maybe not initialize that
>> embedded gem_bo for vmwgfx and shadow bo and driver internal stuff).
>>
>> Just some ideas, since copypasting the ww_mutex dance into all drivers is
>> indeed not great.
> Even better we don't need to force everyone to use drm_gem_object, the
> hard work is already done with the reservation_object. We could add a
> list_head there for unwinding, and then the locking helpers would look
> a lot cleaner and simpler imo. reservation_unlock_all() would even be
> a real function! And if we do this then I think we should also have a
> reservation_acquire_ctx, to store the list_head and maybe anything
> else.
>
> Plus all the code you want to touch is dealing with
> reservation_object, so that's all covered. And it mirros quite a bit
> what we've done with struct drm_modeset_lock, to wrap ww_mutex is
> something easier to deal with for kms.

That's a rather interesting idea.

I wouldn't use a list_head cause that has a rather horrible caching 
footprint for something you want to use during CS, but apart from that 
the idea sounds like it would also solve a bunch of problem during eviction.

Going to give that a try,
Christian.

> -Daniel
>

