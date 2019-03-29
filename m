Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71508C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBAB2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IefhBnKe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IefhBnKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfC2IgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:36:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfC2IgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:36:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BC083609D4; Fri, 29 Mar 2019 08:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553848570;
        bh=fi5prG/G9EA1xgUJ8XJXbzqeIE0ziOdMWngwno8k32w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IefhBnKepUWcMsbC0L36YRMPOE2BQImasez8xb/AbYsp/i7hrqsqRS80wn2w3qOoP
         XDNO9+/1VLEO8pRGXRwaX045ydCaibITyLV4X37PZyHciBReB+9oPZvyEeN2xWBfyF
         n0qO2CxPmX0zukOcOEe84Bko1YAjalQC9hYXTjPQ=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C3D8602F8;
        Fri, 29 Mar 2019 08:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553848570;
        bh=fi5prG/G9EA1xgUJ8XJXbzqeIE0ziOdMWngwno8k32w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IefhBnKepUWcMsbC0L36YRMPOE2BQImasez8xb/AbYsp/i7hrqsqRS80wn2w3qOoP
         XDNO9+/1VLEO8pRGXRwaX045ydCaibITyLV4X37PZyHciBReB+9oPZvyEeN2xWBfyF
         n0qO2CxPmX0zukOcOEe84Bko1YAjalQC9hYXTjPQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C3D8602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] lib/scatterlist: Remove leftover from sg_page_iter
 comment
To:     Gal Pressman <galpress@amazon.com>, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
References: <1553800491-28583-1-git-send-email-galpress@amazon.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <8e313491-8859-d47f-f104-6d2d783cd63a@codeaurora.org>
Date:   Fri, 29 Mar 2019 14:06:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553800491-28583-1-git-send-email-galpress@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 12:44 AM, Gal Pressman wrote:
> Commit d901b2760dc6 ("lib/scatterlist: Provide a DMA page iterator")
> added the sg DMA iterator but a leftover remained in the sg_page_iter
> documentation, remove it.
>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>   include/linux/scatterlist.h | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index b4be960c7e5d..30a9a55c28ba 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -340,11 +340,11 @@ int sg_alloc_table_chained(struct sg_table *table, int nents,
>    * sg page iterator
>    *
>    * Iterates over sg entries page-by-page.  On each successful iteration, you
> - * can call sg_page_iter_page(@piter) to get the current page and its dma
> - * address.


It took me a while till i exact found what you meant by left over.

could have been more specific in the commit,but

Looks  good to me to be removed.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh


>   @piter->sg will point to the sg holding this page and
> - * @piter->sg_pgoffset to the page's page offset within the sg. The iteration
> - * will stop either when a maximum number of sg entries was reached or a
> - * terminating sg (sg_last(sg) == true) was reached.
> + * can call sg_page_iter_page(@piter) to get the current page.
> + * @piter->sg will point to the sg holding this page and @piter->sg_pgoffset to
> + * the page's page offset within the sg. The iteration will stop either when a
> + * maximum number of sg entries was reached or a terminating sg
> + * (sg_last(sg) == true) was reached.
>    */
>   struct sg_page_iter {
>   	struct scatterlist	*sg;		/* sg holding the page */
