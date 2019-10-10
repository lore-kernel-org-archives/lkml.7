Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDA4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B41020673
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfJJKzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:55:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfJJKzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:55:31 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A77B9B294
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 10:55:31 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id k9so2455139wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 03:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cSwY5qjlZoDMf13ZGbgpfesejkb6FeuV+G9YLcC+7pQ=;
        b=HoIyCvWijjKIoDPVh3EtegnjMH0P2cn9sIwTC/sL1xW/rsvNbmMU+dnByw4yIxMcly
         fHKEngIMRudvF7hcgEuAa8o02ceLYzPcCB7bkVJrP6nY7vx7R1n0apYAxVKpN9zGVXXE
         MN9CN+8i6VPnNR9xHPsVmWMlyh+Zkz+QJGrJfICW4GIZffwTc3hBMlkcXi5K7IIbqjbb
         dSF1svCexzsrS9oY0wUM/sssokNexyIRs5gb54G7kebSROfEyNBsnLscEf3DH31Jrxx5
         6wR+Hs+hNnAWdwH5PhklV8DJ9gc2jYUXvGCUjHDO2H8mVhn98cZaBFuPOwCWSoJIdX0R
         PZAg==
X-Gm-Message-State: APjAAAXFZCVLe2C8ns5cf5NJ2pIF2hwMliXllOHbQEmWuHN+CTnPSRBa
        uYxwFN+BgKCJzHLs9Lmkzrr/KEldL7bCpUJGdSy0XvFRS1+Rc8z9PJxyLMukh0ddNVd2kQm11nT
        XFd2BmcG2Us9DGLINt7445zda
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr7968476wrx.83.1570704929566;
        Thu, 10 Oct 2019 03:55:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySoMN1eIJ4n2ryWs4xEqq8Fh+ttgSXxTH/uhDp/leaeEOfqnPg5ZQvlgCz4zJ9qa7KIWjzuw==
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr7968447wrx.83.1570704929313;
        Thu, 10 Oct 2019 03:55:29 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id c9sm4798935wrt.7.2019.10.10.03.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 03:55:28 -0700 (PDT)
Subject: Re: [RFC v2 2/2] x86/kvmclock: Introduce kvm-hostclock clocksource.
To:     Suleiman Souhlal <suleiman@google.com>, rkrcmar@redhat.com,
        tglx@linutronix.de
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        ssouhlal@freebsd.org, tfiga@chromium.org, vkuznets@redhat.com
References: <20191010073055.183635-1-suleiman@google.com>
 <20191010073055.183635-3-suleiman@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2e6e5b14-fa68-67bd-1436-293659c8d92c@redhat.com>
Date:   Thu, 10 Oct 2019 12:55:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010073055.183635-3-suleiman@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/19 09:30, Suleiman Souhlal wrote:
> +kvm_hostclock_enable(struct clocksource *cs)
> +{
> +	pv_timekeeper_enabled = 1;
> +
> +	old_vclock_mode = kvm_clock.archdata.vclock_mode;
> +	kvm_clock.archdata.vclock_mode = VCLOCK_TSC;
> +	return 0;
> +}
> +
> +static void
> +kvm_hostclock_disable(struct clocksource *cs)
> +{
> +	pv_timekeeper_enabled = 0;
> +	kvm_clock.archdata.vclock_mode = old_vclock_mode;
> +}
> +

Why do you poke at kvm_clock?  Instead you should add

	.archdata               = { .vclock_mode = VCLOCK_TSC },

to the kvm_hostclock declaration.

Please also check that the invariant TSC CPUID bit
CPUID[0x80000007].EDX[8] is set before enabling this feature.

Paolo

> +	pvtk = &pv_timekeeper;
> +	do {
> +		gen = pvtk_read_begin(pvtk);
> +		if (!(pv_timekeeper.flags & PVCLOCK_TIMEKEEPER_ENABLED))
> +			return;
> +
> +		pvclock_copy_into_read_base(pvtk, &tk->tkr_mono,
> +		    &pvtk->tkr_mono);
> +		pvclock_copy_into_read_base(pvtk, &tk->tkr_raw, &pvtk->tkr_raw);
> +
> +		tk->xtime_sec = pvtk->xtime_sec;
> +		tk->ktime_sec = pvtk->ktime_sec;
> +		tk->wall_to_monotonic.tv_sec = pvtk->wall_to_monotonic_sec;
> +		tk->wall_to_monotonic.tv_nsec = pvtk->wall_to_monotonic_nsec;
> +		tk->offs_real = pvtk->offs_real;
> +		tk->offs_boot = pvtk->offs_boot;
> +		tk->offs_tai = pvtk->offs_tai;
> +		tk->raw_sec = pvtk->raw_sec;
> +	} while (pvtk_read_retry(pvtk, gen));
> +}
> +

Should you write an "enabled value" (basically the flags) into pvtk as well?

> 
> +kvm_hostclock_init(void)
> +{
> +	unsigned long pa;
> +
> +	pa = __pa(&pv_timekeeper);
> +	wrmsrl(MSR_KVM_TIMEKEEPER_EN, pa);


As Vitaly said, a new CPUID bit must be defined in
Documentation/virt/kvm/cpuid.txt, and used here.  Also please make bit 0
an enable bit.
