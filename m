Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0640BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB345217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NdLlu5Fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfEXEyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 00:54:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42734 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEXEyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 00:54:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id 188so7443494ljf.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 21:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0p20JZOm8Q5zL+TRyVFEg8a2DDLhMZrB4Tuc8+bGlVs=;
        b=NdLlu5FyOM02giIhSKVTGqrQ9mhGuv6PA0VT3iSCPaW8gw95H7I7/ye4/yJQ/doBe+
         P3PKfm/STHksEBlqaXdsRxbVZhAUmKQlkVcOQJes9jBlOssmnfWcQo3sZTy1fXSXKC4x
         3HpUTQuwdDAe2NEQRIsIBBpcDgeU8kW7pY7gWOk++jtNIDdBxy1TsJcssLIa1CSReK1f
         OwjdlzjjuVrT0rWaZc/WAKIWBOzGBgefCexjSCfUNFpNr5AcTa4H4+o1Bh546B3Mbnxh
         51qENYczplF8E3vogRwa8U2fHQ7hK8WKdu+9/ETb86swbsAdzty14xuWE3J3kk5iF0Yf
         dl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0p20JZOm8Q5zL+TRyVFEg8a2DDLhMZrB4Tuc8+bGlVs=;
        b=kIzErg55+smPZqaBbzBkNms4MjTjZUrwVmBhBSt3+FVxTF3ijWpPHdek8aw0VJkBsj
         FmyskcOQaL9OmvMQ1NXXe7E/SSiA8gwB1p0fJG9lHsVM/f1pER9Wn7yxR7eIhYDjGnV3
         S3Gif63V5UJZGCuGRLbFqtkuvodzsJqS/JBIkeUOgwp8fSks5O6VRbFzVN3GhKtoRPs/
         9jHQKkW8i2SX697sx1yR47AKeN0pwGbipt504dH0Tqrbm139dHTxGgcj9A7PQy0CvNYZ
         IDa6UE0fXtswg0N3CWNCn0bOsjwViWrPu1ZoNpfd0KGfAZDYkFkVrJSTrlVQxRZkDI1J
         SmDQ==
X-Gm-Message-State: APjAAAVza28VPCpRHV4nHdbxPQYhnumE3MUDOAKj3GP/pULPdFYH1ctf
        V3lSSXPrgHTcbGrsF7oOHH43G81XnE7EftD1AHQLTg==
X-Google-Smtp-Source: APXvYqw+GBX6IR44aYeJSdzjL+ZaEIKJ61JkR+OOuDdlscXdQs1cdp/fSEKXTniJ9Nxq/1Q2fX0A2wBUzHx8TJZBgtM=
X-Received: by 2002:a2e:86c2:: with SMTP id n2mr18578922ljj.23.1558673687971;
 Thu, 23 May 2019 21:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <1558611952-13295-1-git-send-email-yash.shah@sifive.com> <20190523.092825.2184612182055559835.davem@davemloft.net>
In-Reply-To: <20190523.092825.2184612182055559835.davem@davemloft.net>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Fri, 24 May 2019 10:24:11 +0530
Message-ID: <CAJ2_jOHPbFYtLYoCD0jtpLEyDM9is9gr7sbF+yZCHyfERZc48A@mail.gmail.com>
Subject: Re: [PATCH 0/2] net: macb: Add support for SiFive FU540-C000
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, Palmer Dabbelt <palmer@sifive.com>,
        aou@eecs.berkeley.edu, ynezz@true.cz,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 9:58 PM David Miller <davem@davemloft.net> wrote:
>
>
> Please be consistent in your subsystem prefixes used in your Subject lines.
> You use "net: macb:" then "net/macb:"  Really, plain "macb: " is sufficient.

Sure, Will take care of this in the next revision of this patch.
Thanks for your comment.

- Yash
