Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB53C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843EB20651
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EYZczN2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfHMQjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:39:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33728 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfHMQjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:39:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so22062081otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=I69b5JV+phZxzHOcqYgo6XHHHWtifAb0O34LlDzNHJA=;
        b=EYZczN2l+SqgeTR3GO7GAxvQEc8bVCSyDaCrU9+64khCt4jyBvD8MNRcIhomdraDeP
         7BKBB1AqvgHbi2qq9U2Iw6E6749KNtRkgofzb4RE+czdKJORnjJngYtY4yjPrNyrBpNz
         jwgpxgNIDDN+l/P1LHXaKoL/lgIV1M6S0eUHMlTSjoQ7J0MAUyb4itLv66hBtYUe7lqz
         v//euY0qskbOTYEncKVgZMYHdzDBswGtY2kZW6PDJ/gAIeyEQbLeJKpubKOOcoi8dQn4
         qUZ3IHLfJfDhcAtLNXIxAn/duIcW+T+HCk4eNzPgKRvwQdGJwNlLr7OyrsuCeFZtDA+t
         qG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=I69b5JV+phZxzHOcqYgo6XHHHWtifAb0O34LlDzNHJA=;
        b=PAKjn9bI/XIPkkpxARY3uHBXiN/QONjkkObK8q2p4J6t8N+dUtqXZtAVa0Wn2HhHM/
         S2QM++/N5iLiBGL9Xb6cCAYCad6vJNlom8JLrHjOE5/939rD5rE/bTm2SBZEWIhzrzsA
         wtHbfz4bLwBjjJ8OxWcQD5ftHHyg9bPxxv9v184j5FHS7JmdTlo1PBZjatg1beZbefNm
         etVM9aQU9bprJ7/1C9ecxOYbJeXL+3sDBIsB/Kv1nKXo5OV1E/KakEinGHUe0pcP+VSL
         4ccu/fmjiNPG3i4WIPjIkRj19qnveexzc3BTYqBXqIgTte+HYxD0y3CCjDENvuPZzZbr
         f7ig==
X-Gm-Message-State: APjAAAUpmSOZ5m99xlad2++ThL2gVaHihM86Cg6+HnmhH4rP9Ymsxg7z
        WncJdjdMTI44ZQ8gMWRXotGDig==
X-Google-Smtp-Source: APXvYqzZhud+hR1gsA9k5cTy2mxzBjQ9jW9K5maIofLebjIsNaVBkbaY7+FZgRYGMef7y5DHqPXPYw==
X-Received: by 2002:a5e:8210:: with SMTP id l16mr1641684iom.240.1565714383183;
        Tue, 13 Aug 2019 09:39:43 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id c13sm22298080iok.84.2019.08.13.09.39.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 09:39:42 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:39:41 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Logan Gunthorpe <logang@deltatee.com>
cc:     Greentime Hu <green.hu@gmail.com>, Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Olof Johansson <olof@lixom.net>, greentime.hu@sifive.com,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@vger.kernel.org
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
In-Reply-To: <5506c875-9387-acc9-a7fe-5b7c10036c40@deltatee.com>
Message-ID: <alpine.DEB.2.21.9999.1908130921170.30024@viisi.sifive.com>
References: <20190109203911.7887-1-logang@deltatee.com> <20190109203911.7887-3-logang@deltatee.com> <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com> <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com> <CAEbi=3cn4+7zk2DU1iRa45CDwTsJYfkAV8jXHf-S7Jz63eYy-A@mail.gmail.com>
 <CAEbi=3eZcgWevpX9VO9ohgxVDFVprk_t52Xbs3-TdtZ+js3NVA@mail.gmail.com> <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com> <CAEbi=3ebNM-t_vA4OA7KCvQUF08o6VmL1j=kMojVnYsYsN_fBw@mail.gmail.com> <e2603558-7b2c-2e5f-e28c-f01782dc4e66@deltatee.com>
 <CAEbi=3d7_xefYaVXEnMJW49Bzdbbmc2+UOwXWrCiBo7YkTAihg@mail.gmail.com> <96156909-1453-d487-ff66-a041d67c74d6@deltatee.com> <CAEbi=3dC86dhGdwdarS_x+6-5=WPydUBKjo613qRZxKLDAqU_g@mail.gmail.com> <5506c875-9387-acc9-a7fe-5b7c10036c40@deltatee.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Logan Gunthorpe wrote:

> On 2019-08-13 12:04 a.m., Greentime Hu wrote:
> 
> > Every architecture with mmu defines their own pfn_valid().
> 
> Not true. Arm64, for example just uses the generic implementation in
> mmzone.h. 

arm64 seems to define their own:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig#n899

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/mm/init.c#n235

While there are many architectures which have their own pfn_valid(); 
oddly, almost none of them set HAVE_ARCH_PFN_VALID ?


- Paul
