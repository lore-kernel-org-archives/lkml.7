Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76B0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D142081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBhID84i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfCIKY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 05:24:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41481 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfCIKY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 05:24:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id z25so85977ljk.8;
        Sat, 09 Mar 2019 02:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gSsgWXFYalZQookWaCKR6wCk4xPTvnEbjw0C5FDjrdA=;
        b=rBhID84iEmt/6sYgGpv4ay5RAHMWfMuXiq5g6whFVjaeq3bDgVGQUFPuJbxqYBhuUP
         0g3r0DGEVuOqsWKfP2UdYMsobqxnqzGEta3QG1vP4Kv5BQXBpRP6bVhSxw6nAm2Qw7xi
         9Xt3+JMUwZDL6Cba/NJuY2R4b4SuRGATbQRWiEZZIrFetzHUNWzokhUD9s0cEveSwUAB
         Pw/Uueqv63l3U1Tkib3uwCDeK3Ok2FRWhoL8tlBlQVYVkbN+kaO/LPAAZYJZJdLXGP3H
         wYGyPeu6WfAbl9TGhOYBdp4C5BFMVmimEah4+1cXN+7pkFLKISDBqNLgb7G8wCIbwT3L
         Cg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gSsgWXFYalZQookWaCKR6wCk4xPTvnEbjw0C5FDjrdA=;
        b=V4pJnjctAVMtj0DIfXHH6F/LdNJ5EgCZBr2v60Uy+HhYTYJdumNQ5XhYX264nXv867
         KcT+T9bMn2xw2VtzCPx550LsvSoywr3RvWeizhylaYiEY3vrhMj4Jw0W+oINB0o9PGl7
         IscrsdKElT6wtdVbVeZC5SzND2wByFpQsVB468cZirw33cnRb/WLCcWztJfHTe66yr8X
         P0kTUER48yzWm8c3aQPxnqkXFjRFaYt7DvrlLSgtIF24dmM7Oel+sID1qNJfiw2Z2eOB
         mVjVDRbVNfIwnhtnNR9Juqs1prKZFHwTkrI4F8Q5lGcKh5S+Qu1KfMmkTMqpqw9cPnho
         z2vw==
X-Gm-Message-State: APjAAAUrLs37bWemr+y71PcjfzqNXlc+PxQee5F9spBLF30699sRiTW3
        HJX8eF81Tw+Ot4cJJZt4/Oc=
X-Google-Smtp-Source: APXvYqxaoCLG3ssnnjoXu3fUAiVfSdaNVgEfxhbQWOo7xTcXOUX3TMQg8qq2+ak8LyqHuoNidQp9NA==
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr3662250lji.155.1552127094701;
        Sat, 09 Mar 2019 02:24:54 -0800 (PST)
Received: from localhost (89-64-59-159.dynamic.chello.pl. [89.64.59.159])
        by smtp.gmail.com with ESMTPSA id l11sm20771lja.38.2019.03.09.02.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 02:24:54 -0800 (PST)
Date:   Sat, 9 Mar 2019 11:24:28 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v2] iio: proximity: as3935: fix use-after-free on device
 remove
Message-ID: <20190309102427.GA3565@arch>
References: <20190308175935.21904-1-TheSven73@gmail.com>
 <20190308202936.GA32641@arch>
 <CAGngYiVgEDTQxynjPDMO_ZApAX6uyvUL+iqyK-QHnhDz=E4eCw@mail.gmail.com>
 <20190308223249.GC32641@arch>
 <CAGngYiWSaJqtzUA+nUNJTcssUq1Y=UzYc2u8hDcKDjF6944o1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGngYiWSaJqtzUA+nUNJTcssUq1Y=UzYc2u8hDcKDjF6944o1Q@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 05:46:24PM -0500, Sven Van Asbroeck wrote:
> On Fri, Mar 8, 2019 at 5:33 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
> >
> >
> > So perhaps that change deserves a separate patch because it smells like
> > a code cleanup.
>
> Not really. This patch fixes the order in which resources are torn
> down on release().

What I meant is that delayed work initialization could stay where it was.
The reason you moved it is readability improvement so to me it is more
of a cleanup hence I suggested a separate patch. Up to you.

> You do this by fixing the order by which devm-resources are allocated
> on probe().
>
> So it's a fundamental use-after-free fix, and not really a cleanup.
> But I'm happy to split into multiple patches if you want ?
