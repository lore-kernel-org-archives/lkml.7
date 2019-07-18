Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C41C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCDC217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Ygvn6fW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbfGRGEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:04:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33727 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRGEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:04:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id u15so20591053oiv.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 23:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1LQPeatmBO3Ls1tFC7heZrLlLB6kdfVOLBzlpUftSA=;
        b=Ygvn6fW/L34ez5EdLPrPysK+5BumzlK1V4WQbT4fqFL6HEi7RQKEYbZBC8wHQtaKBK
         ILhnlxGZACwRFgbtUZ/n8gwZLALJfAJNBlCNHqhWaEY03GYLxSdxkMdz6PrGX4WBbGqw
         WQrCBvhNz3srQAm1AXJ/zVHhqriAYY0Uljeb8fGVrU7SICX1/6GYYlhzvga6ITHO7GAM
         DvCTi0As46YqyAOTObm0EiWraNRaWWQrTyg9ai9ay/DtLkVl8OtsXDafDYRXVY3gzQYu
         YEyo2QDnoCpU9DfLo1fYXW2R1Zd1HAskVJKkXMxgwS6k6Q7jz5S9oHYn2q13cWDG8K5j
         IMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1LQPeatmBO3Ls1tFC7heZrLlLB6kdfVOLBzlpUftSA=;
        b=VovVIA93tokEN+uCygDp7fB6cJrIEi75H9H/hZ6B70texRUQ4HaKKkejcTyf1AIzg3
         ux6/CVLQlQ+iF8k+UtreZ9pxhlGwKfFSzCUz+VRHaTgz4w8eF5CyfJnWSeMjtvi53/fu
         giTvSfLzAniJWkxreGIhgGzwJYYfZgDGMkMwuqOgBindjSjT8rX2l57o+INInzmTR8JR
         QBuMoGHizwd7MZCcVYE2AYEDfRWR85hZb0IRf9LGJIhNXyQopf2lf81XoJDp2vs3wUBS
         xXd86gRfSj8ooze2bONKazahE88DgZ3/XG40VamryaRXswINYcxNroZiigIhHMwFm2kE
         Fqzw==
X-Gm-Message-State: APjAAAXMHg5m5X78F5baW2OG/3dN6qxk+kA8MTtGHWMB9+e3itly5T5k
        /1ouVNhPl+j4YU7LhhHIwVGBl5W8wqFZpWSvylQ5Hw==
X-Google-Smtp-Source: APXvYqxm9xDHx6ClBG2mF8PlRAsDH+bKVgC8qhkLQmyTe0e8hYV2WfgikTfBiTzNjyPyqgMGYXqJy4PfXQiD977bIfo=
X-Received: by 2002:aca:ba02:: with SMTP id k2mr19915938oif.70.1563429841600;
 Wed, 17 Jul 2019 23:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190718054851.GA18376@lst.de>
In-Reply-To: <20190718054851.GA18376@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Jul 2019 23:03:49 -0700
Message-ID: <CAPcyv4g=Hr4KOV1NbzPVRxSVL0TaaEPykG3GHwERjx1-SmUQog@mail.gmail.com>
Subject: Re: RFC: move kernel/memremap.c to mm/
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 10:49 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Dan,
>
> was there any really good reason to have memremap.c in kernel/ back
> when you started it?  It seems to be pretty much tried into the mm
> infrastructure, and I keep mistyping the path.  Would you mind a simple
> git-mv patch after -rc1 to move it to mm/ ?

No complaints from me. It ended up there because it was originally
just the common memremap implementation always built with
CONFIG_HAS_IOMEM.

Arguably we should have done this move right after commit 5981690ddb8f
("memremap: split devm_memremap_pages() and memremap()
infrastructure").
