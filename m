Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACFFC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F16E2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfFFSy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:54:59 -0400
Received: from smtprelay0070.hostedemail.com ([216.40.44.70]:36818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726379AbfFFSy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:54:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7B1741801E326;
        Thu,  6 Jun 2019 18:54:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: need53_2b3144507e744
X-Filterd-Recvd-Size: 1559
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Jun 2019 18:54:56 +0000 (UTC)
Message-ID: <4257c916c5db569c6182880e06ddc1230e80ddf0.camel@perches.com>
Subject: Re: [PATCH 1/2] habanalabs: add rate-limit to an error message
From:   Joe Perches <joe@perches.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jun 2019 11:54:55 -0700
In-Reply-To: <20190606122009.12471-1-oded.gabbay@gmail.com>
References: <20190606122009.12471-1-oded.gabbay@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 15:20 +0300, Oded Gabbay wrote:
> This patch changes the print of an error message about mis-configuration
> of the debug infrastructure to be rate-limited, to prevent flooding of
> kernel log, as these configuration requests can come at a high rate.
[]
> diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
[]
> @@ -255,7 +255,7 @@ static int hl_debug_ioctl(struct hl_fpriv *hpriv, void *data)
>  	case HL_DEBUG_OP_SPMU:
>  	case HL_DEBUG_OP_TIMESTAMP:
>  		if (!hdev->in_debug) {
> -			dev_err(hdev->dev,
> +			dev_err_ratelimited(hdev->dev,
>  				"Rejecting debug configuration request because device not in debug mode\n");
>  			return -EFAULT;
>  		}

Perhaps this should be dev_dbg


