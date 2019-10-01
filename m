Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FD2C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20D721924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="yyrFnMA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfJAKmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 06:42:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45810 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbfJAKmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:42:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id h33so11411735edh.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 03:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=K1jPj14nxpAoVvF1PZlHFLbTjJlXvJfGDzQ5Wzyv9Ek=;
        b=yyrFnMA4aY10KseW9DWUcxSYaja2Uswf8aTlSgS6v/hJw/GxX84hrTGd79zrlgjilm
         FzPrD4EROIlhtcwsK6Q8zt1epjMS5KM2UPNklRGjQYM+JrVTZ4XaJj/446qgdyz7uU6i
         fcEZXAPKo38jdbVUX0LXncAADgzJySy7YJuRnaR3rcxi/OQUmJhpq7yU+xwwB80VIVwz
         1Z1yc3qfe2Fiq+RpKLM2UsVVvTJcmsQMsxnoqXc0HPUvoECnZgJX9GnrayrsHJPTQZNr
         Wkn95IGQz6w0b8QIdGnQ1FMQms1Q6NxW1g4x20fOlki8qx3i/yeshnbt0zEg0NWKziui
         Ttzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K1jPj14nxpAoVvF1PZlHFLbTjJlXvJfGDzQ5Wzyv9Ek=;
        b=rksZwoCsanrwRq9+ZWmOAqCG7r3Sgtd3qV0g+3CsHxAjV3NEmgR7vyKBsX2MbEECxi
         F/06uiPLnYmRAR8uRWyKA0XZsaMav/YquqpRJh8LyKx21cPp7MqNge6G0PVLHT6LA6b1
         dpYVuXs7/XY214IbBQMzKJWFp0/tYyiRbEe5ecdbEYCT9ZLM9bNY29Tx9ilUTd8f/hx8
         RHo/EydJXeXXMkNT+Mh4hyIh+jKa+djGaBGoyE5GfScAcA+BS9CtItMy0lSK5sLNSCgn
         pPS0iJoa8EMsMYrdiMnuktcIqx31uHNTUjzWAwkKqd6jDJlY53itGESmJiaoa/7ykEeT
         r8Ng==
X-Gm-Message-State: APjAAAXKe+9CrsbyrG9geHaTvQa03JGoNXMC2bOVJ6wwZ84bzpNAMdG+
        hnDi2MIGM7hKsJt4kRatxitMLQ==
X-Google-Smtp-Source: APXvYqyAm6+9hgtwYZ6sZEL5nFAwqNn1WDZ9BjiinNKVy+eFRejDSKRUOOx14gRU9eSGhSRtDXGILg==
X-Received: by 2002:a17:906:7fda:: with SMTP id r26mr23780727ejs.170.1569926540535;
        Tue, 01 Oct 2019 03:42:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a3sm3041116edk.51.2019.10.01.03.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 03:42:19 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 73B25102FB8; Tue,  1 Oct 2019 13:42:20 +0300 (+03)
Date:   Tue, 1 Oct 2019 13:42:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH 13/15] mm: Add a huge page fault handler for files
Message-ID: <20191001104220.zhjcpdi6oaxl5un5@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190925005214.27240-14-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:12PM -0700, Matthew Wilcox wrote:
> From: William Kucharski <william.kucharski@oracle.com>
> 
> Add filemap_huge_fault() to attempt to satisfy page
> faults on memory-mapped read-only text pages using THP when possible.
> 
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> [rebased on top of mm prep patches -- Matthew]
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

As we discuss before, I think it's wrong direction to separate ->fault()
from ->huge_fault(). If ->fault() would return a huge page alloc_set_pte()
will do The Right Thing™.

-- 
 Kirill A. Shutemov
