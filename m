Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE1CC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 03:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89D820678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 03:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RAldJ7DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392131AbfIQDFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 23:05:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45246 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfIQDFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 23:05:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id x3so826496plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 20:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m/gYUtYqUvo6ZQAhOJa3OteVu4sO8XhLyRb2JBRNr0M=;
        b=RAldJ7DKhfD734MR2BcO0R7ld7KINGa9UXMchKZQS1Qfk29dBkksQkzZLtC4QjlkVp
         AdWlDuuJ0oB6QGeTBxLoWOHaSmCpfJA00KnKg7Wa78k5wCOMTsOH4v8v3XzPslqstQI3
         qAK/JlZIWIdcgwFcbuknA4zLXdlvkH1toP8mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m/gYUtYqUvo6ZQAhOJa3OteVu4sO8XhLyRb2JBRNr0M=;
        b=TYjZ7ow82dVVPWNET1HjTg920Ci7GGp1+5zLDNdu+bh96X9d6VgRi5QWJb3J1fUIFv
         4MhQb2Y6pEW9t80zBQHWWlOVdZKo+fIVHSDn0Vg5DlodjiRAawXoRbYwdgyLAw1a/LKH
         PJzUzPFg5xIuecO39xh6gZvjod3a6jVNtH+jxzsucUItt7iqZ/2edRJsfgaPrrjTVeMH
         0GjnKpdz6WR4JB1s4AkWg4LKsmfrhVcvLshy/pfP3TqLTgi+A3yKUPsPx8nb4nj1msox
         CsNQzqDwWfTaUukQu7XGJjAOubXbZt0cdU0CqGDjwol+HhSTmKpKh0+EAWm/3T96QNHp
         epwg==
X-Gm-Message-State: APjAAAXdN+GqHLc93PRQS6c3ArVj+6mHuR5SVbyLay3VrRXtxhRmdVQf
        c5w5K4kgp8xutDu2KRzgeBs1JW4Th1M=
X-Google-Smtp-Source: APXvYqxjPywckFI1ehceUp9hEb5gRERP6bte07a2unP/1biXqWq7kYB4Se2dAnHJcD+Pgxf13MXn2g==
X-Received: by 2002:a17:902:5987:: with SMTP id p7mr1433063pli.242.1568689502384;
        Mon, 16 Sep 2019 20:05:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v9sm457360pfe.1.2019.09.16.20.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 20:05:01 -0700 (PDT)
Date:   Mon, 16 Sep 2019 20:05:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] usercopy: Skip HIGHMEM page checking
Message-ID: <201909162003.FEEAC65@keescook>
References: <201909161431.E69B29A0@keescook>
 <20190917003209.GS29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917003209.GS29434@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 05:32:09PM -0700, Matthew Wilcox wrote:
> On Mon, Sep 16, 2019 at 02:32:56PM -0700, Kees Cook wrote:
> > When running on a system with >512MB RAM with a 32-bit kernel built with:
> > 
> > 	CONFIG_DEBUG_VIRTUAL=y
> > 	CONFIG_HIGHMEM=y
> > 	CONFIG_HARDENED_USERCOPY=y
> > 
> > all execve()s will fail due to argv copying into kmap()ed pages, and on
> > usercopy checking the calls ultimately of virt_to_page() will be looking
> > for "bad" kmap (highmem) pointers due to CONFIG_DEBUG_VIRTUAL=y:
> 
> I don't understand why you want to skip the check.  We must not cross a
> page boundary of a kmapped page.

That requires a new test which hasn't existed before. First I need to
fix the bug, and then we can add a new test and get that into -next,
etc.

-- 
Kees Cook
