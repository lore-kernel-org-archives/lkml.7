Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08959C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2ABA20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fAyjEW4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfDKVMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:12:01 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36784 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDKVMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:12:00 -0400
Received: by mail-it1-f196.google.com with SMTP id y10so12028432itc.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IkuarGGVKCQsG79ZJK4mrZNMD40jUbFO5RJo6N6EJrQ=;
        b=fAyjEW4Yx1t1hT+431iRw8huCVDlNbsu9i1y3gQX+1JtUn6uB7Zp3/6/Q+D7JR9B4f
         4UfpJ+qTSuENZH/fEPTdb8ltie3rmYv48KE4cuNUd2lpPaHq84Ri636NG+73cTurJy8P
         d0TlWUcYY3Bz5Tr+uUT5l6JPzB5uFUi0Lx5JKgf05VBHygvm8ZemOzNHIYPbZcdacyiC
         7KyOxUqgATenkn0ZmLMtn7ZWbFVjbZbhk02O65/kLKnRLNPrfIZBV/QbJAY3dLKiy1T1
         7vWPSAwfJsA6Ic9ZvyBg6mtbVXW9JCDLjAgBGyiFbeLOG9S2FW75EAZOn8wA2koVyouh
         My6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IkuarGGVKCQsG79ZJK4mrZNMD40jUbFO5RJo6N6EJrQ=;
        b=gCAUCIncIBjZEhN4n1Ufd5LBfYTV/PQc0/ecBeitKw+Xg97RzZGEqJSvaa6r7rw21k
         AmX77YS4LFjWUU8eOGNDWWN181RUY/zOfdn2Og87xfiQJ2vN2z0cDmvri9004Jsd4wB+
         JnmB27G18qMCsWNURvoHtJCPTbotP2ORrGQC7bF7Gp1GaExqhOnWDycD085GLos6AQhQ
         HRtkFK9PerykbLUg1I/xc3uHSYPtey1a/B6fL5z3eHkp1857ybigjd69fLaAL156VJQF
         xx/h9qHBXSONgD8WNwTCLLioNcsXgIr0NzGTnfQEOaBthJuviuvwTTLyFj7bYke8zqf8
         4TsA==
X-Gm-Message-State: APjAAAWCuH3pDNNGt17gpnGoMi2aW8E/w39ixBCX6h1dKyDW8febEUZp
        MTEeL/vCIg89Xnsm9AD0b9SMZQ==
X-Google-Smtp-Source: APXvYqzeKBXYfT9mMVLuIyeUJKPRizOio6KDDbYBXQhMeGA/MGafpAUyZqe721Bbp1rdLANQyR8wMA==
X-Received: by 2002:a24:80c2:: with SMTP id g185mr9042453itd.11.1555017119267;
        Thu, 11 Apr 2019 14:11:59 -0700 (PDT)
Received: from localhost (63-238-229-145.dia.static.qwest.net. [63.238.229.145])
        by smtp.gmail.com with ESMTPSA id l68sm3080312itb.29.2019.04.11.14.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 14:11:58 -0700 (PDT)
Date:   Thu, 11 Apr 2019 14:11:58 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/6] arch: riscv: add support for building DTB files from
 DT source data
In-Reply-To: <20190411114616.GA10032@infradead.org>
Message-ID: <alpine.DEB.2.21.9999.1904111405470.19990@viisi.sifive.com>
References: <20190411084304.5072-2-paul.walmsley@sifive.com> <20190411114616.GA10032@infradead.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019, Christoph Hellwig wrote:

> On Thu, Apr 11, 2019 at 01:42:59AM -0700, Paul Walmsley wrote:
> > Similar to ARM64, add support for building DTB files from DT source
> > data for RISC-V boards.
> > 
> > This patch starts with the infrastructure needed for SiFive boards.
> > Boards from other vendors would add support here in a similar form.
> 
> What do we build it for?  We'd really need something like this:
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/d6242aa147baf57e05e2932199c74d8d24b9926e
> http://git.infradead.org/users/hch/misc.git/commitdiff/0cd5413c8094ab57b68e0629dacfed695f4c1ef1
> 
> To actually use the DT files.

Those patches might be useful - I have not reviewed them closely - but 
they are not necessary. 

The FSBL already supplies a DTB to Linux.  I assume the U-boot port works 
the same way.

I haven't switched to U-boot yet for these driver tests, so I personally 
have been using the open-source FSBL (freedom-u540-c000-bootloader) with 
the following trivial patches applied:

https://github.com/sifive/freedom-u540-c000-bootloader/tree/dev/paulw/supply-fsbl-dtb-v5.1-rc4

The fsbl/ux00_fsbl.dtb file can be symlinked to the kernel DTB output, 
e.g., ~/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dtb.


- Paul

