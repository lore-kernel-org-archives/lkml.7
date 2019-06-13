Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60068C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6D22147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="HiQM8Oj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfFMUP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:15:26 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34211 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfFMUP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:15:26 -0400
Received: by mail-oi1-f196.google.com with SMTP id j184so332303oih.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 13:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYvi3JENt5xjT7/oQoCCDRRyhuGQKrPeHYLl1e4tUxo=;
        b=HiQM8Oj8L+VS1a8Hidw0xr9iYYaQmKDaapqQQLP3xBSAjW2G7zF8GCiMqjGr/ym+Mo
         M+OqlxjvRB4nsYJvbsbx5Z3ifuAo0JozSHiAbNq39t8D2waMsSabG6FDy40WGT4oYy8V
         L96EPmLmkBZ66RnBr04w7xeY6utWIJLm5CrypM9lYrEcqa9F/Z5nPa4IShCeMmTv0t0L
         gS2NRGRi4wYn5eA9ZuBqSXqoz8gXypGTSbll9Wp2Y8UNYHgTyBR1qyLVx2ig9t9lcYmD
         HVaPJZLwJOeNsVJ9c9ozc803Mh/zRF+OxcMsrpFkoEYk0fk+301QRIAXIyrgvI3K0bkW
         VbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYvi3JENt5xjT7/oQoCCDRRyhuGQKrPeHYLl1e4tUxo=;
        b=QcfmivkjoAFpN5Lwjil31iv3BwIUaFjW4P3dH+WzHyEboE5PZoacCIOnodzpnpKx+/
         Z8zLWCIdM88S/lociXNuTUYS0oQJch7OuFIYc4adz6v41OX6eeNEbOBs9Snjn+66tk34
         jmD3tTJpmhubBI1SF8gpNe2s/c5BbumaxAXV71262XMpGfcP6ufzG8cym0krfqMFQs03
         A+JmJwkoG8kk/9Ix8r+ZN7MKeh60+hQD7UT31igaxjnQKt84EWPBHbb6+RLFZTnCVgNa
         U2CKd1QSTetT4Wfu9/zLLdX6C/0NnF79anlke9FP5fD8x8+4aoEzYsh9pPo2QbyQjqUS
         uNQA==
X-Gm-Message-State: APjAAAXdmhrjPNcLvGbMfNgLi25PSzedFsKM+y2ysRNkEdb6fiGXYLan
        AKPfQ7S7A3emjegY2XbTkNrngWNkka01mzwFJZX/JQ==
X-Google-Smtp-Source: APXvYqyS333Lp+D4vjCDNGXf2txUSus++eUTfldGM7ZmElD6Qov2BJs1+/5zSo9qFUO6PniS7TXRoikGBTwqET2Ahjo=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr4014371oih.73.1560456925540;
 Thu, 13 Jun 2019 13:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-9-hch@lst.de>
 <d9e24f8e-986d-e7b8-cf1d-9344ba51719e@deltatee.com>
In-Reply-To: <d9e24f8e-986d-e7b8-cf1d-9344ba51719e@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Jun 2019 13:15:14 -0700
Message-ID: <CAPcyv4gApj=5eYCVSLidDJqF2V1YZiqUht1P26mSzUOjW-ykqA@mail.gmail.com>
Subject: Re: [PATCH 08/22] memremap: pass a struct dev_pagemap to ->kill
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 1:12 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-06-13 3:43 a.m., Christoph Hellwig wrote:
> > Passing the actual typed structure leads to more understandable code
> > vs the actual references.
>
> Ha, ok, I originally suggested this to Dan when he introduced the
> callback[1].
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reported-by: Logan Gunthorpe <logang@deltatee.com> :)


>
> Logan
>
> [1]
> https://lore.kernel.org/lkml/8f0cae82-130f-8a64-cfbd-fda5fd76bb79@deltatee.com/T/#u
>
