Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B65C04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF152133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558774194;
	bh=FhZzgGPS/YmLeoFH3XiZLzM57W4ceRHKxF/3AnE3E2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DedRc+36xQkHL6rfUxBo0aNKuVGFHlQKgTZLBv5pAPAbEFPK/B7R9ULUz4rFQ5VMl
	 69Y4S/j8M1NCKGl6MEBPakfWzTfiitg9oa46HKiVF1T77AYSgWCIM2+atws6Ntqj8S
	 S1KcSq7gv9/eZYE3vnkt5mM2wSOZCMMtD6luRwjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfEYItx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 04:49:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43292 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfEYItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:49:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id l17so3727287wrm.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OZuFW84z9/gtH+SulwiiJSO+gwS6/6DCeSAq1yLxJCs=;
        b=PaVmAI5+LMRWtA2eF28QbiBf4SiDWETkbqgL1Rn1LTa1LVlvRy6R+ypBVFw+aNe2jI
         KsuTkEalTAv/VnaSDBGMPfc73N9KyIRfJbPHaSaAVEzrt7ijNjiQh+THMdB0APgnxJYl
         LkALCE3T+IOCiTb5vAx+2wqs12rCUse8avx+Hy3RznL0kJf7jvZQHJnAk2MEm34fEkh/
         nnzlE7VglRVqKkMBBw7T/O4hin0kkd7y4QRVMACl+UePPJEqVulEbAF4ns+9BPNwdkiL
         y2m0pJjWShG6tPnziHkxieFFS6GM6KU0Auc+MGCwLnXjVZ5czPpp1YeC1zAJRTtmeIp/
         PSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OZuFW84z9/gtH+SulwiiJSO+gwS6/6DCeSAq1yLxJCs=;
        b=aPfMRYXgvkjlbyvw76B6yhP5h6j9utlda8nhTlH4KQMfxk9YGYoekZCCEW+La1hf2W
         LJr0JYtFkPUuLubxgLDOGzdve8qh5to4Pefu9WQWLBQcgk3+aGXuz9TVNVwMj4f1j2Ha
         ED06pNaiT34M6IAFbW6TBQa7tuSfZGl7xA0N6ZAgK80O+O+xiNIaiL/Xu+jjsHOzY9qd
         dTSedIMuvID3UpneohII1HlS1+4sjEosIeQWaRRzgJ6TFgvEsvXuijTfSr8JLyIFp5qk
         r68an7w+I0R9zv5i0YTO7KXc0cw75bhAfPTpDiSgIpYCKLAm68XcnkSuJJEh606gqGdr
         WUhw==
X-Gm-Message-State: APjAAAViEDJM+TM/yg9VmZBUJvlnxA80V4Wv8s9nqSq8E5P5E7DkHx8G
        w35MBjCAKvDMGyWf1MkCa0E=
X-Google-Smtp-Source: APXvYqwsX3fxSvmPdjBMTgFA4ozNGI0ubQIIbPRjSyY+ZPnjvPATN5coK45HVs0YSZ5I6U6VL/SuAg==
X-Received: by 2002:adf:f841:: with SMTP id d1mr2589212wrq.62.1558774191641;
        Sat, 25 May 2019 01:49:51 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i17sm4634665wrr.46.2019.05.25.01.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 01:49:51 -0700 (PDT)
Date:   Sat, 25 May 2019 10:49:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     vincent.weaver@maine.edu, ak@linux.intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        jolsa@redhat.com, eranian@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf/x86/regs: Check reserved bits
Message-ID: <20190525084949.GB15802@gmail.com>
References: <1558636616-4891-1-git-send-email-kan.liang@linux.intel.com>
 <1558636616-4891-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558636616-4891-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:

> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The perf fuzzer triggers a warning which map to:
> 
> 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
> 		return 0;
> 
> The bits between XMM registers and generic registers are reserved.
> But perf_reg_validate() doesn't check these bits.
> 
> Add REG_RESERVED for reserved bits.
> Check the reserved bits in perf_reg_validate().
> 
> Fixes: 878068ea270e ("perf/x86: Support outputting XMM registers")
> Reported-by: Vince Weaver <vincent.weaver@maine.edu>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/kernel/perf_regs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index 86ffe5a..3f8c1fc 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -79,6 +79,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>  	return regs_get_register(regs, pt_regs_offset[idx]);
>  }
>  
> +#define REG_RESERVED	(((1ULL << PERF_REG_X86_XMM0) - 1) & \
> +			~((1ULL << PERF_REG_X86_MAX) - 1))

This is just randomly polluting the macro namespace with a new variant. 
We have PERF_REG_X86_ pattern - why not name the new one within that 
pattern?

Thanks,

	Ingo
