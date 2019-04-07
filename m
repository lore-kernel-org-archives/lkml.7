Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F09CC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 06:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E37820B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 06:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZLe0X5x/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kc9EEwMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfDGGVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 02:21:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60866 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfDGGVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 02:21:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A629060DB4; Sun,  7 Apr 2019 06:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554618082;
        bh=Zm8cgQkIsC08l9USijCNh4jueDmjz1UqE4tPtN/fGfc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZLe0X5x/XvMC612lIvdraGWgs5FSnM2dDs8xEE+5FTDmAH6NZHTsd3PRNGNjt2vAC
         378yux11RUMBAwUy++tI39awOmXLRipazhhZodyUJ3X2tjOvdwmNA77pAzbhdkHxr4
         SruNp9nIknt5rGPBjz+iepLyo78cEL4iQ9yGTfCk=
Received: from [10.79.171.6] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1702060907;
        Sun,  7 Apr 2019 06:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554618081;
        bh=Zm8cgQkIsC08l9USijCNh4jueDmjz1UqE4tPtN/fGfc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Kc9EEwMJFGLnuqdvY2KrFDrD1DuhjltndWefLPUO5QkXux8SBn19DXzVXg94Wv2gD
         tsFC7PWwBVF54U4KPFwjtX8zKScQWZzse0HHABYoDEIWTPyddaQGKE6PcZ8zdG/7DH
         xerKW1HVZaP5fQhnZmb5Z1DpbgKRFusXs7x5Nods=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1702060907
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] acpi/hmat: fix an uninitialized memory_target
To:     Qian Cai <cai@lca.pw>, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, keith.busch@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190407011222.38963-1-cai@lca.pw>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <561c18b5-9bb5-3d25-b172-f1f29910de8e@codeaurora.org>
Date:   Sun, 7 Apr 2019 11:51:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190407011222.38963-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/7/2019 6:42 AM, Qian Cai wrote:
> The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
> memory") introduced an uninitialized "struct memory_target" that could
> cause an incorrect branching.
>
> drivers/acpi/hmat/hmat.c:385:6: warning: variable 'target' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>          if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/hmat/hmat.c:392:6: note: uninitialized use occurs here
>          if (target && p->flags & ACPI_HMAT_PROCESSOR_PD_VALID) {
>              ^~~~~~
> drivers/acpi/hmat/hmat.c:385:2: note: remove the 'if' if its condition
> is always true
>          if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/hmat/hmat.c:369:30: note: initialize the variable 'target'
> to silence this warning
>          struct memory_target *target;
>                                      ^
>                                       = NULL
>
> Signed-off-by: Qian Cai <cai@lca.pw>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/acpi/hmat/hmat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index c9b8abcf012c..6653dba3b377 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>   					      const unsigned long end)
>   {
>   	struct acpi_hmat_proximity_domain *p = (void *)header;
> -	struct memory_target *target;
> +	struct memory_target *target = NULL;
>   
>   	if (p->header.length != sizeof(*p)) {
>   		pr_notice("HMAT: Unexpected address range header length: %d\n",
