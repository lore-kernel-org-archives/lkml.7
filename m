Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE78CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 20:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8662087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 20:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WJknctNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfJaUNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 16:13:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33054 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfJaUNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 16:13:48 -0400
Received: by mail-io1-f68.google.com with SMTP id n17so8263167ioa.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=edoR3drkOe7+sAAN2C14zGy1y4TkfH6JZVLoKAB2I1c=;
        b=WJknctNbQNnq4Hj+o22VpWRFtQqoOiBTkKHsk+HRvEVy3BoU1PzUyESIxTdd5FfBNH
         Da4DbpwX4BAQlSPVaEP7HsjwY9tNc8Rk0+O/ClWYh/dL8GvxUSFIlW/xtAbIp8ssk2d4
         4QMY/4gASgyN4iTUy8LHtcceXfR3Fmirw1+KY5PwZIJ9oFB1X6Lq4K59XRIj4RQGfD5Q
         HyWcdFwWXhpYTk5RAIfNZVGGNH1JTPuKcCPvlNICWWRvaBP4hzyhKAVU1SKNYydCzfKm
         qlvJ+WFDWwM6b19TOzxn0xl7auPIlqje8Z+XWsHJNp7ymmWMhE3tHe7oKrh2Q00rf+iN
         FPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=edoR3drkOe7+sAAN2C14zGy1y4TkfH6JZVLoKAB2I1c=;
        b=sZqMeOLLUP1g7MZ7GGofiKHLkp7T5R0Abzxw7JYqAlAxnyU7g5K1EDY81E+rw/IdWy
         /KtUWRgCLuwDTd8OuYUZHxBs2ai/IKJl18xiwN66TwiVh4nHUyOtjjI+HkNfXe2+llwd
         DRtsnzL+IZ12W97fMk4dnwabDgAXCgbQAk0uBAK06B329vppkgetUN7MOxyKmf9tQBHQ
         LPokTHs5Mr34M1Zl5NQ/NBDAcLGr/bpFjIPA2CyYCUGZ29eFXW0XgoELjfryC4OGt8cc
         7obDcwawvy91JWoTwsgMu+PK2PWEUmv8Jw4LbtW4JViTJxotFg6roVk9Slehr4AaS1vk
         /ypg==
X-Gm-Message-State: APjAAAWAV1FEsiL5tkFzuy1E96+gqn9AGsozYjio6CROhQWF8chXifwd
        I9D83FY+Eo8EB5g7uEGtSGsKFg==
X-Google-Smtp-Source: APXvYqwu18NgGtxYghLIqdGrPlyUezIGUUPxppmYLKUKXEShdep9/77fPJTZMl39SlwLPxfbxPxnCg==
X-Received: by 2002:a02:cc66:: with SMTP id j6mr1049512jaq.61.1572552827929;
        Thu, 31 Oct 2019 13:13:47 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id h11sm436841ioq.57.2019.10.31.13.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 13:13:47 -0700 (PDT)
Date:   Thu, 31 Oct 2019 13:13:45 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RISC-V nommu support v6
In-Reply-To: <20191031155222.GA7270@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1910311312540.16921@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de> <alpine.DEB.2.21.9999.1910301311240.6452@viisi.sifive.com> <20191031155222.GA7270@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019, Christoph Hellwig wrote:

> On Wed, Oct 30, 2019 at 01:21:21PM -0700, Paul Walmsley wrote:
> > I tried building this series from your git branch mentioned above, and 
> > booted it with a buildroot userspace built from your custom buildroot 
> > tree.  Am seeing some segmentation faults from userspace (below). 
> > 
> > Am still planning to merge your patches.
> > 
> > But I'm wondering whether you are seeing these segmentation faults also? 
> > Or is it something that might be specific to my test setup?
> 
> I just built a fresh image using make -j4 with that report and it works
> perfectly fine with my tree.

OK, good to know.

If there are other folks out there who are using Christoph's nommu patch 
set, it'd be great to get testing feedback.


- Paul
