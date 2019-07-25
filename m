Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BDFC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B968321951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq+jJYRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfGYGqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:46:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35210 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYGqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:46:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so43596968wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 23:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ISwW/FPdFOwMA+f1KXsWT0wyXaZu+d7Y2bgLdC1RZjY=;
        b=Jq+jJYRzfYzjtj7fKK0dtSv3ZF/A18/38UcphRm/yWf5nVbWUOLOrO4VS97m49N5SA
         XirL5G0G+/iKpELlfYaYk81exRKefcgnzTvDMzUdsRSEH8cYAB8YXERggG2w24UFC2GA
         XlllfPfL43oFmbHrq2Q+NOwk5OqdPZHMjUTFx7VxeMHZY5qCAQaCC4GGopeFZ3DcQlzt
         tz5Ox5LXUqYY4bAyhqyspuD78R+vCHn1q9IXPHFJSxrYRdFQt5M414PPQ5xhOk6vUUfN
         aMnUnvH9jrNR6ZKheUTfcEfvKZUqKQjzRrYm4CMNQXOpNdfIHq8Uyo9RU1IxpFxK3ovL
         nJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ISwW/FPdFOwMA+f1KXsWT0wyXaZu+d7Y2bgLdC1RZjY=;
        b=WcrXr6AeNkBkz+hVjXMTjLLCHtajpseqTJJnMMP0IqfBAegdtBWAcyTDNAfU+hFO2d
         tA1GZ1JrburnJ1fdJaGI61/zvmxf62aoLvvXdo5MWqIGKIp3nfP+104DwdpsN/6lhV4i
         9pVnhBZAoS6h5gVmlIFiaXTFxdv+91Rw0BqIRo+W/D+3ti9+6Lub+dT9Tds7CtsuvkUO
         Ag2wa2/YiztSgdpCkrYvAmIjpdDfxQI67UkyYYpAHhkQbSg0u2Sm8K5Kf8pNATswjaFJ
         xMxzeD7azj64ayYMAPyINgKbWZ7J8tuCXNyGhUpsGGZWRPDwUGzcbds2R3DjKcSHc9Ex
         UeQA==
X-Gm-Message-State: APjAAAXznEpHAtgqzzFqO2/mBvvKbG3ht55x8KaZz4bKKGVwN2c+wYoo
        iQWrQBPbaBrhOh6x+TfDSQ==
X-Google-Smtp-Source: APXvYqx9qbRIvepznXoOQPiyozZryEUn4nKZyf68iBqkNSV/ji1vnWNYQ+l+Lz/JCf7w/f41c8ClMQ==
X-Received: by 2002:a1c:d107:: with SMTP id i7mr81850351wmg.92.1564037162140;
        Wed, 24 Jul 2019 23:46:02 -0700 (PDT)
Received: from avx2 ([46.53.252.231])
        by smtp.gmail.com with ESMTPSA id a64sm47009192wmf.1.2019.07.24.23.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 23:46:01 -0700 (PDT)
Date:   Thu, 25 Jul 2019 09:45:59 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hch@lst.de" <hch@lst.de>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH 1/2] /proc/kpageflags: prevent an integer overflow in
 stable_page_flags()
Message-ID: <20190725064559.GA14323@avx2>
References: <20190725023100.31141-1-t-fukasawa@vx.jp.nec.com>
 <20190725023100.31141-2-t-fukasawa@vx.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725023100.31141-2-t-fukasawa@vx.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 02:31:16AM +0000, Toshiki Fukasawa wrote:
> stable_page_flags() returns kpageflags info in u64, but it uses
> "1 << KPF_*" internally which is considered as int. This type mismatch
> causes no visible problem now, but it will if you set bit 32 or more as
> done in a subsequent patch. So use BIT_ULL in order to avoid future
> overflow issues.

> -		return 1 << KPF_NOPAGE;
> +		return BIT_ULL(KPF_NOPAGE);

This won't happen until bit 31 is used and all the flags are within int
currently and stable(!), so the problem doesn't exist for them.

Overflow implies some page flags are 64-bit only, which hopefully won't
happen.
