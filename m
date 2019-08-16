Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0557C41514
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C622221726
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="YnSjsjmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfHPOEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:04:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38053 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfHPOEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:04:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so5237229edo.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j/6BPKwgYdq3kl7X0DqLCdZOmgeTKbt4kEmnV+oeC6I=;
        b=YnSjsjmqORHGTHdLdT4KBnuh8v3t5NbxdxRxz3vfItQsLFguH8BIUURBkKImiy3fc+
         QKMSsp4mKy1//EDwlszPaGY31GZAyFNdG4ssiVrhdszq9NlYgjlosyognbxKAcI3ilra
         N/JfIZ8yhEgylnIyMvpv1wmwtlDBvAcfCtiYWfk9USKXRvvTP0EkR6dYW7QHIP0dfzBb
         A0ac3u0A4PJ8TfFimtt9BL7EOajczxJ2XfDozJdP3e/pu3EntdUyw/HNezq23EFggd7A
         +83PyOi1icjBaMtvayv/2K09oVZtJ3h4iUj0aHkVaDkYwd3Nk/aXrAwbLxEvTQlhoJRU
         djfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j/6BPKwgYdq3kl7X0DqLCdZOmgeTKbt4kEmnV+oeC6I=;
        b=Ta2SypEpQZTS4+VyeyFj6bMas1bnQ6bad43fQp7/qPBYvAWY+i9qeicEEIoiXQRqXM
         KfbsDFeAvvdRUthrczkxTp0aIdIGlL1a24TBDGJLhdqUfHL5IFF5V2KcaDx8SITROgrN
         iyrnwNvwBhe4iyND5MFAsUEVui4kJZIm3D9MDVBDwQbjAO4gRb6jnesdkMRK4ld8GHtB
         rK9tTrML68aO6+hnfqikWDu5AkYLWG5xKiA0joDZ23BeKGO0rYs8OgkLa2UUNwBNS+Dv
         gINJgEmMwdMENXqOIZN0nx+Ca9WLApN9zEzzWlvKjKu/pwGydfzXlw0W6a3bn6WiDbJ2
         rBvA==
X-Gm-Message-State: APjAAAU14RuRceBpiy0euFjvj7RpsMIGJqNb3yJ30yKs3gvJE+WjmkRy
        TKy9AuWcOc2wy/sKSW+HwGxHAw==
X-Google-Smtp-Source: APXvYqwqdMEG9G2Oq0aACS617rRtH166b9AKeywrjTiPb1fssPssuw3ekoGQZcKpFtGVZiXPMI46Rg==
X-Received: by 2002:a50:e8c5:: with SMTP id l5mr11205255edn.120.1565964271580;
        Fri, 16 Aug 2019 07:04:31 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id gz5sm829374ejb.21.2019.08.16.07.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 07:04:30 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 263B710490E; Fri, 16 Aug 2019 17:04:30 +0300 (+03)
Date:   Fri, 16 Aug 2019 17:04:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] mm, page_owner: record page owner for each subpage
Message-ID: <20190816140430.aoya6k7qxxrls72h@box>
References: <20190816101401.32382-1-vbabka@suse.cz>
 <20190816101401.32382-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816101401.32382-2-vbabka@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 12:13:59PM +0200, Vlastimil Babka wrote:
> Currently, page owner info is only recorded for the first page of a high-order
> allocation, and copied to tail pages in the event of a split page. With the
> plan to keep previous owner info after freeing the page, it would be benefical
> to record page owner for each subpage upon allocation. This increases the
> overhead for high orders, but that should be acceptable for a debugging option.
> 
> The order stored for each subpage is the order of the whole allocation. This
> makes it possible to calculate the "head" pfn and to recognize "tail" pages
> (quoted because not all high-order allocations are compound pages with true
> head and tail pages). When reading the page_owner debugfs file, keep skipping
> the "tail" pages so that stats gathered by existing scripts don't get inflated.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Hm. That's all reasonable, but I have a question: do you see how page
owner thing works for THP now?

I don't see anything in split_huge_page() path (do not confuse it with
split_page() path) that would copy the information to tail pages. Do you?

-- 
 Kirill A. Shutemov
