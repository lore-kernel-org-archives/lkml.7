Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83260C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61839206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfKUP4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:56:31 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:55268 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfKUP42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:56:28 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iXooW-0002pj-Tl; Thu, 21 Nov 2019 15:56:13 +0000
Message-ID: <58067b19b218600f95dbb9726e63b435d040be1c.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 3/8] powerpc: fix vdso32 for ppc64le
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 21 Nov 2019 15:56:12 +0000
In-Reply-To: <CAK8P3a1eZwCVMdibuPDzbSF6430yBLuoF+o-VZKX_HBWGePCqA@mail.gmail.com>
References: <20191108203435.112759-1-arnd@arndb.de>
         <20191108203435.112759-4-arnd@arndb.de>
         <fdcb510863c801f1f64448e558ee0f8ed20db418.camel@codethink.co.uk>
         <CAK8P3a3BPhX_NRFj66WyRLQUOCV-FGRjmPCgB7gqxMoK8hfywg@mail.gmail.com>
         <d82ef7b94b9c3adc4fbb4e62c17b81a868fb32d8.camel@codethink.co.uk>
         <CAK8P3a1eZwCVMdibuPDzbSF6430yBLuoF+o-VZKX_HBWGePCqA@mail.gmail.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-21 at 11:02 +0100, Arnd Bergmann wrote:
> On Wed, Nov 20, 2019 at 10:49 PM Ben Hutchings
> <ben.hutchings@codethink.co.uk> wrote:
> > On Wed, 2019-11-20 at 20:35 +0100, Arnd Bergmann wrote:
> > > On Wed, Nov 20, 2019 at 8:13 PM Ben Hutchings
> > > <ben.hutchings@codethink.co.uk> wrote:
> > > > On Fri, 2019-11-08 at 21:34 +0100, Arnd Bergmann wrote:
> > > > > On little-endian 32-bit application running on 64-bit kernels,
> > > > > the current vdso would read the wrong half of the xtime seconds
> > > > > field. Change it to return the lower half like it does on
> > > > > big-endian.
> > > > 
> > > > ppc64le doesn't have 32-bit compat so this is only theoretical.
> > > 
> > > That is probably true. I only looked at the kernel, which today still
> > > supports compat mode for ppc64le, but I saw the patches to disable
> > > it, and I don't think anyone has even attempted building user space
> > > for it.
> > 
> > COMPAT is still enabled for some reason, but VDSO32 isn't (since 4.2).
> 
> Ok, I had missed that detail. Should I just drop my patch then?

I think so.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

