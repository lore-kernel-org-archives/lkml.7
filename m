Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86737C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514CE20840
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=utam0k-jp.20150623.gappssmtp.com header.i=@utam0k-jp.20150623.gappssmtp.com header.b="Vjo+ESpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbfGWQ2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:28:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44291 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732643AbfGWQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:28:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so20784787plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utam0k-jp.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pP/B1LW4qOPWYHcHFyf3ZeNn+CzDaAPWjIpJH8sJAfc=;
        b=Vjo+ESpzRZ6f5W3RK1AEwwlekU0xpptJcqLkYuyMbx4ksHg90qbzlVfRZmHDM9GhYV
         P6zP3DBgPz+4H5gdXI/JP1uQoXd4w18ziDvjwWANX1Yh5arSCbSOVCcd7bui4iSag8uj
         7P88t7NvJLOispCDud2zmMzdHy0SzBp+glK1gU+UxjtEcPgKloct3c/gXF+E34eKnt68
         OsTIX5zk+T+4tiief2/Jt7+yvaP26E7csow3OFhIx/Az54od7jFa2QdhRYH2hc4hzM2y
         AijzrrAnZrDr+zyKCl4xciKr4uz7wVPwp0Q2Xvrx5ObdWKg1ONM0MFQchg7ZtB7IxALb
         i46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pP/B1LW4qOPWYHcHFyf3ZeNn+CzDaAPWjIpJH8sJAfc=;
        b=Wbtq2OTLKq931s9ilugYp5rX6fmOCk3dlEYAnVNreXCyhh+b6ZXZhsP0+L3WrV2jf8
         0ucEnCTxnzDs+86m0DC27/08ImZYoB6811BvDO0gfd8GsjHoWhrTUv74fkuiSJABppJZ
         B257XanxbpYPjM+csC0IWdGub0Mc7hHzqvhlNBRgBLS8z2G3NXVOJJ1/SebCGBbjfxzg
         m1pc+ZpvJMn8M2RWxj1WOgegtaDCQb+UVB1PMyrr2SAPWxZqbDtUDp/eKCN+GKFxHZI+
         hZC5fqmgwxMDp/I8skIqJQ/59I2eFb8vl8rZh3GfkOO6i783wcmpVmtwlEUKq7NGlrtE
         Cldw==
X-Gm-Message-State: APjAAAUKIOAOMElkYtvG72x6z5h948lwygbSEsnTDn8OD+vdvSGHv3/z
        7W0KjM3/2DdSNBkL8WDocanR6ljVRi761fWo
X-Google-Smtp-Source: APXvYqyY4aKu8Yla4WyXGFEXydz7MFw2K+jbb6lPBf5rODOgRIh1VLKSPxU2yHItWfS2slJXthkgAw==
X-Received: by 2002:a17:902:2868:: with SMTP id e95mr76167194plb.319.1563899323634;
        Tue, 23 Jul 2019 09:28:43 -0700 (PDT)
Received: from gmail.com (124x37x165x227.ap124.ftth.ucom.ne.jp. [124.37.165.227])
        by smtp.gmail.com with ESMTPSA id z4sm32904868pgp.80.2019.07.23.09.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 09:28:43 -0700 (PDT)
Date:   Wed, 24 Jul 2019 01:28:40 +0900
From:   Toru Komatsu <k0ma@utam0k.jp>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] .gitignore: Add compilation database files
Message-ID: <20190723162840.GA7110@gmail.com>
References: <20190721085409.24499-1-k0ma@utam0k.jp>
 <CAK7LNARBjkYHkmv1michYYMd-2_70d+-Gvg1Kv4FyPeeBShvdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARBjkYHkmv1michYYMd-2_70d+-Gvg1Kv4FyPeeBShvdw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24, Masahiro Yamada wrote:
> Just a nit.
> 
> The patch title is:
> .gitignore: Add compilation database "files"
> 
> Maybe, should it be singular?
> 
> 
> On Sun, Jul 21, 2019 at 5:55 PM Toru Komatsu <k0ma@utam0k.jp> wrote:
> >
> > This file is used by clangd to use language server protocol.
> > It can be generated at each compile using scripts/gen_compile_commands.py.
> > Therefore it is different depending on the environment and should be
> > ignored.
> >
> > Signed-off-by: Toru Komatsu <k0ma@utam0k.jp>
> > ---
> >  .gitignore | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/.gitignore b/.gitignore
> > index 8f5422cba6e2..025d887f64f1 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -142,3 +142,6 @@ x509.genkey
> >
> >  # Kdevelop4
> >  *.kdev4
> > +
> > +# Clang's compilation database files
> > +/compile_commands.json
> > --
> > 2.17.1
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 

Thanks for your review.

 Sorry, this point which you pointed out is my mistake.
 It is should be "file".

 I'm begginer because this patch is my first time,
 What should I do next?

> Thanks,
> ~Toru Komatsu
