Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DD6CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FEA20862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG/i0zjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfJaB1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:27:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41045 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfJaB1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:27:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id l3so2800539pgr.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 18:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/xbLLTWwwR0cd5qQbRpTD2PP+wmSB7aXKTDZeJyUHcY=;
        b=hG/i0zjP4PIYhFBy9cjOQ+6FA5yvDVZTVwsRMIajyd3MWIPZ3T0uOJLuPyupkeskOu
         p4O7CK/20sK5+q9CvApRlPjlmDJPHRoeeJRRqBvIKsFlsCrn50Lu7mW0xapyTrgg7BtH
         LXafi0hTusVYmMZSxsrLU6nBtWCvO8pZmrcysBuy3SGK4glcRMGAPFSIYniDWCzl7Sik
         MOPhn7yFhwcd7jtrp7Fs0nCmXttm95KAlIIqTS6ossP+ZqZO5BOTXBdG80Uobdi4uShM
         0T4iRKxpc8Ed+ULYJ/X1Dg53tt6BQTcoO4bE4FrHOwUTmYF9QGdEpBR0wF24ZJeL0L27
         qufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/xbLLTWwwR0cd5qQbRpTD2PP+wmSB7aXKTDZeJyUHcY=;
        b=OFK4Hg7X9l2Y7j9Gq9C93p2QUnDQQR3JEpEGLT76U+CKa5+c2r51QmEDKPifO3+dBv
         l3+c2tu6/9NX1VfeybcjMgoZJcY4hD9mysm7XNQ1G56QAVfs7csFm8gOd4BCfPTreKK9
         EPCDPFavjrHif1LokXYazcdguY6f75GSMucw+pAS9GpfSDpGBPlHMi2ZkpzTituUxreA
         vl5vNKuEutLsnD4I9OtgChqvS3/6NIfpn7HjQN4Ty0re+VHZAtKhPTutPyAnnii4XJiO
         mrxVbL6HHpOWKRTzuYi/44Ztj/BZ3+mR4kX7iTQc1HNgbnMH1nckDrV4/TlR5vg6Lqjs
         vtaQ==
X-Gm-Message-State: APjAAAV/bDZTYRMFOlyQ3tWHoLKqKoYjQxP1xd615A1wxJBnB6S4Ca+i
        0v9sb8Pz/B/f6ETcVfRsbtY=
X-Google-Smtp-Source: APXvYqxPeZ8N9bZyMSYjCKY94CTqtNjhdT7egzR2ZWKkCv1KRQ2Mfmvy5+dmaQz587G4EdWPOF72qA==
X-Received: by 2002:a63:200e:: with SMTP id g14mr2889289pgg.91.1572485225237;
        Wed, 30 Oct 2019 18:27:05 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:200::1:e375])
        by smtp.gmail.com with ESMTPSA id n23sm1116451pff.137.2019.10.30.18.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 18:27:04 -0700 (PDT)
Date:   Wed, 30 Oct 2019 18:26:56 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paulburton@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Subject: Re: [PATCH] ARM: ASPEED: update default ARCH_NR_GPIO for ARCH_ASPEED
Message-ID: <20191031012655.GA5841@taoren-ubuntu-R90MNF91>
References: <20191028224909.1069-1-rentao.bupt@gmail.com>
 <CACRpkdbOPq4AYt9CLoganV_Ck9bYS9+_U3bggGKAukaQ=FHXkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbOPq4AYt9CLoganV_Ck9bYS9+_U3bggGKAukaQ=FHXkA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 01:49:43AM +0100, Linus Walleij wrote:
> On Mon, Oct 28, 2019 at 11:49 PM <rentao.bupt@gmail.com> wrote:
> 
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > Increase the max number of GPIOs from default 512 to 1024 for ASPEED
> > platforms, because Facebook Yamp (AST2500) BMC platform has total 594
> > GPIO pins (232 provided by ASPEED SoC, and 362 by I/O Expanders).
> >
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please send this patch to the ARM SoC and SoC maintainers:
> arm@kernel.org
> soc@kernel.org

Thanks Linus for the review. I will add ARM SoC and SoC maintaniers in
patch v2.

Somehow get_maintainer.pl doesn't list the 2 addresses in my tree; do I
need to send a patch to update MAINTAINERS accordingly?
 
> Yours,
> Linus Walleij
