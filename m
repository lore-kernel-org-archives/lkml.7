Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1718AC06517
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03EB21852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IitgCdR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfGDJrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:47:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44676 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfGDJrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:47:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so2684042pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 02:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4SdpUWyY7nF3zRR/WMwiXn1AtrDLUN6rhbCHpANtkn8=;
        b=IitgCdR9whQSNacj1M/nbSJsdQPhLvWz8YGHjZuDfyKn4J/+kYtYS/1A1sF8ib44xI
         Jzi+3vhstnJ0PEPZlPBIFJGgMuq6tjar0vi5VCqSjKABufTv9J/BouQzD8NZGsj2rXQc
         JFq2z4Gxqbb5bHDI+1AEOEE6vD4aj8UrnzLPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4SdpUWyY7nF3zRR/WMwiXn1AtrDLUN6rhbCHpANtkn8=;
        b=VClfXCBfhy18PDG3vGPmYQ+M0bJtzyNUhqGoG7w0xhDaY4Mskcq4ZNgr+kvVdkQqH9
         3C1R3wPXGiJn+JdsvCVLBduABJgMqaLAszTTsaOMrWYeWHLtof3nuiF/OkGrmcxQwCw/
         Z+wnLESfQHEPolSjLMzEQJDpE4cnloOLYf+eVDwlnYh/U0USVKEN5uMWbtaNWcB+lBkV
         lOhIGDzkd+mbexaqs1jEZFWKE7/eQEEclPehVcTVnh7U3sLJeeOfbQBUEaahtYVlVSB5
         3c7QD3+OU7vZZYAET6KjAt5NLw8fz0UfkA9StofBuBgxLfx1hUeKtT/rGIx0u/JbJH0D
         KGXA==
X-Gm-Message-State: APjAAAWWlBebtpsGosNcvPlNxDl44ehQC20wmBUMwyBmDXLqspxdnu+j
        DM/z5P0fmhnMDZtW6ZHqnr5a
X-Google-Smtp-Source: APXvYqw8E268vWmApfolD80e2lRtPey+EBMugZPC5t2scycuY0Z9LV07oJTYtyfmFbz+c/ETJr/dPg==
X-Received: by 2002:a63:1723:: with SMTP id x35mr41829828pgl.233.1562233640402;
        Thu, 04 Jul 2019 02:47:20 -0700 (PDT)
Received: from google.com ([2401:fa00:1:b:d89e:cfa6:3c8:e61b])
        by smtp.gmail.com with ESMTPSA id m101sm4159465pjb.7.2019.07.04.02.47.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 02:47:19 -0700 (PDT)
Date:   Thu, 4 Jul 2019 17:47:16 +0800
From:   Kuo-Hsin Yang <vovoy@chromium.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Kuo-Hsin Yang <vovoy@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: scan anonymous pages on file refaults
Message-ID: <20190704094716.GA245276@google.com>
References: <20190628111627.GA107040@google.com>
 <20190701081038.GA83398@google.com>
 <20190703143057.GQ978@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703143057.GQ978@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 04:30:57PM +0200, Michal Hocko wrote:
> 
> How does the reclaim behave with workloads with file backed data set
> not fitting into the memory? Aren't we going to to swap a lot -
> something that the heuristic is protecting from?
> 

In common case, most of the pages in a large file backed data set are
non-executable. When there are a lot of non-executable file pages,
usually more file pages are scanned because of the recent_scanned /
recent_rotated ratio.

I modified the test program to set the accessed sizes of the executable
and non-executable file pages respectively. The test program runs on 2GB
RAM VM with kernel 5.2.0-rc7 and this patch, allocates 2000 MB anonymous
memory, then accesses 100 MB executable file pages and 2100 MB
non-executable file pages for 10 times. The test also prints the file
and anonymous page sizes in kB from /proc/meminfo. There are not too
many swaps in this test case. I got similar test result without this
patch.

$ ./thrash 2000 100 2100 10
Allocate 2000 MB anonymous pages
Active(anon): 1850964, Inactive(anon): 133140, Active(file): 1528, Inactive(file): 1352
Access 100 MB executable file pages
Access 2100 MB regular file pages
File access time, round 0: 26.833665 (sec)
Active(anon): 1476084, Inactive(anon): 492060, Active(file): 2236, Inactive(file): 2224
File access time, round 1: 26.362102 (sec)
Active(anon): 1471364, Inactive(anon): 490464, Active(file): 8508, Inactive(file): 8172
File access time, round 2: 26.828894 (sec)
Active(anon): 1469184, Inactive(anon): 489688, Active(file): 10012, Inactive(file): 9840
File access time, round 3: 27.105603 (sec)
Active(anon): 1468128, Inactive(anon): 489408, Active(file): 11000, Inactive(file): 10388
File access time, round 4: 26.936500 (sec)
Active(anon): 1466380, Inactive(anon): 488788, Active(file): 12872, Inactive(file): 12504
File access time, round 5: 26.294687 (sec)
Active(anon): 1466384, Inactive(anon): 488780, Active(file): 13332, Inactive(file): 12396
File access time, round 6: 27.382404 (sec)
Active(anon): 1466344, Inactive(anon): 488772, Active(file): 13100, Inactive(file): 12276
File access time, round 7: 26.607976 (sec)
Active(anon): 1466392, Inactive(anon): 488764, Active(file): 12892, Inactive(file): 11928
File access time, round 8: 26.477663 (sec)
Active(anon): 1466344, Inactive(anon): 488760, Active(file): 12920, Inactive(file): 12092
File access time, round 9: 26.552859 (sec)
Active(anon): 1465820, Inactive(anon): 488748, Active(file): 13300, Inactive(file): 12372
