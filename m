Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C29C17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8B320856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uaaSpNzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKKIyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:54:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38228 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKKIyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:54:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id v8so12878495ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hh9xvH48eZqqM/CU2YLgBDDsKXb6m+mKj/TnPyvK9dY=;
        b=uaaSpNzbWH8YgtbXIcFwyhuYc+hBKy7DkJEmKF0ApMWUZvUW0rZMM9J/WA1CE3YsI6
         kZa/jmtj1PYHMp6o7i/2aPs6C8CMHszP7zpO4FkcfAyKHJ1ki183iNfU4+KZSXdyGlMF
         ChP+g3H5XS+4ifkJpLti/NzGwPHzOCG64DixClnPmh9xiOiapfImQKON5GZ1Xb+PniP9
         pZCvLxOF9i6mbokRyff2LVkO46L3sqXCinN/ElhsoOYMt0w4acUNMVzLLwTfODjkgIFi
         ScFxfJ03P34ItGGzZe45Kz8NkAX9wXLBKMzfwapeGrIcmf8CYDcYRsUJvY/RCg6HORO8
         5ZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hh9xvH48eZqqM/CU2YLgBDDsKXb6m+mKj/TnPyvK9dY=;
        b=h7mEhGwGi3OMG6xgVhWg7wIs+giHoCc6imNuoX1iqJE0rDZsRaZbrI51iFFmc1WZfi
         yPiKFy+x5xyvEqtTqGoyFYyz5H9RSxspC/UG1FAgvAyH/h8LsTQZW2cilhvzHWDfKqoD
         bHAwRp2ovegphRnw1nObnKZEoTCrtMV/tLKtEWzwx7/1wKdo2crmiLOjcO/aEdd6jpC3
         6kFh0Y1QV6fJUdCNQWJb0vXDdCyLMgG61mHY+HY1shMTYpK5zccoRVqzRMEa9JhXv9pt
         ka7HAilntS8UmtW//eroO8LBZBWfmxPbFGcgcTQJNG1hdxDU7BfdwmJo1gxXtPX2Ra5t
         breQ==
X-Gm-Message-State: APjAAAVWMGFCfaD1rBE5UVNRUXuXmzIBK71eb9fN536v9VggyR+Pm55/
        j7mEUsptR75UT1Z4nBsAUZmwCw==
X-Google-Smtp-Source: APXvYqyofZeBTdxtjeFOuhX2ydZqWkwAOeHUxVbhrP9ll2qhJO8c5SM09gh++TXN6ZJi35hokiq9UA==
X-Received: by 2002:a2e:760d:: with SMTP id r13mr14853035ljc.15.1573462487658;
        Mon, 11 Nov 2019 00:54:47 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z17sm7986463ljz.30.2019.11.11.00.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:54:46 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id B239E101E04; Mon, 11 Nov 2019 11:54:48 +0300 (+03)
Date:   Mon, 11 Nov 2019 11:54:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: rmap: use VM_BUG_ON_PAGE() in
 __page_check_anon_rmap()
Message-ID: <20191111085448.gzlamnjnftiqagxr@box>
References: <1573157346-111316-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573157346-111316-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 04:09:06AM +0800, Yang Shi wrote:
> The __page_check_anon_rmap() just calls two BUG_ON()s protected by
> CONFIG_DEBUG_VM, the #ifdef could be eliminated by using VM_BUG_ON_PAGE().
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
-- 
 Kirill A. Shutemov
