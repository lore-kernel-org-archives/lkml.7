Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE90C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03ED0206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Orbrf0ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfJKM44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:56:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40079 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfJKM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:56:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so9720199ljw.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 05:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E/20N0oOaK1PRtwkpvzYq7XZer2TObH45wVnwVdQ6HQ=;
        b=Orbrf0evJaoUxR6P1zA+qWvxnaTrmaKN8kPaxsH51BF0CuWtiU81HR95mLNlB+7sNf
         1K3ZBZJpFsWWmVVWsxi81lEB+EFpHW9GZZtZJa85B9Rybr8F+TvNzWRscnFI/DJ/beig
         daopA6DSBWUBqyLxZUcezSIV1339lxFnq7jhkEoMGcMg4TMQ9KUC70OClIPb7CPiA7wc
         2fVFrsNV32zvUxUc+mEX63KQgutG7HJyZedZVrQ4Cr2p5GRMHSKukM/d+emDeOLXO+KF
         BX1NI5xqrqCMV4Pbxl68Lp2yZxmkXWEikWJGsMZlLFyGucmF5q4aMiLCR2sqzPaS2NYh
         dSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E/20N0oOaK1PRtwkpvzYq7XZer2TObH45wVnwVdQ6HQ=;
        b=WHBDbapkiPz1oTbxhCworSYLcrPf0vXHYbiY7GBm6oMkDg6uYbVV9614peB8T1M4yc
         VSFf3Dm169HT1ko9reTnOXh4+wYSyN/uUb+9GEBDKRlHK0KdbpQ1UeGozj8C55wm9rTp
         HJMlCxODOldRxOkiXz0idatatU9im5jEtR8SGxwWGG76c8H7Toi4yHrdpz1yrnwIViBb
         ShnJxVyV+8BaxI87Q0Cz2xVhJHiUlSmklsVE//68PhECgIcYDQeHuYU2IefFY8fms0d5
         kEefcSt/mYXI7SeP7oUJPo2P4nMUyAnCFg7PfmijeRl7LSE6yHfsMThXDTMFdN9UKN8+
         K6vA==
X-Gm-Message-State: APjAAAXGFZshbL6rzJ+pzBwE7AtM93el2xBNVucoRd1brNu+yhw7hBB3
        ggdhqhW6MB03RWl+Le8LhTTjDw==
X-Google-Smtp-Source: APXvYqyIbS9Uz3soVljm82VN98x/dEB9BbBFJrjsGBWNNEQiPcY9SjJAJZ5NbYusdNCvYEMZWzN2hg==
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr9291581ljj.140.1570798613448;
        Fri, 11 Oct 2019 05:56:53 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z128sm2004741lfa.1.2019.10.11.05.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 05:56:52 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0043D102DC1; Fri, 11 Oct 2019 15:56:52 +0300 (+03)
Date:   Fri, 11 Oct 2019 15:56:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v5 2/8] mm: pagewalk: Take the pagetable lock in
 walk_pte_range()
Message-ID: <20191011125652.2b7ptnyeeso4qwwj@box>
References: <20191010124314.40067-1-thomas_os@shipmail.org>
 <20191010124314.40067-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191010124314.40067-3-thomas_os@shipmail.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 02:43:08PM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> Without the lock, anybody modifying a pte from within this function might
> have it concurrently modified by someone else.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
