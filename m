Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892B7C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C405214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="a4pCvoEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfIPIjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:39:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43751 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfIPIjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:39:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id r9so3549155edl.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hwAolnsZsEE90RFUUFXiPfKI8w9qoMR+b3uin2XlILY=;
        b=a4pCvoEVsOfSuq7jjr5OIe0A/DVYNN0JDDPlmDLEICk17UysrGPoPCdnEP2ZOO8TeT
         4yq8w8LXsZUAvE3O87UQLIk769o0/NtRLi7+RSZYa0bsUIXFwba4iBRWiZPeBoVD/WRY
         hxGyCz+HHWxe635XqQRGqJyzmwoIuQ1b4XcbHckEb78I7YYBjzPSWMxkSf1KINW3wOLm
         EhhQsXngRx9q2mhqF280g4deG+XKdWdnTr1j8s9mleazbR7zq0Ixr8zidRv2Ww3OG2HX
         r4qsyI9Zv51wyaCboJZBEkUCL2O3D5H5ruy6Nnib+6tqpGMFzqfJMqXvmQSIfLP+aiuR
         eplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hwAolnsZsEE90RFUUFXiPfKI8w9qoMR+b3uin2XlILY=;
        b=QaFBnRKO82+YkkCyC5DNbZmHrkYrWQRQvbyXLDNqSjUloq40PgyAWGz1g669qzufKO
         28yrljywsIPt60PPjWslzElBUm7B1zyLDggb69JgcErpdHx35i7QEgtPR4eGOLYaY9OO
         bpcdhziSR6M2CTS6ShLdyp03dnxwfaqkwHveBqO5LlB0LwERr6jhaPXig7K316bpzNv4
         gZpD5vPMTrno68Jp7XjRDvuwTMjGpKQdQPRORSz9viv7pW7RZ1t1Kj5vJrJYa4t2B+XK
         +UOlYbP9T1MVHhQvz33K1a/Wp5Y7eyDUzgddu2YTSriXhUQbApmubycDQtjIWqG+kYkj
         ikrA==
X-Gm-Message-State: APjAAAV3d43RBjcYfiCJBOE9KlxdDmCDl/thv7gwzXGV+T8TKkLKjvt/
        wqV+uC8qgLh7T9mfrUwCZcLP/g==
X-Google-Smtp-Source: APXvYqyWuH/epvBa+jvhYtrHY/HCJV7DVodJ2Xobx+58rAjl0Fp8x8RmkUsyrJsesL5f6AC8vSqwqg==
X-Received: by 2002:a17:906:1197:: with SMTP id n23mr51749838eja.122.1568623162322;
        Mon, 16 Sep 2019 01:39:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v8sm1900279edl.74.2019.09.16.01.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 01:39:21 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 432F1104174; Mon, 16 Sep 2019 11:39:23 +0300 (+03)
Date:   Mon, 16 Sep 2019 11:39:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: clean up validate_slab()
Message-ID: <20190916083923.u45azgtdvaaxo2w3@box.shutemov.name>
References: <20190912023111.219636-1-yuzhao@google.com>
 <20190914000743.182739-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914000743.182739-1-yuzhao@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 06:07:42PM -0600, Yu Zhao wrote:
> The function doesn't need to return any value, and the check can be
> done in one pass.
> 
> There is a behavior change: before the patch, we stop at the first
> invalid free object; after the patch, we stop at the first invalid
> object, free or in use. This shouldn't matter because the original
> behavior isn't intended anyway.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
