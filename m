Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01069C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E03206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbfKEWrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:47:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730370AbfKEWrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:47:51 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1625C85539
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 22:47:51 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id g5so96420wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 14:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wcmDWg9yuhKKv0L3oJXn41fVzC0MNDFjqyIzi0LiKTI=;
        b=rQ5aEpt+uzNezeFNw4x1+4K+X3kgHhUO1bpK1hhyazjop8MYFzkzQ2pta4ZmZbxovB
         cX70+WJ5pScyYqTEmxBkcOdRTQsjBvv0sqBjuANidFBWije663j6MG89IVS2kzKZEPuT
         eHY9GIcTkup6Kg08WMCCqaUvvQk0xHIbw3X0o6XsPSusxyt912uCn7P8H5tTtNV9LvW2
         hOLwCbVtKoBjoahZvgYQDkzqP9zHKo46CmVrllR/5IPDE1pWgqsZFPGtyFU/49sGOBft
         XHLEOSMx+44LdsLp8azWOuOjNGja0tYTNls7/FXzKZgIGWgvbC9krwWqrHbSdEMwuR5w
         syqA==
X-Gm-Message-State: APjAAAXCPZhvmAi2Q2UwTZlOeOXrejRUCl/zpnTi40xSaTMX2b4K7r8X
        u5kYZWTDnbSMewa1q8S9oMEcH2XG8zckVU56JS3h6aVcQqn7vKGairfCXCldThphQkWqDz9Hf4G
        Km3+0zJnkmPxQ+DOOB9MuKA1o
X-Received: by 2002:adf:d18b:: with SMTP id v11mr31907200wrc.308.1572994069737;
        Tue, 05 Nov 2019 14:47:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyCgB3DCEZvdikreQIv1Te0UDqxG/X/MG7Mu4voWCvEas+t6FebQMWQ6I3oq4eEicA/ORE4xA==
X-Received: by 2002:adf:d18b:: with SMTP id v11mr31907185wrc.308.1572994069442;
        Tue, 05 Nov 2019 14:47:49 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id 205sm1175250wmb.3.2019.11.05.14.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:47:48 -0800 (PST)
Subject: Re: [PATCH v4 13/17] kvm: i8254: Deactivate APICv when using
 in-kernel PIT re-injection mode.
To:     "rkagan@virtuozzo.com" <rkagan@virtuozzo.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "graf@amazon.com" <graf@amazon.com>,
        "jschoenh@amazon.de" <jschoenh@amazon.de>,
        "karahmed@amazon.de" <karahmed@amazon.de>,
        "rimasluk@amazon.com" <rimasluk@amazon.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
References: <1572648072-84536-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1572648072-84536-14-git-send-email-suravee.suthikulpanit@amd.com>
 <70fb2b49-2198-bde4-a38b-f37bc8bc9847@redhat.com>
 <20191104231712.GD23545@rkaganb.lan>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ac4313a6-df96-2223-bed3-33c3a8555c98@redhat.com>
Date:   Tue, 5 Nov 2019 23:47:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191104231712.GD23545@rkaganb.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/19 00:17, Roman Kagan wrote:
>> This is not too nice for Intel which does support (through the EOI exit
>> mask) APICv even if PIT reinjection active.
> Hmm, it's tempting to just make svm_load_eoi_exitmap() disable AVIC when
> given a non-empty eoi_exit_bitmap, and enable it back on a clear
> eoi_exit_bitmap.  This may remove the need to add special treatment to
> PIT etc.

That is a very nice idea---we can make that a single disable reason,
like APICV_DEACTIVATE_REASON_EOI, and Intel can simply never use it.

Paolo
