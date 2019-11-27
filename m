Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB924C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 06:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB64A20665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 06:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574837682;
	bh=rxs7qi8eKR+9ZrDZ28RvjAwZEH/m4ffIBqFeOsG9kbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ThIXshH5EV0rmw659vASQtwbDoyLtjDeCweEWUseLCVkUyF41MEpCzj76SYRkJqk+
	 x2oVadd1C+PW8EscSaKqQDfabasY6ynNntSBPA3WbKT2+Bf5SMD5atk+tvAwFLTAKj
	 1sU+oHxUElUWU7MS3DaOC/TuSDdEL1NEfRTgLZHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfK0Gyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 01:54:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43564 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfK0Gyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 01:54:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id n1so25313232wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 22:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KuQPrp2Sf7gN5I9EAr348T1yBTBQmJrpqeh1YXF7Lzs=;
        b=WMOXL/ILHyTMMK62UlIIUCyH/MoU3hbrKHjGiJ/sgbLmF8XmA91lLhtmCa5Ztrd3g6
         tNdDYpi5taMs0iX+3voaZrBBh19vE2wkV+mc0weNsnYvdJbu672uh6m8LRKlUqHGoCWz
         v9ogaH1rzEAdR8vW2/bEmSfiNJKyEetkpVt/bvZ+qrCan9TMT2J8I7SpohSfhatJPiEp
         +s8lTs3pULMQCxidqNPa5VniRtds2lDbR2ucfDDfd9XwVVL/EsrXHhXCjrVPGvOluJ6b
         SLikrXMnNPR51Uvy6lfWXbg9wcOFADAPMj8IQfMOh7MPxmQJ1Xs7wHF3N7bQZHB+ostn
         SwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KuQPrp2Sf7gN5I9EAr348T1yBTBQmJrpqeh1YXF7Lzs=;
        b=fsLqy75UA/Tx2+wV/oFBHlVq9rgFlmBkr6XR63kRPqTUyMr9+qIc6iCCUIqRTsqfSi
         nFmyUeW8lszY39RrghS+jvPeU9HYvpDyugHwMJ+gEhXar0fJzZk/pZR4U7OgvzZV5zly
         rXVf09GvaHe0V/AbFSiAkYjfmOILWfeNd9GteRMe3FrSVQlp3OyCYPljLg0iN56CiUCD
         wUHKYbh3QU4AtlQU5FIOGbSBGjTiDsvgpFu6FYfRgEVQu9poQBt6PnQSearHV4RkeyKp
         vJFiYte8OTZGd9gspmstCYtFcdHzPW2eLGECT5+zeuYA8HrXH7b0QyvjpLMtT8vvvKma
         QXqA==
X-Gm-Message-State: APjAAAXpIFROkbtT9b7WuvlKsEJcFUpVFKU2g5562A38HGvIrW1pyWeu
        aEWJaQlo1BTr3zuM8wtPUw7CBMrd
X-Google-Smtp-Source: APXvYqwE4fh4DybzzJTVdArcKOAdloAXiFEfExedjedmAj6f0bS3UToeENnW1eKVNkyO6Rvspl+tFQ==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr19328980wrm.264.1574837679093;
        Tue, 26 Nov 2019 22:54:39 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id z9sm18102498wrv.35.2019.11.26.22.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 22:54:38 -0800 (PST)
Date:   Wed, 27 Nov 2019 07:54:36 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     bp@alien8.de, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com, mingo@redhat.com
Subject: Re: [PATCH] cpu: microcode: Add comma to 0
Message-ID: <20191127065436.GC52731@gmail.com>
References: <20191126221519.167145-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126221519.167145-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jules Irenge <jbi.octave@gmail.com> wrote:

> Add ","  after 0
> Because memory for the struct is being cleared
> and elements after "," are missing on purpose
>  as they are being cleared to
> 
> Recommended by Boris Petkov
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index a0e52bd00ecc..04ee649f4acb 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -418,7 +418,7 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
>  static bool
>  apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
>  {
> -	struct cont_desc desc = { 0 };
> +	struct cont_desc desc = { 0, };

This is 100% unnecessary - " = { }" is enough of a structure initializer.

Thanks,

	Ingo
