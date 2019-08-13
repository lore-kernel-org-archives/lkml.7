Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B94C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1D42054F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="K0rfqc3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfHMSl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 14:41:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39414 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfHMSlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:41:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id b1so8251988otp.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 11:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fX5yjg/2zdiBezYuZ3iR/R/lX21Xnc3q+P+SkpxJPD4=;
        b=K0rfqc3MV9Ye1zNkcmZD56MLVzb20dfzFqvgae3GxR9n6zhp27voJQiAVbAkg7OMeq
         LOcTLMBRl/l1QO63J21y5UKSmHMIKItMSLpFLi5AobisxH8lGcy2xucbFyt2CHTTF13D
         LUIiB23JFws4kF0EgcyUj0Slm3cBtfaH4aosnUw58T1crgUCCkQac8s3oGE8Gpz/C13b
         G3+LRxwQlKxKbFG6OmQezQCg00OWxBRIi0dgwos5zcqkBF3l+a7GsrvPIfZSzHRJMd35
         4fty1YV/Y9SKrq1rgwPNXBRB7uobNf4vms7SfnK3T6B7j+k61AfuaKLk33gI1JHicpK4
         HFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fX5yjg/2zdiBezYuZ3iR/R/lX21Xnc3q+P+SkpxJPD4=;
        b=XMsJP1RzggEKq0KNkA0FrxQkJLfBbIsAj8VU10YdqbdtJHocWzLdgvdfjBACRY51LM
         ko0Cuwrb/rfBiUKrprkzOaFG0Lq2AFoPQQkF1lVI4766IkTp5dwgm86mhzQHvxHGI1wj
         BDZVGJO3wyivhTvlr0ElnOMEj5g38SdtpiPjGRbi0dV4qyl8SCu2wH1JX5AaYLVeZNBq
         vpax3fnlV6ZSY/gVNAbxD4XrI/NOxAt7vqTlezmXjAcVL5hPKnJ/7A+x+TMpZOrqjsn2
         1Xj3zKDM0xhAm59sVAn8IsEAfz1GnoUVdtvRaWWmo1LYf7ZfXPrU1X/0YunSnjbZHT3d
         gvzA==
X-Gm-Message-State: APjAAAXYopCmIXD3nuoODeCN2UfCMHL9/JybE2fVNCszzfdEGd5WR0ns
        04x0f+T6z+fJJvUjb4neBpO2KA==
X-Google-Smtp-Source: APXvYqwqPZ5UQlBLYUIPuJNViu7vjL/d8NYkDxT9b3OHqwWDHdjO/dJHLuKBdIt2gWRUxAIpGp0PIA==
X-Received: by 2002:a6b:6a01:: with SMTP id x1mr4841202iog.77.1565721714779;
        Tue, 13 Aug 2019 11:41:54 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id e17sm21413438ioh.0.2019.08.13.11.41.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 11:41:54 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:41:53 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     davem@davemloft.net, nicolas.ferre@microchip.com
cc:     Rob Herring <robh@kernel.org>, Yash Shah <yash.shah@sifive.com>,
        robh+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        palmer@sifive.com, aou@eecs.berkeley.edu, ynezz@true.cz,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH 1/3] macb: bindings doc: update sifive fu540-c000
 binding
In-Reply-To: <20190812233242.GA21855@bogus>
Message-ID: <alpine.DEB.2.21.9999.1908131140230.5033@viisi.sifive.com>
References: <1563534631-15897-1-git-send-email-yash.shah@sifive.com> <20190812233242.GA21855@bogus>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas, Dave,

On Mon, 12 Aug 2019, Rob Herring wrote:

> On Fri, 19 Jul 2019 16:40:29 +0530, Yash Shah wrote:
> > As per the discussion with Nicolas Ferre, rename the compatible property
> > to a more appropriate and specific string.
> > LINK: https://lkml.org/lkml/2019/7/17/200
> > 
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  Documentation/devicetree/bindings/net/macb.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Am assuming you'll pick this up for the -net tree for v5.4-rc1 or earlier.  
If not, please let us know.


- Paul
