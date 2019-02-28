Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4EBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DC42186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551317603;
	bh=hMlxlqpTqPxOazeZPMTBLrsbtsP80OkV1e7tOnB0WXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mhpeR1C26V5EkJZe4YZ1nZZiq0qnFM9j+o9FjV76ldA26zopW8UjDg1iYIWabTt/s
	 SXxUQr2cnCDncbsnEkR2LsNdIYY/X9nEt7CTdZWY96XrLnXVcsCTg13ViP/VGBeU3f
	 fScLYV3Qna9xF6idAc5dG2tAF6/54WFzq2WRrIX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbfB1BdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:33:22 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:35248 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbfB1BdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:33:19 -0500
Received: by mail-lj1-f180.google.com with SMTP id t13so11270548lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 17:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRel07BgZCBNm0kpyEmi9XKoLtin0pKoTUn9HMx79PM=;
        b=daTu39/QQzrT2sAaHZ0vKeE2cL8O+JYYB0I42x52UTaH3mms/4aJV7EjvI/duinHbd
         SoubJAZqaeeHJR7acCkQz+nY9yWp3H40NWWHE7qXDeBRr+ZCd223uPdMs1qWPVbOXnIy
         I5wdTHrsIBktVfamjMSz/9iAC9Q/6wk/LM34I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRel07BgZCBNm0kpyEmi9XKoLtin0pKoTUn9HMx79PM=;
        b=A8J8NDJFtuNM9gXw5n8AL3lL5O0c9DxRgmdix7TZycUrDV6XBtXlk7VgXbx3L32D0g
         VnhPQ5j7VSWgH0UX0txw6b5/YFz5Giozj/CIo4Qomj/JRY7T2Je2Vc6rp5+hn3UtsVoX
         OqeJ0kbbw50T5eTUN432IueWQLq+/lTw3X7Z/Xkg6kiT9ADm84zzgRT40z9dygcB4kBN
         HNom5YFsTD0/4jErdb3XqcaBTvV7sxhWbTFVn3LES4Ssh0QH7hFpzZZKZLka8IiEz1Eq
         6C9aiPWHY19TQRZ0Jml0+KwpO6NOI5NCP/q9FzSLDkKCEcAWYVKLV8u5kR5XMHsfvEJ9
         i7Hw==
X-Gm-Message-State: AHQUAuYSLsEustICRk1CU48voB2/U3l8blzb41+hE3VpFLyvm3cB2PCo
        U6SwDpOwYuEEFhUSlMyO2PAg6gILndQ=
X-Google-Smtp-Source: APXvYqxvyJPIowbM9MIYyyQLh+Ir9AcwCv1Hi8CHi3wno9gBkhdE2I4AAzYDAOVqWwDBZzc3bIsDMQ==
X-Received: by 2002:a2e:801:: with SMTP id 1mr3281431lji.61.1551317596102;
        Wed, 27 Feb 2019 17:33:16 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id j14sm3749454lji.32.2019.02.27.17.33.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 17:33:15 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id v10so15665167lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 17:33:14 -0800 (PST)
X-Received: by 2002:a2e:8510:: with SMTP id j16mr3082630lji.2.1551317594237;
 Wed, 27 Feb 2019 17:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20181114092242.GD18977@shao2-debian> <20181114141713.GA25731@bombadil.infradead.org>
 <875zt7t14h.fsf@yhuang-dev.intel.com> <CAHk-=whn+F+vFgCR0a04atTQuBmXhq0oU1Y1f0YqMiUFHj28JQ@mail.gmail.com>
 <1c33a91c-a436-a879-ca14-7eebcbf971c2@redhat.com> <87imx4pv5q.fsf@yhuang-dev.intel.com>
In-Reply-To: <87imx4pv5q.fsf@yhuang-dev.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Feb 2019 17:32:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXgigVGwumT0y_N64LjCiB5tR0snjCAm3u4YyhDB+dwQ@mail.gmail.com>
Message-ID: <CAHk-=wiXgigVGwumT0y_N64LjCiB5tR0snjCAm3u4YyhDB+dwQ@mail.gmail.com>
Subject: Re: [LKP] [page cache] eb797a8ee0: vm-scalability.throughput -16.5% regression
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Chen, Rong A" <rong.a.chen@intel.com>, "lkp@01.org" <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim C Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 5:19 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> So I think in the heavily contended situation, we should put the fields
> accessed by rwsem holder in a different cache line of rwsem.  But in
> un-contended situation, we should put the fields accessed in rwsem
> holder and rwsem in the same cache line to reduce the cache footprint.
> The requirement of un-contended and heavily contended situation is
> contradicted.

Generally, we should strive to optimize for the uncontended state.

The performance profile of a contended state tends to be very
different, and the actual solution tends to be to try really hard to
just avoid contention to begin with.

I think we've gotten to the point where we have very few real loads
that show lock contention on a kernel level. And when people do find
loads that cause contention, we should try really hard to fix the
locking rather than try to then treat the symptom of contention.

So on the whole, aim to make the uncontended case go fast, at least to
a first approximation.

               Linus
