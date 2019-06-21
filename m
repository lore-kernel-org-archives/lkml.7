Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CFAC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC5A206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iFE5ScFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfFUNkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:40:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46003 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfFUNkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:40:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id j19so6879016qtr.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 06:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZCrivaPmWHSHjQSdgEw4GI/j98fJxtxh9tp1DIhn9Pk=;
        b=iFE5ScFSlA9eaFIsPJU8p0w1qOx41yW1vrAuYeo+l9Q0KwpkxwhaD346XR6CI3LuMu
         FsUTSf6vE97JnP3EPZrFn46YHJ7vRTKevOvCMH1mna8IGtNFXf48ywkiIrsuxvMz1Lyo
         73WFQX5rdb2D6muLva15ZoWDq9Kj/YcD/y2bpNGuMg6dRxVmYAap99xfHkj4krlsmpA9
         WLzb7MYs8YrQkoW/Cq3RrCPIBJ2bvt0kiEleJq5K2k1LS5IcxoG3chSgmdVQLBLoizx0
         yMC2TCuZc1Ce7lhLmgcinzihQvYINNi8qNCu1nQLWvdKkjW4U7948HBdCkUlKYsn6Uth
         DaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZCrivaPmWHSHjQSdgEw4GI/j98fJxtxh9tp1DIhn9Pk=;
        b=MMKadOPwiC/7UT1lGBItA4P5478Yoyz/lx+lIAJ6mDkcAmkuS9hFnjx2CjR52n990X
         S/ybg3gi4Cfh9wRb5uzmHIWzGtoqLszutQ4v5akKHGjDelNFex50tpZiE+Oz6+RCdfaO
         zUWvgy3LKiZShdC/8mgEchbbY/OkOE3RqhEEJMIcm+46lHfDnaFp33HEHFALEcZ3yKiD
         0p2tJ24JmVwVjpQTlqxwV4IgudTGn+g4Ly6S3Uam48zJcu7WvXOHi0OmxSucTBgrMJcR
         8wQFhrtN6D1e0wlVv40a01r5W4kO2bhCSPrtiZmUFmSeTepwN24At3NtC1oClGFueKC5
         2Iug==
X-Gm-Message-State: APjAAAX/XsVpsDqHw9EyQghMFZ+3atNWbCA+XJ5ajmlphjWbLfPF0EsZ
        A2kygytvMFqcHpf1Dx2j2VFk7w==
X-Google-Smtp-Source: APXvYqzfk92nAm4v0PC/p+cfLaUPeFmmoTuTFE99jGSQ5m486NYHbLSajeoJYynPCh/suXX0ETWpgw==
X-Received: by 2002:ac8:17c1:: with SMTP id r1mr115641302qtk.41.1561124422594;
        Fri, 21 Jun 2019 06:40:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i22sm1837536qti.30.2019.06.21.06.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 06:40:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1heJm9-000060-L5; Fri, 21 Jun 2019 10:40:21 -0300
Date:   Fri, 21 Jun 2019 10:40:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/16] mm: simplify gup_fast_permitted
Message-ID: <20190621134021.GM19891@ziepe.ca>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611144102.8848-3-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:40:48PM +0200, Christoph Hellwig wrote:
> Pass in the already calculated end value instead of recomputing it, and
> leave the end > start check in the callers instead of duplicating them
> in the arch code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/s390/include/asm/pgtable.h   |  8 +-------
>  arch/x86/include/asm/pgtable_64.h |  8 +-------
>  mm/gup.c                          | 17 +++++++----------
>  3 files changed, 9 insertions(+), 24 deletions(-)

Much cleaner

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
