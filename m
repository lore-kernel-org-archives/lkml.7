Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0798FC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90CA20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfGJHsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:48:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51374 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfGJHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:48:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so1159384wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 00:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5pKvfGeJDZMFrUJE5dsk55XrwkeCdIBhXPGCJpJX3yQ=;
        b=ihE3IlGVddfVt6YhZtvSFELhHnlLK2tEjva6bhKYdx91p0wjixJ0V1JwpzIzfnGwEn
         Zwnc7Mddo5AZdmdLwYBKrs2pKhL9t28nzbvfpLEBOTIPOEqFqFf8knNCcjZoYqbbOHOM
         YwtAI34KXn4LmNeQN8jgIbALWyVJ+cySPFpQjG2++CtXe61miuDizrXtuvJwOCeVTQmc
         jXWIS1Q1hleBtiSuxslehs8sww3YSeNwQW6KhSVXVszt1a1bs39ImnP2+0S0oaGMwC3A
         eoLbzDnXocAtCNOgenFAh/pW0s11AfgMLuIzszG6nw8xd7VZcW13AvzGBZDw4hKtscm7
         Jd9w==
X-Gm-Message-State: APjAAAUHtQvXclPEj+JNlQb/DORur49pw+Ac4mZm0MOwmGxft925Yr0z
        3loA2ql42g9Am+Je1peb3gCuwV8kzeA=
X-Google-Smtp-Source: APXvYqxBo7fXc7J0sh27HZaG+Ucnx/OPQLgxeNCFIGDoYdEKJeVURij5Mh83Y1Lvo9M9i95o4ynonQ==
X-Received: by 2002:a05:600c:c6:: with SMTP id u6mr3766726wmm.153.1562744902060;
        Wed, 10 Jul 2019 00:48:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423? ([2001:b07:6468:f312:19db:ad53:90ea:9423])
        by smtp.gmail.com with ESMTPSA id b8sm1168256wmh.46.2019.07.10.00.48.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 00:48:21 -0700 (PDT)
Subject: Re: [PATCH 2/5] KVM: cpuid: extract do_cpuid_7_mask and support
 multiple subleafs
To:     Jing Liu <jing2.liu@linux.intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20190704140715.31181-1-pbonzini@redhat.com>
 <20190704140715.31181-3-pbonzini@redhat.com>
 <5af77de6-3a18-a3b9-b492-c280ac4310a1@linux.intel.com>
 <d3454d11-97fb-42f2-0a0c-add0456b076c@redhat.com>
 <752c2473-04d9-8420-a78f-fa677f806aca@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <841ba614-7657-8342-2814-ec6560e726af@redhat.com>
Date:   Wed, 10 Jul 2019 09:48:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <752c2473-04d9-8420-a78f-fa677f806aca@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/19 09:32, Jing Liu wrote:
> 
> 
> On 7/10/2019 2:30 PM, Paolo Bonzini wrote:
>> On 08/07/19 09:07, Jing Liu wrote:
>>>>
>>> And when adding subleaf 1, plan to add codes,
>>>
>>> case 1:
>>>      entry->eax |= kvm_cpuid_7_1_eax_x86_features;
>>>      entry->ebx = entry->ecx = entry->edx =0;
>>>      break;
>>>
>>> What do you think?
>>
>> This should be "&=", not "|=".  Otherwise yes, that's the idea.
>>
> 
> Yes! So let me send out the BFloat16 patch based on your patch set now
> or you have merge plan soon?

Just send it . :)

Paolo

