Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E856AC31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C071520679
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijVry35i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfFPQ0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 12:26:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39762 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfFPQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:26:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id p24so4796737lfo.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S2vKWdD0glGLsN86+msjXTlKQT0jYdW+WcffeWNC3YE=;
        b=ijVry35ioGnqrLNPwg7Qdc3soSdUviCs43Ws+b7WZQpWZkrkjFpcNPtaadd05zyV27
         eye1hNuVhPV0MdxY7n2cpTXpeBkrfTNXznuKI56iCV2VGMgcpznyH5UW3813WhJToN6a
         zRVPg/Xc383rOwzNidEZMCeLIjPRu2BSu1gEuPuaOLuVC14it8GWaZjxANZYjVq6SCiM
         yJ68jKLTUFLa6LKVMJLyZ6zGrg+qG/qlLsv29fZuMKd+2n37E5swqhwh4p0U8pcRXBx4
         3qSawWU1Gj44vHvR4YtddyQ5m0ky31amOC/9CeXrdZFVMcrSZDBbxp8suFhXjS68oxfX
         GngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S2vKWdD0glGLsN86+msjXTlKQT0jYdW+WcffeWNC3YE=;
        b=cRMFE02lJQ7EMkLejZ9VNmKFV2K+t3WHUzT6yptMKNd8iOcM3vu4drbWVE7F37aj3k
         6gXvL0u6K+FT0Z+LA1nTrNuOq4t5ttdcfwPjQMo1ocAuYwWnLpDD5T2Ku4zPwoyJCJp9
         DEAFUHmWSRAIueQocrwCX3WjKyWxs35YT+Opae02mt8Yw3JBZG1nTrV4N7w6U5BDd2h0
         7sslZoqDNYJJGUZWeANeqYDf+OKBdtSKZt9QWu+tnxE/F0kk33shb9lIzRkn6UpwZS4u
         VTToulUfBgtxG64c4lgjlvN2Wv9T5w3oFa0xbFKTR7sD7seoJjjpGqJORXex3MtScomz
         6kvQ==
X-Gm-Message-State: APjAAAU1tPl3YHU6JXO1Uz61TaiDHImofWYtA/vdERtmFAH+3XSPtPAU
        ZBto3HJts2q4YfCIpPCHOmQ=
X-Google-Smtp-Source: APXvYqwHsK9HmYkoBRaV5mX53vBWNhfqHOKQbpGSHLmmMgtNh9X4TDiaBlD50tp2dD18uvyneP0SXw==
X-Received: by 2002:ac2:528e:: with SMTP id q14mr24437296lfm.17.1560702407939;
        Sun, 16 Jun 2019 09:26:47 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id y12sm1482549lfy.36.2019.06.16.09.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Jun 2019 09:26:47 -0700 (PDT)
Date:   Sun, 16 Jun 2019 19:26:45 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v7 06/10] mm: don't check the dying flag on kmem_cache
 creation
Message-ID: <20190616162645.rbcjhqjceuuxgvgr@esperanza>
References: <20190611231813.3148843-1-guro@fb.com>
 <20190611231813.3148843-7-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611231813.3148843-7-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:18:09PM -0700, Roman Gushchin wrote:
> There is no point in checking the root_cache->memcg_params.dying
> flag on kmem_cache creation path. New allocations shouldn't be
> performed using a dead root kmem_cache, so no new memcg kmem_cache
> creation can be scheduled after the flag is set. And if it was
> scheduled before, flush_memcg_workqueue() will wait for it anyway.
> 
> So let's drop this check to simplify the code.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
