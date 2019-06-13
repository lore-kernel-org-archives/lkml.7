Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B92C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D6C20449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbfFMPOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:14:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:6702 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732260AbfFMPON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:14:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 08:13:54 -0700
X-ExtLoop1: 1
Received: from bbouchn-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.22])
  by orsmga004.jf.intel.com with ESMTP; 13 Jun 2019 08:13:53 -0700
Date:   Thu, 13 Jun 2019 18:13:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: linux-next: build warning after merge of the tpmdd tree
Message-ID: <20190613151352.GB18488@linux.intel.com>
References: <20190611145255.68682629@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611145255.68682629@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew, can you provide a fixup for this?

/Jarkko

On Tue, Jun 11, 2019 at 02:52:55PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tpmdd tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> drivers/firmware/efi/tpm.c: In function 'efi_tpm_eventlog_init':
> drivers/firmware/efi/tpm.c:80:10: warning: passing argument 1 of 'tpm2_calc_event_log_size' makes pointer from integer without a cast [-Wint-conversion]
>   tbl_size = tpm2_calc_event_log_size(efi.tpm_final_log
>                                       ~~~~~~~~~~~~~~~~~
>           + sizeof(final_tbl->version)
>           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           + sizeof(final_tbl->nr_events),
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/firmware/efi/tpm.c:19:43: note: expected 'void *' but argument is of type 'long unsigned int'
>  static int tpm2_calc_event_log_size(void *data, int count, void *size_info)
>                                      ~~~~~~^~~~
> 
> Introduced by commit
> 
>   a537b15c54a3 ("tpm: Reserve the TPM final events table")
> 
> -- 
> Cheers,
> Stephen Rothwell


