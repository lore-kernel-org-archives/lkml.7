Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F282BECE587
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 07:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5631206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 07:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfJMHfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 03:35:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbfJMHfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 03:35:12 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3DD23B72A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 07:35:11 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id c90so8346021edf.17
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 00:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+nhMwoFA/Zdj7REX7JZ9vKBwgACObI42dK519n+ylCo=;
        b=ZPn2pWcS0CUBp6AE09P7cFPUh6aOcF7/vl8iHx61m3m1O3lTpRBrYRfTcBJiH8scls
         R6XVJ+6hh5GN+JMpPFXbfcP8g0YeblcgefeVenlHWLSZFy2avxocJs/Y705r1JcSNtVl
         xhgZuefV9URiqvswOWHpOUEbUHEYCroS0m3+gYIbWa4WPObRJJQVphFmDq7JJtGHj7Id
         vBJdxF1w+wirxUph9lF3flqf5ZCZP/uGR4Hwrc4lFQCguK5y2vE71SWJW8v2j4frIhjt
         TwFEWlP5px7506TY7zmG3O1yS/VzpJ3LARD5b3Z2zoD2m7n86Bk8Dv0qXExbAsbOsL+X
         N3VA==
X-Gm-Message-State: APjAAAUMuMxvixFabh1Vzx/F8EIQujSAsXnA8MJTy5StoR2FkA+QF5bW
        MDS33XVzAnroCLqCLKHABr7ixJhn4rLus9kqN7ZjUimGqYvgBUBefErfppNoE6RGjKEnGI/6XfO
        gdMbCyImqc8ZHMFnG2fYj8GfF
X-Received: by 2002:aa7:c6cf:: with SMTP id b15mr22102432eds.215.1570952110652;
        Sun, 13 Oct 2019 00:35:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxaaWc1RW2fUkJ93Cyh8P72IOM0zreeQVqZTdbNARbLtHBJmDsAswhMB+6rig1it3UkM/KPyQ==
X-Received: by 2002:aa7:c6cf:: with SMTP id b15mr22102421eds.215.1570952110454;
        Sun, 13 Oct 2019 00:35:10 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id f36sm2471710ede.28.2019.10.13.00.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2019 00:35:09 -0700 (PDT)
Subject: Re: [PATCH] x86/mce: Lower throttling MCE messages to warnings
To:     Benjamin Berg <bberg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <5da27a3e.1c69fb81.d3083.7f73SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1eab3630-30d7-ff8f-8da6-aa9fc5c17f34@redhat.com>
Date:   Sun, 13 Oct 2019 09:35:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <5da27a3e.1c69fb81.d3083.7f73SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 09-10-2019 17:54, Benjamin Berg wrote:
> On modern CPUs it is quite normal that the temperature limits are
> reached and the CPU is throttled. In fact, often the thermal design is
> not sufficient to cool the CPU at full load and limits can quickly be
> reached when a burst in load happens. This will even happen with
> technologies like RAPL limitting the long term power consumption of
> the package.
> 
> So these messages do not usually indicate a hardware issue (e.g.
> insufficient cooling). Log them as warnings to avoid confusion about
> their severity.
> 
> Signed-off-by: Benjamin Berg <bberg@redhat.com>
> Tested-by: Christian Kellner <ckellner@redhat.com>

This seems like the exact same patch as you send before, is there
any reason for this resend ?

Regards,

Hans


> ---
>   arch/x86/kernel/cpu/mce/therm_throt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
> index 6e2becf547c5..bc441d68d060 100644
> --- a/arch/x86/kernel/cpu/mce/therm_throt.c
> +++ b/arch/x86/kernel/cpu/mce/therm_throt.c
> @@ -188,7 +188,7 @@ static void therm_throt_process(bool new_event, int event, int level)
>   	/* if we just entered the thermal event */
>   	if (new_event) {
>   		if (event == THERMAL_THROTTLING_EVENT)
> -			pr_crit("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
> +			pr_warn("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
>   				this_cpu,
>   				level == CORE_LEVEL ? "Core" : "Package",
>   				state->count);
> 
