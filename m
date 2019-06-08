Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF8DC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32BF214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfFHKBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:01:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfFHKBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:01:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2BD625944C;
        Sat,  8 Jun 2019 10:01:46 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2484560BE5;
        Sat,  8 Jun 2019 10:01:41 +0000 (UTC)
Date:   Sat, 8 Jun 2019 18:01:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     lijiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com, Thomas.Lendacky@amd.com
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190608100139.GC26148@MiWiFi-R3L-srv>
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic>
 <20190608035451.GB26148@MiWiFi-R3L-srv>
 <20190608091030.GB32464@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608091030.GB32464@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 08 Jun 2019 10:01:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/19 at 11:10am, Borislav Petkov wrote:
> On Sat, Jun 08, 2019 at 11:54:51AM +0800, Baoquan He wrote:
> > Is it a UEFI box?
> 
> Yes.

OK, it doesn't matter with uefi since CONFIG_RANDOMIZE_BASE is not set. 


> 
> > If it's uefi machine, it should relate to below issue. Because kexec
> > always fails to randomly choose a new position for kernel.
> 
> The kernel succeeds in selecting a position for the kernel - the kexec
> kernel doesn't load when a panic happens. Rather, the box panics and
> nothing more.

OK, it may be different with the case we met, if panic happened when
load a kdump kernel.

We can load with 'kexec -l' or 'kexec -p', but can't boot after triggering
crash or execute 'kexec -e' to do kexec jumping.
