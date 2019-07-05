Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AABC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241652085A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfGEKPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:15:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:13012 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfGEKPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:15:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 03:15:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="363561959"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2019 03:15:01 -0700
Message-ID: <a8ee93721a674434e22d31fd1d10bf9472c1c739.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: Document UEFI event log quirks
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     tweek@google.com, matthewgarrett@google.com,
        Jonathan Corbet <corbet@lwn.net>
Date:   Fri, 05 Jul 2019 13:15:01 +0300
In-Reply-To: <6acf78df-b168-14d3-fea4-9a9d2945e77f@infradead.org>
References: <20190703161109.22935-1-jarkko.sakkinen@linux.intel.com>
         <6acf78df-b168-14d3-fea4-9a9d2945e77f@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 09:45 -0700, Randy Dunlap wrote:
> > +This introduces another problem: nothing guarantees that it is not
> > +called before the stub gets to run. Thus, it needs to copy the final
> > +events table preboot size to the custom configuration table so that
> > +kernel offset it later on.
> 
> ?  kernel can offset it later on.

EFI stub calculates the total size of the events in the final events
table at the time.

Later on, TPM driver uses this offset to copy only the events that
were actually generated after ExitBootServices():

/*
 * Copy any of the final events log that didn't also end up in the
 * main log. Events can be logged in both if events are generated
 * between GetEventLog() and ExitBootServices().
 */
memcpy((void *)log->bios_event_log + log_size,
       final_tbl->events + log_tbl->final_events_preboot_size,
       efi_tpm_final_log_size);

What would be a better way to describe this?

/Jarkko

