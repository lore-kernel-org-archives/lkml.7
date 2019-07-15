Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE54C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4823820665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfGOL4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:56:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39642 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbfGOL4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:56:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so4533828wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 04:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XFWpBNJB1XF7x1pi/vljYSJV0914VRIWwI4XKNBeu5o=;
        b=CG5jMCx41imiLHEpx4qYghJ+NedQZ21iyTLDI44IxlEXZqN7B4sjcCu43m8Kof5nEI
         WjAAwCorpptbkWlA5ahw4853TU1yHAIiWNIH3nnSOePSaficIj5d9ukUWKwq5mvnAd9f
         iX5K1tvoMznPR7x3G5ATQrbsKza+Cu6Xc/1SSZ0TKKwITXbaxKaxtpggo7MnGcseLiGp
         +fBbAjtRnB7yYoMAkFfodGaQGQBlPmcTOsJrDNbWK0LrIzkW/biIyoLfG8aro5kXPWQD
         Gr0K2ngIf//dBJULFYnn8AlQrfD+Qi30cEv4gTJ3YaIU4G+bEc2TrRZH5pz73ouo8vV4
         Ew7w==
X-Gm-Message-State: APjAAAXwqBvEpWjCdkaWp5BsiGFw59D3qtdK+V7S0rWHUwoTjYxi7I9f
        QyckR18UIVSWf/smPGXg8z2/hzsKBdc=
X-Google-Smtp-Source: APXvYqy1D5C+lU/rPQaQ0mt2Nc7LxZgHKSMsYB6lbGaMy/HCVyC7JOBHpiFmnFLHJFsnSURXW5Q/bQ==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr24900964wmf.111.1563191774132;
        Mon, 15 Jul 2019 04:56:14 -0700 (PDT)
Received: from [192.168.178.40] ([151.20.129.151])
        by smtp.gmail.com with ESMTPSA id f2sm13153714wrq.48.2019.07.15.04.56.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 04:56:13 -0700 (PDT)
Subject: Re: [PATCH v1] KVM: x86: expose AVX512_BF16 feature to guest
To:     Jing Liu <jing2.liu@linux.intel.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <1562824197-13658-1-git-send-email-jing2.liu@linux.intel.com>
 <305e2a40-93a3-23ed-71a2-d3f2541e837a@redhat.com>
 <CANRm+CzOp6orH+7sqCQjLuxsYRccfq7H-o4QBcgxGfT-=RaJ-w@mail.gmail.com>
 <332e8951-e6bb-8394-490d-26c8154712b9@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <68d07943-c957-7caa-f77c-944cd0d726bf@redhat.com>
Date:   Mon, 15 Jul 2019 13:56:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <332e8951-e6bb-8394-490d-26c8154712b9@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/19 13:05, Jing Liu wrote:
>>
>>
> Thanks for the information.
> 
> This warning would be fixed by changing to
> entry->eax = min(entry->eax, (u32)1);
> 
> @Paolo, sorry for trouble. Would you mind if I re-send?

No need, I can fix it myself (I'd also use 1u instead of the cast).

Paolo
