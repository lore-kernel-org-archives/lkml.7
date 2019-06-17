Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DE7C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6249C2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfFQN6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:58:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36655 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQN6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:58:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id p15so10785202qtl.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 06:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFz3ypAEzci/q5w59/tNyFmelIHZ1nn0STu2Nvru2uc=;
        b=G03R0rm6voax48wyuCMskbVYbnj609kABDo1UvgVGRtzce68kttKVHYD3Ua9fknE9l
         uHrn+ma+FaMIIjktUVwo4UPFBD3J6cZLm9oR+00zmYO5pQDFaX8aGNwfkYaeT7gIru1q
         yQdCZz3grv5YufbblqSrilXzGO1cf9Z4kFeIbEHm1hEbD+3pqVOKGSnxutgcFjVfVJqt
         NAShANzTtI9xT7Td+Mny90tQ9MfmQ8Y/BdfRZ3FesfG2YsA4L/2BWticzugYb2x7klJF
         tGi6o4LIFguUs4lZSc+yYlKPtXhp34aoEqSnSUGAUbyt+wAZLkrKNHGrkIpFrpOKuFuN
         3I4g==
X-Gm-Message-State: APjAAAU+VWdc4Fr1jiMuQnX5F8q1sDMVv8PDRN3nbiUHAYWODpCx5zSI
        DcExkeWEJ2C4dNupzpVSgHpW9epmd87eCs3y4Do=
X-Google-Smtp-Source: APXvYqyev+G8a5jSyoJqMzYH275GJDy37HQarq/vA8SGhqIgSuHoCBiXgAGnWnLDw/V+JEYWqCTG39p+QIItQLSgxBI=
X-Received: by 2002:aed:2bc1:: with SMTP id e59mr74159317qtd.7.1560779887799;
 Mon, 17 Jun 2019 06:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190617124632.1176809-1-arnd@arndb.de> <6103cc84-6af3-7b82-4cac-aea500934dd1@linux.intel.com>
In-Reply-To: <6103cc84-6af3-7b82-4cac-aea500934dd1@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jun 2019 15:57:50 +0200
Message-ID: <CAK8P3a381XbG8BGOPo3tN6+q2EzFU+9R9Q=q-uv=Mbf931bt=g@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: disallow building without
 CONFIG_PCI again
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 3:52 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> On 6/17/19 2:45 PM, Arnd Bergmann wrote:
> > Compile-testing without PCI just causes warnings:
> >
> > sound/soc/sof/sof-pci-dev.c:330:13: error: 'sof_pci_remove' defined but not used [-Werror=unused-function]
> >   static void sof_pci_remove(struct pci_dev *pci)
> >               ^~~~~~~~~~~~~~
> > sound/soc/sof/sof-pci-dev.c:230:12: error: 'sof_pci_probe' defined but not used [-Werror=unused-function]
> >   static int sof_pci_probe(struct pci_dev *pci,
> >              ^~~~~~~~~~~~~
> >
> > I tried to fix this in a way that would still allow compile
> > tests, but it got too ugly, so this just reverts the patch
> > that allowed it in the first place.
> >
> > Most architectures do allow enabling PCI, so the value of the
> > COMPILE_TEST alternative was not very high to start with.
>
> I think COMPILE_TEST has value in that it exposed issues in the PCI
> headers, and in general COMPILE_TEST exposes code that can be
> simplified/refactored. That said I don't have the time to suggest an
> alternative at the moment so it's fine with me if you want to revert. If
> you don't mind sharing your config it'd help me work on this when I get
> a chance.

I agree that fixing this in the pci headers would be best. Ideally we would
be able to compile-test PCI drivers without any #ifdef in the sources,
while ending up with an empty .o file as the compiler can discard all
local functions starting with an unused pci_driver.

I saw the error in a randconfig build, uploaded the .config to
https://pastebin.com/zBeyM41R now.

        Arnd
