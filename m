Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB6C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A7021873
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DPUUic0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbfGQRZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:25:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40922 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfGQRZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:25:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so24172192qtn.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y3o2MAlK+hZOMib5Fac+i/rBUtNgoVpu1Wg0Rqwft/s=;
        b=DPUUic0kZrEK5De+KOwCI8bpRhFk2KK+ZmZlM56sbOTXqLpgamN78Ag4v9yfk6ha5H
         u56XFFBXun8Schg9m40q0aRD2TZKdDv6ESpYsvcSnWZlYcj8d3dqiezrrkRbhSia2lp9
         dHXiPKsYyKU0FUUIgxbSAoWxn1HlLfjp1eDs0N+OKcO7v/o02m1mKt2yWQKe+y1vftDT
         Ul4Fptj5c/ybCtg0baZpgxb8VXQAxp5Yr4RjuRk8bN9mnLM/XwsmkahyzrVSnV32wX9X
         7RreQ6Z5ik0HALFGwOkE+iqeLPK+SS2TK1e0Kn463bPTaiT0vevLxAfRm64mKxbO1aRz
         AsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y3o2MAlK+hZOMib5Fac+i/rBUtNgoVpu1Wg0Rqwft/s=;
        b=GE/CREMI4nWOOxxb4jlHIy/nMVAUv7knTVUSEgCljLBl81LY02LDDtnSsVViDcZhST
         f8LoBp62vcTliKeb+HVr87ZPwZkIpTJ8XnONhXziIgHIRuu2Dc88KlXVY2TnWQPUF0v4
         zFhlqsOEZWPZ8iwKqbmyTfCFXzkpyy/vCIlgEAJ8uWKYjBIRSuzduRWkIAVZhPGkaZsE
         40ApktRYkZMqgOrb77wu/QwP9NnTsBire2gGnTbqOZlXxkK3bdMw09rLfrVTQEgk1voj
         m2Hst+hLxgUEzGf+l3MsQJWyvMow23WNDU5B27MSxGZYbzpqtZD9qpZ4UY5kPYM/kbs/
         8Lkg==
X-Gm-Message-State: APjAAAVgwlPrm4uwfO88sHJzzejy7nvT+/7A9pK9hHZO0wU6WXXQfpcN
        v397Ev3ZHXzize2brGDTVTZ6WQ==
X-Google-Smtp-Source: APXvYqyHlN70UeDzu9ByPw4va7icrC2D2fl5bsL6h+PrR1CAEoD2mQjrGDPi5Cc4I4CDuQroOsYYWw==
X-Received: by 2002:a0c:b909:: with SMTP id u9mr29849022qvf.10.1563384345959;
        Wed, 17 Jul 2019 10:25:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w16sm10407356qki.36.2019.07.17.10.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 10:25:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hnngW-0006Ts-Uq; Wed, 17 Jul 2019 14:25:44 -0300
Date:   Wed, 17 Jul 2019 14:25:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
Message-ID: <20190717172544.GL12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
 <20190717122558.GF12119@ziepe.ca>
 <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com>
 <20190717165628.GJ12119@ziepe.ca>
 <5d2f5570.1c69fb81.f3832.3c3f@mx.google.com>
 <20190717171216.GK12119@ziepe.ca>
 <5d2f594d.1c69fb81.baadd.d81d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d2f594d.1c69fb81.baadd.d81d@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 10:22:20AM -0700, Stephen Boyd wrote:
> Quoting Jason Gunthorpe (2019-07-17 10:12:16)
> > On Wed, Jul 17, 2019 at 10:05:52AM -0700, Stephen Boyd wrote:
> > > 
> > > Yes. The space savings comes from having the extra module 'cr50.ko' that
> > > holds almost nothing at all when the two drivers are modules.
> > 
> > I'm not sure it is an actual savings, there is alot of minimum
> > overhead and alignment to have a module in the first place.
> > 
> 
> Yeah. I'm pretty sure that's why it's a bool and not a tristate for this
> symbol. A module has overhead that is not necessary for these little
> helpers.

Linking driver stuff like that to the kernel is pretty hacky, IMHO

Jason
