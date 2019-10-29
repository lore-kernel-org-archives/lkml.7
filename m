Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C32CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF9B21721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572385656;
	bh=pwNnyj+k5EM25iSVdP3GC9AqhFmMSbZd5YRK21JHcfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mwKD3SNDZtpmNfALli9JebXuPPn0nc4rzTPAc3wd+u0MfebYdUTfQjYmIhfUcH2Yv
	 FVMi2ME+WXhfCNlKWHtDOVMfXHF0pYFcKsM91JJNsT+wB2CPAyJtMofPurNReNMkd4
	 edoYsU82AWuy+jmutv2Ib33qY2bJSMhg4ka/6+kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfJ2Vrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:47:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33495 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfJ2Vre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:47:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id u13so307058ote.0;
        Tue, 29 Oct 2019 14:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwNnyj+k5EM25iSVdP3GC9AqhFmMSbZd5YRK21JHcfE=;
        b=LqWPNvkKEGAL5arS764pYx3bjQA+SSvecwI/CX9cxDydl2t0Cpa0e3Rrswxlo5B+1V
         1gp4832PAXvG/qQuwgbep0kHC/qZNFIbHyyWnEVtAieJcs/MwXO0E/CFkvVLuhdVgoCx
         p5ywKvSwxm/LuPwM0M71smMFU6yFdr5ikKpkz4hjAXayqRJNfklEB0Iclwa0XlRbwHqD
         jE/vdY06pM3yFX9vlLq2LgniYSmhY5RaDfMowyAA1nY8gXDq8AI+s3KxMV3x25k4gUu3
         VqRYasyNq650I/BECySPuS1XGdD8gUq69/RfHkL0PWBdDbjChiQzEFOuI6wGDla2gXay
         SFmQ==
X-Gm-Message-State: APjAAAXFta/WAyEVMjQSXDxIfp61Ar/U0SSsDaeTDh9QFuS1fRx1VALe
        eOPDJzUUCoLDtiWA4zLLrGWm68gJ4w5/6c71ojw=
X-Google-Smtp-Source: APXvYqweZp4jeAZD2ef4WZnlOnsYXcZXtVF5QzQHiNciMjK9rivjpgDTE7L4/I4xSUGRnOgqcFjUpQUz/ptSalHNY6A=
X-Received: by 2002:a9d:5907:: with SMTP id t7mr19014905oth.118.1572385654042;
 Tue, 29 Oct 2019 14:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <1572382505.5937.97.camel@lca.pw>
In-Reply-To: <1572382505.5937.97.camel@lca.pw>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Oct 2019 22:47:23 +0100
Message-ID: <CAJZ5v0g6_-HBEKfHtfe8LFG9PKosGeUW3-gwTBW6F32OwFwO3g@mail.gmail.com>
Subject: Re: "Force HWP min perf before offline" triggers unchecked MSR access errors
To:     Qian Cai <cai@lca.pw>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 9:55 PM Qian Cai <cai@lca.pw> wrote:
>
> The commit af3b7379e2d7 ("cpufreq: intel_pstate: Force HWP min perf before
> offline") triggers an error below while doing CPU hotplug. Reverted it (on the
> top of the linux-next) fixed it.
>
> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

The MSR_IA32_ENERGY_PERF_BIAS MSR appears to be not present, which
should be caught by the X86_FEATURE_EPB check in
intel_pstate_set_epb().

Do you run this in a guest perchance?
