Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A76DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0899920656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvSJ3MJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfDXG4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:56:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40435 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDXG4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:56:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id d46so14883665eda.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 23:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pG4U6Pj6XdFOz0C0Zq0fAJCSNX59YSgZn7TTQCFIKew=;
        b=ZvSJ3MJGsy0sxUyOP8slTSiyY0YYPZaBOm2jhpjeYpvUsLXLoGbqDl6gfQ6arvQ+cn
         +QfG7OH4rMOp1E/NYpisd8XbcoU0lbrQtaoFxOzA+wqdIKedHJUan2jnRafzXqfrpuuQ
         niocPCX3J7NLwwDxrxugEPhlmR7LlEyhMNii1YF50FqzrCVkuOB/VYo0+isBago+uBkQ
         qM02UEDOc4nIIm3I71bWIG5T9ZfaslzGyc0xhJTgwF+4XAA+DTUP8yNGEm+PP088F/e7
         RaKBTvwgfv0zFLvRydJqIikLMlB9rgN3lJ4mh1CBNNuGOF52w2qZGMZHuicymYW36by5
         nKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pG4U6Pj6XdFOz0C0Zq0fAJCSNX59YSgZn7TTQCFIKew=;
        b=QjsCZmpXZ+r2mI0Sd9SQGW8iRBJwsjEvhJ49XHsV35oc2+YgMXuhQ+bA0fVdLDmgRP
         0aLOLjuzXbvZvFhbxJvv1+/Dfes4bX+j1O5RIitwqUIFGf5WhaxjnnD1MkNIMKIpevb2
         rBkiNGUwnlINPAwITI+/l9iY8VjjkNXVA6oBEiSphelSAW3roajhB2Qu0RMoiJu2H4Ev
         BOzADUr+PQMPZ0pw1ru0GADO2KndvHa+fx36e1utkOYr2NOBo70P+EFYDwglXwR2wAeX
         U/d3lGyvrrXwmFKlCWKGnJpRi5hEzXrEqVYxolChbnE/ih0E56BRm9q0YD2rm+FuPrSS
         oKSw==
X-Gm-Message-State: APjAAAWaoE741H+zXRd1Oi0nWeBH42D4nY4+J6qLNVyi3NEoFq7k1BpS
        HJEYoxB5hua2+Mavc47drQiBWuP4IDAzuJ/6yyg=
X-Google-Smtp-Source: APXvYqya+OnEpbThxFTXYcPwiyeRXrV0Vr7OCawwFIaB6xozTXAmQVt7EdOTa4bb+Jfjun5bxaDIQNLb6xfIB96gIqw=
X-Received: by 2002:a05:6402:55a:: with SMTP id i26mr10266776edx.249.1556088962386;
 Tue, 23 Apr 2019 23:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190409102654.25845-1-hch@lst.de> <20190424061423.GA12864@lst.de>
In-Reply-To: <20190424061423.GA12864@lst.de>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 24 Apr 2019 14:55:25 +0800
Message-ID: <CAEbi=3cpQWymVB0fErJ5-cULm59dmG5QZ+MNH0PB7oOGOpe8hA@mail.gmail.com>
Subject: Re: [PATCH] nds32: remove __virt_to_bus and __bus_to_virt
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> =E6=96=BC 2019=E5=B9=B44=E6=9C=8824=E6=97=A5=
 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> ping?
>
> On Tue, Apr 09, 2019 at 12:26:54PM +0200, Christoph Hellwig wrote:
> > These macros are not used anywhere.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/nds32/include/asm/memory.h | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/arch/nds32/include/asm/memory.h b/arch/nds32/include/asm/m=
emory.h
> > index 60efc726b56e..9d552ee39bdb 100644
> > --- a/arch/nds32/include/asm/memory.h
> > +++ b/arch/nds32/include/asm/memory.h
> > @@ -15,14 +15,6 @@
> >  #define PHYS_OFFSET     (0x0)
> >  #endif
> >
> > -#ifndef __virt_to_bus
> > -#define __virt_to_bus        __virt_to_phys
> > -#endif
> > -
> > -#ifndef __bus_to_virt
> > -#define __bus_to_virt        __phys_to_virt
> > -#endif
> > -
> >  /*
> >   * TASK_SIZE - the maximum size of a user space task.
> >   * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
> > --

Hi Christoph,

Thank you.
Acked-by: Greentime Hu <greentime@andestech.com>
