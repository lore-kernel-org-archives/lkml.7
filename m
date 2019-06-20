Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD2DC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00832083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561058814;
	bh=X9iReCu19YA5rySlU8tSMZQ03dSsWfdWuyPJC4fRhOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o8yW0/MhoWWwH0WszkEHt/TF0MyYPgKdCLQ5UPrAxzCbRGARSl5N3KWlCvWiW7uCJ
	 GGZCVa+c5pPNN2kU7bZh/OVpnOYlSNXF2ZoRJVjsn3ANqCblInI1mqyHIlxBY2BK2q
	 ViMgQhBju59OSyKrMU59gGSgz1uwsHEl0LSvAoBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFTT0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:26:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:36412 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbfFTT0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:26:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E42C3AC9A;
        Thu, 20 Jun 2019 19:26:50 +0000 (UTC)
Date:   Thu, 20 Jun 2019 21:26:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Message-ID: <20190620192648.GI12083@dhcp22.suse.cz>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-19-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613094326.24093-19-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-06-19 11:43:21, Christoph Hellwig wrote:
> The code hasn't been used since it was added to the tree, and doesn't
> appear to actually be usable.  Mark it as BROKEN until either a user
> comes along or we finally give up on it.

I would go even further and simply remove all the DEVICE_PUBLIC code.

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Anyway
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0d2ba7e1f43e..406fa45e9ecc 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -721,6 +721,7 @@ config DEVICE_PRIVATE
>  config DEVICE_PUBLIC
>  	bool "Addressable device memory (like GPU memory)"
>  	depends on ARCH_HAS_HMM
> +	depends on BROKEN
>  	select HMM
>  	select DEV_PAGEMAP_OPS
>  
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
