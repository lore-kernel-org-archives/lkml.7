Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2AEC28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97547256BC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Z2k6P15B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfE3MU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:20:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43576 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfE3MU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:20:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so8823377edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 05:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YT3ORHa/ZvJBb9khTyipcwzY8aPEUTPQ5f0pg4jxr5Y=;
        b=Z2k6P15BL06hicotC2dSnEhV4GaouaYG/VP+GJ3fGnAhF6at7jpkvpP/YG0JsS3EXO
         /WmsTJLB5yROTZTpRxkMVP5tsNLz1NTj4KHZjtrEY3hwmzJ0k+hnd8h5BPu5s5utlIaY
         4GgG5pQr07iKIMbAzXkcfrvYvubSvkZzB0y/Tgyo+teWVipAtuwqkcQ0mATGh2pId31v
         FlOjjKi7NJhawjq3cI2k0UcyG6Uo1GdWhl0a6KGpV9MNvka+4sAXH206O2kwt8JdXvdP
         xVnDd4ry5jN/dyzJLCyT7PseowF6bzOXZRvj0IjQMxxiKs8NV0ibOIfa+4TYyVwTHni2
         V63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YT3ORHa/ZvJBb9khTyipcwzY8aPEUTPQ5f0pg4jxr5Y=;
        b=X/FIWCfYzOvvRf3CwkQeK05x+eYeGQhihyWbDc87whotsjyaxJWbXCtg16Pz2TgWLR
         jOyIaWoDz4xr1rCdM1sZoG+Fb1zLnDoySX6Yfi7DPjrCWfQflST66HmUuCRu8/2i/tgo
         9RbrvRTb6kSSwMsPll3ehALpArDYZIqnECaLu9h1BC4vgVtAlVVNyFkJVq7Bsr4pMDwR
         Xve1DEqoxLqh9onhGO0eR4PDAzJrOwVjtjqnhgz4Rj5CgEd1PyrlQriOW2jP0e9oUjP1
         AlSwVnOPyGGw5sLTfAiZHLiSg3Cgj0LK0g/UwHGIvEAOdecFk47x3xxds6eGgpz44XNv
         LCdg==
X-Gm-Message-State: APjAAAU4fDqfWdMJJilvGkfAOabQCXeQ1VrDJHb8p877o4e/lt5uy+q9
        rOyFutwJ7b/k27vL1KGUvqKscg==
X-Google-Smtp-Source: APXvYqz1QMEcICzGq1904VHz2gHy6zj21AwriFZbwIfNLZqfdA6Rb2hqgd+xEtLtBupnaHP/sjhZpw==
X-Received: by 2002:a17:906:63c1:: with SMTP id u1mr3160741ejk.173.1559218857620;
        Thu, 30 May 2019 05:20:57 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d11sm682334eda.45.2019.05.30.05.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 05:20:56 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 975811041ED; Thu, 30 May 2019 15:20:55 +0300 (+03)
Date:   Thu, 30 May 2019 15:20:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, namit@vmware.com,
        peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, chad.mynhier@oracle.com,
        mike.kravetz@oracle.com
Subject: Re: [PATCH uprobe, thp 4/4] uprobe: collapse THP pmd after removing
 all uprobes
Message-ID: <20190530122055.xzlbo3wfpqtmo2fw@box>
References: <20190529212049.2413886-1-songliubraving@fb.com>
 <20190529212049.2413886-5-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529212049.2413886-5-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 02:20:49PM -0700, Song Liu wrote:
> After all uprobes are removed from the huge page (with PTE pgtable), it
> is possible to collapse the pmd and benefit from THP again. This patch
> does the collapse.

I don't think it's right way to go. We should deferred it to khugepaged.
We need to teach khugepaged to deal with PTE-mapped compound page.
And uprobe should only kick khugepaged for a VMA. Maybe synchronously.

-- 
 Kirill A. Shutemov
