Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1F6C282E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF2921874
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404162AbfEXUp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 16:45:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38471 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389927AbfEXUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:45:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id t5so10411138wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 13:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mx7/UI9Jm1N8o+CZmUOfiHnK1kOQ3K16dEGlWbDQvu4=;
        b=rG0MGquD3LtiovQGgrbGgPaZLOMsfEOFJ50WVqVCYdcli8sL2n5vVIbBt8zzLK/tB5
         l1kw5nyjeMr2R1woVrdtB/UQ+g/sRS4UCHHrJmEuO2N2xZ7OifqEXxMbHeIATDU+6iT/
         HZeLlU/tVDEK9zKt8egT78b10EsaCl1AOrGzxXRlmUaJItERMsh9dzJjScekgtH0lPqJ
         0ksPWUe54uWLVSRNpqT6No+hZ/oLDgUVgKocbl1qkKNjqFcG2K+IZf6MpF67z1ZTrFmA
         zA80S8hDELbjX/MSGneIyi1adSRYCgWJvXEkq56M1XB7WSyFqEikD1fhxCmbqxUZUy9U
         eCuA==
X-Gm-Message-State: APjAAAUBkByg0ZqrZsHEj4r8FJZNqluhMFuYPB51yV1f2EUP+A3fXEEc
        zgZyfxwGFyChPwB/cF3dKeGAwBpdkTI=
X-Google-Smtp-Source: APXvYqxJ83uZdMSEPSw6n2yqxH4DHAUSilro/nLhvRdru9Hu/zOSo5muHXY3j4Boz/pBy1d6U3DQdg==
X-Received: by 2002:a1c:ef05:: with SMTP id n5mr1213237wmh.149.1558730756405;
        Fri, 24 May 2019 13:45:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4d53:18d:3ffd:370? ([2001:b07:6468:f312:4d53:18d:3ffd:370])
        by smtp.gmail.com with ESMTPSA id p11sm2914061wrs.5.2019.05.24.13.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 13:45:55 -0700 (PDT)
Subject: Re: [PATCH] kvm: fix compilation on s390
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1558725957-22998-1-git-send-email-pbonzini@redhat.com>
 <20190524202438.GE30439@unicorn.suse.cz>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <328789af-23b2-d5d6-2353-2e36e39c7452@redhat.com>
Date:   Fri, 24 May 2019 22:45:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524202438.GE30439@unicorn.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/19 22:24, Michal Kubecek wrote:
> On Fri, May 24, 2019 at 09:25:57PM +0200, Paolo Bonzini wrote:
>> s390 does not have memremap, even though in this particular case it
>> would be useful.
> 
> This is not completely true: memremap() is built when HAS_IOMEM is
> defined which on s390 depends on CONFIG_PCI. So for "normal" configs
> HAS_IOMEM would be enabled and memremap() would be available. We only
> encountered the build error with a special minimal config for zfcpdump.

I see; I'll change it to "does not always have".

Paolo
