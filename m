Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA44C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C882082F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tB61YPUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGSFpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 01:45:33 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42177 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfGSFpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 01:45:32 -0400
Received: by mail-yb1-f194.google.com with SMTP id f195so12269343ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 22:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yk2+4Vq4KFG4mMs/65lsgjXt1lwrBOm3DDIfsr8Tq+4=;
        b=tB61YPUUXcLoU2JKUJmP9kqM/evG6BLIRj5/WW6E4NGFfWnUCDDpcaOy4OcgYkBn4d
         DK76LahHfJhT4gE/zTX8IvVpltuZtj0c+rWQUU6RzJL7TjpS9i0m1g9tpZHsVnt9pWbp
         0ZNyKnP6zn3V1yM1uU3U3WvH1Lr1r8+F9mqkkXP6sBe1Jz37gomlX2wpt/H30YKn2ck5
         MNAG8jyw8tmWimrPDBeqgBHZwUzfD5EKUZT1PrSfAvVMipzm6Gu5pAJfDmwyBY6lB1XA
         L+v49P/zSEUU9Jfvg0jWGWwTwxtnYevcvmjt1pbkb9hv0Maht83WeNvLRm4E/yS6Nn6c
         jlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yk2+4Vq4KFG4mMs/65lsgjXt1lwrBOm3DDIfsr8Tq+4=;
        b=cYeTIw4KVfzGhS731Ui1W/I0NUjkYH5T977hEobkt6IRAYFWyt4AuFN1tK7dxpzuwu
         zYYUjRuGUsi+FSLNucjMtNuOGIU+v93FosMxDvrvcKDWWb+JHorHSWAo3Ejz0QbYWa2y
         THikIxfmwCpNefCKdLVJ3WA6XuCLVMGO1AmJuxGFSDM6VChf6WcIKrj4E/CrbsUYyivB
         78I5nnxJlCG5a3KlwQJqumLHZaoOz54aKQfjVLLqfeUnBp7YFPAwXGsMrB1s3rTWkYsX
         pw0TjUnVwdEJ8I21u7zIR5iUMWg3bGVGBeo+NPwSE7KFMc9gnusHHLDmOckFf2y2snHg
         hjng==
X-Gm-Message-State: APjAAAUBEiyUpBMel+XJZOab5ALXzInQaL+okqne9m3X3QS/waAJfa3s
        8+EE74OuQrurWxQZZkfjlcj1hRlbkcHoZA0K1Rg=
X-Google-Smtp-Source: APXvYqzcfqtZ4d0w1mMAJJOcUgfPCaVC1MuNb1NA/3sDzRfZNs9FhBPeMZD2vTgyESc5G1M9T0VmGn9xvpIULvmk52o=
X-Received: by 2002:a25:b9c8:: with SMTP id y8mr7219655ybj.484.1563515131921;
 Thu, 18 Jul 2019 22:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
In-Reply-To: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
From:   Balbir Singh <bsingharora@gmail.com>
Date:   Fri, 19 Jul 2019 15:45:20 +1000
Message-ID: <CAKTCnzm25sa_6p=U-FAL9dEPdd13OJ446hqhZfHPn5zrYmAKRg@mail.gmail.com>
Subject: Re: [PATCH v3] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 3:31 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> From 8dcba2ef5b1466b023b88b4eca463b30de78d9eb Mon Sep 17 00:00:00 2001
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Fri, 19 Jul 2019 15:03:06 +1000
> Subject:
>
> Another issue with the Apple T2 based 2018 controllers seem to be
> that they blow up (and shut the machine down) if there's a tag
> collision between the IO queue and the Admin queue.
>
> My suspicion is that they use our tags for their internal tracking
> and don't mix them with the queue id. They also seem to not like
> when tags go beyond the IO queue depth, ie 128 tags.
>
> This adds a quirk that marks tags 0..31 of the IO queue reserved
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
