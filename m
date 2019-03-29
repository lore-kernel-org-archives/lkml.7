Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F12AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C482082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QkMXmQN+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YzoEvJsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfC2Hcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:32:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47712 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfC2Hcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:32:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4F167602BA; Fri, 29 Mar 2019 07:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553844771;
        bh=/eqaOa63W84sE/ZYgU73eA2Fvn8iTbZF4RsMMuBYwmM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QkMXmQN+bIgBMKLilXf3gf3/VPVhYrsVgbyRn6Lj4FcXyd1K23smZT1MplB0potAX
         jn2UHkyvvrcasf8mc+4Yf1/4VsCFrjIkh1PSkVqWFFDPvWuSlpXQR8Qt4xxh3lb90h
         o2EB60pw7WA8yztwOQulbQbNDnaznUqCaIlImzoI=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E48DB6063A;
        Fri, 29 Mar 2019 07:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553844770;
        bh=/eqaOa63W84sE/ZYgU73eA2Fvn8iTbZF4RsMMuBYwmM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YzoEvJsU/fPeG2/86gACX0hHijImiaSgOX+alNxEBs8vFW6O1C3xQ91aDazH14L7A
         kdd4eL5E01dFYQaB6UfmHQdV7l3sXwZAPz1dKs95834Mj8/UV9PzebS/UwOXjuKxlV
         z/WJd13Nj40cnKoNy6jrtbhwyq/1NLHzFj2bLINg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E48DB6063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] x86: define LOADED_MM_SWITCHING with pointer-sized number
To:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
References: <20190328230939.15711-1-jannh@google.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <fff520e9-4bbc-9a48-f3a7-fb76c443d7b9@codeaurora.org>
Date:   Fri, 29 Mar 2019 13:02:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328230939.15711-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 4:39 AM, Jann Horn wrote:
> sparse complains that LOADED_MM_SWITCHING's definition casts an int to a
> pointer:
>
> arch/x86/mm/tlb.c:409:17: warning: non size-preserving integer to pointer
> cast
>
> Use a pointer-sized integer constant instead.
>
> Signed-off-by: Jann Horn <jannh@google.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   arch/x86/include/asm/tlbflush.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index f4204bf377fc..90926e8dd1f8 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -167,7 +167,7 @@ struct tlb_state {
>   	 */
>   	struct mm_struct *loaded_mm;
>   
> -#define LOADED_MM_SWITCHING ((struct mm_struct *)1)
> +#define LOADED_MM_SWITCHING ((struct mm_struct *)1UL)
>   
>   	/* Last user mm for optimizing IBPB */
>   	union {
