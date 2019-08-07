Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6E4C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F7E21E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbfHGNoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:44:05 -0400
Received: from verein.lst.de ([213.95.11.211]:37842 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388240AbfHGNoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:44:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 986EA68B20; Wed,  7 Aug 2019 15:44:01 +0200 (CEST)
Date:   Wed, 7 Aug 2019 15:44:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christoph Hellwig <hch@lst.de>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: remove sn2, hpsim and ia64 machvecs
Message-ID: <20190807134401.GA14792@lst.de>
References: <20190807133049.20893-1-hch@lst.de> <0b5ef759-06c7-4f12-5e8b-ce35d2f25b5c@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b5ef759-06c7-4f12-5e8b-ce35d2f25b5c@physik.fu-berlin.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 03:35:37PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Christoph!
> 
> On 8/7/19 3:30 PM, Christoph Hellwig wrote:
> > let me know what you think of this series.  This drops the pretty much
> > dead sn2 and hpsim support, which then allows us to build a single ia64
> > kernel image that supports all remaining systems without extra indirections
> > in the fast path.
> 
> Interesting. Does that mean Debian no longer needs to maintain two different
> kernels for ia64, currently named "itanium" and "mckinley"?

I don't think so.  Assumeing one of them sets CONFIG_ITANIUM and the
other just CONFIG_MCKINLEY, the first one already covers everything that
the second can.  But assuming both set CONFIG_IA64_GENERIC they should
both get a little faster as a lot of indirect calls there just exist for
SN2 are gone with this.  And if my memory serves me right indirect calls
have always been rather expensive on ia64 vs other architectures (at least
before spectre mitigations made others slower as well).

> 
> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
---end quoted text---
