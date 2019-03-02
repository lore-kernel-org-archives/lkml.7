Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D054C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036552083E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfCBBAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 20:00:24 -0500
Received: from smtprelay0129.hostedemail.com ([216.40.44.129]:39115 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725996AbfCBBAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 20:00:24 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3D256837F27B;
        Sat,  2 Mar 2019 01:00:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ducks60_3d7439fd05d1e
X-Filterd-Recvd-Size: 1571
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 Mar 2019 01:00:22 +0000 (UTC)
Message-ID: <91b9cfc4a87bfd7a220f558f514e322f4864b13e.camel@perches.com>
Subject: Re: [PATCH 11/15] habanalabs: print pointer using %p
From:   Joe Perches <joe@perches.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 Mar 2019 17:00:20 -0800
In-Reply-To: <20190228095545.30842-2-oded.gabbay@gmail.com>
References: <20190228095545.30842-1-oded.gabbay@gmail.com>
         <20190228095545.30842-2-oded.gabbay@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 11:55 +0200, Oded Gabbay wrote:
> Don't cast pointer to u64 to print it. Instead, print the pointer using
> %p.

You might want to use %px here if you _really_
want the actual address and not the hashed output
%p normally produces.

> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
[]
> @@ -4276,9 +4276,8 @@ static int goya_parse_cb_no_ext_quque(struct hl_device *hdev,
>  			return 0;
>  
>  		dev_err(hdev->dev,
> -			"Internal CB address 0x%llx + 0x%x is not in SRAM nor in DRAM\n",
> -			(u64) (uintptr_t) parser->user_cb,
> -			parser->user_cb_size);
> +			"Internal CB address %p + 0x%x is not in SRAM nor in DRAM\n",
> +			parser->user_cb, parser->user_cb_size);


