Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1648C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E02525DD7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="H1BMlWCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfE3Qsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 12:48:51 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:52348 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726015AbfE3Qsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:48:51 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 29CB7C020D;
        Thu, 30 May 2019 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559234913; bh=I8CpabKTC7cp43uKpZMBEkLYPK9H8pVEcumQE4+A1Qc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=H1BMlWCiJxnPxLIJnT6Jh7jP57g/Bd7u0qmejFHOkpRaQItvYF0AYq8zmXRSB+mml
         URMrWa9frLRVwCD7RTpVgDtolVRNWP8CVqly9Nf9u5fw+z9cQd/85gkWNvBVjzok4t
         Ry7zQ3/zawnLwMC4LVMGcXTCAq/b+kvXFPqhK6mZ5o99iubcVXPOtWRUQ2FPGYOgDy
         9Xgc79Nbz5hukcDPWh/HF1QfAagj9HwuVMoxpoWzSs1h4f08AXF5tFnwtH76yASplZ
         XeOZ062RH9YQdBOtpFv5N9DX3ZC+YALIhlSFbgdRgfrfCoborax/Nkg2aQ/PhvRzMI
         fYlycXtGilphA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A3CF5A00BA;
        Thu, 30 May 2019 16:48:49 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 30 May 2019 09:48:45 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 30 May 2019 22:18:42 +0530
Received: from [10.10.161.35] (10.10.161.35) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 30 May 2019 22:18:54 +0530
Subject: Re: [PATCH 9/9] ARC: mm: do_page_fault refactor #8: release mmap_sem
 sooner
To:     <linux-snps-arc@lists.infradead.org>
CC:     Peter Zijlstra <peterz@infradead.org>, <paltsev@snyopsys.com>,
        <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Newsgroups: gmane.linux.kernel.arc,gmane.linux.kernel
References: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
 <1557880176-24964-10-git-send-email-vgupta@synopsys.com>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 mQINBFEffBMBEADIXSn0fEQcM8GPYFZyvBrY8456hGplRnLLFimPi/BBGFA24IR+B/Vh/EFk
 B5LAyKuPEEbR3WSVB1x7TovwEErPWKmhHFbyugdCKDv7qWVj7pOB+vqycTG3i16eixB69row
 lDkZ2RQyy1i/wOtHt8Kr69V9aMOIVIlBNjx5vNOjxfOLux3C0SRl1veA8sdkoSACY3McOqJ8
 zR8q1mZDRHCfz+aNxgmVIVFN2JY29zBNOeCzNL1b6ndjU73whH/1hd9YMx2Sp149T8MBpkuQ
 cFYUPYm8Mn0dQ5PHAide+D3iKCHMupX0ux1Y6g7Ym9jhVtxq3OdUI5I5vsED7NgV9c8++baM
 7j7ext5v0l8UeulHfj4LglTaJIvwbUrCGgtyS9haKlUHbmey/af1j0sTrGxZs1ky1cTX7yeF
 nSYs12GRiVZkh/Pf3nRLkjV+kH++ZtR1GZLqwamiYZhAHjo1Vzyl50JT9EuX07/XTyq/Bx6E
 dcJWr79ZphJ+mR2HrMdvZo3VSpXEgjROpYlD4GKUApFxW6RrZkvMzuR2bqi48FThXKhFXJBd
 JiTfiO8tpXaHg/yh/V9vNQqdu7KmZIuZ0EdeZHoXe+8lxoNyQPcPSj7LcmE6gONJR8ZqAzyk
 F5voeRIy005ZmJJ3VOH3Gw6Gz49LVy7Kz72yo1IPHZJNpSV5xwARAQABtCpWaW5lZXQgR3Vw
 dGEgKGFsaWFzKSA8dmd1cHRhQHN5bm9wc3lzLmNvbT6JAj4EEwECACgCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheABQJbBYpwBQkLx0HcAAoJEGnX8d3iisJeChAQAMR2UVbJyydOv3aV
 jmqP47gVFq4Qml1weP5z6czl1I8n37bIhdW0/lV2Zll+yU1YGpMgdDTHiDqnGWi4pJeu4+c5
 xsI/VqkH6WWXpfruhDsbJ3IJQ46//jb79ogjm6VVeGlOOYxx/G/RUUXZ12+CMPQo7Bv+Jb+t
 NJnYXYMND2Dlr2TiRahFeeQo8uFbeEdJGDsSIbkOV0jzrYUAPeBwdN8N0eOB19KUgPqPAC4W
 HCg2LJ/o6/BImN7bhEFDFu7gTT0nqFVZNXlOw4UcGGpM3dq/qu8ZgRE0turY9SsjKsJYKvg4
 djAaOh7H9NJK72JOjUhXY/sMBwW5vnNwFyXCB5t4ZcNxStoxrMtyf35synJVinFy6wCzH3eJ
 XYNfFsv4gjF3l9VYmGEJeI8JG/ljYQVjsQxcrU1lf8lfARuNkleUL8Y3rtxn6eZVtAlJE8q2
 hBgu/RUj79BKnWEPFmxfKsaj8of+5wubTkP0I5tXh0akKZlVwQ3lbDdHxznejcVCwyjXBSny
 d0+qKIXX1eMh0/5sDYM06/B34rQyq9HZVVPRHdvsfwCU0s3G+5Fai02mK68okr8TECOzqZtG
 cuQmkAeegdY70Bpzfbwxo45WWQq8dSRURA7KDeY5LutMphQPIP2syqgIaiEatHgwetyVCOt6
 tf3ClCidHNaGky9KcNSQ
