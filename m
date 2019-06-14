Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660D1C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C992080A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHN1sCz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfFNSvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:51:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43683 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNSvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:51:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so3547526wru.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TwsuP/5QpBpyw+894FkICl68mr19hbmwJDtOpUhHp38=;
        b=eHN1sCz3W2HTRU7bY4U0Qo31XyxAGdDIGeVU0H3BQa3VmHEmxCdG5Sfx+qwxSwdk6o
         kDaqfroDELkJHWYJMYMCqJTVNHXUNYpWwzBVQmbQjAZeGN9MGFYSdcy6TGbmvL885SIm
         mpwm93e4a4mutIMsuS7/vbvrRZFR6dhZCy0yZ/v8Rnct7mIrb3mhtXVYHs4YJ3OL75OS
         6dxYdzLxvja+X44d8HGx6bj/vqUT/vmAjoLUE2Cd2jFufxhXQwXYJqNvFaq+do9ekxal
         uGK6BnU8q5zlVin8s9e0gspC7CgrdU85QCMNInHjsla8YPLlhRLcDpRBrIBVz4PEC296
         2Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TwsuP/5QpBpyw+894FkICl68mr19hbmwJDtOpUhHp38=;
        b=LLGnG5MaKzIVhvMx+WbEWkuBN9wLsjDQfMjtDtNRpMP4PW180TEZ3Sk0q52uLBOmBi
         gMsTWPJh3vKXHqLVSFTGwk+3bLR244LrbVxX+7sFTFBAuGwKwJsxGZcWyS6LQ8svVnlj
         i47Pze0H3OdaT6iMbzu1J3Pqv9vY486F8qEDYCMnkjThQMRiraKGb93VAbBWGZV/Tb+y
         Jc5dnjYk/eT6iYsVQEvZS1rMSxTjqBfAgPI0G2t0Pwi7Cp1ji1c+Hnccfw4U0L0A4utk
         PfvFUvJdoOFp2/rlc6zNbhEvcbfmrowio+l/Tuhtvznb0qQxwRCaK3zRPDL1hgMSi1uV
         WiiA==
X-Gm-Message-State: APjAAAWjaltNbEMLHiw4xgDcLGhiHTB8L/UHMk8T/bbfbbH8B0gPK+HB
        aq+le2AMTwpEGcdXRguYu60=
X-Google-Smtp-Source: APXvYqz28bIDeaYBfPgupDqxKtdLyXRvsj0tCGO/2NqJFDkP1DqXrqASNNCznmEFJdwF1A4VtB2Aqg==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr10305574wrj.272.1560538273929;
        Fri, 14 Jun 2019 11:51:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id r4sm584930wra.96.2019.06.14.11.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 11:51:13 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 3/6] drm/gem: use new ww_mutex_(un)lock_for_each macros
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Qiang Yu <yuq825@gmail.com>, "Anholt, Eric" <eric@anholt.net>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        lima@lists.freedesktop.org
References: <20190614124125.124181-1-christian.koenig@amd.com>
 <20190614124125.124181-4-christian.koenig@amd.com>
 <20190614131916.GQ3436@hirez.programming.kicks-ass.net>
 <20190614152242.GC23020@phenom.ffwll.local>
 <094da0f7-a0f0-9ed4-d2da-8c6e6d165380@gmail.com>
 <CAKMK7uFcDCJ9sozny1RqqRATwcK39doZNq+NZekvrzuO63ap-Q@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d97212dc-367c-28e9-6961-9b99110a4d2e@gmail.com>
Date:   Fri, 14 Jun 2019 20:51:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFcDCJ9sozny1RqqRATwcK39doZNq+NZekvrzuO63ap-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.06.19 um 20:24 schrieb Daniel Vetter:
>
> On Fri, Jun 14, 2019 at 8:10 PM Christian König <ckoenig.leichtzumerken@gmail.com> wrote:
>> [SNIP]
>> WW_MUTEX_LOCK_BEGIN()
>>
>> lock(lru_lock);
>>
>> while (bo = list_first(lru)) {
>> 	if (kref_get_unless_zero(bo)) {
>> 		unlock(lru_lock);
>> 		WW_MUTEX_LOCK(bo->ww_mutex);
>> 		lock(lru_lock);
>> 	} else {
>> 		/* bo is getting freed, steal it from the freeing process
>> 		 * or just ignore */
>> 	}
>> }
>> unlock(lru_lock)
>>
>> WW_MUTEX_LOCK_END;

Ah, now I know what you mean. And NO, that approach doesn't work.

See for the correct ww_mutex dance we need to use the iterator multiple 
times.

Once to give us the BOs which needs to be locked and another time to 
give us the BOs which needs to be unlocked in case of a contention.

That won't work with the approach you suggest here.

Regards,
Christian.

>
>
> Also I think if we allow this we could perhaps use this to implement the
> modeset macros too.
> -Daniel
>
>
>
>
>>> This is kinda what we went with for modeset locks with
>>> DRM_MODESET_LOCK_ALL_BEGIN/END, you can grab more locks in between the
>>> pair at least. But it's a lot more limited use-cases, maybe too fragile an
>>> idea for ww_mutex in full generality.
>>>
>>> Not going to type this out because too much w/e mode here already, but I
>>> can give it a stab next week.
>>> -Daniel
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>

