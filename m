Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053C0C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE252086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RGMUuN+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390518AbfHHXW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 19:22:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46855 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732938AbfHHXW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:22:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id z17so7136982otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 16:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yo53A10QsIF3XF0Bf4xyGS53E9kiosKFbv27vH/Lz18=;
        b=RGMUuN+uZ56NjxAK0C1mhv22NA08OkeaIhz2c2SqFGjp32NDWIxsl1BjVWBIrWGqqy
         eVmXcq22KWyOpWhm8k2bCOvSoKwKOCddp9/L433MsZSOdHiA1KcaLzbKQWE8UqkysaEh
         SEqOtcPo9la96yRagHcyqAGJjZogTq1HWq9pU4R2t8tmFB7LafGUzJv5e4oB1LMgPJlF
         ZAAyWvjq/UlbTHYTvit/Zqv79CnZDf6/VNxXNacQxO8bE+itlqaCUaXXTh3+kDRjIojX
         zWsLG/5vX+RxVD+DOf8SeLLDB07ehTYMA5ZM1zgJWI0E2qQLoBaVtTZXcSheSjOpml+W
         3+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yo53A10QsIF3XF0Bf4xyGS53E9kiosKFbv27vH/Lz18=;
        b=kAh+E00JOZ3+L/0qw5cabUqb0VJWuvktZq0w4z7RnRrazvjyr/K1HZjJZMw9+DfLye
         wg8lh6C1P0TA1wkQqYsRFHkGz1Qdq34WYgMifAHEH8KJIJqOzl3o1W/zW2lngDOC8O7+
         Ke6fzC7TblJOf3qhqZ8jqsW2chp3d0eX1ZWjA9LOv7lhJs5kbc4fpi0bFsXjmiI4fkQR
         dpDE5UBSpE3oTtmMmVB9oU9qoUD9wXSsjsiSzm7DoX4Cw+mxRmGZWm61Sf+XW8UKcte+
         khpN4e7QFkiCDkWEQEwxDPiH47QGaEWKPIrZI1df2fErsrUpvUMODnQx0y42oosGKPEe
         YLJw==
X-Gm-Message-State: APjAAAUTPF8bXYedV1wKntnUfkl3ZyTjSUFtsuFqGIrk3ZSzGHNqcNUb
        04bnLNiY4GOwDKm+fss7OJlnig==
X-Google-Smtp-Source: APXvYqyut0MaAojt4oQBMYDbrqnOQe3cs7lpeIX8YsgToxuKXyji9/ZByGtjbWQ9UVGGda0uKixR0Q==
X-Received: by 2002:a6b:6516:: with SMTP id z22mr17741943iob.7.1565306545766;
        Thu, 08 Aug 2019 16:22:25 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id i4sm118719877iog.31.2019.08.08.16.22.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 16:22:25 -0700 (PDT)
Date:   Thu, 8 Aug 2019 16:22:24 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     akpm@linux-foundation.org
cc:     mm-commits@vger.kernel.org, bmeng.cn@gmail.com, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: + riscv-kbuild-add-virtual-memory-system-selection.patch added
 to -mm tree
In-Reply-To: <20190731215335.XZNjD%akpm@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.9999.1908081620450.21111@viisi.sifive.com>
References: <20190731215335.XZNjD%akpm@linux-foundation.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, 31 Jul 2019, akpm@linux-foundation.org wrote:

> The patch titled
>      Subject: riscv: kbuild: add virtual memory system selection
> has been added to the -mm tree.  Its filename is
>      riscv-kbuild-add-virtual-memory-system-selection.patch
> 
> This patch should soon appear at
>     http://ozlabs.org/~akpm/mmots/broken-out/riscv-kbuild-add-virtual-memory-system-selection.patch
> and later at
>     http://ozlabs.org/~akpm/mmotm/broken-out/riscv-kbuild-add-virtual-memory-system-selection.patch

Could you please drop this patch from -mm when you have the opportunity?  
Based on some feedback from Christoph Hellwig that this patch would break 
randconfig, I've decided to abandon this patch for the moment.

thanks


- Paul
