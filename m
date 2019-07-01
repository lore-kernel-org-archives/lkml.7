Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35764C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087E821721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HbzLSATl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfGASzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:55:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36973 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGASzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:55:46 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so31227917iok.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RJ0nEuxA5ZfGEtI2ORfLwcWi8vWMBFVOAlEHomBChyQ=;
        b=HbzLSATlu0bOPE6tk/xnT9HDbbVtyy45AYUGmkUYAX6YsI55Lpn71MXmredYkGWMbq
         1VDR9JEMs83A5H6kwLxkMrdr44fypQJHUNuTDthZLSWTaTyEibYd0g2IUL2UbrIo1tcN
         vXYVBHOzPTaZlFut6jN8aNqd4M2DQbXo0H2btfX9eCdhG1WbruSR2gRKWR38BsjypdHc
         2sLzgCevrNW8pEQM6BKC4Fr9c+vwXxv6Lw202eSNQgMQB4RNLkGrVAa2JfAzn6+a1oND
         fX186svC9PpMypUq4VhzVOmMN0oIsPB/0BdKcPV2A9uIUyNo+FksHyv5Qu0Sl/eP4FUs
         L9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RJ0nEuxA5ZfGEtI2ORfLwcWi8vWMBFVOAlEHomBChyQ=;
        b=gbu3MMsugQnGFlqSMpzBp2l72LOOmqehIT0HY5ehtzo87FPs2FWb+n93GsHf8JVDz+
         wJnIjdD3ZOAyKlwyJW2MO1Elt+MH1+u9UgN+//hAT8E7xyN3GRH3h7lRD3MJ1ESPa0aF
         /mhITvpeKqx81N7ayTq+Tr4qZp/UbWzyjAqyPc8k2UY0w+3fEm6X6GnXDLEUYahNAzJS
         YOaGNqLCdK6zaeWxzMOeeIM4/HARnl47UaKf9rgaqA530qpKdv6tyng2h5/HYGMZXBKg
         EomndTqba28lagxsg5zTa2UBccLWsjZw5vieBw3ZN3MTlsEZ92XycaYpAIbTbYEHF4/p
         gnhQ==
X-Gm-Message-State: APjAAAWDeQbTgyu4ETN4QjXW3l/GqFfnHzkiQ3wjDCWZPCLIXUiEU2ec
        0fgU0bQYIv12aJyMEIHG4LSVlQ==
X-Google-Smtp-Source: APXvYqwL+eY8ECnhe7jn5wjvS3/54CfYE6LIGPJ7PbOYEamcU5iLZxD/gx7lxHGv1GuBLS9usOFDKA==
X-Received: by 2002:a02:bb08:: with SMTP id y8mr2038974jan.51.1562007345538;
        Mon, 01 Jul 2019 11:55:45 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id r139sm24862445iod.61.2019.07.01.11.55.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 11:55:45 -0700 (PDT)
Date:   Mon, 1 Jul 2019 11:55:44 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <Atish.Patra@wdc.com>
cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "ottosabart@seberm.com" <ottosabart@seberm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "johan@kernel.org" <johan@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 0/7] Unify CPU topology across ARM & RISC-V
In-Reply-To: <5f31cb3c576bdbd89665614582af66d04ece8f29.camel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1907011154310.3867@viisi.sifive.com>
References: <20190627195302.28300-1-atish.patra@wdc.com>  <alpine.DEB.2.21.9999.1907011143520.3867@viisi.sifive.com> <5f31cb3c576bdbd89665614582af66d04ece8f29.camel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2019, Atish Patra wrote:

> On Mon, 2019-07-01 at 11:44 -0700, Paul Walmsley wrote:
> > 
> > Looks like patches 1, 6, and 7 are missing your Signed-off-by:.  Can I 
> > add those?
> > 
> Sure. 
> 
> Is it a common practice to add "Signed-off-by:" the sender even if the
> sender has not touched the patch at all?

Yes, see section 11(c) here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n418

The main factor here is that you collected and resent the patches - thus 
you're in the patch submission chain.


- Paul