Message-ID: <d7284369-52a6-71e5-65ae-75ec389eb92b@synopsys.com>
Date:   Thu, 30 May 2019 09:48:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1557880176-24964-10-git-send-email-vgupta@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.35]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/19 5:29 PM, Vineet Gupta wrote:
> In case of successful page fault handling, this patch releases mmap_sem
> before updating the perf stat event for major/minor faults. So even
> though the contention reduction is NOT supe rhigh, it is still an
> improvement.

This patch causes regression: LMBench lat_sig triggers a bogus oom.

The issue is not due to code movement of up_read() but as artifact of @fault
initialized to VM_FAULT_ERROR. The lat_sig invalid access doesn't take
handle_mm_fault() instead it hits !VM_WRITE case for write access leading to use
of "initialized" value of @fault VM_FAULT_ERROR which includes VM_FAULT_OOM hence
the bogus oom handling.


> There's an additional code size improvement as we only have 2 up_read()
> calls now.
> 
> Note to myself:
> --------------
> 
> 1. Given the way it is done, we are forced to move @bad_area label earlier
>    causing the various "goto bad_area" cases to hit perf stat code.
> 
>  - PERF_COUNT_SW_PAGE_FAULTS is NOW updated for access errors which is what
>    arm/arm64 seem to be doing as well (with slightly different code)
>  - PERF_COUNT_SW_PAGE_FAULTS_{MAJ,MIN} must NOT be updated for the
>    error case which is guarded by now setting @fault initial value
>    to VM_FAULT_ERROR which serves both cases when handle_mm_fault()
>    returns error or is not called at all.
> 
> 2. arm/arm64 use two homebrew fault flags VM_FAULT_BAD{MAP,MAPACCESS}
>    which I was inclined to add too but seems not needed for ARC
> 
>  - given that we have everything is 1 function we cabn stil use goto
>  - we setup si_code at the right place (arm* do that in the end)
>  - we init fault already to error value which guards entry into perf
>    stats event update
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
>  arch/arc/mm/fault.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
> index 20402217d9da..e93ea06c214c 100644
> --- a/arch/arc/mm/fault.c
> +++ b/arch/arc/mm/fault.c
> @@ -68,7 +68,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
>  	struct mm_struct *mm = tsk->mm;
>  	int sig, si_code = SEGV_MAPERR;
>  	unsigned int write = 0, exec = 0, mask;
> -	vm_fault_t fault;			/* handle_mm_fault() output */
> +	vm_fault_t fault = VM_FAULT_ERROR;	/* handle_mm_fault() output */
>  	unsigned int flags;			/* handle_mm_fault() input */
>  
>  	/*
> @@ -155,6 +155,9 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
>  		}
>  	}
>  
> +bad_area:
> +	up_read(&mm->mmap_sem);
> +
>  	/*
>  	 * Major/minor page fault accounting
>  	 * (in case of retry we only land here once)
> @@ -173,13 +176,9 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
>  		}
>  
>  		/* Normal return path: fault Handled Gracefully */
> -		up_read(&mm->mmap_sem);
>  		return;
>  	}
>  
> -bad_area:
> -	up_read(&mm->mmap_sem);
> -
>  	if (!user_mode(regs))
>  		goto no_context;
>  
> 

