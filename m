Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D2C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26552214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mAg8m7rS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfEFTuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 15:50:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42057 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfEFTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:50:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id d4so2417168qkc.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ESsJ96JGC0CvnjgihpL/0kogE+VQksbbiyHqcPsgGyM=;
        b=mAg8m7rSPAxM5D+1qNjO71dhsXUrQSGF8zaXxmrvN1W1e7B7fEhL/nFNC4QmlTH5S/
         9FjLthJrMSnJTSlBNmAzOuj+WEEEHBw1j3jchmVO404WkT8GTT4n4WekZCWvQcvu4KOF
         mx0V5cfxdymPVb2Ruxoza7w5KItB51NAJ5xivBL7H4fj5rRig8CXPXI75f55CKvkZyYC
         Gs093sJb6bHKcKo1jSkGyp2Pk8c68+e+QijlfKiUVNZuBsCjguF+Uc/8jtTaC+sffP6g
         22gO2vicgInFZL3gRZwFvB6M65AQIPZr/G+9s6iQjRuVRTS6fQK5LrCRIMT4SjvjNieX
         MViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ESsJ96JGC0CvnjgihpL/0kogE+VQksbbiyHqcPsgGyM=;
        b=WOgP19QurriZ7giH6BK+HmzRv5X7+E0/dFe2mNMlZ5z8EJyzp2rZkAkf4P9TM2U1+r
         XvKd3Ep/6iA6a79IPXpYpvfZwjQOw4IfR0ouitpuYk8d9o9DKowyHf7rITvu3t48+2T9
         WvNFkOV1fpvpllGVSz5bHTMTQYZdZg+SIdVO05SyBkpEgcauyesrdLm2L66SaanMfU6x
         mhtQpDvW0CeRqLo2WR7Vr+Tk6sPprZgfsKFeVp+l04WJLYNW+4DNCCE5ddgtqrvMkU3u
         sOY9lWiOtgd7iZAXLjuB9D3u/4nDBJ88MWuWI7rr+pXSMcImIYxh/i8FSSXWJe3mFjpg
         L4Yw==
X-Gm-Message-State: APjAAAUEkBHTJn5zs1ZmAtOl0ymseJJZwOlHbRdofxcI7qeSd8YOTJSO
        TrqwilKpKKCA5IuSNcBuiW3hvQ==
X-Google-Smtp-Source: APXvYqweK3T+QR6CpnWc0KpWvE878/YztoCohPUsZDawCWkz4P9i6ckWrJvxSZLqhWTPckszjgD1bg==
X-Received: by 2002:a05:620a:16b4:: with SMTP id s20mr10803976qkj.34.1557172222493;
        Mon, 06 May 2019 12:50:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id o44sm9303175qto.36.2019.05.06.12.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 12:50:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNjcy-0007kq-Cs; Mon, 06 May 2019 16:50:20 -0300
Date:   Mon, 6 May 2019 16:50:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v15 13/17] IB, arm64: untag user pointers in
 ib_uverbs_(re)reg_mr()
Message-ID: <20190506195020.GD6201@ziepe.ca>
References: <cover.1557160186.git.andreyknvl@google.com>
 <66d044ab9445dcf36a96205a109458ac23f38b73.1557160186.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d044ab9445dcf36a96205a109458ac23f38b73.1557160186.git.andreyknvl@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 06:30:59PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> ib_uverbs_(re)reg_mr() use provided user pointers for vma lookups (through
> e.g. mlx4_get_umem_mr()), which can only by done with untagged pointers.
> 
> Untag user pointers in these functions.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 4 ++++
>  1 file changed, 4 insertions(+)

I think this is OK.. We should really get it tested though.. Leon?

Jason
