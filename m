Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA421C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755D82146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SaRopDJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfI0CjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 22:39:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38463 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfI0CjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 22:39:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id w10so451696plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 19:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ugGWtC6tWcx2fP9kC+FkMWTMK1HTBdo3JgwsJvUVFAM=;
        b=SaRopDJyNjchc597CXuHhCvlT0QteAtds1WgC0biPm73ZQCA7BguaTT5oK5rFSAhHv
         lPr2yg95M41xVKeTGn2liVHJXpSC7d2KA+BAIV0LtRjtYpkn3bro1t24+OU3gOc5XnOi
         TBffW5qggkacn0AlT56KXQDZ5UD5OXaUZ8N6UJk6N3m7NF4x0N5fcVTwWs+cinLcCxkt
         /2b2kjCP5HB17T+VPdvQ6iWiQHZMbmeO2o0x+xOufA5Naizp08S0WdDLKL9k8gLfWPh8
         HEwUS2iCDBm2TiqRmQH1WTYwNNtIfxwi4dB2r0MXXxwc+H+qRLHDGFXLMNicrEgp5bfe
         IBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ugGWtC6tWcx2fP9kC+FkMWTMK1HTBdo3JgwsJvUVFAM=;
        b=OPzRJdHHZBVYPQo6skPQrxReUT0XU/9XqzvuBVEsHvsdOZYwVvisKjuY1V4hv82qZS
         lFM0hdf68N+MFEXt9D6ClL4WdIW2+MDWMSnJ6121jq3X6grOsMsSLIoJZhjMFMigARRd
         mD/zigbW8go7o85zXRW3gPZL6ujmZbziXVm/y3N90xIRYikjtJbREkQX0f7EttZuU+bU
         y88I3hQnP9ynWccJ+IT7JD39F2j6TFsbrEa0+tvWVYRlOAG6hhsJpyk3ldKjEXxqirIp
         h+NRa7XShWQBQHIIGb4OZ54XvmA/8OJP0ImH3WEvAYoR8kxHYY1+eVBVqmIUGCAVKg5H
         ZwwA==
X-Gm-Message-State: APjAAAUs3eU/pE00swf4kyUO9mCuj4XPmOWYh77FOpYAS1Da12XYImjv
        wVBo3vUmlivEydpo/zy3XyTK3g==
X-Google-Smtp-Source: APXvYqx8ZK9cXLmKUyvQarXc8SJ2g7dMslv5karQmeS3tdVNMxnTTnjxYZT45TL6jU2YOkIJn71c1w==
X-Received: by 2002:a17:902:5a44:: with SMTP id f4mr1886518plm.31.1569551944763;
        Thu, 26 Sep 2019 19:39:04 -0700 (PDT)
Received: from js-desktop.svl.corp.google.com ([2620:15c:2cd:2:5e41:bb1f:98fb:39da])
        by smtp.gmail.com with ESMTPSA id 192sm602134pfb.110.2019.09.26.19.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 19:39:03 -0700 (PDT)
Subject: Re: [PATCH 1/3] KVM: x86: assign two bits to track SPTE kinds
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <1569518306-46567-1-git-send-email-pbonzini@redhat.com>
 <1569518306-46567-2-git-send-email-pbonzini@redhat.com>
From:   Junaid Shahid <junaids@google.com>
Openpgp: preference=signencrypt
Autocrypt: addr=junaids@google.com; keydata=
 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
 iWogGkOc4UGfcj87Lt9ivHEsVoo/lwCTIiQ=
Organization: Google
Message-ID: <69e911cc-77eb-3083-660b-e74883636b53@google.com>
Date:   Thu, 26 Sep 2019 19:39:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569518306-46567-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/26/19 10:18 AM, Paolo Bonzini wrote:
> Currently, we are overloading SPTE_SPECIAL_MASK to mean both
> "A/D bits unavailable" and MMIO, where the difference between the
> two is determined by mio_mask and mmio_value.
> 
> However, the next patch will need two bits to distinguish
> availability of A/D bits from write protection.  So, while at
> it give MMIO its own bit pattern, and move the two bits from
> bit 62 to bits 52..53 since Intel is allocating EPT page table
> bits from the top.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Junaid Shahid <junaids@google.com>
