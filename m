Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D60C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BDD2071B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dkjSly7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKRKWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:22:20 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45656 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRKWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:22:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id v8so13308266lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 02:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qbPQwF0bssglb/RejZ5biijyFl/W/ftZF5sC8RlWOAE=;
        b=dkjSly7KUEUA/ht5aYTUHiK7ZjJxXg4jVvQkY5I1cC+nad/0aoZ0GrsQ28zALUP447
         6QkHABksQvdyOyaQcbfFyThusL9EEynzoq03YuzUVZcfPCoqj9rJtIb0Syzy/5CSIPI9
         dd/v9B02kVSilomcEhJd/RPYL1yh2GMoayYhmx7dj5+NLB0Werwqd/8VEzkDiuY1JIKt
         mPdFzi+JX1CPBP7ix3m6gkTnotXXSXUY9HuJY2Z7vKsJDkR6wsY+6DIQttnTiHoid43y
         TXXF6dQuyOqHMnzvpAhn4+nZyEKd/A0h6vnY1ajvstIbaa0a87l7/Ry89OsM3T8jqbl7
         IInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qbPQwF0bssglb/RejZ5biijyFl/W/ftZF5sC8RlWOAE=;
        b=iimUy7L9UeTrfToVb3G7qTA9E21Ie4T2eb6RNJlM92D5qZ6awzIneEpQe5lfGVjHUR
         dwgxAswm2gcXz/4Ekne6Pfu+POtJ9FTaaNQ5yH3TgygFtVj9r9e/+/Ws2n9cw7m8lzlI
         W21OhJCVNifGs/1pdUliHVGxPuH5rBfPPK4ZQIwIp1IWgTvMYFuXKLJmoFVCnqym4FWt
         0Eh6I1ucL/6RhelLVbTzw623778Vmjy4WwpolzbicPL4anYYELgwWyWzEUGifuvohbJi
         +KLEJYBPlEv/vvsYRCBibDcCYoRCqj5W/vy7C0gjRHeklwrV3Hu/Jcd8ViJobKji0LwR
         1ktw==
X-Gm-Message-State: APjAAAXmv4q9jQ9NWKEzbnE06bKrbtfD2gvla0yAl0PRE0PDExZNMD/a
        IQ7R88Qn2d7DPFMUVPJF7Czz6g==
X-Google-Smtp-Source: APXvYqyYnltIcki0IKgAOwiCoiixFAoOAltEYBQYq0Di6MZQ4sHR5hTascN4HEV9mxeGiKCWjuAtlQ==
X-Received: by 2002:ac2:5442:: with SMTP id d2mr19918744lfn.161.1574072537874;
        Mon, 18 Nov 2019 02:22:17 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a18sm598055lfg.2.2019.11.18.02.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 02:22:16 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id B3F31100C23; Mon, 18 Nov 2019 13:22:19 +0300 (+03)
Date:   Mon, 18 Nov 2019 13:22:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/2] mm: Fix a huge pud insertion race during faulting
Message-ID: <20191118102219.om5monxih7kfodyz@box>
References: <20191115115808.21181-1-thomas_os@shipmail.org>
 <20191115115808.21181-2-thomas_os@shipmail.org>
 <20191115115800.45c053abcdb550d70b9baec9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191115115800.45c053abcdb550d70b9baec9@linux-foundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:58:00AM -0800, Andrew Morton wrote:
> On Fri, 15 Nov 2019 12:58:08 +0100 Thomas Hellström (VMware) <thomas_os@shipmail.org> wrote:
> 
> > A huge pud page can theoretically be faulted in racing with pmd_alloc()
> > in __handle_mm_fault(). That will lead to pmd_alloc() returning an
> > invalid pmd pointer. Fix this by adding a pud_trans_unstable() function
> > similar to pmd_trans_unstable() and check whether the pud is really stable
> > before using the pmd pointer.
> > 
> > Race:
> > Thread 1:             Thread 2:                 Comment
> > create_huge_pud()                               Fallback - not taken.
> > 		      create_huge_pud()         Taken.
> > pmd_alloc()                                     Returns an invalid pointer.
> 
> What are the user-visible runtime effects of this change?

Data corruption: kernel writes to a huge page thing it's page table.

> Is a -stable backport warranted?

I believe it is.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
