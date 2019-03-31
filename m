Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6839C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738E8206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="juvyUCsg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bwl+eqmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfCaJbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:31:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36828 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfCaJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:31:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A89C60850; Sun, 31 Mar 2019 09:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554024700;
        bh=blDipizSjY9+clrmPwUDwYisBBSAVJrkaImCaAPzKPE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=juvyUCsgxSumXPRhvX3C228ZZlZ1cOTnzMpPRFw1CsvhhKPqNonNywolrRhD0ttkX
         O1jFfVNLrjoDrgHNsoT80uF+ElbuLZhJPx1lZhaT8yP2KVkBmxctfLUyNC5YQ/JhcG
         47dM1E1e5D93GvDysGNdsCAw3g12SyzJSatfrIQc=
Received: from [10.79.166.22] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CE4460779;
        Sun, 31 Mar 2019 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554024699;
        bh=blDipizSjY9+clrmPwUDwYisBBSAVJrkaImCaAPzKPE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Bwl+eqmDohl4IHQ2ESq36WXtygAUaDiDYbuQ5vLMuqoTJZPc87RaO1C27NE5wElyf
         4yntvCZNsj3G1qLL3rxj4g3DkHshquv7YT1VYjZcv2fXGan13DtV0+8GtQ9ggtXORR
         Yds9jJ2VP9B9Y3VCtqa/kswVA3j9SmckfSmbiYZ4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CE4460779
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
To:     helgaas@kernel.org, Jean Delvare <jdelvare@suse.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20190325183652.252175-1-helgaas@kernel.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <26166856-a177-ff92-a204-db7005a2aa05@codeaurora.org>
Date:   Sun, 31 Mar 2019 15:01:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190325183652.252175-1-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/26/2019 12:06 AM, helgaas@kernel.org wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> convert i2c-isch to platform_device") removed the use of
> acpi_check_region() but not the include.
>
> Remove the now-unnecessary include of <linux/acpi.h>.  No functional change
> intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/i2c/busses/i2c-isch.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
> index 5c754bf659e2..f64c1d72f73f 100644
> --- a/drivers/i2c/busses/i2c-isch.c
> +++ b/drivers/i2c/busses/i2c-isch.c
> @@ -30,7 +30,6 @@
>   #include <linux/ioport.h>
>   #include <linux/i2c.h>
>   #include <linux/io.h>
> -#include <linux/acpi.h>
>   
>   /* SCH SMBus address offsets */
>   #define SMBHSTCNT	(0 + sch_smba)
