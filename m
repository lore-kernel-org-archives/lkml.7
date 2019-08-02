Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5BCC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB71820644
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404066AbfHBRE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:04:57 -0400
Received: from foss.arm.com ([217.140.110.172]:55232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403954AbfHBRE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:04:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74938344;
        Fri,  2 Aug 2019 10:04:56 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C281F3F575;
        Fri,  2 Aug 2019 10:04:55 -0700 (PDT)
Subject: Re: [PATCH v2 12/24] EDAC, ghes: Use standard kernel macros for page
 calculations
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-13-rrichter@marvell.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <ffd8ec87-74fd-3d8e-1c8e-eed7f425df48@arm.com>
Date:   Fri, 2 Aug 2019 18:04:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190624150758.6695-13-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On 24/06/2019 16:09, Robert Richter wrote:
> Use standard macros for page calculations.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---

> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 786f1b32eee1..746083876b5f 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -311,8 +311,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  
>  	/* Error address */
>  	if (mem_err->validation_bits & CPER_MEM_VALID_PA) {
> -		e->page_frame_number = mem_err->physical_addr >> PAGE_SHIFT;
> -		e->offset_in_page = mem_err->physical_addr & ~PAGE_MASK;
> +		e->page_frame_number = PHYS_PFN(mem_err->physical_addr);
> +		e->offset_in_page = offset_in_page(mem_err->physical_addr);
>  	}
>  
>  	/* Error grain */
> 


After a shorter game of spot-the-difference:
Reviewed-by: James Morse <james.morse@arm.com>

Previously here:
https://lore.kernel.org/linux-edac/e566fe1d-ed06-53bc-6827-f6dfa32ee485@arm.com/


Please pick up tags when posting a new version.
If you don't do this, its very difficult to convince people to spend time reviewing your
series.


Thanks,

James
