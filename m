Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BC4C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C7920748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574316292;
	bh=bJ1pC8sNxLuSKO9wSA6bo0s1rJS5HTbHJC3usr8+UOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L0E/IZSSbKt39yei8HWWBwkTF22KWHojKC14N1TSZBdlDwJHwHNgx1a3CEFhY4SAU
	 mOtWc43EQ2YzzcDZ80f13gJvYMb6HHftyrBm2Nqb1FRtMWx7odURVlaZkuAmD7sUQz
	 ijy9HEDtlSBvyY30YCdIxpuXGhcmo9Yy+vMmjvI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKUGEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 01:04:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44322 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUGEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 01:04:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so2795748wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 22:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Aftv2B7pRGkc7+AovR1Vv564LUJRIu9W5RpFUDJ8xIw=;
        b=nLLinjq9fpIl0ZgbkNtjiASwUpwqguNl6ZcBlyo/8h3DND16GCBrkFNrJW3S+oOYms
         dAdKllSaQ3iGsbrtWoqh1p5eHGq1vVPUkoGpx4jbXXczHFTzN0bEDvBYp+njO7KgOYKt
         HqmRGsaGobDhd3Q6qaxIAnGl5DOz7r/CJckiNikZ5f2aOzB5FnpTPCLe2C0SXFrUbd7A
         9iuTdkAzOVJial0lxrLFJssx97oCIz4AUrdekKYxWfTIIvbPPvsnIt4W9n+GguQXTxb9
         9eRcBSmzomQapHcswda8JAQO73rtyX+zRhm1ERZQFTbwFeKK/QimEu3IyPdpuKArDN+i
         A9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Aftv2B7pRGkc7+AovR1Vv564LUJRIu9W5RpFUDJ8xIw=;
        b=ZOS43xGlQxqLDDLFeqYy/hYCrFDtE3NERnD04fNSCDmVw33ZkBzLwRgVO/juinw0Fa
         zq0Z8E1bK3nnpTMParTHm+t8/hshVjOOQ/U3Afg80okV+4U9GLgyTu27TjnM2WbZFwAf
         SdJih5+MbYS86CKC/okPqE0QIaVADJX8x9USEwmBoLdqWzOyA8sEIiL6a5OwmK0aTNT1
         Ypyj1y2nYk0uGS8I/0/ryiE83FzElO1nptzEKSrLgOz+TFo9Qg3PQ4WMypo2jK286tsd
         g4kQX/ntNVwCBsQkcXf5WOPFZRC1Y2+Eo161p+5DK/rMKeLHBXQlgl7wxnnE5oPJ1HH3
         0FoA==
X-Gm-Message-State: APjAAAVZEuzeb5QG1rBthBpMrHX4EGAUUK3QM2pBEDTY7kE/zOfDpyZ+
        kvPDeYzstDp0CpGzcEAbIk8=
X-Google-Smtp-Source: APXvYqyuT6Q9PoLkXMPKpYUiFqgtbY+G7TVQjYrBsYIwMxp3oHnCW0kjdcKK2gyKiskhwb3dYUKbNQ==
X-Received: by 2002:adf:de0a:: with SMTP id b10mr8395798wrm.268.1574316286735;
        Wed, 20 Nov 2019 22:04:46 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v81sm1820545wmg.4.2019.11.20.22.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 22:04:46 -0800 (PST)
Date:   Thu, 21 Nov 2019 07:04:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121060444.GA55272@gmail.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Fenghua Yu <fenghua.yu@intel.com> wrote:

> Split lock detection is disabled by default. Enable the feature by
> kernel parameter "split_lock_detect".
> 
> Usually it is enabled in real time when expensive split lock issues
> cannot be tolerated so should be fatal errors, or for debugging and
> fixing the split lock issues to improve performance.
> 
> Please note: enabling this feature will cause kernel panic or SIGBUS
> to user application when a split lock issue is detected.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 10 ++++++
>  arch/x86/kernel/cpu/intel.c                   | 34 +++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 8dee8f68fe15..1ed313891f44 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3166,6 +3166,16 @@
>  
>  	nosoftlockup	[KNL] Disable the soft-lockup detector.
>  
> +	split_lock_detect
> +			[X86] Enable split lock detection
> +			This is a real time or debugging feature. When enabled
> +			(and if hardware support is present), atomic
> +			instructions that access data across cache line
> +			boundaries will result in an alignment check exception.
> +			When triggered in applications the kernel will send
> +			SIGBUS. The kernel will panic for a split lock in
> +			OS code.

It would be really nice to be able to enable/disable this runtime as 
well, has this been raised before, and what was the conclusion?

Thanks,

	Ingo
