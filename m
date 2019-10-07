Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0094C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4A420867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfJGMBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:01:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbfJGMBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:01:53 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C90DF4E926
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 12:01:52 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id r21so3227070wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 05:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bsJhXhtGYtCH4CJ8wCC3ALCtO7mJ3gdkqUkiOJ5d8pY=;
        b=E3gLbrw2BR5eL6ibm14cAFhCVMfMmp2Ew9YCTJIxyPQGctPDNiwxq53jMaLII0j5xE
         4WaOw1r4kNVHcz+k7SaLjALPQCO+Zf+2pCv+ALXRF78Y/6/Kwe2wWC6pxYi5fKVf4Jb5
         XR1Mk+DmW1AbN+t1GHVwRfnINtgypOJbecDQJbFiro6bMuF8+PPGixGenVdXbfHCkDo/
         DBPV9vK97dMdVcfNqO7UpNP37mRLW+XMfq7l6FPz7v+etPGIWnVelxz13LxEWNo78/HZ
         L4s3b70uGvD2BlmTPQbYsO1ae82MNS4Ph1sEe6u8/TCY4CRwTLt88R2FpBIO8aLeypAk
         x7QQ==
X-Gm-Message-State: APjAAAURVxpgEwYXGWOx8EmNKfN0LKH3vcfVY1GnAmV2uaNYrttSTPRS
        Z+u34HVlX53bWj38AKs7yXld8niLG2lPl8srQ2B3ylx4ejM1ImrRPe8X8Mx8VHCm+C80rx9iweG
        GC/81JhWhBuOWJWInrUXjrv0R
X-Received: by 2002:a7b:c758:: with SMTP id w24mr18575850wmk.148.1570449711347;
        Mon, 07 Oct 2019 05:01:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpkDLI5RBBqDmC0OqrP6lbSm3bJNPcdNP66AeEivRkI32/Jf0wIuKO8BUPPRXP1sZq+LKpHQ==
X-Received: by 2002:a7b:c758:: with SMTP id w24mr18575822wmk.148.1570449711066;
        Mon, 07 Oct 2019 05:01:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dd9:ce92:89b5:d1f2? ([2001:b07:6468:f312:9dd9:ce92:89b5:d1f2])
        by smtp.gmail.com with ESMTPSA id l18sm15770965wrc.18.2019.10.07.05.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 05:01:50 -0700 (PDT)
Subject: Re: [PATCH 1/3] perf/core: Provide a kernel-internal interface to
 recalibrate event period
To:     Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, peterz@infradead.org,
        Jim Mattson <jmattson@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        ak@linux.intel.com, wei.w.wang@intel.com, kan.liang@intel.com,
        like.xu@intel.com, ehankland@google.com, arbel.moshe@oracle.com,
        linux-kernel@vger.kernel.org
References: <20190930072257.43352-1-like.xu@linux.intel.com>
 <20190930072257.43352-2-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6439df1c-df4a-9820-edb2-0ff41b581d37@redhat.com>
Date:   Mon, 7 Oct 2019 14:01:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930072257.43352-2-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/19 09:22, Like Xu wrote:
> -static int perf_event_period(struct perf_event *event, u64 __user *arg)
> +static int _perf_event_period(struct perf_event *event, u64 value)

__perf_event_period or perf_event_period_locked would be more consistent
with other code in Linux.

Paolo
