Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E019AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46B1206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Or92XvET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfDDTcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:32:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDDTcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X3BixeUprOuiy8/0lh64efR9tiWPWebFNIO6/YVU9bM=; b=Or92XvETTcWxa4QxUugY+Jmvi
        8fi+mU/rYRIQIWeVrY87oBnNfm4TkTs/bOXWgEncdvqovZeCD2n2Rui1MnyN2GLWb8eSMUFDFwVcm
        iq4XakOcY76/aWD/dUDsZnqKf/Eu0TQ243bREY3ptUie33mKmRgsmZHVy5fglIm44taDT/4YoX7N5
        04kE01uprZTsZrEbMc/t4bPhJHiZrD+WvZjjiLWhlA9+F1ED92hARDOpEPIPfeL+Yp/VAq5IEfXIK
        VNNGFVR4lZ0cCskETUfbzhdyvFdUq/z4pKhOhpp16t2ELdHM/GYR48h6B0GanWHfdV3tc+XjCVZQ9
        t4LjA6lFQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hC85s-0006uZ-1H; Thu, 04 Apr 2019 19:32:12 +0000
Date:   Thu, 4 Apr 2019 12:32:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        vishal.l.verma@intel.com, x86@kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org
Subject: Re: [RFC PATCH 2/5] lib/memregion: Uplevel the pmem "region" ida to
 a global allocator
Message-ID: <20190404193211.GK22763@bombadil.infradead.org>
References: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155440491849.3190322.17551464505265122881.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155440491849.3190322.17551464505265122881.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 12:08:38PM -0700, Dan Williams wrote:
> +++ b/lib/Kconfig
> @@ -318,6 +318,12 @@ config DECOMPRESS_LZ4
>  config GENERIC_ALLOCATOR
>  	bool
>  
> +#
> +# Generic IDA for memory regions
> +#

Leaky abstraction -- nobody needs know that it's implemented as an IDA.
Suggest:

# Memory region ID allocation

...

> +++ b/lib/memregion.c
> @@ -0,0 +1,22 @@
> +#include <linux/idr.h>
> +#include <linux/module.h>
> +
> +static DEFINE_IDA(region_ida);
> +
> +int memregion_alloc(void)
> +{
> +	return ida_simple_get(&region_ida, 0, 0, GFP_KERNEL);
> +}
> +EXPORT_SYMBOL(memregion_alloc);
> +
> +void memregion_free(int id)
> +{
> +	ida_simple_remove(&region_ida, id);
> +}
> +EXPORT_SYMBOL(memregion_free);
> +
> +static void __exit memregion_exit(void)
> +{
> +	ida_destroy(&region_ida);
> +}
> +module_exit(memregion_exit);

 - Should these be EXPORT_SYMBOL_GPL?
 - Can we use the new interface, ida_alloc() and ida_free()?
 - Do we really want memregion_exit() to happen while there are still IDs
   allocated in the IDA?  I think this might well be better as:

	BUG_ON(!ida_empty(&region_ida));

Also, do we really want to call the structure the region_ida?  Why not
region_ids?
