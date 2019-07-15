Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAFCC73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 02:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4997B20820
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 02:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563158942;
	bh=IKV8zOi6Ze0AE2qNwQsmARcgsuDl3otsHvSGrnDuVWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Mq3jKGZUN11J/f4e5DSloZJNibEdbidKrTC2lzPAoxLDY7jVYAdYSZlEVTf0lnSk8
	 RilegusbVoIO1mhJ6q2SgSyNq/NWzpenQBaDL5BPzxlm9XPU9RHMvhV0D3BJNZZ1Ok
	 e3zxzrOuCp0GZvWoMlSFGj6vdWO68zecUVOjpr4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfGOCtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 22:49:01 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:39324 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfGOCtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 22:49:00 -0400
Received: by mail-lj1-f174.google.com with SMTP id v18so14537617ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 19:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xXZnp3zLEv9/8rZrVJ8Bb1hgH0mFVq0ktioQL8IoBE=;
        b=QG6qimnZ0OuOr18TPPyD1ZpsfC2oaBrHXD55BhiSP6dw+mQqPSGsIUy/Yf4/KOcnWu
         3PMYYqkRk/B44HHs/mOcE5iy2y+FDx49TCkO+kDXoObGp0hcYXLYXFAlMjRw25zjrKgL
         tjFllJ7em2UwShT6KqGZwlL9Geykn6fnTBnEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xXZnp3zLEv9/8rZrVJ8Bb1hgH0mFVq0ktioQL8IoBE=;
        b=H3nOIOYk5SGmQwK8XQ05D1wxhhaxmD6xEN+k+I3BpT9v9i2A5RJsIU1x2kaFW8eaK/
         I9inR7WcGmcoBHCxjVSWjG0pxIrHWVZIGrKyStcuZayVbjVWHJkej/9+5OwHAf13iqkZ
         oMN7QK0ep5Ya+kpyUiL+yw2/tByMPXrNBSjYTAG+Yl41RxdmpORAoBLGIxfGE5COUAe6
         1H0Q15lRP2ZMXNAf4JGotsYBSy5pc0PWGZQxgQQ1koJUHJg00Esv1eNrC8+PPxhURb/Y
         7Vy+kcnjDV2iOu+oUan7fW0RtGAC6n8VGP+0mgo7D9OU92QtZmXFywMRJLWDoF8DoKLa
         je8Q==
X-Gm-Message-State: APjAAAWR6l/mhJM2Y1Y+XuhQe4bgaEVcERpOhYW3ZYzKzgYCrL96VFy/
        dzMxNkOEZwUUn1pc8IE9pLY9oa/mVSA=
X-Google-Smtp-Source: APXvYqxtcNXYSGbZB6OBp6yh5wDdv2VWvZoeS9iPuPRDSH5h4yMeXlwfb72zKaUXuFpYEymLRGCgSw==
X-Received: by 2002:a2e:8999:: with SMTP id c25mr12367130lji.169.1563158937861;
        Sun, 14 Jul 2019 19:48:57 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id e26sm2150905lfc.68.2019.07.14.19.48.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 19:48:56 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 16so14539322ljv.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 19:48:56 -0700 (PDT)
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr11885151ljk.90.1563158936002;
 Sun, 14 Jul 2019 19:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190709192418.GA13677@ziepe.ca>
In-Reply-To: <20190709192418.GA13677@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Jul 2019 19:48:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHKrYEMDbA9CxZ2Sw8JuW3=Wxr1fZo+EvXXLhg4iUOmw@mail.gmail.com>
Message-ID: <CAHk-=wgHKrYEMDbA9CxZ2Sw8JuW3=Wxr1fZo+EvXXLhg4iUOmw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull hmm changes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 12:24 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> I'm sending it early as it is now a dependency for several patches in
> mm's quilt.

.. but I waited to merge it until I had time to review it more
closely, because I expected the review to be painful.

I'm happy to say that I was overly pessimistic, and that instead of
finding things to hate, I found it all looking good.

Particularly the whole "use reference counts properly, so that
lifetimes make sense and all those nasty cases can't happen" parts.

It's all merged, just waiting for the test-build to verify that I
didn't miss anything (well, at least nothing obvious).

                      Linus
