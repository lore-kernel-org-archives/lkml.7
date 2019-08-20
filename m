Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A177C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF1722DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfHTIvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:51:13 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:53130 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbfHTIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:51:13 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46CPf55hJxz1rK4j;
        Tue, 20 Aug 2019 10:51:09 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46CPf54PDPz1qqkR;
        Tue, 20 Aug 2019 10:51:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id L20mSo19cVoG; Tue, 20 Aug 2019 10:51:08 +0200 (CEST)
X-Auth-Info: xcY6E7IcabXdliwAorIpwgVxvtg+uHfQdCPV1Me18qGqBrFxBMgTnTm+lnzp4WNr
Received: from hawking (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 20 Aug 2019 10:51:08 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "paul.walmsley\@sifive.com" <paul.walmsley@sifive.com>,
        "aou\@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "allison\@lohutok.net" <allison@lohutok.net>,
        "anup\@brainfault.org" <anup@brainfault.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch\@infradead.org" <hch@infradead.org>,
        "palmer\@sifive.com" <palmer@sifive.com>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
References: <20190820004735.18518-1-atish.patra@wdc.com>
        <mvmh86cl1o3.fsf@linux-m68k.org>
        <b2510462b55ffd93dba0c1b7cc28f9eef3089b50.camel@wdc.com>
X-Yow:  Hold the MAYO & pass the COSMIC AWARENESS...
Date:   Tue, 20 Aug 2019 10:51:07 +0200
In-Reply-To: <b2510462b55ffd93dba0c1b7cc28f9eef3089b50.camel@wdc.com> (Atish
        Patra's message of "Tue, 20 Aug 2019 08:42:19 +0000")
Message-ID: <mvma7c4kyo4.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 20 2019, Atish Patra <Atish.Patra@wdc.com> wrote:

> +
> +       cpuid = get_cpu();
> +	if (!cmask) {
> +               riscv_cpuid_to_hartid_mask(cpu_online_mask, &hmask);
> +               goto issue_sfence;
> +       }
> +
> +       
> +       if (cpumask_test_cpu(cpuid, cmask) && cpumask_weight(cmask) ==
> 1) {
> +               /* Save trap cost by issuing a local tlb flush here */
> +               if ((start == 0 && size == -1) || (size > PAGE_SIZE))
> +                       local_flush_tlb_all();
> +               else if (size == PAGE_SIZE)
> +                       local_flush_tlb_page(start);
> +               goto done;
> +       }
> +
>         riscv_cpuid_to_hartid_mask(cmask, &hmask);
> +
> +issue_sfence:
>         sbi_remote_sfence_vma(hmask.bits, start, size);
> +done:
> +       put_cpu();
>  }
>
> This is much simpler than what I had done in v2. I will address the if
> condition around size as well.

I still think that this function should be moved out of the header.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
