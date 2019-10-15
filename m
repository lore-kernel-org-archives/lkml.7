Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514C5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA612064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfJOIcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:32:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfJOIcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:32:15 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F1EE5945B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:32:15 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id f3so9731597wrr.23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 01:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P5PIeo7F8BONUmbx5z3F8WKmU2e7zzUSE3SYwbN/HB8=;
        b=d3AOzIBD451fs2SQ8hBugBOFoy2DlN9bbGWYwcEz6+Lk2CVT6i+Bu7bad9+aIyHa7A
         2PZXw5XibI4oGXhf455w2VxNgyZA2aa5NAlpl0wgT0oh7MveNFG/JEZ+8DnlrgueJtKM
         WZ985S4uAWsx0GnLz7JvHrNvnFc+Ne9jsYHtMp8/A5jiOsDFVx0+4QCMbV0q8o2F7TPd
         H2tEJOxu/rTN7yxscPHBNqVOkBQaETXHf6E6PJDyU4IfDLsTOj6Q3JKMhDYX8OSHEWMz
         qaq6uQx5ttN3RRZQXJS79F4zUwVAh4lDNk+ub9/xugpAoTnHE9y2Q48R6CmpxwEu7KHX
         kJ+g==
X-Gm-Message-State: APjAAAUBy5AMEpQ2qHjr/vloWo6nVlaXg34KkXm2qnvPpT/HJBF7tz2U
        KKnY1RCOvyBtNkIoOBEB9h4xF1eHSCtYU8kX1z6KW1eQSdJ3ySiFOdpjNkzs265Zns/+LsyLmE1
        k/CUkQXpIQzfhf4Tt9nqZ/X5P
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr27570509wrr.55.1571128333665;
        Tue, 15 Oct 2019 01:32:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxrwQzt+PWn32MNk4JHIoXCkTdb8YUH7EkIrAtHisFtFyFyrwBRV58d5gOa3puF11f2x3ROYw==
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr27570487wrr.55.1571128333388;
        Tue, 15 Oct 2019 01:32:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41? ([2001:b07:6468:f312:d001:591b:c73b:6c41])
        by smtp.gmail.com with ESMTPSA id a4sm17420727wmm.10.2019.10.15.01.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 01:32:12 -0700 (PDT)
Subject: Re: [PATCH 01/14] KVM: monolithic: x86: remove kvm.ko
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20190928172323.14663-1-aarcange@redhat.com>
 <20190928172323.14663-2-aarcange@redhat.com>
 <20191015013144.GC24895@linux.intel.com>
 <20191015031828.GE24895@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <259674b0-85e3-5266-4eaa-6314e8156f77@redhat.com>
Date:   Tue, 15 Oct 2019 10:32:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015031828.GE24895@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/19 05:18, Sean Christopherson wrote:
>> The KVM config option should be changed to a bool and its help text
>> updated.  Maybe something similar to the help for VIRTUALIZATION to make
>> it clear that enabling KVM on its own does nothing.
> Making KVM a bool doesn't work well, keeping it a tristate and keying off
> KVM=y to force Intel or AMD (as done in the next patch) looks like the
> cleanest implementation.

Indeed, keeping the KVM option as tristate helps showing the right
suboptions, similar to what Andrea did in patch 2.  However, this patch
already breaks the CONFIG_KVM_INTEL=y && CONFIG_KVM_AMD=y case I think,
so it should be squashed with "KVM: monolithic: x86: disable linking vmx
and svm at the same time into the kernel".

> The help text should still be updated though.

The patch doesn't change the fact that enabling KVM on its own does
nothing, so the help text can be updated independently (patch welcome :)).

Thanks,

Paolo

