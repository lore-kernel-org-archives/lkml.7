Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452A9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24751208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfFXIdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:33:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44167 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfFXIdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:33:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16so12868032wrl.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 01:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bnWH5ZYxHlgk6lep5hk4Qa6BJhgMEWUWAwCwWs+mOkc=;
        b=lvwpWkA6zeqtFKtI09NLqGUGIzurMvY5B+QLDeKFcqmFCC1YDgfRSMKlqW3YST1/aA
         CAQ9T3g2qpnFJLh9ZEddvYVeNoIXRb9LNGHzuEF4/noTMhnADZH/+GHfbqS2UQq/L3Su
         a9zxmLweROg8cB00mm3otxrNlwlbBWsloZyQS9lXIpIAOqN3L0iEmB05Bq8pkTRPP6gg
         +JzyvwXljYmhLqzMW7nrb6kqXVFW/h4E2UEeKFyqWyH3f6WBWzRXViYzexAsQJQB9+hP
         qk6kuzGaO1pBuMGGHUWbuLYemkZYU2XmvQS+w6X2hCC0Kq8AEBE45p9ndO9tiJz67F3I
         bHSA==
X-Gm-Message-State: APjAAAURmlEkA+AkgkafPldw8sqM9fGXWrXqxc/YDSehch+aWIEeiqZO
        BIuPQNOynZVtmvx/ckYLhCcaXg==
X-Google-Smtp-Source: APXvYqzvQga6R/hMu6SQdyZltSZSj0H1hwlCMupwuQ3CzWkY4X6amO1rNwFKryTvHOYQ/5B3klPoLA==
X-Received: by 2002:adf:e705:: with SMTP id c5mr81080226wrm.270.1561365219275;
        Mon, 24 Jun 2019 01:33:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab? ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
        by smtp.gmail.com with ESMTPSA id j32sm24751894wrj.43.2019.06.24.01.33.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 01:33:38 -0700 (PDT)
Subject: Re: [PATCH RFC] kvm: x86: Expose AVX512_BF16 feature to guest
To:     Jing Liu <jing2.liu@linux.intel.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jing2.liu@intel.com
References: <1561029712-11848-1-git-send-email-jing2.liu@linux.intel.com>
 <1561029712-11848-2-git-send-email-jing2.liu@linux.intel.com>
 <fd861e94-3ea5-3976-9855-05375f869f00@redhat.com>
 <384bc07d-6105-d380-cd44-4518870c15f1@linux.intel.com>
 <fb749626-1d9e-138f-c673-14b52fe7170c@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7d304ae7-73c0-d2a9-cd3e-975941a91266@redhat.com>
Date:   Mon, 24 Jun 2019 10:33:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fb749626-1d9e-138f-c673-14b52fe7170c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/19 05:10, Jing Liu wrote:
>> What do you think about @index in current function? Does it mean, we
>> need put cpuid from index to max subleaf to @entry[i]? If so, the logic
>> seems as follows,
>>
>> if (index == 0) {
>>      // Put subleaf 0 into @entry
>>      // Put subleaf 1 into @entry[1]
>> } else if (index < entry->eax) {
>>      // Put subleaf 1 into @entry
>> } else {
>>      // Put all zero into @entry
>> }
>>
>> But this seems not identical with other cases, for current caller
>> function. Or we can simply ignore @index in 0x07 and just put all
>> possible subleaf info back?

There are indeed quite some cleanups to be made there.  Let me post a
series as soon as possible, and you can base your work on it.

Paolo
