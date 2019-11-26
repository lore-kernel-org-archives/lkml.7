Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C31BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AD62071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="LRCXODLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfKZPwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:52:53 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37416 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfKZPwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:52:53 -0500
Received: by mail-qk1-f196.google.com with SMTP id e187so16530095qkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 07:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O3f3EeNDCGqbP17ATNYzQA2fraEUA3qHPgg/ocitAC0=;
        b=LRCXODLsW3T/isyZrmMRVLf/MdTJdlDe0WL95t1G7dIcz7vAls41eXRbPza/0SCDrN
         p3XwF0+l1VqCOlRMAcim4F9RvPZNfMQM+MKr3BVjl8n6/Th72nFEeiCxBZVae9SdQbAW
         6N8LYQSDm6rcbg7pq7anLPKJkfEABkAb7agGujp9fVqC2smB7Q2okVkeQNK4sc1g8J46
         h19jUqwbjRNe5Frq8qYnC+Yk5v5RkyN0E/u04UsCvv/qNd/q08z/UxrdIo9MFHAw5e0B
         rbcswYphSxWCqgYPy2SmUGzO42xOGyDxc0LFlpqHXVOlEUuhWKYnWne9RHyfefsQ7Dyy
         BY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O3f3EeNDCGqbP17ATNYzQA2fraEUA3qHPgg/ocitAC0=;
        b=j4HLO7a81EKCTyKYMn5j7qag5b8fOrtlm/7OrCsYuJ+56tE1XFqGc7/BhF8g6nNBz1
         sr7A06nYKnteN2igY1GS1bY/lhhsJ2x4CLt96O/somgX5hNq3RmnUfBys7vTZLH/YGjV
         Wf2D2z0gkaVqVJN/S5qP2TZX9bMuhrrhThtPHIEUBG2u1FYO8ePs8FtkOfTHPkoyGyoL
         S5e3xlowx+dn0NJrhR9D9sAt0hGe7rO89ZFRdMQFm7TLj0eiMv91kriK+RqZnLHJiUvU
         NCc2ewExRs6cforqhet7qaJpvZXxZxg+L9rS6G49UzYVnR1eL5+LxWJO/XRgjQMTpxHl
         OPRQ==
X-Gm-Message-State: APjAAAWlznMFYaoiGKRfAgH/kb5p+Bfr8JKsTP4OsDWAJoUaNw0uOoR8
        MFgqb75reXgT1MTJMqtt3NXTHA==
X-Google-Smtp-Source: APXvYqw/hTILiAsPj2NKsupddCm2m9m0Y0Tg3j93FtRHPv8fhS9ztgRxjX7bZOOBhLSnO98A+BVEAQ==
X-Received: by 2002:a37:de12:: with SMTP id h18mr16528254qkj.256.1574783571892;
        Tue, 26 Nov 2019 07:52:51 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1218])
        by smtp.gmail.com with ESMTPSA id z7sm6183512qth.85.2019.11.26.07.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 07:52:51 -0800 (PST)
Date:   Tue, 26 Nov 2019 10:52:49 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: Increase buffer size for zlib functions
Message-ID: <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
 <20191126144130.75710-6-zaslonko@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126144130.75710-6-zaslonko@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 03:41:30PM +0100, Mikhail Zaslonko wrote:
> Due to the small size of zlib buffer (1 page) set in btrfs code, s390
> hardware compression is rather limited in terms of performance. Increasing
> the buffer size to 4 pages would bring significant benefit for s390
> hardware compression (up to 60% better performance compared to the
> PAGE_SIZE buffer) and should not bring much overhead in terms of memory
> consumption due to order 2 allocations.
> 
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

We may have to make these allocations under memory pressure in the IO context,
order 2 allocations here is going to be not awesome.  If you really want it then
you need to at least be able to fall back to single page if you fail to get the
allocation.  Thanks,

josef
