Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1641DC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3EF2189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562245047;
	bh=2hR0pY5iMZ0Mzal+gCP9kE9xa8QstyB6RpnG93AvzHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CD3X+jox2PHOJYUY6yrPfy9hWzov0nU+p8k/bEl570m7WPHjqO1pFdIL+h0n9x8Pw
	 sJqR37KA+QUr4yKBT+vUznkG7gf/Z1udJf/8XCiGydXzQnR5esuhBA9ftH0KENz2ug
	 8h+ZqKUI9KaVQKWvJnYm1ZNv8ItydmhUfq5mdPuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfGDM50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfGDM5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:57:25 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD5A2189E;
        Thu,  4 Jul 2019 12:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562245045;
        bh=2hR0pY5iMZ0Mzal+gCP9kE9xa8QstyB6RpnG93AvzHs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qcAuhQT1PHD9pQKa/lHgF03Ldk6XALhEeSyrHW5bffmiBE++WtH6fMbLo4QYi/GOv
         5kWfA0q69x+rOAudE46fTUW1sIDe1ZcpCqCNRI3XMFwpIYfyHDtSXjRf58d6tWTClv
         7Zh4YprLD3emUcuAp8jtaju6FNfqcUxz02tWIQUM=
Received: by mail-lj1-f180.google.com with SMTP id k18so6061650ljc.11;
        Thu, 04 Jul 2019 05:57:24 -0700 (PDT)
X-Gm-Message-State: APjAAAX/3DQuFApZUyR9a5dL3+ZSR+ajoKfmzfq9fmN0yQQnGi05yRZU
        YvgGMwPlnHZRkI/KdybsK4rjc9g84CHLJCqhgj8=
X-Google-Smtp-Source: APXvYqz7Yne2c4j0yOEnBWVsz0GsuIQwXj2ZqjRNKVMgq/yoVqwQylgQcqjaP2XNuRfBeGt5nYb/NmZMgx/hoZ+2Ot4=
X-Received: by 2002:a2e:50e:: with SMTP id 14mr25223510ljf.5.1562245043093;
 Thu, 04 Jul 2019 05:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfx6HeJgTu9TiusGACyt+uXVSmnpibO0m-qzCvFQNGK7g@mail.gmail.com>
 <VI1PR04MB44316904F765E93CC1DFA0EDEDFA0@VI1PR04MB4431.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB44316904F765E93CC1DFA0EDEDFA0@VI1PR04MB4431.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 4 Jul 2019 14:57:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdYJKe019CKT=hPRXLejMdZ1KNzxpFh60ruToKOqnAorQ@mail.gmail.com>
Message-ID: <CAJKOXPdYJKe019CKT=hPRXLejMdZ1KNzxpFh60ruToKOqnAorQ@mail.gmail.com>
Subject: Re: [EXT] [BUG BISECT] Net boot fails on VF50 after "dmaengine:
 fsl-edma: support little endian for edma driver"
To:     Peng Ma <peng.ma@nxp.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Leo Li <leoyang.li@nxp.com>, Andy Tang <andy.tang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 at 04:10, Peng Ma <peng.ma@nxp.com> wrote:
>
> Hi Krzysztof,
>
> I am sorry, It is my mistake to forget about VF50 used EDMA IP with little endian.
> The Register(CHCFG0 - CHCFG15) of our platform designed as follows:
> *-------------------------------------------------------------------------------*
> |     Offset   | Big endian Register| Little endian Register|
> |---------------------|--------------------------|-----------------------------|
> |     0x0     |     CHCFG0    |     CHCFG3      |
> |---------------------|--------------------------|-----------------------------|
> |     0x1     |     CHCFG1    |     CHCFG2      |
> |---------------------|--------------------------|-----------------------------|
> |     0x2     |     CHCFG2    |     CHCFG1      |
> |---------------------|--------------------------|-----------------------------|
> |     0x3     |     CHCFG3    |     CHCFG0      |
> |---------------------|--------------------------|-----------------------------|
> |     ...      |        ......     |         ......      |
> |---------------------|--------------------------|-----------------------------|
> |     0xC     |     CHCFG12   |     CHCFG15     |
> |---------------------|--------------------------|-----------------------------|
> |     0xD     |     CHCFG13   |     CHCFG14     |
> |---------------------|--------------------------|-----------------------------|
> |     0xE     |     CHCFG14   |     CHCFG13     |
> |---------------------|--------------------------|-----------------------------|
> |     0xF     |     CHCFG15   |     CHCFG12     |
> *-------------------------------------------------------------------------------*
>
> So we need this patch, I make some changes,Please help me to test attatchment on VF50 board,
> Thanks.

With the patch VF50 boots fine.

BTW, Colibri VF50 nicely boots from network almost out of the box so
it is easy to add it to automated tests for simple boot tests. This
way you do not have to manually test it on such platform...

Best regards,
Krzysztof
