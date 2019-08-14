Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BFCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A5520665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfHNBHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:07:24 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:29400 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726747AbfHNBHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 21:07:23 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Aug 2019 21:07:23 EDT
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x7E0tamm019296;
        Wed, 14 Aug 2019 08:55:36 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 14 Aug 2019
 09:07:07 +0800
Date:   Wed, 14 Aug 2019 09:07:08 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        <linux-riscv@lists.infradead.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>
Subject: Re: [PATCH 13/15] riscv: clear the instruction cache and all
 registers when booting
Message-ID: <20190814010707.GA22925@andestech.com>
References: <20190813154747.24256-1-hch@lst.de>
 <20190813154747.24256-14-hch@lst.de>
 <20190814010013.GA18655@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190814010013.GA18655@andestech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x7E0tamm019296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please ignore the previous mail, I must have missed this part of the patch,
> 
> > +	csrr	t0, CSR_MISA
> > +	andi	t0, t0, (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D)
> > +	bnez	t0, .Lreset_regs_done
> > +

In S-mode we were not able to obtain the ISA information in misa, but now
the nommu port is in M-mode so this is rather straightforward.

