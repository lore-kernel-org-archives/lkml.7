Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D203AC606CD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A240F2177B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404871AbfGHUJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:09:57 -0400
Received: from ms.lwn.net ([45.79.88.28]:53304 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfGHUJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:09:56 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8CC8C2B8;
        Mon,  8 Jul 2019 20:09:55 +0000 (UTC)
Date:   Mon, 8 Jul 2019 14:09:54 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        skhan@linuxfoundation.org, mchehab@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Documentation: coresight: covert txt to rst
Message-ID: <20190708140954.35a38021@lwn.net>
In-Reply-To: <20190705204512.15444-1-tranmanphong@gmail.com>
References: <20190705204512.15444-1-tranmanphong@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  6 Jul 2019 03:45:12 +0700
Phong Tran <tranmanphong@gmail.com> wrote:

> change the format file and adpate the text style
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  .../trace/{coresight.txt => coresight.rst}         | 296 ++++++++++++---------
>  Documentation/trace/index.rst                      |   1 +
>  2 files changed, 167 insertions(+), 130 deletions(-)
>  rename Documentation/trace/{coresight.txt => coresight.rst} (59%)
> 
> diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.rst
> similarity index 59%
> rename from Documentation/trace/coresight.txt
> rename to Documentation/trace/coresight.rst
> index efbc832146e7..bea24e70cfba 100644
> --- a/Documentation/trace/coresight.txt
> +++ b/Documentation/trace/coresight.rst
> @@ -1,5 +1,6 @@
> -		Coresight - HW Assisted Tracing on ARM
> -		======================================
> +======================================
> +Coresight - HW Assisted Tracing on ARM
> +======================================
>  
>     Author:   Mathieu Poirier <mathieu.poirier@linaro.org>
>     Date:     September 11th, 2014
> @@ -26,7 +27,7 @@ implementation, either storing the compressed stream in a memory buffer or
>  creating an interface to the outside world where data can be transferred to a
>  host without fear of filling up the onboard coresight memory buffer.
>  
> -At typical coresight system would look like this:
> +At typical coresight system would look like this::
>  
>    *****************************************************************
>   **************************** AMBA AXI  ****************************===||
> @@ -95,6 +96,7 @@ Acronyms and Classification
>  
>  Acronyms:
>  
> +======== =============================================================
>  PTM:     Program Trace Macrocell
>  ETM:     Embedded Trace Macrocell
>  STM:     System trace Macrocell
> @@ -104,6 +106,7 @@ TPIU:    Trace Port Interface Unit
>  TMC-ETR: Trace Memory Controller, configured as Embedded Trace Router
>  TMC-ETF: Trace Memory Controller, configured as Embedded Trace FIFO
>  CTI:     Cross Trigger Interface
> +======== =============================================================

A minor nit, but since you're making a table out of this, you don't need
the colons in the first column.

>  Classification:
>  
> @@ -118,7 +121,7 @@ Misc:
>  
>  
>  Device Tree Bindings
> -----------------------
> +--------------------
>  
>  See Documentation/devicetree/bindings/arm/coresight.txt for details.
>  
> @@ -133,57 +136,63 @@ The coresight framework provides a central point to represent, configure and
>  manage coresight devices on a platform.  Any coresight compliant device can
>  register with the framework for as long as they use the right APIs:
>  
> -struct coresight_device *coresight_register(struct coresight_desc *desc);
> -void coresight_unregister(struct coresight_device *csdev);
> +.. c:function:: struct coresight_device *coresight_register(struct coresight_desc *desc);
> +.. c:function:: void coresight_unregister(struct coresight_device *csdev);
>  
> -The registering function is taking a "struct coresight_device *csdev" and
> +The registering function is taking a :code:`struct coresight_device *csdev` and

As a general rule, we would rather see less markup in the text files than
you are applying here.  Just present the prototypes in a literal block
here.  (Even better would be a nice kerneldoc comment in the source that
could be pulled in, but that's more work).  I wouldn't use :code: anywhere,
really. 

As well as addressing Mathieu's comments, could you pass through and cut
the markup down to the bare minimum?

Thanks,

jon
