Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D28C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABE5222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="JFYJOt2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfIZOPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 10:15:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45308 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfIZOPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:15:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id h33so2169853edh.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vGFtvroMWb8i1UdgYB+FIzFbUPu5RC5n7gywEg0Ns3c=;
        b=JFYJOt2TB9b5dmR12GgayBbj3a/6oM6CocwMQzb8vdNlNcaueXrxse5cVDSoSa3CMA
         jWz7F/9pNEyCwWevcB2nqWdY8kOXhAetnCnhk0FzXElb9xkWKBs3Zl0Vw2TTyze4OVtQ
         jA6XjwXZsF36fzPI4WI/WDUywLYhhMNW/pFSQKjc+UikmOO4hU+Nmbcxwh5kFTSGmE7J
         rgdL6O4aD8pm+ZtenP+Jvs80CqEJO5X3INxIbDdL8vfv4I4KlRNvOF4AFSDT0BrNaLq1
         Wx+dWvWRkEY0iNzmwQo+OsIVxEHbi8psveBR0XcbigEAo27vZc2NK7kmghiGh1fFPY2o
         kKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vGFtvroMWb8i1UdgYB+FIzFbUPu5RC5n7gywEg0Ns3c=;
        b=PZZme5PJ79KtzHIJ6BRrz0gnToKz9e1vK9rkRSxwd/gVmnQacFAkmdFpOdAW6pU4UJ
         ATeg1tEBA/gIUv4VXB9gXE2IPNnWEnjVQ2PRJ3RXMsbT7Q3cawE16agsctNsVhjvgrx3
         5hJiqcnJt1ef5+u6HV6GwVhuoRzqVBBYjcrvaMDzdSKiMhcayUsUiU6d/sfOVFyTRH2q
         aWdoihJCu+3nRexKTLAimRU606YvHjOm4WZTcPtg04JTUcuGtCcWrzB6U2mU1Wpf9Goy
         lWWBV61T5O/GgN2lbPg9FixQSgW6NdZpH/cNtF8m9VzZDUj9m0Wvk3LXLtXu4X92QcFa
         lEVg==
X-Gm-Message-State: APjAAAVvyKHBDU1W4mRJsunrjPTqAGzS6BXO2Z88A/J8aDoHRIABhDE7
        r5Ot4TPKPG1j7JNAHewO0R/XCQ==
X-Google-Smtp-Source: APXvYqxL1Tay1aeeI2DJfAbE/xiOHQlPvFzqDtA8sro5dyATqS6m3DqDyn6gFl+H9Log7+18MDe2+g==
X-Received: by 2002:a50:b7ed:: with SMTP id i42mr3813685ede.52.1569507320676;
        Thu, 26 Sep 2019 07:15:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g8sm497256edm.82.2019.09.26.07.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 07:15:19 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D5333101CFB; Thu, 26 Sep 2019 17:15:22 +0300 (+03)
Date:   Thu, 26 Sep 2019 17:15:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] mm: Add __page_cache_alloc_order
Message-ID: <20190926141522.sdjyj45t2ruev2sy@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-9-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:07PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This new function allows page cache pages to be allocated that are
> larger than an order-0 page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
