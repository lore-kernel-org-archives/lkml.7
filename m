Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB91C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A863D214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="T6kWLJqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfF1SxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:53:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42516 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF1SxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:53:00 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so6141735ior.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0vnkzi3BuJTyXx7KRAPPLKqoLRHPgMrkqNHgPj4DsWE=;
        b=T6kWLJqrYH5JG0ZpMsTWJYlyGp9L3SPHrYqLjVPcryv7lQnYlvRo3gyaCu9yw18RST
         Z87ehkfmmJPrNWqwbVGwO9zaTzKN6gap4ePTLSce7dgy/LWbvt+j+oH15CCz/kDxDRXT
         kU+5cB/xXZA8kY42vlqCnC82yo2PhgaWetCTG/BFjvvO3NEjkfHPPtVNtIdzkmKPSV9n
         sn1Tqp6C8V/RzMRtEteqgpcaDUHN/M557MGODv7f7gUChAz0zOz3c5iizFfLdZikIwK0
         pGDBZemdSCGyArGmU3wNXGeWyE+g30zZSvPbbAKcxM1YICX3RCRnUn/dMCGi84YW3huv
         IBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0vnkzi3BuJTyXx7KRAPPLKqoLRHPgMrkqNHgPj4DsWE=;
        b=C+MtD/JVPcpfpqcjV9f35PnAhdgphYXUrthCBrkCRfmWjyxaYBzXiooUlCC4Mnd2VT
         jefmzQYVc3elVArtpIrTy4j2DhDQe6UnjyWDTkRElayEJ87pIjVqmT7sARC8+Pqgr685
         9E6oBe+kIeqGEPAJgdZK3NCfa+AaZGCM9ulrE44/pp5IW+fy5DMt7fg7goxN6t503Qdx
         lCSRo/BVozBx3Zj9uznr7NEBaZQ+vJpgeBy6Nz2hjgJ5+I/tbS0lpdiZ1g4mUUsFxmV0
         h23ot3tv9C2oowqUSv2j55rq5ZJBCsZY8zVZt0wWVIvi+mcmrUwtIwuB/rrEx0XOKV7A
         PNsw==
X-Gm-Message-State: APjAAAV2xLOd32J7G8obfCmj9NCZE8Z/rKZWeA9A2YE4208Pqt/cvSnG
        WQ1kc3VGTVTuVIOJk0T1TOQBqP8wKo8=
X-Google-Smtp-Source: APXvYqxpEW1Y8xJHyOkBaajlUN4Y39E+v9ExrC3+JygOPXs47MYzUBN0cdnJSzJFUIgReI45GA6Nrg==
X-Received: by 2002:a02:bb08:: with SMTP id y8mr13143899jan.51.1561747980021;
        Fri, 28 Jun 2019 11:53:00 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id w23sm2481400iod.12.2019.06.28.11.52.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 11:52:59 -0700 (PDT)
Date:   Fri, 28 Jun 2019 11:52:58 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     damon <liush.damon@gmail.com>
cc:     palmer@sifive.com, sorear2@gmail.com, aou@eecs.berkeley.edu,
        anup.patel@wdc.com, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: redefine
 PTRS_PER_PGD/PTRS_PER_PMD/PTRS_PER_PTE
In-Reply-To: <1556093512-5006-1-git-send-email-liush.damon@gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1906281147260.3867@viisi.sifive.com>
References: <1556093512-5006-1-git-send-email-liush.damon@gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019, damon wrote:

> Use the number of addresses to define the relevant macros.
> 
> Signed-off-by: damon <liush.damon@gmail.com>

This patch looks reasonable to me.  But what's missing from the 
description is the motivation.  Is this a prerequisite for another patch 
that you're planning to post?  Or because you think this is clearer than 
the original?  Or something else?  etc.


- Paul
