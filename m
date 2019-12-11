Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9102CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604D82073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="G2E2Di2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbfLKPof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:44:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39603 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbfLKPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:44:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id e10so24589926ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 07:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XdzBTtaNquqJQQc4imgAleeVldIWzikxbiqcx5Oj4Uw=;
        b=G2E2Di2yoRVC6LiYhg1kO50cH34YBeUkTvPVd13zyFgGT5Zhg5360ZibuMIwXzjzZT
         x4RiYwW9WBQI4t5kV+nbfqmKJPgz3nEu/Ok4dxgoc7DZqCrMPUustH30XN1suYlnEOKN
         qSs+GuTWkYCPlMdMRJUtL7WvIn7cs594EGRqqvxKMvO3GEybm9jv82wo8Mn2/VqwMqxE
         KXW1WBNB42/ak4h0bBQwEC/4bP+zQP3pUgvQNe+eq8+TJLAcHJVyjkJsm1KHurbFMSTl
         9gQ2vhMXWr3Gw4CrbO87BXw1zG/y++JkWskieWBimgUr+G07/l3wZy9bukniaD1h9hSP
         JB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XdzBTtaNquqJQQc4imgAleeVldIWzikxbiqcx5Oj4Uw=;
        b=blcRU3ERtxBb9HlBDRX0HylIIjaqWR0Ce+HEgxgUc3IWWxZvX8dAW8rf7N9sYegYjZ
         THBx/eLkR8Nqx6RFrcqnIEQ4MdpRy5WSDn7al3mPZ7ncrom+hIV7cNL/QqNpjjOrXKgv
         XxIXP1sk8uJzCShO/kDgIMAKs4lzb3b2CeqeYjIdnMlvVhBbnbr//XokcsviBBvHGckS
         SNw5mOis4l5YY2HTJUvF8IOH1rYzFr2aviMzWg+I/RXf8OFjY3xr9g3O5UcxLl1rMtXd
         59WIFMCtnrJ+lfdc8yqeyPlLfUK4QbI5Kfs27N93wp9mOmkgbLV591j1ILKz3WYV/V2p
         fjbA==
X-Gm-Message-State: APjAAAU9aOiMy+hMp/Suy9E7wGo9q2NddssxX8TiaKDsppa8RFwdrlaL
        dZWsFzkyVdVrWxvpX5Gber6Bdw==
X-Google-Smtp-Source: APXvYqwSQs81SgJhtxgOyKyhGTp7SwuA3qzUk/Yet+/zmbJc38BOSBCKb5y1J1lYoQveRVIKsu2I3A==
X-Received: by 2002:a2e:814e:: with SMTP id t14mr2470350ljg.149.1576079069978;
        Wed, 11 Dec 2019 07:44:29 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d25sm1400170ljj.51.2019.12.11.07.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:44:29 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A073E101218; Wed, 11 Dec 2019 18:44:29 +0300 (+03)
Date:   Wed, 11 Dec 2019 18:44:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: Re: [RFC PATCH v1 2/4] mm: also set VMA in khugepaged range
 invalidation
Message-ID: <20191211154429.7tscxcqk725guyce@box>
References: <DB7PR02MB3979E79A7ADF7E7B2F397418BB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR02MB3979E79A7ADF7E7B2F397418BB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:29:21AM +0000, Mircea CIRJALIU - MELIU wrote:
> MMU notifier client may need the VMA for extra info.
> This change is needed by the remote mapping feature that inspects anon VMAs
> with huge mappings. 

The change itself is okay, but commit message should be better.

Do we have any user of mmu notifiers in current kernel that affected by
the missing vma here?

And subject starting with 'also' looks wrong to me.

-- 
 Kirill A. Shutemov
