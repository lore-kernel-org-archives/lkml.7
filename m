Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33929C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5BD2199C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cCibAOf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfGWFcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 01:32:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39518 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfGWFcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:32:16 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so36754618otq.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 22:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfVOBTkGgWLnADqNb7WUL1YdExalu2RGHdRuN86uruA=;
        b=cCibAOf/Js0bFf/rOoWSrEyv9y1+LYPfRTwhuC16wpTr2xqyeheiY8joolznjwpFlP
         EbgrMxhMTsMUIefhUgH/OmAXMe6s+jzC0XdqdQeOkk1pUiz/pGhkFAjClaN8uIVhXPF3
         jkqht7TWonRqMhxwIj84p7o2qG7aDmnoSj33hNmiZPmSjKmXJivzBSIab1oXHzDJCYGq
         yUXZreSZ42kaDuP8Ikp/IDHhRmJfO+C47QlO7Af9mva8zDj5lJGj3eyQvC+zwjof36U+
         r9aYfq+OT3HnG5wU/ZC/A6jMWzVUD1dWXhrjMRMOkfkASGysOpiw7bpJIXU1mBVC7XJt
         Vcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfVOBTkGgWLnADqNb7WUL1YdExalu2RGHdRuN86uruA=;
        b=Z7IEzMyt3QuQWvMpuMInN0Zv00WagC+VR3vU0hhCma6fYgFmvUN+kMlRJmP8Vd32o6
         d1zx6wjXX4ZQwpjVaAp6yrSZ512PfKSEp7YsjRV6YrmcCwbZT8FyX23ZGK2xTSdCuu4T
         LyQRWrVAXkkEaK2S3q6y6PIEkUQF3mynvnKI1Y9CNJ1AtZ7BFH0FOMuFibzs27R7AZ7o
         K8ezbDdPyBK7F2rLORM/77pw47l3CredNeq5yThkUOfeDvbXpK4zQp5R2C3/L6Zfc4iw
         nLUA/j2xQqQy/6Fd0h8jb3zdqldn71iEDUVONAkTN5W8P9GVD9Qcr3DbzAgoI1gebjmz
         rDiQ==
X-Gm-Message-State: APjAAAXviHqhOZcHJ+o9z8xPULyIwq8XcTx5co9C3Aii3FGAfWFndu2P
        HHnAFG8NQreA52ske6MB3HrLANz5gpig/ncAdHC6fA==
X-Google-Smtp-Source: APXvYqyjt2ypLm0Iyn93tghYH78tRb7uLgwNWDeXJ9GGqsHKMUS9oIUtJUlcsPdUhpTaqHwb8X/qdw/MGcgyJyksvSU=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr21255488otn.247.1563859934961;
 Mon, 22 Jul 2019 22:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190722094143.18387-1-hch@lst.de>
In-Reply-To: <20190722094143.18387-1-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Jul 2019 22:32:03 -0700
Message-ID: <CAPcyv4j7wPPBbcPDRGn=L8K-HQCZQbM0+HiXJX_F+1Uway+qXA@mail.gmail.com>
Subject: Re: [PATCH] memremap: move from kernel/ to mm/
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 2:42 AM Christoph Hellwig <hch@lst.de> wrote:
>
> memremap.c implements MM functionality for ZONE_DEVICE, so it really
> should be in the mm/ directory, not the kernel/ one.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Dan Williams <dan.j.williams@intel.com>
