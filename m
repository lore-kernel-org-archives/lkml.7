Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE4DC04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B880C2087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfIVvSgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfEPHkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 03:40:23 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:35412 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 03:40:22 -0400
Received: by mail-oi1-f177.google.com with SMTP id a132so1819489oib.2;
        Thu, 16 May 2019 00:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2+h/8RLqoYaj/QDLXv5hozjlrm561LLiGV0YnZUsFM=;
        b=UfIVvSgh9tW2fx0O/r446tlpot6A6hGVEYDXDbmvXNezzm0ozMJebrhI6gGX7H/BqK
         cl1aAJyQF3+xv7CWP/TeKC1D6L5dCh/tfmmqPwk9JZsrnYYfoQAz/Jkcvr3y1LAuWfgZ
         0RT/QRdggbKb18gS4e7uiCCW1HrsudLJce194ZSo738S6NhXWn/oolMPsD9goAE+Ao7H
         SgG4JdyKhrK8OWwnswYXTm1YTbWrSUdVzOo2ZX+NESbepZXudVNNuhztDNUJQB9yEE9n
         Fr5NTyrUHfFvT2own58J8NZ6a+Z5UFMkmv2Y5HK8OO0gveGfZCwmxDNzPSh6XKexL8Cr
         ZfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2+h/8RLqoYaj/QDLXv5hozjlrm561LLiGV0YnZUsFM=;
        b=Caa83wutLg+uvrQmumEUQ++kTkMdHq7mhQGt75xb3rIpb74W1Z/rNUg8ib1zMJR7aj
         TsEgBbKPprNh5XcJC6gZowOjqycVKZH55vD1Yx5f8vX8RuwjPPKkZSimwQuin+j2LuE8
         q1VP9rewTeHqBOQU+2JgqqvKpckBCnbAx40SkN5zHRkPb/61GSJ/xNoiK7Xsvzdn1hqb
         ZWwWchbRJS5RmYSSIrKj2CfgI9bPV8Xg1dTA0qfsGokRJLOQdYipP0fZs1eYjYa6bSLy
         +CP5jdAvqB2wBCgGXrNlSeXQMtH9sim33KjX7fp5MtidA2jMtDRx0ZKpJHmvk5z/jwVq
         U1nA==
X-Gm-Message-State: APjAAAUnvDUw6zD0CBbMIiH5dg90k94K5Jmm2t6GnL0lmLIw2Kol8kqM
        kunqPZlXWgW3oXIlgicRadrqyxENlRfzXnPemFI1eg==
X-Google-Smtp-Source: APXvYqynNyRwkPL2O1IuzdKmVBU44+T/ucei56yyxoVIU7iBA1GwKUKmpER+vo4IDvLxcX7+uCFdEEW2rq2m0XbKjHM=
X-Received: by 2002:aca:d746:: with SMTP id o67mr9469243oig.157.1557992422197;
 Thu, 16 May 2019 00:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190515090659.123121100@linuxfoundation.org> <20190515090704.367472403@linuxfoundation.org>
 <CAD9gYJ+zOgwe5mxns=0m=Lpz0Dthn0f1_YkyR+n0w7JaAswL1w@mail.gmail.com> <20190515163105.GB30626@kroah.com>
In-Reply-To: <20190515163105.GB30626@kroah.com>
From:   Jinpu Wang <jinpuwang@gmail.com>
Date:   Thu, 16 May 2019 09:40:10 +0200
Message-ID: <CAD9gYJKzrb5-us-6AjfJgb=pWhPw9vdTo9cW25S42u8CMHzwVA@mail.gmail.com>
Subject: Re: [PATCH 4.14 067/115] crypto: testmgr - add AES-CFB tests
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "v3.14+, only the raid10 part" <stable@vger.kernel.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snip
> >
> > Can you drop the patch?
>
> Yes, now dropped.  Sasha, I think I did this same thing in the past :)
Thanks, I remember I probably reported same thing in the past too :)

Jack
