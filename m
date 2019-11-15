Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E7DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B751020730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfKOQHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:07:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:10613 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfKOQHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:07:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 08:07:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="214800600"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2019 08:06:59 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     tip-bot2 for Thomas Richter <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, acme@kernel.org,
        gor@linux.ibm.com, hechaol@fb.com, heiko.carstens@de.ibm.com,
        linux-perf-users@vger.kernel.org, songliubraving@fb.com,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [tip: perf/urgent] perf/aux: Fix tracking of auxiliary trace buffer allocation
In-Reply-To: <157165050422.29376.10692255781840811810.tip-bot2@tip-bot2>
References: <20191021083354.67868-1-tmricht@linux.ibm.com> <157165050422.29376.10692255781840811810.tip-bot2@tip-bot2>
Date:   Fri, 15 Nov 2019 18:06:59 +0200
Message-ID: <87bltddsyk.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"tip-bot2 for Thomas Richter" <tip-bot2@linutronix.de> writes:

>  		/* now it's safe to free the pages */
> -		atomic_long_sub(rb->aux_nr_pages, &mmap_user->locked_vm);
> -		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
> +		if (!rb->aux_mmap_locked)
> +			atomic_long_sub(rb->aux_nr_pages, &mmap_user->locked_vm);
> +		else
> +			atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);

This only works correctly when rb->aux_mmap_locked is either equal to
rb->aux_nr_pages or zero. Otherwise, it leaks

  rb->aux_nr_pages - rb->aux_mmap_locked

in the locked_vm permanently.

Regards,
--
Alex
