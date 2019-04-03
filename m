Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A72C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA902147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfDCLms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:42:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfDCLmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:42:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8882A308A967;
        Wed,  3 Apr 2019 11:42:47 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EA0819731;
        Wed,  3 Apr 2019 11:42:46 +0000 (UTC)
Subject: Re: [PATCH v1] tools/power: turbostat: fix buffer overrun
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-pm@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
References: <1554274934-12649-1-git-send-email-n-horiguchi@ah.jp.nec.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <f3ff449d-f431-4ea6-5c3f-8e19e2c534a8@redhat.com>
Date:   Wed, 3 Apr 2019 07:42:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1554274934-12649-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 03 Apr 2019 11:42:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/19 3:02 AM, Naoya Horiguchi wrote:
> turbostat could be terminated by general protection fault on some latest
> hardwares which (for example) support 9 levels of C-states and show 18
> "tADDED" lines. That bloats the total output and finally causes buffer
> overrun.  So let's extend the buffer to avoid this.
> 
> This patch also removes duplicated "pc10:" line to reduce buffer usage.
> 
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git v5.1-rc3-mmotm-2019-04-02-17-16/tools/power/x86/turbostat/turbostat.c v5.1-rc3-mmotm-2019-04-02-17-16_patched/tools/power/x86/turbostat/turbostat.c
> index c7727be..17b1f544 100644
> --- v5.1-rc3-mmotm-2019-04-02-17-16/tools/power/x86/turbostat/turbostat.c
> +++ v5.1-rc3-mmotm-2019-04-02-17-16_patched/tools/power/x86/turbostat/turbostat.c
> @@ -861,7 +861,6 @@ int dump_counters(struct thread_data *t, struct core_data *c,
>  		outp += sprintf(outp, "pc8: %016llX\n", p->pc8);
>  		outp += sprintf(outp, "pc9: %016llX\n", p->pc9);
>  		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
> -		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
>  		outp += sprintf(outp, "cpu_lpi: %016llX\n", p->cpu_lpi);
>  		outp += sprintf(outp, "sys_lpi: %016llX\n", p->sys_lpi);
>  		outp += sprintf(outp, "Joules PKG: %0X\n", p->energy_pkg);
> @@ -5135,7 +5134,7 @@ int initialize_counters(int cpu_id)
>  
>  void allocate_output_buffer()
>  {
> -	output_buffer = calloc(1, (1 + topo.num_cpus) * 1024);
> +	output_buffer = calloc(1, (1 + topo.num_cpus) * 2048);

Is there a better way to calculate the size of that buffer other than a magic
number?

P.

>  	outp = output_buffer;
>  	if (outp == NULL)
>  		err(-1, "calloc output buffer");
> 
