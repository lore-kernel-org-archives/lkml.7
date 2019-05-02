Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39467C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE092087F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TAjDKfRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfEBSop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:44:45 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34353 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfEBSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:44:44 -0400
Received: by mail-yw1-f68.google.com with SMTP id u14so2373038ywe.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0H6/1V6/5CIKh3CDtEYPw4qJMt0j8mXo9dQuEOmaJ2c=;
        b=TAjDKfRewk/UKamdlBYp4Z/f6fr9mzmhTBqPKn6Tso2lr/AkBQ1LMwAK9XIDmPfqWH
         1X2g+ZiCkYEJEIfn+6n2PJc1Ev9G5K81J+GgEo5MfNluS5utNruV2aiJWOsWhO1L39V3
         Z6C+J9uqiqXPYgQ6dcQSGANxw+xbHRVZAHWyN5hgFksgs/XhUgIKGl/0h+zrDIy2eofo
         aoMe+6WRmr7JILlqWxy3H4DaUeYvmUJdygIwom0nYWR8nN82LMnNt4srD1UZaJjPLcot
         OJpUgaV5+1lK6hPsIBFneSFAOj6A3kBGy7IE9y3T5wB9bI5Hesqt1uBVI3nJujocribj
         yDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0H6/1V6/5CIKh3CDtEYPw4qJMt0j8mXo9dQuEOmaJ2c=;
        b=QjU8eMwQaeDzSuyK99CEPr0HUiItYlxubdGGims0g/8UieczN8O/jsnOjwNQPNxGUQ
         LEh1X/Wog/gVYoQHStn15QHLPQJi4DkFewoiqkjFF21q40NXz8WO6G1jrYP7mEdsqLgW
         HXl0j6Xlw8pEaUM1D/4kQMxsBHB5xsvAGkrN/2vMsIZGGWybZclLpC7YR1DI0ViG2gSa
         aZ+UEm0wvHFsmv40m9xfYNz+3oT+sLC+VWo/R5hebaBq9su9Sc2r8yhHOfNBt0lDVDfP
         j+Gbbls2ikmQTl2Des/h2EkNQ8xw59bxedL9kErhBCWBrWOAkLmLyLutO46Rh9ze7fUM
         wfdg==
X-Gm-Message-State: APjAAAUM2zRENrGTEYO+0eOFa6bYCwJVFKsvfQCvjW60wTUmo/mq+9FE
        dqBUAxRQCwMFhnrsSccD2liU8Q==
X-Google-Smtp-Source: APXvYqym/T/mBRrGXQQDSpwxLouliK+q+GpIj38u16aTEyLNBYQwSdaMmlgY9yKwhmdV2+JjJHDJNw==
X-Received: by 2002:a25:5d0f:: with SMTP id r15mr4433647ybb.373.1556822683578;
        Thu, 02 May 2019 11:44:43 -0700 (PDT)
Received: from ziepe.ca (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id q204sm16965820ywq.44.2019.05.02.11.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 11:44:42 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hMGhG-00026A-3l; Thu, 02 May 2019 15:44:42 -0300
Date:   Thu, 2 May 2019 15:44:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v13 16/20] IB/mlx4, arm64: untag user pointers in
 mlx4_get_umem_mr
Message-ID: <20190502184442.GA31165@ziepe.ca>
References: <cover.1553093420.git.andreyknvl@google.com>
 <1e2824fd77e8eeb351c6c6246f384d0d89fd2d58.1553093421.git.andreyknvl@google.com>
 <20190429180915.GZ6705@mtr-leonro.mtl.com>
 <20190430111625.GD29799@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430111625.GD29799@arrakis.emea.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:16:25PM +0100, Catalin Marinas wrote:
> > Interesting, the followup question is why mlx4 is only one driver in IB which
> > needs such code in umem_mr. I'll take a look on it.
> 
> I don't know. Just using the light heuristics of find_vma() shows some
> other places. For example, ib_umem_odp_get() gets the umem->address via
> ib_umem_start(). This was previously set in ib_umem_get() as called from
> mlx4_get_umem_mr(). Should the above patch have just untagged "start" on
> entry?

I have a feeling that there needs to be something for this in the odp
code..

Presumably mmu notifiers and what not also use untagged pointers? Most
likely then the umem should also be storing untagged pointers.

This probably becomes problematic because we do want the tag in cases
talking about the base VA of the MR..

Jason
