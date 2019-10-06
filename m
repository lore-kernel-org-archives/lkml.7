Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616A7C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3920620835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfJFQIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 12:08:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfJFQIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 12:08:23 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7CA6A4E83E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2019 16:08:23 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id i14so3888207wro.19
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 09:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JpUUvq7TdpHWK/oJt1Hyc4zywgI4ZqBPJjGMbhOuXvg=;
        b=Jaa3Ip15h1n9HWNzmjYB/cU1TBwq198TFEYDYMlcR3qXXUfjo/w9YbKy5I1DJsKqNO
         YmiS3DNM5EgzAO4iZBjWGalPExKLMDKXWAapmBrluB4KOtyi71/yPNsVwVTAH7yK5rMS
         XtpG/4ewATTOC5VQ+Ep642YN50j9HrT7OGl0h4AUqDDWlGwaquIqAlmexaXYZtfIUfi8
         aY1fanUnqc8QHZphX6HWB5sJhITHpssSNl6fWYq8adnOype6RV4caCiH+vDCMCa4Clz4
         mN6Xmm3evAJyluuQ/BNe0H32CaoCvqdPn7UWEjKzoYIO4Ea3hVDyIA/NLK/LkDUWbKX5
         SSCw==
X-Gm-Message-State: APjAAAU+8QRcbTGekST6HzracWVUD+cCfvQfv86TxbViyftEcCNSjL6u
        QnE9Dv/6rlg2L/UMq5mQL4dnbqNHTIlw/dg1VkozapctcUAzZF3w4Q7wwXLUt3IB+rWj2PMd9uM
        lFXVYYFNc1VRmFqjUmB8eSEm5
X-Received: by 2002:adf:f00d:: with SMTP id j13mr7490019wro.140.1570378102190;
        Sun, 06 Oct 2019 09:08:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwn07XGlWG9aFiuAXSb0CLn7dLoAyisaKRcX6XiJg17I7XfoY2AukCqMHctQ9p6r1wcci9a+w==
X-Received: by 2002:adf:f00d:: with SMTP id j13mr7490001wro.140.1570378101946;
        Sun, 06 Oct 2019 09:08:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e876:e214:dc8e:2846? ([2001:b07:6468:f312:e876:e214:dc8e:2846])
        by smtp.gmail.com with ESMTPSA id g185sm13155693wme.10.2019.10.06.09.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 09:08:21 -0700 (PDT)
Subject: Re: [PATCH 2/3] KVM: x86: always expose VIRT_SSBD to guests
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Jim Mattson <jmattson@google.com>, konrad.wilk@oracle.com
References: <1566376002-17121-1-git-send-email-pbonzini@redhat.com>
 <1566376002-17121-3-git-send-email-pbonzini@redhat.com>
 <20191001221646.GN4084@habkost.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a15e4b77-22ca-e92d-b170-e40b845a5bd1@redhat.com>
Date:   Sun, 6 Oct 2019 18:08:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001221646.GN4084@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/19 00:16, Eduardo Habkost wrote:
> Wasn't the old code at arch/x86/kvm/cpuid.c:__do_cpuid_func()
> supposed to be deleted?
> 
>                /*
>                 * The preference is to use SPEC CTRL MSR instead of the
>                 * VIRT_SPEC MSR.
>                 */
>                if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
>                    !boot_cpu_has(X86_FEATURE_AMD_SSBD))
>                        entry->ebx |= F(VIRT_SSBD);

Yeah, it's harmless but also useless.

Paolo
