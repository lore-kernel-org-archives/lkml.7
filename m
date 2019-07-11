Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0458C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EF520863
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="tF3TLrAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfGKSHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 14:07:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43305 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbfGKSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 14:07:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so3413329plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HFqqVAf53kQZdQpKzWHw6YV0GKjGRqkuwN0W084Idiw=;
        b=tF3TLrAgMwyyskndvYBbdeyeiTdA3ax3J7vfMGNXEegyPwcKqVxi0vW4QF8Sbo9L5W
         6OJUTIJAIWTZ6kDHn9Rv2qLS2xtqXEkdbqacOfgHYFg6HZzoRJ/Ai5gJZYJ5hAWMIZ1i
         UykxeqaETOYUXDlhn2iVJspR45SoeMH5gfP7RQBZC0w1ekRo0mYMhWilnnztwDL99w0v
         2SQcmkV3JGGe7XtnqSV6bNjtH65hfzDSJfN5lILS8DFbRrsh5tasseTAZgiZmLzPNgyg
         lZOSsTWjhmHGGU223CWsarbZthwmuT7ikTEsPom1WpjgEWZqxirlJhjcCi7DUoxUnQv9
         XTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HFqqVAf53kQZdQpKzWHw6YV0GKjGRqkuwN0W084Idiw=;
        b=WzIRMlTXlgo35RaxkjFwwXjHD00Mcl1+iO9kyULtceGkru9aTZz9OslO6IBFlj05Tu
         CYVUQU2Qlg1uHRVJ8W1WMBRbEPi6A0l65Dc2oFRkyyoGJMFlMZdTbMxgxlYmN793ctv0
         gu5e9HreV8taBOA33kieYU6jIbWa9gopTQoazaZH2hzr1xRDGkhsGnbGR06PjrxZ5V5k
         aNbpZ94c2DUxzNinkp5jHg7tWu552u8KVEByKY6O2EMjq93p3ZHEQlQ8sDZVDNbCqtR/
         q+WTboVnw0q/VyYFeoSaBwVDyJl+lH71nMUC+ElonJE9XEGBgtlNtBKmLSfvlllBBRQ4
         B17w==
X-Gm-Message-State: APjAAAWTT5av8vuPNfFZDPXSsymRvxbpF4j/38XVWekEV9YdGxWkgZpf
        7BfQUDnFSPg4jxidd1APf28=
X-Google-Smtp-Source: APXvYqzMAQG40OUqLYdym3Kco+SvImeO5ZcrWpZB4aqsTh7miN748rzlQ4W0jLflNC0KF2SfAxfUFg==
X-Received: by 2002:a17:902:145:: with SMTP id 63mr6305306plb.55.1562868450408;
        Thu, 11 Jul 2019 11:07:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5385])
        by smtp.gmail.com with ESMTPSA id w2sm2686882pgc.32.2019.07.11.11.07.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 11:07:29 -0700 (PDT)
Date:   Thu, 11 Jul 2019 14:07:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 3/4] mm: account nr_isolated_xxx in
 [isolate|putback]_lru_page
Message-ID: <20190711180727.GC20341@cmpxchg.org>
References: <20190711012528.176050-1-minchan@kernel.org>
 <20190711012528.176050-4-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711012528.176050-4-minchan@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 10:25:27AM +0900, Minchan Kim wrote:
> The isolate counting is pecpu counter so it would be not huge gain
> to work them by batch. Rather than complicating to make them batch,
> let's make it more stright-foward via adding the counting logic
> into [isolate|putback]_lru_page API.
> 
> * v1
>  * fix accounting bug - Hillf
> 
> Link: http://lkml.kernel.org/r/20190531165927.GA20067@cmpxchg.org
> Acked-by: Michal Hocko <mhocko@suse.com>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

This is tricky to review, but fwiw it looks correct to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
