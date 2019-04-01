Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D9BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946352070D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w0vnAvf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfDASKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:10:32 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39473 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbfDASKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:10:30 -0400
Received: by mail-it1-f196.google.com with SMTP id 139so598153ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AD94Jv299gZgv5RKSmdV/1oR0tYTxqdl/ZeLOJjm9es=;
        b=w0vnAvf96KINzbSgbYuGBgWgf+dfazYV8ARpvbvuOH6UL9eV3hiKRgFzdwzMZyrDu7
         Jj2Vb5nqjvDxH82qhHinYsLeeJ45bAv3QCbdnICD/yPRHKh5Z+S2gp8g9BbaL3FFnYMx
         s5dtnOeskP4K0QArhaJGta1acRrm1YiWSwCSvy1PEwrMgEszFgCPaUd7V/JUMUCj3xvr
         mbea9zfpAqQ8NaFH02enc3OtVu+/eqqYZgObPIM3OkpoCdR83rwhL5HIyeA1HDrp05wk
         DJGjW+Cl6UV/Zrb398NP+oTBWEiwUfhrZ7rOkpAXg4Xuctjpz/ZNcDvEvVitxg6yQYZJ
         ordg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AD94Jv299gZgv5RKSmdV/1oR0tYTxqdl/ZeLOJjm9es=;
        b=uiR05296FvYbTd97kSxbrJWFxLg5CZZrg8mGLLMOiLyijyY2YskUNfYVy8U63sOheo
         Ke8AXQODoHydqklyGQGZzPPslQ/NBYv6pzRiAy5/Z71at1FJ8rB/P3qbnMzDYjIF+5g7
         BIjYIk5SBKvk3Bo77K/X9fBc63hNY20EcfAAcamUmMcTCTtf4iZJ5bKcb9ZcQ7fmMqUK
         3I8hFJtqhmKN7kgcN3hJ7XIeqpk6bVMw1NJHzsE2aENWdQITqd47gErK7FgUBV+H3YAf
         LBP9mwXrsPorEF0RHLOGgDdZM18UvEsCwHNlRXGGE3KCRbWKlCJwvnelBZUT21xFiNqr
         6xbw==
X-Gm-Message-State: APjAAAWExHaUrijruNh1B7hP1FT0JxCp8PQwM1DkiON2ff0cvdlEuMVw
        zZV3jSiCeElPBbGftxFW2Vk6ryhEqiTQhQ==
X-Google-Smtp-Source: APXvYqztWXj6N8CpdRrK5NuYp4j57kuSoiHonRuoD9426+4rQd0dU1x4LNPZCdT/bQlUas/Kw1W8+Q==
X-Received: by 2002:a02:a40b:: with SMTP id c11mr34817489jal.50.1554142229351;
        Mon, 01 Apr 2019 11:10:29 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m143sm5849545itm.32.2019.04.01.11.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:10:28 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commits in the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190402050842.2db07437@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <25f6354a-8847-4610-c609-825ed4545b7b@kernel.dk>
Date:   Mon, 1 Apr 2019 12:10:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402050842.2db07437@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 12:08 PM, Stephen Rothwell wrote:
> Hi Jens,
> 
> Commits
> 
>   837d7c7005c3 ("block: enable multi-page bvec for passthrough IO")
>   df88a384baa3 ("block: pass page to xen_biovec_phys_mergeable")
> 
> are missing a Signed-off-by from their committer.

That's my silly error, I'll fix that up. Thanks for letting me know.

-- 
Jens Axboe

