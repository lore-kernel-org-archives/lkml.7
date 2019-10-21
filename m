Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C88DCA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7842089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfJUIMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:12:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbfJUIMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:12:50 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7641F85545
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 08:12:50 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id v26so2458508wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 01:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iMBlsmTbyc1by6UD9+Cjcv74kSZEU4gLAG9XLb3vXMM=;
        b=QpVmjnUu0dZLwH9TbJ2gxLy3njTpXglFtWuqzuFqq8T+Pi0aT6ogVcWc9QPKmVeMNb
         UkWGsD9FwXrSBu+hwa5wRLLs2XrdaV5z6/OoKrYXqDCha1mpA5xkr/3i6SbxjTBCv7iP
         C+82f02Pjss1a8v78YnpeU6L/FDym7m5XdjkPC8I3XqqF9lUo83E7u4ZTGJ26Ui21o+a
         WjGezwwSan02XKOcAZLThsFRBjqCm045BBPVwhmQcinEMD+f2z/0+xmpJHvcFKHrILFn
         EQAMk4PNNUFynABgLhFQsf/EqYc76WZrmWKHVLk04dpJ5oQRge35AMbgqfft5uB7kX5l
         s6JA==
X-Gm-Message-State: APjAAAWzI2atWmb+QGwHNRDkHwxk7fazTclDpCGBUlAV7S2Ca2pdJISo
        ayAMq1nFrMXerrDK7UbBYtTvlCBWhrv6BR4b8u0C4d4sJmuL7eNQMlwJm8kFafamaNWnqMVuc2A
        /7y8afgawS/rtI1qJP8M4mpav
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr19263027wma.44.1571645568972;
        Mon, 21 Oct 2019 01:12:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx9/+OXOzpeQV7Ni65kLbXS9IKEOhkhFOGoxsIe0Y4dR3AU7giY9RU0QnZvv+DPO6xdA+wWEw==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr19262990wma.44.1571645568652;
        Mon, 21 Oct 2019 01:12:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:566:fc24:94f2:2f13? ([2001:b07:6468:f312:566:fc24:94f2:2f13])
        by smtp.gmail.com with ESMTPSA id x7sm16385365wrg.63.2019.10.21.01.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 01:12:48 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] KVM: x86/vPMU: Reuse perf_event to avoid
 unnecessary pmc_reprogram_counter
To:     Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        peterz@infradead.org, Jim Mattson <jmattson@google.com>
Cc:     rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        ak@linux.intel.com, wei.w.wang@intel.com, kan.liang@intel.com,
        like.xu@intel.com, ehankland@google.com, arbel.moshe@oracle.com,
        linux-kernel@vger.kernel.org
References: <20191013091533.12971-1-like.xu@linux.intel.com>
 <20191013091533.12971-4-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5020e826-e461-c28a-0b40-6e00aaa28163@redhat.com>
Date:   Mon, 21 Oct 2019 10:12:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191013091533.12971-4-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a naming tweak:

On 13/10/19 11:15, Like Xu wrote:
> +	/* the exact requested config to create perf_event */
> +	u64 programed_config;

	/*
	 * eventsel value for general purpose counters, ctrl value for
	 * fixed counters.
	 */
	u64 current_config;

