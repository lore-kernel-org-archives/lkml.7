Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A674C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B262166E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfHCGla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 02:41:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42245 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfHCGla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 02:41:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so29402762wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 23:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bCAARCxw6zb522vIF1/F1TsSvMa3dI/ciDgyTzIdOx4=;
        b=U1L7fsMK2xNC56RfO8Oj0JT9g2kMeOxqO59VaXpRfZ2/lUlT4OkUwl7h/f/NbBafxL
         KebDbYZbtUBYYUZMVuO2BmA23ptJqJK1EHGyzYHqZhUOf6ROK1bCHIDOR+X4b63elgYH
         QXV3rb/Y9KdrqRGhEh9alHE3bzk0wfKzqRsLuPOWqQbs3HFjmIcz/7bXHusn/HKYrtNP
         Fe1HISk8AWyFk81do/bg1iqJFKlpQTeyTEWo0xCqCfqU/h9oWY800h6l1HPT6+j0b+tB
         LSsrFrV6tUpo8ZpzWSSf0ouGWBGF/XQB9gp4oQ5hSHL+Cwe6qBN2vCj0DyAQNx+wy1ec
         eghg==
X-Gm-Message-State: APjAAAWC0wZ8/dC0QcV9THfxw0F+MekFvPCznAayosR+Mv2I2/BHs8e+
        ZhBM/GT4Nkbe67OYU548sp+P8f95o1E=
X-Google-Smtp-Source: APXvYqy7OSGxNl0+EgJQYDBAzWv2iXpLXjLUXVT0UHiSR68dXLvHmgd68cVQXfzTdbdnNdl7ggLLLQ==
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr66202962wro.284.1564814487966;
        Fri, 02 Aug 2019 23:41:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id 17sm64589032wmx.47.2019.08.02.23.41.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 23:41:27 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] KVM: Fix leak vCPU's VMCS value into other pCPU
To:     Wanpeng Li <kernellwp@gmail.com>, Sasha Levin <sashal@kernel.org>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "# v3 . 10+" <stable@vger.kernel.org>
References: <1564630214-28442-1-git-send-email-wanpengli@tencent.com>
 <20190801133133.955E4216C8@mail.kernel.org>
 <CANRm+Cy1wWSwn7HH-dNWeR6FX1TT_M7t_9vvRMdCKFATmvFDkA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c96d6707-87bd-1794-331e-6fa1a2d562f8@redhat.com>
Date:   Sat, 3 Aug 2019 08:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANRm+Cy1wWSwn7HH-dNWeR6FX1TT_M7t_9vvRMdCKFATmvFDkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/19 02:46, Wanpeng Li wrote:
> Thanks for reporting this, after more grep, it seems that just x86 and
> s390 enable async_pf in their Makefile. So I can move 'if
> (!list_empty_careful(&vcpu->async_pf.done))' checking to
> kvm_arch_dy_runnable()

No, wrap it with #ifdef CONFIG_KVM_ASYNC_PF instead.  Thanks!

Paolo
