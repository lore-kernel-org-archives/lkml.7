Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285AFC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0475B20844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="G2Jp6Kw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfGJR7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:59:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43872 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfGJR7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:59:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so1434988pfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ES97aFmR5L44lLqRIVOCJ8hUxBvKgXhJbYiu6/Q0/Fc=;
        b=G2Jp6Kw0GGV35fsgDKNHqJfaM2heLRlNcrWhIIyjt3IJlC+NnRqCSKz3hZP4Fu887z
         dLBsxgJdCYEXhvDJAp3WncuhblsZDmYVCC2kQkS4he/c15xnvz5aiyCqSdp9VDsJmtyl
         X4Xfx4ip5r0bjXUypnNqrUjDim4ROXbrVkV+AZoYurquMpsbvjV3UGR3mvY59J4Erd/Q
         HfxhW7ZRcsJPApUQIYhWqYnFzemVB04iMIOfP8a0p1Z57U4tObOxvtzDBBNj4fUP3H9H
         YllCevWMv7u9kprPq+Y6qJSXms6qEKoWNmdB8ooErkpLpmr/kzmE0sWEDfpRKKj3QL55
         8WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ES97aFmR5L44lLqRIVOCJ8hUxBvKgXhJbYiu6/Q0/Fc=;
        b=fplfqgt9R2hgfKAnITR4/tMF370uIK79PJvf6DQeN5+fUW28AXeEdD01hKqQmrMDsx
         Jiorf4s0onAJCKRTiStORe+ZI40bcamVm8Qi9JMUoee/RxAByVddxKUpUTwl8Z0Isebe
         4ByeRzMb9/SWXsHKfJT113hp3X7LdHFkE0Th0hF1+NINYPjIEiyum32Bdmf+SBH2/H3I
         IH6DR1BXNtz9iUsvuhiUf+dNsD/rv070oy6QdhZ7i4GIn3DatK0i2r1ewWAtf/zpdVLU
         +Mdz+AEJIWk/UsjG1k5p4QmfgBjH4+r6ojPEpQcCk56IAOBdaej1C6he1To/omNcO92Y
         f40g==
X-Gm-Message-State: APjAAAXnX1n2klwZH3stznI1MfiVtRX23bH4lJvc9aO6+rfOTxpqmK1l
        0unN5JljNW6zwEo/8CSLauo1Zw==
X-Google-Smtp-Source: APXvYqyO4Vg3ye0b1RbrpmbLDKJYF/6XJJtpfFq/5KqsBldN0dxT158xtqFfP0Z4CzvYy6JnEEB0wQ==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr38678975pgk.355.1562781548877;
        Wed, 10 Jul 2019 10:59:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5b9d])
        by smtp.gmail.com with ESMTPSA id m5sm3325435pfa.116.2019.07.10.10.59.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 10:59:08 -0700 (PDT)
Date:   Wed, 10 Jul 2019 13:59:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v9 3/6] mm,thp: stats for file backed THP
Message-ID: <20190710175905.GD11197@cmpxchg.org>
References: <20190625001246.685563-1-songliubraving@fb.com>
 <20190625001246.685563-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001246.685563-4-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:43PM -0700, Song Liu wrote:
> @@ -413,6 +413,7 @@ struct mem_size_stats {
>  	unsigned long lazyfree;
>  	unsigned long anonymous_thp;
>  	unsigned long shmem_thp;
> +	unsigned long file_thp;

This appears to be unused.

Other than that, this looks good to me. It's a bit of a shame that
it's not symmetrical with the anon THP stats, but that already
diverged on shmem pages, so not your fault... Ah well.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
