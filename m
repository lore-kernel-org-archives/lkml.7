Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2F8CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F3420848
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="iVhQ666t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfKCQTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 11:19:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34141 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfKCQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 11:19:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id e4so9685372pgs.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 08:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k2y2VEQ6EOQqU8lpzmH1pyg0O79K2DS1lBypqABiboQ=;
        b=iVhQ666t3tQ+qZCwGRKpXthAY72vAJ8S2et2Isra+GmB0R+eRKw4eBg7nMJZ2I12Nf
         9WR9tuuxUA7+zVMLNtT4wMwhrE/utRm/DR4tge4D3EBin2y3TLk88NiCqB3yaJVZ5kQa
         uag/9V99OvbuikTW97n8gJP1hGliHrqE2V99OAn6SYrth3JxRvx2PYuQIqmFKFwh2jva
         G1DsvsYdPvIGixktN9CiVc20/ELD3ofGUAVk1VmvDcXRKHvVLbRphEF7p/JXQuAX5MMj
         j+OSeC0FGNyRYGPRURN1CpRgdVYfoAY7v56W2mvhYifdOIC9lCd5ChczW2YnpZ874zq0
         Zwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k2y2VEQ6EOQqU8lpzmH1pyg0O79K2DS1lBypqABiboQ=;
        b=DVR46rIeaXBNvfi9ezQ7XaBL7xAhq9aRRCKjFJkepOIz1NfZ3s5aSr4iA+QK+RJ5ca
         rvbp6eFP4k5SFSpUe+N3DoRc75v1lkMmc3ogQrnfaieoTzG487lqfXs3a3Go2aJdKBmC
         JZ5rSVpSjVpJ+3TGS0mTuM9CAh3x5bPa3gTpjl526BANslrRlOXcqK38j4dxv7Vtmb6M
         LlUMMfmiqDrnDe5fz2jowHjlEDFG94E8GK/faB817QNVa/7qpJSc0kqiTjiM6qDjg7Ss
         l1cdl+ruTQmvtceP/Gf/RI68yGvwpKZqiJaI58HRsFEqHGAJhM2K9JnwnbTj/TojUqeS
         bl5A==
X-Gm-Message-State: APjAAAXbg2l53tIVAVZxs0lLMs6+hvImncgT1CGWoR3ExqMCOf2nakcJ
        MSa9crqZQmIEIYCNo/3HEGV+YA==
X-Google-Smtp-Source: APXvYqyDL/BMS4PI9TBgOSpGlTSmx5TlQ08Dmxa6IvrSo6XiAfT3jNCe1N1gHULjcF8YFx3kqqC37A==
X-Received: by 2002:a62:fb0f:: with SMTP id x15mr26702010pfm.59.1572797981783;
        Sun, 03 Nov 2019 08:19:41 -0800 (PST)
Received: from localhost ([66.167.121.235])
        by smtp.gmail.com with ESMTPSA id u65sm14087510pfb.35.2019.11.03.08.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 08:19:41 -0800 (PST)
Date:   Sun, 3 Nov 2019 08:19:37 -0800
From:   Sandeep Patil <sspatil@android.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v14 3/5] dma-buf: heaps: Add system heap to dmabuf heaps
Message-ID: <20191103161937.GB12805@google.com>
References: <20191101214238.78015-1-john.stultz@linaro.org>
 <20191101214238.78015-4-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101214238.78015-4-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 09:42:36PM +0000, John Stultz wrote:
> This patch adds system heap to the dma-buf heaps framework.
> 
> This allows applications to get a page-allocator backed dma-buf
> for non-contiguous memory.
> 
> This code is an evolution of the Android ION implementation, so
> thanks to its original authors and maintainters:
>   Rebecca Schultz Zavin, Colin Cross, Laura Abbott, and others!
> 
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> Acked-by: Laura Abbott <labbott@redhat.com>
> Tested-by: Ayan Kumar Halder <ayan.halder@arm.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Acked-by: Sandeep Patil <sspatil@android.com>
