Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F085C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C58206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551918563;
	bh=qLH+LCZMmU3HhBmvX+ag+Pbbyvq+DwYT0PiaQiByQuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JGilngMc71Ffa1rvXnKfJ3vXsjiArZ1lwAkN265l/CYNvOZHPsCiRtte74LdrwTon
	 jr3ZpHvtfceG1E5T9h0rNaW72uwbIDSm0H8sJXBRd8odj6krD5Rt1RbnRKKRVEocwK
	 ZieHYsZyxyOQ2NJpeCyqQqjb3wqns/XN4I0ad4E0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfCGA3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:29:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36968 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGA3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:29:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id a17so12584761ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbJ0UlggnKYK1jDmFNStqwUyu5vfmirkoF92RcPOO3A=;
        b=VC4oXkbO/4BT0umjvdMgvDLX7CuFfoVAvLnm5BgTSov645gClqahgz2zffcFrfMVhX
         6+DENVkH0/MRZ2AI5+KtBKHVjnFaYiHS44hgU2feHhhD82vGdxQYumeXn5B2uf43MSN0
         akdOqV0Rgkftl45GuaWSAn7Bdh8b9X0pbOg3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbJ0UlggnKYK1jDmFNStqwUyu5vfmirkoF92RcPOO3A=;
        b=alfQzaO7ko2n8NHsdnVtZkNh0j095lldGxLXs33W5kOX9yR93BtDRlPzX0cCiwTaTY
         osJPP1adnGyHCuFj/W+nb0bEBJeGpChs9jNraIaI4f3vrqkLUBrfl7ywDWngheuxjuBa
         NEd4MAoHmoDcHVRplko+VgqJlensSsQtD7kftEqrBxxikAj+p+m9+WTf26qrXDNktTC9
         dBmJHDUnV+kigfZHiw3Z3smU90oUOmRU/gEoiSHRZQIrUjWrFxIHMFdBlml53bue1dQO
         F5XeFxuOQFXVOztIDrJaOTQUbqRbglZpIhBbiSy53KfnuJPjd37GGEVty6BcH05561dV
         67FQ==
X-Gm-Message-State: APjAAAV48Smk592ceYZqPHZSMPzfp7Jz+kT8O6qX+i1WLW+DUaTYD33h
        MKNvBx4SdB72KzEXHsZWaOmodMs3Klo=
X-Google-Smtp-Source: APXvYqycupaMmyBWuMPOjPI6gLg2+gCjyAU49tvvf7blfMqbUyPRtGYyoJTLQbBnokq+5dTKEhZ83A==
X-Received: by 2002:a2e:b014:: with SMTP id y20mr3971843ljk.116.1551918559197;
        Wed, 06 Mar 2019 16:29:19 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c86sm574578ljf.28.2019.03.06.16.29.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 16:29:18 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id u9so6202323lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:29:18 -0800 (PST)
X-Received: by 2002:ac2:5542:: with SMTP id l2mr3446951lfk.136.1551918200185;
 Wed, 06 Mar 2019 16:23:20 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
 <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
In-Reply-To: <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Mar 2019 16:23:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjzJSnQaj5b02aAjFdVMrKOp8UpyfQcoquRjem=X+SgTA@mail.gmail.com>
Message-ID: <CAHk-=wjzJSnQaj5b02aAjFdVMrKOp8UpyfQcoquRjem=X+SgTA@mail.gmail.com>
Subject: Re: [PATCH 1/8] aio: make sure file is pinned
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon kim <kyeongdon.kim@lge.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        zhengbin <zhengbin13@huawei.com>, bcrl@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, houtao1@huawei.com, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 4:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> "aio: remove the extra get_file/fput pair in io_submit_one" was
> too optimistic - not dereferencing file pointer after e.g.
> ->write_iter() returns is not enough; that reference might've been
> the only thing that kept alive objects that are referenced
> *before* the method returns.  Such as inode, for example...

I still; think that this is actually _worse_ than just having the
refcount on the req instead.

As it is, we have that completely insane "ref can go away from under
us", because nothing keeps that around, which then causes all those
other crazy issues with "woken" etc garbage.

I think we should be able to get rid of those entirely. Make the
poll() case just return zero if it has added the entry successfully to
poll queue.  No need for "woken", no need for all that odd "oh, but
now the req might no longer exist".

The refcount wasn't the problem. Everything *else* was the problem,
including only using the refcount for the poll case etc.

                       Linus
