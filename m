Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85065C43215
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5790920675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sjADaI35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfLDAPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 19:15:21 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34776 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLDAPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 19:15:20 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so5219699oig.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 16:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9JhZIkY5UYbY9sicT+H9HLXPSEjz22qXNqZGrcjpfw=;
        b=sjADaI35VirKvqsrqcyE6zHoNPjuN6G2m9ZEfOP0vAzlUcOZatDYa+fY1Lh7TSemxA
         E9z4+FLH81bsPE7jhKCCKN1DmErGGdIxeh39qCg4GwDB8ZsVx4r61KmTjQwCb/UuucdY
         MQzoUEuK07SBtKntXdJCpBk0kcT0omifR4aXFxcw7o3rx9lv7uA9aBUSsKzYL5hvmff7
         VBUsVf8LYZp9bvzGB9w4p+HLgV4aSriJTATl3XEvLqXfP38gMCA0YJngB18JE+aJyc3p
         AyoPpUAJe7VB1HdvyAHKuhO3bnO22MuhuJUDQ1jhzTpN+/z3jkA188FqW0RuyD6OHbD0
         B3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9JhZIkY5UYbY9sicT+H9HLXPSEjz22qXNqZGrcjpfw=;
        b=hKWYe7SbhtFdD2LSJrK5yJycB1QgtlnS7XMZTOgleInzpVDSB6VkUz+swAAbY3VL9F
         pIHydzntlc4YNRwdCja+ienFv+xayWq676j8m3AaZqYVnaxKRuteWmp9uUWag29Zr00B
         ePVTgoMO0GBYilAOh0ORQ6nOaucoRAYwprzwhyujUV3qbyfqL1AHSvxiZDAa7J6GPT/M
         28c9UgeJDwpzpB/kanVnhAiCDA0W730WAaVgnp+KgSmbJbd6WD7V791gBkiWY0YYf1Hp
         FUncm7seZqNpFROAgGzYphJKezM3kLsqHLA1UKfllYhV1rtfRVSoqyiWJSgj2msnV3fm
         EqNA==
X-Gm-Message-State: APjAAAVsASoVb4aAIBPdyo8cXRpTaMnpyuQ5bbP3QR51Mq4OEZKXcFvT
        SgJyLM+BURGQfK70eqPHxnHyjS5B65yjEG5F0pVmAA==
X-Google-Smtp-Source: APXvYqzZunLuEIN9d3ELG/cd3hfZU5berEzOo2/mUNAdgvjVy3WYCgxi0H9bamLriZ+TeAij+34DEI9woMPAH/4Z6q0=
X-Received: by 2002:aca:2405:: with SMTP id n5mr318915oic.73.1575418519668;
 Tue, 03 Dec 2019 16:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20191203034655.51561-1-alastair@au1.ibm.com> <20191203035057.GR20752@bombadil.infradead.org>
 <1e3892815b9684e3fb4f84bd1935ea7e68cd07d8.camel@au1.ibm.com> <20191203124240.GT20752@bombadil.infradead.org>
In-Reply-To: <20191203124240.GT20752@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 3 Dec 2019 16:15:08 -0800
Message-ID: <CAPcyv4hccpaw5fFdp7u3Z=C0zNZ1oTBtNfyLhJ16C2Dmq+Qp3Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] Add support for OpenCAPI SCM devices
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Alastair D'Silva" <alastair@au1.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 4:43 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Dec 03, 2019 at 03:01:17PM +1100, Alastair D'Silva wrote:
> > On Mon, 2019-12-02 at 19:50 -0800, Matthew Wilcox wrote:
> > > On Tue, Dec 03, 2019 at 02:46:28PM +1100, Alastair D'Silva wrote:
> > > > This series adds support for OpenCAPI SCM devices, exposing
> > >
> > > Could we _not_ introduce yet another term for persistent memory?
> > >
> >
> > "Storage Class Memory" is an industry wide term, and is used repeatedly
> > in the device specifications. It's not something that has been pulled
> > out of thin air.
>
> "Somebody else also wrote down Storage Class Memory".  Don't care.
> Google gets 750k hits for Persistent Memory and 150k hits for
> Storage Class Memory.  This term lost.
>
> > The term is also already in use within the 'papr_scm' driver.
>
> The acronym "SCM" is already in use.  Socket Control Messages go back
> to early Unix (SCM_RIGHTS, SCM_CREDENTIALS, etc).  Really, you're just
> making the case that IBM already uses the term SCM.  You should stop.

I tend to agree. The naming of things under
arch/powerpc/platforms/pseries/ is not under my purview, but
drivers/nvdimm/ is. Since this driver is colocated with the "pmem"
driver let's not proliferate the "scm" vs "pmem" confusion.
