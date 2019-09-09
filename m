Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F20C49ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DF72089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfIIRK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:10:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfIIRK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 13:10:26 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDB5D81DEB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2019 17:10:25 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id x12so7672169wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 10:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vktWNuZwbJFGpFqKeMcs/0LdSEYrwQogjSjWjrJcDWk=;
        b=OBoZplGENERX+RPjhjuE60BKlvnxu8ZEAEAb7Yt9ljLBQWaL5ZbcMcBKOYt9JhMnfM
         jJQnret67hgWo2VA+UJYpYpFaY+QCSWJGUphJaHdUerq1Ia17FkLy/yj0Gfl6RRFNnfw
         Al2V3bKO87zy8h/bDzbQWzKVPUEklPfEAUFU1cgvRlijcqBkT3Wew3ijlGFlqkZaYpGj
         4bhUQPV3a1u8XBeFcH6H6GwXab8fSP7ATJwtVsn611KrDMYs9ujfDoETt12AS4zYozys
         XWWeS7kdxVkVANg0nCkP00bcGtgu9GiTRlXunQJzC96x8Hh7e565rIc6yVT20w0mQ5Df
         qd9A==
X-Gm-Message-State: APjAAAVDu5Ay0s6Vr0stEoJhtc3JIfy8mmWmb5THi52lfY9+T79+hYwI
        K+dQXbLMazJ03I9BqoqqMk4h908VCQh9nHTn/UswzNaJmkqdrivlob0Xi4Go3QWwwE88/YF7/tf
        ErbE8v55bcgm/M/xFj5v0dxLW
X-Received: by 2002:a5d:6703:: with SMTP id o3mr19299892wru.335.1568049024382;
        Mon, 09 Sep 2019 10:10:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz1n8Q55r7pA74Rbm16weqpXyq4cX1HxgIYP07KC/z/TIvITLwn+XU8NsN4rLzMHK0+7mHPAA==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr19299855wru.335.1568049024123;
        Mon, 09 Sep 2019 10:10:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4580:a289:2f55:eec1? ([2001:b07:6468:f312:4580:a289:2f55:eec1])
        by smtp.gmail.com with ESMTPSA id g73sm292338wme.10.2019.09.09.10.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 10:10:23 -0700 (PDT)
Subject: Re: [PATCH RESEND v4 8/9] KVM: MMU: Enable Lazy mode SPPT setup
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, mst@redhat.com,
        rkrcmar@redhat.com, jmattson@google.com, yu.c.zhang@intel.com,
        alazar@bitdefender.com
References: <20190814070403.6588-1-weijiang.yang@intel.com>
 <20190814070403.6588-9-weijiang.yang@intel.com>
 <63f8952b-2497-16ec-ff55-1da017c50a8c@redhat.com>
 <20190820131214.GD4828@local-michael-cet-test.sh.intel.com>
 <20190904134925.GA25149@local-michael-cet-test.sh.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6cdea038-8d6f-6d75-47b2-bb23ff1c9f15@redhat.com>
Date:   Mon, 9 Sep 2019 19:10:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904134925.GA25149@local-michael-cet-test.sh.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/19 15:49, Yang Weijiang wrote:
>>> This would not enable SPP if the guest is backed by huge pages.
>>> Instead, either the PT_PAGE_TABLE_LEVEL level must be forced for all
>>> pages covered by SPP ranges, or (better) kvm_enable_spp_protection must
>>> be able to cover multiple pages at once.
>>>
>>> Paolo
>> OK, I'll figure out how to make it, thanks!
> Hi, Paolo,
> Regarding this change, I have some concerns, splitting EPT huge page
> entries(e.g., 1GB page)will take long time compared with normal EPT page
> fault processing, especially for multiple vcpus/pages,so the in-flight time increases,
> but HW walks EPT for translations in the meantime, would it bring any side effect? 
> or there's a way to mitigate it?

Sub-page permissions are only defined on EPT PTEs, not on large pages.
Therefore, in order to allow subpage permissions the EPT page tables
must already be split.

Paolo
