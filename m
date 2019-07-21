Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA4FC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 16:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BABD2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563728305;
	bh=Wn7DAEN4zfCf3rwdVvg3JF4XxDH5IZ+mzUu5qoI3Xsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HG13NYvaH9pBdPJMLeTTupr+CM/hpW7duLbIsdNQGHLLOT85x7w726F9DhvLlmiY9
	 pgFZVZoYZMmfNsXB7WCfYlml9nUtJwkJbn+Uvl3TNWVK1+x1eYVXcNJjxfXcij3QZl
	 JqAYG+WVJCBMVDLAdDCalbR2PgTSfdJHBOfgKU5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfGUQ6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 12:58:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35421 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfGUQ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 12:58:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id p197so24871451lfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JIuU92ucT6bQTXAcxJLrdNS8BLR+pSqNO48JgC8/dJw=;
        b=JWhLyO68Hrib0GO70cuR1VtthguReGEJ9R2mWF5MJMmuYYlNXh0tejOJPwrZW3bQ+y
         oCIboqjxklsU2/gyMVnv8F9oSF6QM2yijtblZ5RueBaDIQOHmT2bW8TxAQH19XPN1G/a
         h1YfAYY2AemzRecXuSFS2X4NUgGnNqLq2BwWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIuU92ucT6bQTXAcxJLrdNS8BLR+pSqNO48JgC8/dJw=;
        b=saKp33lKfR0EYQb4FI7ugxKO+d1ieVTxZYJQJoSi93u7vojaI4ZZdJ4VcrFjmFyTU3
         AxmqYAVIMm3XwTiCIcCphMP1QRr97pbnIUKZpHTQEGFTORVFFD98ajOHkQuMOnts8wuL
         hpsjiu5ce99dwCYi0yPwUhQJgfLb1uODPv4PplMYEhrfw14rHxSAjCcCh7nMFEOgcwI4
         Bgdmz3L07Ak3y6VUXoUNqkUwNG2xMJFxoIDcoa1093Vfh0Z9ULhXM93eO6KqkmcF5wz4
         AD7xMmhRbAfZPcQlRQ1uI/2RcwzAeSRLXnyRzuNZoQoKVT/FSXZTNxRZu7uxTGJqB4rr
         NlsA==
X-Gm-Message-State: APjAAAX0BdnMDpD1MpItyfL+44w4D2wMDsX+/MWyCx/VErOBBswG6+yH
        wyLfJ0L0xfUc5zDdF87DLLh2sz+4f+M=
X-Google-Smtp-Source: APXvYqzLoTVAr/wk1JN6LL02tb8ifFB/6l5mtYtARW/NGargMx8VxrTTku4xxuug6UCB033ZNASkJA==
X-Received: by 2002:a19:f603:: with SMTP id x3mr26568682lfe.125.1563728301199;
        Sun, 21 Jul 2019 09:58:21 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 11sm7066105ljc.66.2019.07.21.09.58.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 09:58:20 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id c9so24861011lfh.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 09:58:20 -0700 (PDT)
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr18859096lfp.61.1563728299917;
 Sun, 21 Jul 2019 09:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <1562861865-23660-1-git-send-email-cai@lca.pw>
In-Reply-To: <1562861865-23660-1-git-send-email-cai@lca.pw>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Jul 2019 09:58:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwd9vT1h7jKMU_E4ae2QLFFH69UxcXpO3J9YqEApdUNg@mail.gmail.com>
Message-ID: <CAHk-=wgwd9vT1h7jKMU_E4ae2QLFFH69UxcXpO3J9YqEApdUNg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/amd: fix a crash in iova_magazine_free_pfns
To:     Qian Cai <cai@lca.pw>
Cc:     Joerg Roedel <jroedel@suse.de>, Christoph Hellwig <hch@lst.de>,
        iommu <iommu@lists.linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 9:18 AM Qian Cai <cai@lca.pw> wrote:
>
> The commit b3aa14f02254 ("iommu: remove the mapping_error dma_map_ops
> method") incorrectly changed the checking from dma_ops_alloc_iova() in
> map_sg() causes a crash under memory pressure as dma_ops_alloc_iova()
> never return DMA_MAPPING_ERROR on failure but 0, so the error handling
> is all wrong.

This one seems to have fallen through the cracks.

Applied directly.

Maybe it's hiding in some fixes tree that I haven't gotten a pull
request for yet?

           Linus
