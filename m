Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6291C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB6220685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="htc8vYEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfDXHWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:22:31 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:46298 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfDXHWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:22:31 -0400
Received: by mail-qk1-f178.google.com with SMTP id w73so8058433qkb.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 00:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QPj3RrJhF0a00h3VE9qVOc+yEBckW0c77016N9YAvt0=;
        b=htc8vYEryCUyzFy11pcvpYMKyTe/di+s5c1jIdni7ygAIGmGYaX/PxV+UtK60l88JY
         5ZW6wTPNEPD6PKJ/ZVX277DSHUd1DnB6Fpd2xFpxjy7+yIbduMbS8butVK8U8gUfRfxS
         ZlepyKsnjymXVk/lL+u1PZLdRp5HqwpEqZ9briTJhHMQvnLwm3HYSLfVGVgIlwU2CuyZ
         t/r6IY5Xg03B+i8iGPtVjc9GOOCfoapwWcxFbOIrCDtpQft3nQMxSVb70mHub7EUpUWb
         3y6CikmQjTb8KXFXf8N9cCZEJlYyEYrVNqydn7VIMxqVEAC8qXeIM6ypcW4DjFNSiKNk
         P0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QPj3RrJhF0a00h3VE9qVOc+yEBckW0c77016N9YAvt0=;
        b=ORxq/6bHvZHKjEKHvLqB8xTe9jp6AQZaOi1P9Db2snLismE+QzfwEtW5NXEaSsOoMB
         AUbMASdT9GfXwlZyRNhwpuzx6dmPbCDy0v0oHrWOTK1MUCvo1BCbxj2AOY50Lbizq/5S
         dEEGAkzL3AG36ESuHclt/WFV2BBGdJJLHNz7TJ7s55ybHWqLLbJ85HMRYtnKfu2hUPWJ
         2UsWBW4BcKMYgDsJQjwkkqibqKUGWdmbrAqRywKErlTSd6H+rwrglTOyksYjKdTL0gkA
         d18YFe+tzYSfZNd+k/76SFBEDunyDMrsBulrLY74ARKwhR7BlKlMaxUaW9mHDHSL83Fn
         V1Yw==
X-Gm-Message-State: APjAAAWSoJYJVmbtwTe80Zg6sxOg4j+YoDe+0QhvSBvMs+2EBJJ/iCGt
        gmMywAtj7joiNjx5ack+RjvnDWcDVlTV9t1gUqK1ydo58Yw=
X-Google-Smtp-Source: APXvYqzZGPijU0HNtEavhlsB7B0Y0/Yhy2YCNQY9VlZwNt5txtoqZ9AcB66DKjLvIdjeNL6DBqw1H6aKpQnWUgQ83Sw=
X-Received: by 2002:a05:620a:12bc:: with SMTP id x28mr22764175qki.329.1556090550012;
 Wed, 24 Apr 2019 00:22:30 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 24 Apr 2019 15:22:18 +0800
Message-ID: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
Subject: sg_dma_page_iter offset & length considerations
To:     jgg@mellanox.com, imre.deak@intel.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org
Cc:     Oleksij Rempel <linux@rempel-privat.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In drivers/mmc/alcor.c we're working with a MMC controller which
supports DMA transfers split up into page-sized chunks. A DMA transfer
consists of multiple pages, after each page is transferred there is an
interrupt so that the driver can program the DMA address of the next
page in the sequence. All pages must be complete in length, only the
last one can be a partial transfer.

I thought that the sg_dma_page_iter API looked like a great fit here:
the driver can accept any old sglist, and then use this new API to
collapse it into a list of pages that can be easily iterated over, and
fed to the hardware one at a time.

But looking closer I think I may have made some bad assumptions, and
I'm left with some fundamental questions about this API.

Specifically I can see userspace generates requests which present a
sglist such as:
 - first entry with offset=1536 length=2560
 - 7 entries with offset=0 length=4096
 - last entry with offset=0 length=1536

I gather that dma_map_sg() will take care off the offsets, i.e. any
physical address I get with sg_page_iter_dma_address() will already
have the offset applied, so I don't have to worry about tracking that.

But what about the length? For every page returned by the iterator, I
can't assume that I am being asked to work with the full page, right?
Such as the first and last page in the above example. I need to go
back to the sglist to check the corresponding length variable, and
having to go back to check the sglist seems to defeat the convenience
of having the sglist collapsed into a list of pages by the iterator.

Any comments?

Thanks
Daniel
