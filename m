Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13276C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39F32075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfE1Jq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:46:57 -0400
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:56554 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbfE1Jq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:46:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2FF991803EF1F;
        Tue, 28 May 2019 09:46:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mist72_7673f0578614e
X-Filterd-Recvd-Size: 4027
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 May 2019 09:46:53 +0000 (UTC)
Message-ID: <7bad367da73e07dca74941f80ed998590c6f14fb.camel@perches.com>
Subject: Re: [EXT] Re: [V3 1/2] dmaengine: fsl-dpaa2-qdma: Add the
 DPDMAI(Data Path DMA Interface) support
From:   Joe Perches <joe@perches.com>
To:     Peng Ma <peng.ma@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Date:   Tue, 28 May 2019 02:46:52 -0700
In-Reply-To: <VI1PR04MB44314E4B35FA0C7E850CD512ED1E0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190409072212.15860-1-peng.ma@nxp.com>
         <20190426124550.GE28103@vkoul-mobl>
         <VI1PR04MB44314E4B35FA0C7E850CD512ED1E0@VI1PR04MB4431.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-28 at 04:47 +0000, Peng Ma wrote:
> -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
[]
> > > diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> > > b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> > > new file mode 100644
> > > index 0000000..c8a7b7f
> > > --- /dev/null
> > > +++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> > > @@ -0,0 +1,524 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/* Copyright 2014-2018 NXP */
> > > +
> > > +/*
> > > + * Redistribution and use in source and binary forms, with or without
> > > + * modification, are permitted provided that the following conditions are
> > met:
> > > + * * Redistributions of source code must retain the above copyright
> > > + * notice, this list of conditions and the following disclaimer.
> > > + * * Redistributions in binary form must reproduce the above
> > > +copyright
> > > + * notice, this list of conditions and the following disclaimer in
> > > +the
> > > + * documentation and/or other materials provided with the distribution.
> > > + * * Neither the name of the above-listed copyright holders nor the
> > > + * names of any contributors may be used to endorse or promote
> > > +products
> > > + * derived from this software without specific prior written permission.
> > > + *
> > > + *
> > > + * ALTERNATIVELY, this software may be distributed under the terms of
> > > +the
> > > + * GNU General Public License ("GPL") as published by the Free
> > > +Software
> > > + * Foundation, either version 2 of that License or (at your option)
> > > +any
> > > + * later version.
> > > + *
> > > + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> > CONTRIBUTORS "AS IS"
> > > + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> > LIMITED
> > > +TO, THE
> > > + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> > PARTICULAR
> > > +PURPOSE
> > > + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR
> > > +CONTRIBUTORS BE
> > > + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
> > > +OR
> > > + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
> > PROCUREMENT
> > > +OF
> > > + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> > > +BUSINESS
> > > + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
> > > +WHETHER IN
> > > + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
> > > +OTHERWISE)
> > > + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
> > > +ADVISED OF THE
> > > + * POSSIBILITY OF SUCH DAMAGE.
> > > + */
> > 
> > we have SiPDX tag, why do you need ths here!
> > 
> [Peng Ma] It is my mistake. I will fixe it.

Please have your company review which licenses you are
intending to use as the SPDX tag does not match the
licenses shown in the text.


