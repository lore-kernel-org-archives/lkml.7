Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF88EC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8FD2343B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j28iqp/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfHaCug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 22:50:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37857 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfHaCug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 22:50:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so4434661pgp.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 19:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pRGk1s9ftRrOgrFlJyIOUPDg0XINxHbTOG06p4KdZFQ=;
        b=j28iqp/6JSYiDZNbRISiYHb21g4mVidI5hA2fpwhhod9ip0yIepebDaVqaNC4NSZ6t
         F4sqJtg0aNnUBAJ4xvigwSkyU3d3BhU4fKyqFQwEEecpZb6omCOOgzbVZVdAwVudh8YS
         6sAdCx1o8qqmfBIKwSjsLucJEbNfA+AnN8WTl8dWCKLDsa5HJRooFNeT9lMV7R87U2u9
         KXmlf47JGDrH7ILcbodi08i+6ehVBoujXc6/cUx4HyJ5u93ZM3FF54VbS+qgGeIEXSfV
         n5I3UI6QXxv203AO8+D/lzpzXof1tsEkr9j37CEL5qafNFHR6QEo9dMi6UqQFn1zoh8l
         UWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=pRGk1s9ftRrOgrFlJyIOUPDg0XINxHbTOG06p4KdZFQ=;
        b=Xw/MJctiNx58qhVr2M6wc+Ci5Q3HFSua6ePmi3A3GGLPNrV56nifkXfkre8OJPpqZn
         a32RuLZINHsPREppItXfuJyp0SF55TjM1k/V/N0aoZnafXqdA4wInN5SYwiDYklO82Re
         MhW5Ba0EtOLcKImgAq4uNn4Src6yF2sb79R5wTuzynIxR4zXLdiY8uUqKBjuotkgrGuY
         5vgAZARJZ2paZC8ckN6Hn/J3oruXg5vtEbUr/GfRfwc5Q7wGa21RuI+roBnYyz1r+JWy
         8bQZKHO8q5B0nD2DDi7FmXmS5VvTXiSBWpJG7ZZ0injKKZgjeovNws1SfpPTB2nLLvWE
         mfKQ==
X-Gm-Message-State: APjAAAWa71/KqamIIyNSqCzeIjOxwDYN4ftfZ9VgxM7HTiXo9cvNJT9X
        CKe5fVQcA6AIAC5mKb4Ky2pT4g==
X-Google-Smtp-Source: APXvYqyyIZTS2at8UaC2GBzO1HAEDcqCzwTOJ2eIeXn1Qqrvu+CLxM4PQ8fncDRODM0mD17f4WmUzQ==
X-Received: by 2002:a63:f07:: with SMTP id e7mr16271558pgl.238.1567219835444;
        Fri, 30 Aug 2019 19:50:35 -0700 (PDT)
Received: from localhost ([216.9.110.5])
        by smtp.gmail.com with ESMTPSA id 195sm8287179pfu.75.2019.08.30.19.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 19:50:34 -0700 (PDT)
Date:   Fri, 30 Aug 2019 19:50:33 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Anup Patel <Anup.Patel@wdc.com>
Subject: Re: [PATCH v4 0/3] Optimize tlbflush path
In-Reply-To: <20190822075151.24838-1-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1908301939300.16731@viisi.sifive.com>
References: <20190822075151.24838-1-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On Thu, 22 Aug 2019, Atish Patra wrote:

> This series adds few optimizations to reduce the trap cost in the tlb
> flush path. We should only make SBI calls to remote tlb flush only if
> absolutely required. 

The patches look great.  My understanding is that these optimization 
patches may actually be a partial workaround for the TLB flushing bug that 
we've been looking at for the last month or so, which can corrupt memory 
or crash the system.

If that's the case, let's first root-cause the underlying bug.  Otherwise 
we'll just be papering over the actual issue, which probably could still 
occur even with this series, correct?  Since it contains no explicit 
fixes?


- Paul
