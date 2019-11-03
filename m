Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C29CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D8220848
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Khdriynl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfKCQXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 11:23:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46819 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfKCQXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 11:23:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id f19so9651480pgn.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 08:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j2lriok88KfgLjsrKyDIkNuRgg5g4CfcKHQtO8a84EQ=;
        b=KhdriynlfZww++sMZQBTRRKI6N29ArSpOXaWi7TpJOjUSWEbvKWqVKwVUUWH6jZI2a
         eT6mOCzL4LmE1FOUAdbruEhjwHIqnbj+c6eZcFyhO7nbORLMMMKonyFzDSSaWYpdjfD2
         au4dpF/TBnnwyOCh/nAB1aXfUk7yc+ST1x8hmb0rNXqrnc5HG462C/SnYew/hyRecDXc
         2qCRU2dY+Bc0FiSfFT1zrFE5qSTJZjiTYXm6fbwegNUno1czU/j8/tyJbICHmAUF8kGE
         y43ABDKWq/ffzZPzjwe5NKrArlLRnhMaMMpBx7pcB8G8JJhb/6lD2iy9oWj3FMfXbcf5
         0CGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j2lriok88KfgLjsrKyDIkNuRgg5g4CfcKHQtO8a84EQ=;
        b=YXdJascb90dZ3BbcvKIU9qJJzZHyWGsmN5A/jxgL+F96oZ9YX9RzZLL0Wn/aVeiXKw
         0Qj0lR46uq7hKSgZyD3TrCyeWV2TlsDqfrP3tZr+Po6Bm+tmKTJxKcPBtjwzwJjlQH0w
         7upKXtcjoM7egWh1vtde2LjG120K7W9TSWGuw4h3E1brIcFS/4S+Z4jagjfrLJMyfWtC
         xijeCKctCVPEXCoc8z4UUb7d7GPAUQa1dtSjHLCBXe0M2CAe3Hu4ZklgrELZrc9ZUFXQ
         P8/4/6v+NARrajP6M1E05SrzJSxE0sSr3sjzl3nky5j5x6m7Kof7DnGpzft9EEEgxXre
         sRWw==
X-Gm-Message-State: APjAAAVSAk7TUqFRKyxQj+YbvJY5sId6sbdPX470649zp6cayVn4VYLF
        Bw1mywryROVmbEqzz4F/AdFCfQ==
X-Google-Smtp-Source: APXvYqz81nCadr0nvlcvinUftQYqG2U7r9qf+Xl6Gv5aBBWqLWBX3MTzoQergdMULIPYHR5qaNc/kA==
X-Received: by 2002:a63:3812:: with SMTP id f18mr25459581pga.320.1572798182825;
        Sun, 03 Nov 2019 08:23:02 -0800 (PST)
Received: from localhost ([66.167.121.235])
        by smtp.gmail.com with ESMTPSA id p7sm15612699pjp.4.2019.11.03.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 08:23:02 -0800 (PST)
Date:   Sun, 3 Nov 2019 08:22:58 -0800
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
Subject: Re: [PATCH v14 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
Message-ID: <20191103162258.GA116247@google.com>
References: <20191101214238.78015-1-john.stultz@linaro.org>
 <20191101214238.78015-5-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101214238.78015-5-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 09:42:37PM +0000, John Stultz wrote:
> This adds a CMA heap, which allows userspace to allocate
> a dma-buf of contiguous memory out of a CMA region.
> 
> This code is an evolution of the Android ION implementation, so
> thanks to its original author and maintainters:
>   Benjamin Gaignard, Laura Abbott, and others!
> 
> NOTE: This patch only adds the default CMA heap. We will enable
> selectively adding other CMA memory regions to the dmabuf heaps
> interface with a later patch (which requires a dt binding)
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
