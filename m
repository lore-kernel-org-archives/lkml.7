Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8720CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A817421872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbfJVJ66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:58:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:45260 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731588AbfJVJ66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:58:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3E18AFBD;
        Tue, 22 Oct 2019 09:58:55 +0000 (UTC)
Date:   Tue, 22 Oct 2019 11:58:52 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Message-ID: <20191022095852.GB20429@linux>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-11-osalvador@suse.de>
 <20191018120615.GM5017@dhcp22.suse.cz>
 <20191021125842.GA11330@linux>
 <20191021154158.GV9379@dhcp22.suse.cz>
 <20191022074615.GA19060@linux>
 <20191022082611.GD9379@dhcp22.suse.cz>
 <20191022083505.GA19708@linux>
 <20191022092256.GH9379@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022092256.GH9379@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 11:22:56AM +0200, Michal Hocko wrote:
> Hmm, that might be a misunderstanding on my end. I thought that it is
> the MCE handler to say whether the failure is recoverable or not. If yes
> then we can touch the content of the memory (that would imply the
> migration). Other than that both paths should be essentially the same,
> no? Well unrecoverable case would be essentially force migration failure
> path.
> 
> MADV_HWPOISON is explicitly documented to test MCE handling IIUC:
> : This feature is intended for testing of memory error-handling
> : code; it is available only if the kernel was configured with
> : CONFIG_MEMORY_FAILURE.
> 
> There is no explicit note about the type of the error that is injected
> but I think it is reasonably safe to assume this is a recoverable one.

MADV_HWPOISON stands for hard-offline.
MADV_SOFT_OFFLINE stands for soft-offline.

MADV_SOFT_OFFLINE (since Linux 2.6.33)
              Soft offline the pages in the range specified by addr and
              length.  The memory of each page in the specified range is
              preserved (i.e., when next accessed, the same content will be
              visible, but in a new physical page frame), and the original
              page is offlined (i.e., no longer used, and taken out of
              normal memory management).  The effect of the
              MADV_SOFT_OFFLINE operation is invisible to (i.e., does not
              change the semantics of) the calling process.

              This feature is intended for testing of memory error-handling
              code; it is available only if the kernel was configured with
              CONFIG_MEMORY_FAILURE.


But both follow different approaches.

I think it is up to some controlers to trigger soft-offline or hard-offline:

static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
{
#ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
	...
        /* iff following two events can be handled properly by now */
        if (sec_sev == GHES_SEV_CORRECTED &&
            (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
                flags = MF_SOFT_OFFLINE;
        if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
                flags = 0;

        if (flags != -1)
                memory_failure_queue(pfn, flags);
	...
#endif
 }


static void memory_failure_work_func(struct work_struct *work)
{
	...
	for (;;) {
		spin_lock_irqsave(&mf_cpu->lock, proc_flags);
		gotten = kfifo_get(&mf_cpu->fifo, &entry);
		spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
		if (!gotten)
			break;
		if (entry.flags & MF_SOFT_OFFLINE)
			soft_offline_page(pfn_to_page(entry.pfn), entry.flags);
		else
			memory_failure(entry.pfn, entry.flags);
	}
 }

AFAICS, for hard-offline case, a recovered event would be if:

- the page to shut down is already free
- the page was unmapped

In some cases we need to kill the process if it holds dirty pages.

But we never migrate contents in hard-offline path.
I guess it is because we cannot really trust the contents anymore.


-- 
Oscar Salvador
SUSE L3
