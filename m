Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59521C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C66C22CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="CJP7CTbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfHTCYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:24:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42296 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfHTCYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:24:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id j7so3621168ota.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 19:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBHOOAIpl+BVp9v5InU9pcm2gaJbl2xEJrSQBhETvYs=;
        b=CJP7CTbTPhZR+phUQnNkcTI/KNVWXl0SEGDWRt6JUQ8QXyB0Ee6aK8B6XXfkWH2D2X
         FIJQnLB5WFJV/CEJA4E/Iu2JcnEey/xpN9i0OeyUTPYwhZxbAzvnq886azOWzP46T02n
         J0qfxbD6Inesz2YwKORlypUR85mXvGdZkPZcPl3EgMqeUoUQnZFm2pg5O2htZW/EMhMb
         OVWEuyEOYV90TI4cJ+wa2Dqu+Bf0RQBah7CyzDuL9yw3lUe7T3OCIgBtrdE7pwdiXtCZ
         H2FU67p4R9TZSCDOstBQu9JQ34ERrQYLwlBW2NRSBK/zEmI9YmMsyTlL87m83uQrBx2t
         brrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBHOOAIpl+BVp9v5InU9pcm2gaJbl2xEJrSQBhETvYs=;
        b=V8ov2bZgMs9EHh4ZI/cQCLtPaILxlIK9L3JtH9UpL8ApvoFGJLhZFH2DU9Rwh6p548
         xmUnsdwkMaezVdat2zhqbWVztsyuli1954X6MrWBk+DLeMR9yF0nWrMo6NTwAlLyh7kT
         Nu29wmvnWPRraVMhJYMxVixiTQjqBjxNqviXLPDzb8Uzbd6c9mzhEOOIcp7lC8491heI
         P9KN0qgvEGPl+d0jesxh4h1V1oX3zm/I8SZPIRmb91XCIohD7gb2h1Sr/tUiawgrsaZm
         bWuG4agXZqy9OFmSph4d9F11R+pzIHeHmMhlspl4NyeGM+PYDRqOLpSniwWUooXyRNSE
         SWAA==
X-Gm-Message-State: APjAAAWPoaBTXB+5W0u7y2Ygk7ol5LSBYInKvYDSFxYyyYVfIc7NvPEl
        sFVpJRVR4tbJl1Zj/1MofL2NJVcxNB7MKAlwGwPEuw==
X-Google-Smtp-Source: APXvYqyNozQmsW6VwbwYlZxgLUM3eNQ/tnZ1XVJVsGuQWe47WPqdIvt2eUClmdyGd3c5FW1ejTh7V/zH1JQI72JUIu0=
X-Received: by 2002:a05:6830:458:: with SMTP id d24mr19989967otc.126.1566267889874;
 Mon, 19 Aug 2019 19:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de> <20190818090557.17853-5-hch@lst.de>
In-Reply-To: <20190818090557.17853-5-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 19 Aug 2019 19:24:39 -0700
Message-ID: <CAPcyv4iy=RGu87Px_6Pr3f8yx5tH1hm58M85n74zYbbUTA299Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] memremap: provide a not device managed memremap_pages
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 2:12 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The kvmppc ultravisor code wants a device private memory pool that is
> system wide and not attached to a device.  Instead of faking up one
> provide a low-level memremap_pages for it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
