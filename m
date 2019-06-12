Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0B2C31E45
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F8D2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="fw4Q74Ba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408538AbfFLCw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 22:52:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33564 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404957AbfFLCw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 22:52:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id h9so23240806edr.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 19:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lTSsRBqCkV01tyi99VGZwhMHPEHI5mgEc1RD90UNjyg=;
        b=fw4Q74Ba1btatZL0a2YpiRpBrSxcKAXumIpAR0gE8oNWSDYZ83TELkQamlGVpC9PcO
         0HqHzzhxCVU6HkPE38P/AWAFRnYuv0FdhzPRumcorq5U4AwW71pM9i6oa3y4Dhh+LajO
         VrBmdg8q3xP860V1auFmiSrwn/ulafeuZba2kalmeIx3OCqwea3dNN5kAhNRVyRasRqU
         pm8eLz+8IBRUI5NQWvEsObpHzJ2ITP39NptQiwOUuybbiJieu9qVCkDW3QFRUiuXc6lT
         tU7wLG2yIFK3Jw/Y+5zeaasWKVasi6tO2VImYEOeSBh0oakk8FTZva4XQZ16RtNJUJGJ
         2fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lTSsRBqCkV01tyi99VGZwhMHPEHI5mgEc1RD90UNjyg=;
        b=WHgAd2Qg8vhzD64/w0NyvlMeQlf7jip1ImztGBIdMQGD5FKNMxLyAnzb4ctjkz9543
         a/gLbv/i8TEV8v8ZHbMnOvEO4DcQMHUobmfbo6qd/yL2vsnpyw+osjvmiYmyEMpC3Pmi
         tdx+FkyFuuXOJk28Y4NoN6NGrhSJyqWzsUTDo7XwoYG9htK7+6IjXWxXLY4M4nEMnVU4
         M3zstP/mN5pad7oGke8Nv6dPx/xE50iTmdPCCQesTJb2PoroY6D+xAC/HsegcQMygCe8
         1+nkAhyNOUtTX/n9owwKYIr0WtpIsLrXRS/m1CiubgbafU5C6WtRsx3X+cfrQI+5Rxb2
         bE/A==
X-Gm-Message-State: APjAAAXZ6d56s7oQLAJFXdd0fmracsvOP9i7C1a6M/OUaN+tqXHazEmw
        +40K/1hN9z1lKx/cBV/Hm1O4XQ==
X-Google-Smtp-Source: APXvYqwhPUYZ7NcTbUtoLkSK379H17VO3ocGiSwvUcxrlIx/jQ0N2GugFDy7c6sGViaRmAcsB8xXKg==
X-Received: by 2002:a17:906:300b:: with SMTP id 11mr48124392ejz.291.1560307977066;
        Tue, 11 Jun 2019 19:52:57 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z22sm604246edz.6.2019.06.11.19.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 19:52:56 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 146C9102306; Wed, 12 Jun 2019 05:52:57 +0300 (+03)
Date:   Wed, 12 Jun 2019 05:52:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: shrinker: make shrinker not depend on memcg kmem
Message-ID: <20190612025257.7fv55qmx6p45hz7o@box>
References: <1559887659-23121-1-git-send-email-yang.shi@linux.alibaba.com>
 <1559887659-23121-5-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559887659-23121-5-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 02:07:39PM +0800, Yang Shi wrote:
> Currently shrinker is just allocated and can work when memcg kmem is
> enabled.  But, THP deferred split shrinker is not slab shrinker, it
> doesn't make too much sense to have such shrinker depend on memcg kmem.
> It should be able to reclaim THP even though memcg kmem is disabled.
> 
> Introduce a new shrinker flag, SHRINKER_NONSLAB, for non-slab shrinker,
> i.e. THP deferred split shrinker.  When memcg kmem is disabled, just
> such shrinkers can be called in shrinking memcg slab.

Looks like it breaks bisectability. It has to be done before makeing
shrinker memcg-aware, hasn't it?

-- 
 Kirill A. Shutemov
