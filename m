Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C73EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF4320865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389480AbfJCRiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:38:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62967 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729496AbfJCRiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:38:03 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E9D8C05AA56
        for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2019 17:38:03 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id b6so1440381wrw.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lYo2GXCjdmNjbw8XriQ6Oi5EGNGdZIx3mlt6jwh3aLc=;
        b=JXnBtsFhrzftQRbx/loekfNTxkeh4/wt6Y2ImJvocakGyOubGkhibIbWZcLlF0wFPE
         TO2p7o9qc81ixt/QA9TenYF4mr+X8HKQbDCmzG4eMU+T36Q4Np2dRv1enZN+0ptrYb5p
         wbTh/L6dK4Uv7LGYEpa/Tez8WeInUp2nQ4lm2jSiFJEvFXyhBhtgdp718lnMnJIbauab
         coX4Ch58gxQ2Q2ICPDtzn6fcB2dqgUVKOeJ9gcBrYPmCSMxEZOal3+0n7TK8dXTcLaEr
         Hqnn3RD+GXIsuHD37ez9B6rMUZAXJFmjhNa2HNztH+1wjcj7JPABurImVHZr724u2N12
         vL8g==
X-Gm-Message-State: APjAAAUFDHcmUH9AcVepkxRUIeNqUDHIazSdKLKYK4BXuIGEGoFMLAbH
        HntMIgJ3dMIdeZMsWKxE0RiVT/nM/ThRlcLOj6NF4Hc6fGSQnaLt3ECzKqcO7vCHWEdBgFl9EA3
        NnqRygoTR3EM4y6oRu9/km8o9
X-Received: by 2002:a1c:4384:: with SMTP id q126mr8378377wma.153.1570124282263;
        Thu, 03 Oct 2019 10:38:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzEKq5aJk6CuYAnZXAOfVO7RG4gr7SrDCJd/9DLazu4cJxcuFQ2bh6dgmgX7bvVQXHfJKqpqQ==
X-Received: by 2002:a1c:4384:: with SMTP id q126mr8378354wma.153.1570124281992;
        Thu, 03 Oct 2019 10:38:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464? ([2001:b07:6468:f312:b903:6d6f:a447:e464])
        by smtp.gmail.com with ESMTPSA id s12sm5445982wra.82.2019.10.03.10.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 10:38:01 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86: omit absent pmu MSRs from MSR list
To:     Jim Mattson <jmattson@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <1570097418-42233-1-git-send-email-pbonzini@redhat.com>
 <CALMp9eRFUeSB035VEC61CzAg6PY=aApjyiQoSnRydH788COL4w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f8e169a5-4cf6-8df7-86bb-f70a480c33ad@redhat.com>
Date:   Thu, 3 Oct 2019 19:37:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eRFUeSB035VEC61CzAg6PY=aApjyiQoSnRydH788COL4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/19 19:20, Jim Mattson wrote:
> You've truncated the list I originally provided, so I think this need
> only go to MSR_ARCH_PERFMON_PERFCTR0 + 17. Otherwise, we could lose
> some valuable MSRs.

This is v2, so it was meant to replace the patch that truncates the
list.  But I can include the other one too, perhaps even ask the x86
maintainers about decreasing INTEL_PMC_MAX_GENERIC to 18.

>> +                       if (msrs_to_save[i] - MSR_ARCH_PERFMON_PERFCTR0 >=
>> +                           min(INTEL_PMC_MAX_GENERIC, x86_pmu.num_counters_gp))
> Why involve INTEL_PMC_MAX_GENERIC here?

It's not really necessary, but I wanted to imitate how intel_pmu_refresh
initializes pmu->nr_arch_gp_counters.

Paolo

>> +                               continue;
>> +                       break;
>> +               case MSR_ARCH_PERFMON_EVENTSEL0 ... MSR_ARCH_PERFMON_EVENTSEL0 + 31:
> Same as the two comments above.
>> +                       if (msrs_to_save[i] - MSR_ARCH_PERFMON_EVENTSEL0 >=
>> +                           min(INTEL_PMC_MAX_GENERIC, x86_pmu.num_counters_gp))
>> +                               continue;

