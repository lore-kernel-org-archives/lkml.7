Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D89C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B7421721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfFLFuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 01:50:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfFLFuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 01:50:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB6C4859FF;
        Wed, 12 Jun 2019 05:50:01 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A692600CD;
        Wed, 12 Jun 2019 05:49:53 +0000 (UTC)
Date:   Wed, 12 Jun 2019 13:49:49 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, lijiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, Thomas.Lendacky@amd.com
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190612054949.GA23066@dhcp-128-65.nay.redhat.com>
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic>
 <20190608035451.GB26148@MiWiFi-R3L-srv>
 <20190608091030.GB32464@zn.tnic>
 <20190608100139.GC26148@MiWiFi-R3L-srv>
 <20190608100623.GA9138@zn.tnic>
 <20190608102659.GA9130@MiWiFi-R3L-srv>
 <20190610113747.GD5488@zn.tnic>
 <20190612015549.GI26148@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612015549.GI26148@MiWiFi-R3L-srv>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 12 Jun 2019 05:50:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/19 at 09:55am, Baoquan He wrote:
> On 06/10/19 at 01:37pm, Borislav Petkov wrote:
> > On Sat, Jun 08, 2019 at 06:26:59PM +0800, Baoquan He wrote:
> > > OK, I see. Then it should be the issue we have met and talked about with
> > > Tom.
> > > https://lkml.kernel.org/r/20190604134952.GC26891@MiWiFi-R3L-srv
> > > 
> > > You can apply Tom's patch as below. I tested it, it can make kexec
> > > kernel succeed to boot, but failed for kdump kernel booting. The kdump
> > > kernel can boot till the end of kernel initialization, then hang with a
> > > call trace. I have pasted the log in the above thread. Haven't got the
> > > reason.
> > > http://lkml.kernel.org/r/508c2853-dc4f-70a6-6fa8-97c950dc31c6@amd.com
> > 
> > I can confirm the same observation.
> 
> With further investigation, the failure after applying Tom's patch is
> caused by OOM. When increase crashkernel reservation to 512M, kdump
> kernel can boot successfully. I noticed your crashkernel reservation is
> 256M, that will fail and stuck there very possibly.

Usually for Fedora/RHEL variant kernel + userspace, 160M is a good value
works for common setup.  Sometimes people forgot to strip debuginfo,
thus the kernel modules packed in initramfs is too big and cause out of
memory.

> 
> So Tom's patch can fix the issue. We need further check why much more
> crashkernel memory is needed on those AMD boxes with sme support..
> 
> Thanks
> Baoquan
