Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2294AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02462133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388482AbfJCUMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:12:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387979AbfJCUMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:12:55 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A616A59451
        for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2019 20:12:54 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id o188so1581329wmo.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rerzWNDOelGSyyCVe9BrAyvD4JaZG3M8YLw2oByHjPM=;
        b=RSOhRtxtYWapEcAEslEqYiFD+ruM0WwOHiNoN9atfrywXwR0dXCSKZgac0OV9oso6D
         Gaw9vIuPXD6vmQ8xMvkbWZ/QvVJ5VosythujmPvYWrXWGq7GYOXzme1cr0l4lk7yWvAJ
         7pu/v069Hqwyl7caRDrWYKdo0DceLxtzkwetwdXkpj0JnICWB4UnUz0tKqtEAfXsVSx8
         eLhEpcPcVKO/bNatVX85hUotE8qnH2eF2v/Ah7V4X6Sf+/EUwpHKSet4CB21K89MzdiE
         RzH9f/BdmCnthszxma3dvsdzbaY4rJYMM7PfE8zDpboMFaUWZrsoc3H8DvCEMhuiiJlo
         Z4GA==
X-Gm-Message-State: APjAAAWBMIG7hAqgXOg5hZftrhw+fKzSSKSmeUJd3r4y46/z7DJuVFZS
        L+aFqf5L6vkF0660eNBAsF3rguL6GHpEXwvkeOEDbB7tT40dmu1R4zr7DsaD9wrTgLHtcLS7TFz
        F1VEezjgGCNLliGGaTtn7pvjR
X-Received: by 2002:a7b:caaa:: with SMTP id r10mr8580931wml.100.1570133573282;
        Thu, 03 Oct 2019 13:12:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxigiOC/2WV/mXvcjmQaOXxgRGDV6OKPxDANRnt+Nj/+WYpfbOYZVrhbaSwqm9sAffAeu5UcA==
X-Received: by 2002:a7b:caaa:: with SMTP id r10mr8580919wml.100.1570133573021;
        Thu, 03 Oct 2019 13:12:53 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id h14sm4502733wro.44.2019.10.03.13.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 13:12:52 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86: omit absent pmu MSRs from MSR list
To:     Jim Mattson <jmattson@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <1570097418-42233-1-git-send-email-pbonzini@redhat.com>
 <CALMp9eRFUeSB035VEC61CzAg6PY=aApjyiQoSnRydH788COL4w@mail.gmail.com>
 <f8e169a5-4cf6-8df7-86bb-f70a480c33ad@redhat.com>
 <CALMp9eSCB-wyLm-QYS-7gTcSeuWWCvgYL3iDEP0y6BM4cWMFag@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d879b3a1-c5e8-00ba-4b80-e5da4dcceea7@redhat.com>
Date:   Thu, 3 Oct 2019 22:12:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eSCB-wyLm-QYS-7gTcSeuWWCvgYL3iDEP0y6BM4cWMFag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/19 20:23, Jim Mattson wrote:
> On Thu, Oct 3, 2019 at 10:38 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 03/10/19 19:20, Jim Mattson wrote:
>>> You've truncated the list I originally provided, so I think this need
>>> only go to MSR_ARCH_PERFMON_PERFCTR0 + 17. Otherwise, we could lose
>>> some valuable MSRs.
>>
>> This is v2, so it was meant to replace the patch that truncates the
>> list.  But I can include the other one too, perhaps even ask the x86
>> maintainers about decreasing INTEL_PMC_MAX_GENERIC to 18.
> 
> The list should definitely be truncated, since
> MSR_ARCH_PERFMON_EVENTSEL0 + 18 is IA32_PERF_STATUS.

Ok, thanks.

Paolo

