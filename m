Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60132C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F542175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554478593;
	bh=KO+Bx5T0axLekH0skoRWOhS3pDLqZ6mZZCB90Cse7w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wWCJ++r1dEI2cgvIYpcu3Qap5HTjyGJYwcMzwurkP6gxogsw7nHRpbADI2Nt3/3wc
	 Qr+vRBDUDiJy7KGAVSR/Q8IYYG7rk8K4+BXV/BeW8vtq8QI2MgaaU7taZ6mXXDZOf2
	 yuoUM1d1v82PRYh36tgzbhmyivUgF8pGCr6hBDQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfDEPgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:36:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:30309 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbfDEPgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:36:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 08:36:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,313,1549958400"; 
   d="scan'208";a="158577326"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2019 08:36:29 -0700
Date:   Fri, 5 Apr 2019 09:38:00 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] acpi/hmat: fix uninitialized pointer dereference
 on pointer 'target'
Message-ID: <20190405153759.GB25081@localhost.localdomain>
References: <20190405141215.2079-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405141215.2079-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 07:12:15AM -0700, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer 'target' is not initialized and is only assigned when the
> ACPI_HMAT_MEMORY_PD_VALID bit in p->flags is set.  There is a later null
> check on target that leads to an uninitialized pointer read and
> dereference when assigning target->processor_pxm when target contains a
> non-null garbage value.  Fix this by initializing targer to null.
> 
> Fixes: 665ac7e92757 ("acpi/hmat: Register processor domain to its memory")
> Addresses-Coverity: ("Uninitialized pointer read")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I would have sworn this was fixed as it's in my tree already, but the
submitted patch sure enough doesn't have it.

I've double checked to see if there are any other discrepencies, and
there are no other differences after this.

Thanks for the fix!

Reviewed-by: Keith Busch <keith.busch@intel.com>

> ---
>  drivers/acpi/hmat/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index b7824a0309f7..b275016ff648 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>  					      const unsigned long end)
>  {
>  	struct acpi_hmat_proximity_domain *p = (void *)header;
> -	struct memory_target *target;
> +	struct memory_target *target = NULL;
>  
>  	if (p->header.length != sizeof(*p)) {
>  		pr_notice("HMAT: Unexpected address range header length: %d\n",
> -- 
