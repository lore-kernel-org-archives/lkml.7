Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212EEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035512251D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfKTNGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:06:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:42091 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfKTNG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:06:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 05:06:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="196847595"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga007.jf.intel.com with ESMTP; 20 Nov 2019 05:06:27 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     zhiche.yy@alibaba-inc.com, xlpang@linux.alibaba.com,
        Wen Yang <wenyang@linux.alibaba.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] intel_th: avoid double free in error flow
In-Reply-To: <20191119173447.2454-1-wenyang@linux.alibaba.com>
References: <20191119173447.2454-1-wenyang@linux.alibaba.com>
Date:   Wed, 20 Nov 2019 15:06:26 +0200
Message-ID: <87y2wad7e5.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wen Yang <wenyang@linux.alibaba.com> writes:

> There is a possible double free issue in intel_th_subdevice_alloc:
>
> 651         err = intel_th_device_add_resources(thdev, res, subdev->nres);
> 652         if (err) {
> 653                 put_device(&thdev->dev);
> 654                 goto fail_put_device;     ---> freed
> 655         }
> ...
> 687 fail_put_device:
> 688         put_device(&thdev->dev);          ---> double freed
> 689
>
> This patch fix it by removing the unnecessary put_device().

Unnecessary is a too generous term here.

> Fixes: a753bfcfdb1f ("intel_th: Make the switch allocate its subdevices")
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org

Cc: stable@ is missing.

> ---
>  drivers/hwtracing/intel_th/core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
> index d5c1821..98d195c 100644
> --- a/drivers/hwtracing/intel_th/core.c
> +++ b/drivers/hwtracing/intel_th/core.c
> @@ -649,10 +649,8 @@ static inline void intel_th_request_hub_module_flush(struct intel_th *th)
>  	}
>  
>  	err = intel_th_device_add_resources(thdev, res, subdev->nres);
> -	if (err) {
> -		put_device(&thdev->dev);
> +	if (err)
>  		goto fail_put_device;
> -	}

What about the second instance of the same problem a few lines lower?

Thanks,
--
Alex
