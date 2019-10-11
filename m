Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B8EECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1122A214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570792821;
	bh=bumCG1WRptxKnMHlJVLP39ZNhnzIViQEg49SP+p+NKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=baJYBK+YDJkCb+L4vioFeVr1Y+mawIsMyRdionbmgpY9sDifRo+k+sv9wgZ5gchh1
	 BEdLO5MdtLB2yzVbbOiQ3AkIoZ+tQaA63DXkrmT23Ltqwggry64bHTgtuXfdPstION
	 FrSYoOalh7h3F5JOW6hD6Gp3vCCTRIYjpeOcUnNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfJKLUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:20:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfJKLUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XyJkLzK1tgqObp/ZMiScyNde0WPBzRBi2jcUwb+sE58=; b=D61ONBQoro8pAOe2yUr9ihwlv
        xdMLOvh0S8seCDUh1REvjyqi7eqxDHtxid2eqWC6bQ2PdGvQjYaPVr6Uf6GYKu3H2OO6PcocKOikq
        6O5JwobwzI8kHpsqmw/RRpzkNuYPxyYymgcnYqcjnmlkwDJyjk6r3mU8Beb1/WXoSPca05aXyqDgP
        n/lFoPmjJZYKxvQbF2a8/vbXhF2y72p+tQpFZcwgoiP1jEIV4j+6V7Fx2YhNvfh05xwQlxzfCC6OB
        NRXj2nlE+Nxo6aeOBg2NWRPQ3Mq/YeEkzgy0Fe0dTBssaB0gNZFR8EIJNuLFoBy7L3htKbvaRUPCp
        0iT/2ViRQ==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsxz-0007RH-Lh; Fri, 11 Oct 2019 11:20:15 +0000
Date:   Fri, 11 Oct 2019 08:20:11 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/19] EDAC, ghes: Remove intermediate buffer
 pvt->detail_location
Message-ID: <20191011082011.5d95e7f3@coco.lan>
In-Reply-To: <20191010202418.25098-18-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-18-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:38 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> detail_location[] is used to collect two location strings so they can
> be passed as one to trace_mc_event(). Instead of having an extra copy
> step, assemble the location string in other_detail[] from the
> beginning.
> 
> Using other_detail[] to call trace_mc_event() is now the same as in
> edac_mc.c and code can be unified.
> 
> Reviewed-by: James Morse <james.morse@arm.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  drivers/edac/ghes_edac.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 97242cf18a88..8d9d3c4dbebb 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -21,8 +21,7 @@ struct ghes_edac_pvt {
>  	struct mem_ctl_info *mci;
>  
>  	/* Buffers for the error handling routine */
> -	char detail_location[240];
> -	char other_detail[160];
> +	char other_detail[400];
>  	char msg[80];
>  };
>  
> @@ -356,6 +355,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  
>  	/* All other fields are mapped on e->other_detail */
>  	p = pvt->other_detail;
> +	p += snprintf(p, sizeof(pvt->other_detail),
> +		"APEI location: %s ", e->location);
>  	if (mem_err->validation_bits & CPER_MEM_VALID_ERROR_STATUS) {
>  		u64 status = mem_err->error_status;
>  
> @@ -436,12 +437,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	grain_bits = fls_long(e->grain - 1);
>  
>  	/* Generate the trace event */
> -	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
> -		 "APEI location: %s %s", e->location, e->other_detail);
>  	trace_mc_event(e->type, e->msg, e->label, e->error_count,
>  		       mci->mc_idx, e->top_layer, e->mid_layer, e->low_layer,
>  		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
> -		       grain_bits, e->syndrome, pvt->detail_location);
> +		       grain_bits, e->syndrome, e->other_detail);
>  
>  	dimm = edac_get_dimm_by_index(mci, e->top_layer);
>  



Thanks,
Mauro
