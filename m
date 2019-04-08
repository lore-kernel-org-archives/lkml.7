Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55C3C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918CC20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfDHREy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:04:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbfDHREx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:04:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1915D308302F;
        Mon,  8 Apr 2019 17:04:53 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A10155C29A;
        Mon,  8 Apr 2019 17:04:52 +0000 (UTC)
Subject: Re: [PATCH] tools/power turbostat: fix file descriptor leaks
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190408161240.GA30623@embeddedor>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <16370c2e-c5f9-a4cf-02fc-6b5b4ab65e1c@redhat.com>
Date:   Mon, 8 Apr 2019 13:04:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190408161240.GA30623@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 08 Apr 2019 17:04:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/19 12:12 PM, Gustavo A. R. Silva wrote:
> Fix file descriptor leaks by closing fp before return.
> 
> Addresses-Coverity-ID: 1444591 ("Resource leak")
> Addresses-Coverity-ID: 1444592 ("Resource leak")
> Fixes: 5ea7647b333f ("tools/power turbostat: Warn on bad ACPI LPIT data")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Prarit Bhargava <prarit@redhat.com>

P.

> ---
>  tools/power/x86/turbostat/turbostat.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index c7727be9719f..78d9acba8e9b 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -2924,6 +2924,7 @@ int snapshot_cpu_lpi_us(void)
>  	if (retval != 1) {
>  		fprintf(stderr, "Disabling Low Power Idle CPU output\n");
>  		BIC_NOT_PRESENT(BIC_CPU_LPI);
> +		fclose(fp);
>  		return -1;
>  	}
>  
> @@ -2950,6 +2951,7 @@ int snapshot_sys_lpi_us(void)
>  	if (retval != 1) {
>  		fprintf(stderr, "Disabling Low Power Idle System output\n");
>  		BIC_NOT_PRESENT(BIC_SYS_LPI);
> +		fclose(fp);
>  		return -1;
>  	}
>  	fclose(fp);
> 
