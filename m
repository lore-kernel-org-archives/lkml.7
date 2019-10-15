Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A718C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F0120872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="AAAw2I6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfJOGcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 02:32:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40122 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfJOGcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 02:32:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id e13so3288153pga.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ocFENo40eBkOamSyXJJZMLvSNduSNIAZPjJ2SmsMR/E=;
        b=AAAw2I6JicRTwP1XQ0Mh+Yf7oGvbrwyVbwgzWtL+OohVihJM7BnkTspwNITR/85fii
         CyRw8980Lw/qYHLo0fK9SRqJB2hxVndfjPwJE0pYel9OIy3uyAJ9ws0VAx2iuFbM6Mz+
         qRU4d+kp7W/TtFg44B6fpgznp1dJM2QAK2aUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ocFENo40eBkOamSyXJJZMLvSNduSNIAZPjJ2SmsMR/E=;
        b=Xpo/3rkfs+Z40YI75NgvrPhpQkeguMXdbW0Knx1wnPQKO6wLBZl7LwWmsI4R4NuJ+G
         CPRuFV5keQc4xr78Z/px+cIcELpVuWAWXZ1ANL7qxG1xFtnISFjhn8OERyatukHtCxL9
         FY7A6TjqSAFWg7Aa22Y/yZJBIBxvdy8+x/YS1rPGViFSGpvgOc7QxtWB+GPpnSFOifZl
         6KeCGoBJqxnww5ABErPiBnmHGuFmtX1WWnkvtOyMpx2g+NZIKxtLsxKeKVbijlHPhkZx
         CT3TnUcUDDeqbQpdpc4pFcoSgFZbNXhF6JJSGOI1hXUDqXCGpV5WUVT5/BJAqHynKC0G
         e5sg==
X-Gm-Message-State: APjAAAXh4hN5ma7Pf/9ftCyOtwr1BrWW/sBhM1Ozao9rhJ1cFqF2/jA7
        DITC0DaYZ1JDVi+mQkcbJ3UG37AcgJ8=
X-Google-Smtp-Source: APXvYqy12kiIddn/cKAZnrFSYzEeliZZBLeUJMlvZ7ea/7DvNH++JQuArzk3aup3MdDRAMq5RabnqA==
X-Received: by 2002:a63:7405:: with SMTP id p5mr37573902pgc.264.1571121127089;
        Mon, 14 Oct 2019 23:32:07 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id i1sm24230357pfg.2.2019.10.14.23.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 23:32:06 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        glider@google.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        dvyukov@google.com, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real shadow memory
In-Reply-To: <20191014152717.GA20438@lakrids.cambridge.arm.com>
References: <20191001065834.8880-1-dja@axtens.net> <20191001065834.8880-2-dja@axtens.net> <352cb4fa-2e57-7e3b-23af-898e113bbe22@virtuozzo.com> <87ftjvtoo7.fsf@dja-thinkpad.axtens.net> <20191014152717.GA20438@lakrids.cambridge.arm.com>
Date:   Tue, 15 Oct 2019 17:32:03 +1100
Message-ID: <875zkqtt7g.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> There is a potential problem here, as Will Deacon wrote up at:
>
>   https://lore.kernel.org/linux-arm-kernel/20190827131818.14724-1-will@kernel.org/
>
> ... in the section starting:
>
> | *** Other architecture maintainers -- start here! ***
>
> ... whereby the CPU can spuriously fault on an access after observing a
> valid PTE.
>
> For arm64 we handle the spurious fault, and it looks like x86 would need
> something like its vmalloc_fault() applying to the shadow region to
> cater for this.

I'm not really up on x86 - my first thought would be that their stronger
memory ordering might be sufficient but I really don't know. Reading the
thread I see arm and powerpc discussions but nothing from anyone else,
so I'm none the wiser there...

Andy, do you have any thoughts?

Regards,
Daniel

>
> Thanks,
> Mark.
