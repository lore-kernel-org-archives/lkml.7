Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668B6C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FCE206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfJJKur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:50:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732317AbfJJKuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:50:46 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABEE980F81
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 10:50:46 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id z17so2564754wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 03:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2JdVNcJHcx/QcdzRfb4YJuuCrnXrMcDI8HLU35hMmQI=;
        b=J2u3AIBG1+FKM8piBmzRiMndZ+LvAkerC+KLs3qm7EGBPLGSlRB0ENvurrbjaulCUw
         3pyz7kEgBsf3BavD00M42UZF4MQhqJLPW+ItFjVgjn+LXT3tzasnesamKPfbE/WndgG/
         G+hgH25SpWjp08Na8pA4H150BQdMiEGwz5bLojGUjhyoWa7QoXTKn9mom92v7WWMFOy/
         1sr+cT31spwIDur2S84AuFAKUi9oECwfq89l3TCCgpCVwKndYsEKYer8vRHz6ZZxI44I
         VC/1KTzgu2P6RyVWZ8gWHxpRYG5eZ+FZXpClzWt/7pTYNweC2EpBrkUihcDdqX8L2Nds
         VA2A==
X-Gm-Message-State: APjAAAWE7fkZI2t01c/So4gx5vnYczvrpAbH7TchnGHBeM+TgBDESMIx
        dHFc3UOJHzPUV24H5wylNw0/zuPb9nfgVdXij2ZPTIh/ZdwKbiBX+ONF/FlxKnSF4VPS3ALNHiw
        IeU9MjGwxQ62K98MlLhnlspv1
X-Received: by 2002:a5d:49c4:: with SMTP id t4mr7614238wrs.242.1570704645362;
        Thu, 10 Oct 2019 03:50:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAUpvDxsejwxKs/FKoQEGqKcCFjQ2DOCIheMbyTXCS7dsfl/Lhw3da0uewQazR2XTE22w4PQ==
X-Received: by 2002:a5d:49c4:: with SMTP id t4mr7614227wrs.242.1570704645151;
        Thu, 10 Oct 2019 03:50:45 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id u11sm4393311wmd.32.2019.10.10.03.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 03:50:44 -0700 (PDT)
Subject: Re: [RFC v2 1/2] kvm: Mechanism to copy host timekeeping parameters
 into guest.
To:     Suleiman Souhlal <suleiman@google.com>, rkrcmar@redhat.com,
        tglx@linutronix.de
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        ssouhlal@freebsd.org, tfiga@chromium.org, vkuznets@redhat.com
References: <20191010073055.183635-1-suleiman@google.com>
 <20191010073055.183635-2-suleiman@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e436f19b-8ff9-9442-897d-07fed3b424a4@redhat.com>
Date:   Thu, 10 Oct 2019 12:50:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010073055.183635-2-suleiman@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/19 09:30, Suleiman Souhlal wrote:
>  	kvmclock_reset(vcpu);
>  
> +	if (vcpu->arch.pv_timekeeper_enabled)
> +		atomic_dec(&pv_timekeepers_nr);
> +

Please make the new MSR systemwide, there's no need to have one copy per
vCPU.  Also, it has to be cleared on reset.  I have just sent a patch
"[PATCH] kvm: clear kvmclock MSR on reset" and CCed you, you can add the
clearing to kvmclock_reset with that patch applied.

Paolo
