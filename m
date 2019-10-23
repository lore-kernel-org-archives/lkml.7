Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E70CA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF0621848
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbfJWCDl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 22:03:41 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:49310 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJWCDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:03:41 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9N23MKB021293
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 23 Oct 2019 11:03:22 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9N23Mqq023495;
        Wed, 23 Oct 2019 11:03:22 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9N1xBGi000839;
        Wed, 23 Oct 2019 11:03:22 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-109427; Wed, 23 Oct 2019 11:01:35 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0439.000; Wed,
 23 Oct 2019 11:01:34 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     Michal Hocko <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Thread-Topic: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Thread-Index: AQHVhPYxuKrdanK4Pk2pyFsBlimO86dfuBWAgATFroCAAC2WAIABDXAAgAALI4CAAAKLgIAADVAAgAAKCgCAAQz4gA==
Date:   Wed, 23 Oct 2019 02:01:33 +0000
Message-ID: <20191023020133.GA24383@hori.linux.bs1.fc.nec.co.jp>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-11-osalvador@suse.de>
 <20191018120615.GM5017@dhcp22.suse.cz> <20191021125842.GA11330@linux>
 <20191021154158.GV9379@dhcp22.suse.cz> <20191022074615.GA19060@linux>
 <20191022082611.GD9379@dhcp22.suse.cz> <20191022083505.GA19708@linux>
 <20191022092256.GH9379@dhcp22.suse.cz> <20191022095852.GB20429@linux>
In-Reply-To: <20191022095852.GB20429@linux>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <BF3613A18D765B4890293C557CE91D47@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 11:58:52AM +0200, Oscar Salvador wrote:
> On Tue, Oct 22, 2019 at 11:22:56AM +0200, Michal Hocko wrote:
> > Hmm, that might be a misunderstanding on my end. I thought that it is
> > the MCE handler to say whether the failure is recoverable or not. If yes
> > then we can touch the content of the memory (that would imply the
> > migration). Other than that both paths should be essentially the same,
> > no? Well unrecoverable case would be essentially force migration failure
> > path.
> > 
> > MADV_HWPOISON is explicitly documented to test MCE handling IIUC:
> > : This feature is intended for testing of memory error-handling
> > : code; it is available only if the kernel was configured with
> > : CONFIG_MEMORY_FAILURE.
> > 
> > There is no explicit note about the type of the error that is injected
> > but I think it is reasonably safe to assume this is a recoverable one.
> 
> MADV_HWPOISON stands for hard-offline.
> MADV_SOFT_OFFLINE stands for soft-offline.

Maybe MADV_HWPOISON should've be named like MADV_HARD_OFFLINE, although
it's API and hard to change once implemented.

> 
> MADV_SOFT_OFFLINE (since Linux 2.6.33)
>               Soft offline the pages in the range specified by addr and
>               length.  The memory of each page in the specified range is
>               preserved (i.e., when next accessed, the same content will be
>               visible, but in a new physical page frame), and the original
>               page is offlined (i.e., no longer used, and taken out of
>               normal memory management).  The effect of the
>               MADV_SOFT_OFFLINE operation is invisible to (i.e., does not
>               change the semantics of) the calling process.
> 
>               This feature is intended for testing of memory error-handling
>               code;

Although this expression might not clear enough, madvise(MADV_HWPOISON or
MADV_SOFT_OFFLINE) only covers memory error handling part, not MCE handling
part.  We have some other injection methods in the lower layers like
mce-inject and APEI.

> it is available only if the kernel was configured with
>               CONFIG_MEMORY_FAILURE.
> 
> 
> But both follow different approaches.
> 
> I think it is up to some controlers to trigger soft-offline or hard-offline:

Yes, I think so.  One usecase of soft offline is triggered by CMCI interrupt
in Intel CPU.  CMCI handler stores corrected error events in /dev/mcelog.
mcelogd polls on this device file and if corrected errors occur often enough
(IIRC the default threshold is "10 events in 24 hours",) mcelogd triggers
soft-offline via soft_offline_page under /sys.

OTOH, hard-offline is triggered directly (accurately over ring buffer to separate
context) from MCE handler.  mcelogd logs MCE events but does not involve in
page offline logic.

> 
> static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
> {
> #ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
> 	...
>         /* iff following two events can be handled properly by now */
>         if (sec_sev == GHES_SEV_CORRECTED &&
>             (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
>                 flags = MF_SOFT_OFFLINE;
>         if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
>                 flags = 0;
> 
>         if (flags != -1)
>                 memory_failure_queue(pfn, flags);
> 	...
> #endif
>  }
> 
> 
> static void memory_failure_work_func(struct work_struct *work)
> {
> 	...
> 	for (;;) {
> 		spin_lock_irqsave(&mf_cpu->lock, proc_flags);
> 		gotten = kfifo_get(&mf_cpu->fifo, &entry);
> 		spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
> 		if (!gotten)
> 			break;
> 		if (entry.flags & MF_SOFT_OFFLINE)
> 			soft_offline_page(pfn_to_page(entry.pfn), entry.flags);
> 		else
> 			memory_failure(entry.pfn, entry.flags);
> 	}
>  }
> 
> AFAICS, for hard-offline case, a recovered event would be if:
> 
> - the page to shut down is already free
> - the page was unmapped
> 
> In some cases we need to kill the process if it holds dirty pages.

One caveat is that even if the process maps dirty error pages, we
don't have to kill it unless the error data is consumed.

Thanks,
Naoya Horiguchi
