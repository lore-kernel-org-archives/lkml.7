Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048ACC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 13:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FB7222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 13:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="byj3666j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfIZNz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 09:55:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40305 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfIZNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 09:55:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id v38so2103689edm.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aOr0iyfBLl80umcRhExqHZHW4urAI30wkAKXPx7sd8s=;
        b=byj3666jUomIxQfVgejvo9qb9jGyy7ag0vbTbVW71SegiKooHWd3O/zR9mU4jnpKRq
         bfOavtCnWSSNGyUXeiUwmCDfS6pewUtqXrgAb29RPcOQV44Q+7nTWMvi2Qai5qKFX8gZ
         0tVLgaeBW3mCWMCnH/z/g0dZEalHgm9Gf+TA5USpCcAJqP9BGnH9Wg2kEkzlJFyhyXHN
         eR22wGokBq86OaykauTi3oZw/WmqYf7zfUyhxk3Yq8a3rw9cYcQnotYj3MWUlv9EYVB1
         MhFXn3/H+1CY66b1QwIXAt02H42lnbbT7g4p2yI8zYAXD4+Vzad797Aq01FUSoUyjeLi
         qbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aOr0iyfBLl80umcRhExqHZHW4urAI30wkAKXPx7sd8s=;
        b=n2rLTodsFLRELLgAuuc8iTQgzX1rWLAEY3lQMZ0aez2Ddr8EA8COdeOc5GTa5zzi4A
         bNQQreKSAbKYh2vvPDcdyOQBlWw8PT0aSQFjpUF40UhNlUj4mJ9u2KGfs4/pB8c0Oy6E
         b7npePFYvqLeuk+3VegaLhOWTIxgnzgks2QQYfDxElv/HDEywPrFTW7BNNHhQiT6v3RC
         gWvRDRd1w1qRSdeKa6pIat4vpyWN6Rz08F8wPqNV/8Q0o6rA5f8GpsU4Yqd8x5lbQctR
         ke2qnxISdmpqvzDM3pWzH4OihEW92hirXb+Mkt9xtPwG1wq04WLKs8RjqC7AbiT1IlV/
         BT7w==
X-Gm-Message-State: APjAAAVSPylm1bjpvNr6aaHO20MgOp84ezJXoJNcz3nmPpLupzhTgOlb
        eE3+574xFKrkOdFaGgB2eCpWQg==
X-Google-Smtp-Source: APXvYqwRM3uOue8sdkJXKA0j0BlH3YC2gCanRwb3iFVBEmOi2tgQReY6Xpln4M8dnVP9lPsAWlOk+A==
X-Received: by 2002:a50:eb93:: with SMTP id y19mr3762407edr.94.1569506125053;
        Thu, 26 Sep 2019 06:55:25 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m18sm250017ejq.72.2019.09.26.06.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 06:55:24 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 68168101CFB; Thu, 26 Sep 2019 16:55:27 +0300 (+03)
Date:   Thu, 26 Sep 2019 16:55:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] mm: Use vm_fault error code directly
Message-ID: <20190926135527.htzehar7j5uv6nsu@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-2-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:00PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use VM_FAULT_OOM instead of indirecting through vmf_error(-ENOMEM).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
