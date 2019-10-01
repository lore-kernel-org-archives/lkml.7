Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60179C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 05:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4012168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 05:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfJAE7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 00:59:54 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:49896 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726157AbfJAE7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 00:59:53 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x914gucI059794;
        Tue, 1 Oct 2019 12:42:57 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 1 Oct 2019
 12:58:15 +0800
Date:   Tue, 1 Oct 2019 12:58:16 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Atish Patra <Atish.Patra@wdc.com>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [PATCH v2 0/3] Add support for SBI v0.2
Message-ID: <20191001045815.GA6572@andestech.com>
References: <20190927000915.31781-1-atish.patra@wdc.com>
 <20190927221913.GA4700@infradead.org>
 <8683f51f26708a468bcdf16a48db1cffac6c28d8.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8683f51f26708a468bcdf16a48db1cffac6c28d8.camel@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x914gucI059794
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 10:57:45PM +0000, Atish Patra wrote:
> On Fri, 2019-09-27 at 15:19 -0700, Christoph Hellwig wrote:
> > On Thu, Sep 26, 2019 at 05:09:12PM -0700, Atish Patra wrote:
> > > The Supervisor Binary Interface(SBI) specification[1] now defines a
> > > base extension that provides extendability to add future extensions
> > > while maintaining backward compatibility with previous versions.
> > > The new version is defined as 0.2 and older version is marked as
> > > 0.1.
> > > 
> > > This series adds support v0.2 and a unified calling convention
> > > implementation between 0.1 and 0.2. It also adds minimal SBI
> > > functions
> > > from 0.2 as well to keep the series lean. 
> > 
> > So before we do this game can be please make sure we have a clean 0.2
> > environment that never uses the legacy extensions as discussed
> > before?
> > Without that all this work is rather futile.
> > 
> 
> As per our discussion offline, here are things need to be done to
> achieve that.
> 
> 1. Replace timer, sfence and ipi with better alternative APIs
> 	- sbi_set_timer will be same but with new calling convention
> 	- send_ipi and sfence_* apis can be modified in such a way that
> 		- we don't have to use unprivileged load anymore
> 		- Make it scalable
> 
> 2. Drop clear_ipi, console, and shutdown in 0.2.
> 
> We will have a new kernel config (LEGACY_SBI) that can be manually
> enabled if older firmware need to be used. By default, LEGACY_SBI will
> be disabled and kernel with new SBI will be built. We will have to set
> a flag day in a year or so when we can remove the LEGACY_SBI
> completely.
> 
> Let us know if it is not an acceptable approach to anybody.
> I will post a RFC patch with new alternate v0.2 APIs sometime next
> week.
>

Will this legacy option be compatible will bbl?  says, version 1.0.0 or
any earlier ones?

> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> -- 
> Regards,
> Atish
