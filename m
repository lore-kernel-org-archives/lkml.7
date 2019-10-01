Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C749AC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F1021A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="VxJqWe3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbfJAKqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 06:46:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32926 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfJAKqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:46:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id c4so11482671edl.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZGPIEKrHmzcXL2G1AKBp3a5BxehFh3AVUPgPe2piYK4=;
        b=VxJqWe3mdZat5nR/fSc2HvBQrlQKull+sVq32H4etLILzPBpyr6lVFrBD74sM+QgeW
         n5Vjw2s85vp2oTMun6+bsscUIJDoizbDUeXixHcVM9q5Qq/QnxLQHocmATrcpgBIpyX+
         VEGe+Q//+gTcp6vBNvc24PMoWYr7ThfKxW354YRyFC2RVKv9ekJgXFX/zWqH6JH3bJey
         55Q7uNfhxksBxLGuYWgqKqGnDdp5gnBk3K32tQQ6+LY+SPIIsRlH+L936r/G0B3NpiZS
         RKg+Y7r+YZXqFEB0U26J3mRe6fTIVy0mwUdb/zmONsyo4JIS305UBeptY38Kv4p4Sbju
         irxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZGPIEKrHmzcXL2G1AKBp3a5BxehFh3AVUPgPe2piYK4=;
        b=VUIP8sgYjkMHYzpn2VCjMB5tjCXAkqB4MXnBcJQ28Utq7WmRNH+sEP0593+b/uPD4Z
         Bcmn2GO2t4InPbDNiMNfmHtvmMZ39FQiVAxU5x6PZljRy1rVAUtZkpX6Oia8ectrZH0N
         6OxH4xtnXaUS8F44eXlo0zvwMrnzOMAJA7Kt6gJUnolazssulBg53SS7RpGynhbwJQIi
         47fnB0xdadZ694568jvPNjWVRoDHsjJxkpKsquo3ffgYGfyguz2ItlAwRsevoxt9njhV
         sSBi2ssoWbh9N+8XdUoDSFBob+OsQP6lpn1XJJGxO5zKN/CaTK9bGDpGqHSXslKcMAri
         Lynw==
X-Gm-Message-State: APjAAAXi7AjJOgkOee9MB96qkKu8xivY3/l2CHXfstITTxJ58nvz+FbV
        wHJhwbMj05NqzWA8TKz4Awmm/Q==
X-Google-Smtp-Source: APXvYqx+vdXoo3tJzcApTsLX/qaEoEohFu9FCkGIiXfq+CUARk1Jii+GqGjNaAc7FqOsJtWmP86UPQ==
X-Received: by 2002:a05:6402:32f:: with SMTP id q15mr24712672edw.143.1569926758568;
        Tue, 01 Oct 2019 03:45:58 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z20sm3051639edb.3.2019.10.01.03.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 03:45:57 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7B8AE102FB8; Tue,  1 Oct 2019 13:45:58 +0300 (+03)
Date:   Tue, 1 Oct 2019 13:45:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH 14/15] mm: Align THP mappings for non-DAX
Message-ID: <20191001104558.rdcqhjdz7frfuhca@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-15-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:13PM -0700, Matthew Wilcox wrote:
> From: William Kucharski <william.kucharski@oracle.com>
> 
> When we have the opportunity to use transparent huge pages to map a
> file, we want to follow the same rules as DAX.
> 
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/huge_memory.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index cbe7d0619439..670a1780bd2f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -563,8 +563,6 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>  
>  	if (addr)
>  		goto out;
> -	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
> -		goto out;
>  
>  	addr = __thp_get_unmapped_area(filp, len, off, flags, PMD_SIZE);
>  	if (addr)

I think you reducing ASLR without any real indication that THP is relevant
for the VMA. We need to know if any huge page allocation will be
*attempted* for the VMA or the file.

-- 
 Kirill A. Shutemov
