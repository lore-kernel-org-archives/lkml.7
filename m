Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45885C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E642086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557861168;
	bh=Dx8fO3TTAFVbhjdjmVSXfGcWo/4xM9XJT2npi4xsxtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rDLRpHdEnReibuqiyn9NSXi/7d6FaOo0zFWG/TffTl5U20e4MEC6/BBg9oQ7sLqvI
	 UwWyD1osRCQE2c2IjaFMAUQTNY8jW2IHnyc+F9KB42xTXRisqg3LYyxo7n7pKL//c9
	 9a5iqg7t2BfL0YEE47GsC9bl6WcOLkQdwd01WXMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfENTMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfENTMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:12:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AFDD20675;
        Tue, 14 May 2019 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557861166;
        bh=Dx8fO3TTAFVbhjdjmVSXfGcWo/4xM9XJT2npi4xsxtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toauLP82s6SvK8V1KkHf5COFmXqXrCdzvWsSIFzpnOMz7HsK8pGBWSn2riYujnQm3
         UI2pj0XEpWNT5f3qUGUCkuemRm2ajtG8i/wdw9VqAHsfrUmDKzFPIQ/O90P7kZZGPL
         U0nCodj8lpkzjPsBWsi9XCyThfy2fiK8twsrFumQ=
Date:   Tue, 14 May 2019 21:12:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/6] drivers/base/devres: Introduce
 devm_release_action()
Message-ID: <20190514191243.GA17226@kroah.com>
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155727336530.292046.2926860263201336366.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155727336530.292046.2926860263201336366.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 04:56:05PM -0700, Dan Williams wrote:
> The devm_add_action() facility allows a resource allocation routine to
> add custom devm semantics. One such user is devm_memremap_pages().
> 
> There is now a need to manually trigger devm_memremap_pages_release().
> Introduce devm_release_action() so the release action can be triggered
> via a new devm_memunmap_pages() api in a follow-on change.
> 
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/base/devres.c  |   24 +++++++++++++++++++++++-
>  include/linux/device.h |    1 +
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index e038e2b3b7ea..0bbb328bd17f 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -755,10 +755,32 @@ void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
>  
>  	WARN_ON(devres_destroy(dev, devm_action_release, devm_action_match,
>  			       &devres));
> -
>  }
>  EXPORT_SYMBOL_GPL(devm_remove_action);
>  
> +/**
> + * devm_release_action() - release previously added custom action
> + * @dev: Device that owns the action
> + * @action: Function implementing the action
> + * @data: Pointer to data passed to @action implementation
> + *
> + * Releases and removes instance of @action previously added by
> + * devm_add_action().  Both action and data should match one of the
> + * existing entries.
> + */
> +void devm_release_action(struct device *dev, void (*action)(void *), void *data)
> +{
> +	struct action_devres devres = {
> +		.data = data,
> +		.action = action,
> +	};
> +
> +	WARN_ON(devres_release(dev, devm_action_release, devm_action_match,
> +			       &devres));

What does WARN_ON help here?  are we going to start getting syzbot
reports of this happening?

How can this fail?

thanks,

greg k-h
