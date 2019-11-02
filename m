Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F23CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE6621726
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfKBKBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:01:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfKBKBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:01:10 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8761F85539
        for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2019 10:01:10 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id f16so6719200wrr.16
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 03:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9XNTKc5genliBm4pwVnGp5ocSwuijOny5znRUr/6AeE=;
        b=kBQBt6UZN9OCblQ3Dq9ke/09kvElaH2SBuJ/yethiKpi54lyClgCSbnsufLY1XYNZ4
         rwvAlNYltLNKgFTzAnO5Y5TRF36SeIB9x3pX5CKMpviWb6lmiqnT6KDfYgJtuwJLu59u
         oXX9oFmDfesoshQ76kOpsMJRssfYWBBUc3wIJL5t9dlODjzeGSVTLKORxVVZK7OfuAsg
         MqZeBcjvjlDnl8KBFHpgmQsq4iZiCUs1z6ihz1yxxyJPWPc+nTRFY1WRqhKxp4ptrmbG
         AmN2b1khSWcSPIh9sZ6hmncoHL7wF7Sq19cQsiWUCgCxJQbT2UBKXWSzpB32NyV68Cuj
         V85g==
X-Gm-Message-State: APjAAAUtYcB614aWyJ/wdAlg1xff44ibUFPUHN2StlHOtpmpBQ6fpXzb
        FMUQAq3sMDOgEchwNVT3KWNRBLtrSRbDF+ra0nMPXGyU7W7pbqEaTTth+EpzWM1clbV7nBI627h
        XQMWm+/SkuA1EDJz6V4N5y/cr
X-Received: by 2002:adf:b1d2:: with SMTP id r18mr14095113wra.138.1572688869239;
        Sat, 02 Nov 2019 03:01:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAbnbtaVvZ/Im2kHYX6IDEmFoBtWlaf3txs0fR9HacSgsiPdOBQBsCH7wyWCpWDEDQIlgeIg==
X-Received: by 2002:adf:b1d2:: with SMTP id r18mr14095088wra.138.1572688868989;
        Sat, 02 Nov 2019 03:01:08 -0700 (PDT)
Received: from [192.168.42.35] (mob-31-159-163-247.net.vodafone.it. [31.159.163.247])
        by smtp.gmail.com with ESMTPSA id w15sm10084861wro.65.2019.11.02.03.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 03:01:08 -0700 (PDT)
Subject: Re: [PATCH v4 12/17] svm: Temporary deactivate AVIC during ExtINT
 handling
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rkagan@virtuozzo.com" <rkagan@virtuozzo.com>,
        "graf@amazon.com" <graf@amazon.com>,
        "jschoenh@amazon.de" <jschoenh@amazon.de>,
        "karahmed@amazon.de" <karahmed@amazon.de>,
        "rimasluk@amazon.com" <rimasluk@amazon.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
References: <1572648072-84536-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1572648072-84536-13-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e57e11f4-ec24-6ad1-22ce-97da1910ed02@redhat.com>
Date:   Sat, 2 Nov 2019 11:01:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1572648072-84536-13-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/19 23:41, Suthikulpanit, Suravee wrote:
> +		/*
> +		 * IRQ window is not needed when AVIC is enabled,
> +		 * unless we have pending ExtINT since it cannot be injected
> +		 * via AVIC. In such case, we need to temporarily disable AVIC,
> +		 * and fallback to injecting IRQ via V_IRQ.
> +		 */
> +		if (kvm_vcpu_apicv_active(vcpu))
> +			svm_request_update_avic(vcpu, false);

This must be pretty heavy-weight on SMP VMs, even if most ExtINT guests
do not need SMP in the guest.  One alternative is to enable/disable
APICv when LVT or IOAPIC registers are written with ExtINT mode.  Not a
blocker, just an idea to consider.

Paolo
