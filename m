Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B23CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 09:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88D420679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 09:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfKBJvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 05:51:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfKBJvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 05:51:31 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A302D85A07
        for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2019 09:51:30 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id t2so7007352wri.18
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 02:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l8qAdWRObZ9diNurmyFj32RwamTbc6O7HnqjMAubn+g=;
        b=F/4kmTglVBiuG5IX8kiCRKCTSlknKlq+DHJS3l7yRRHw42DE3CnnpfAO+/CcY4m+Az
         1NaVtqBxGjpY76B6EGmAXyM2zuC+oyuRBpQInlN8M7tED930bPQ5YWBBL3pTXAcWVgF1
         Zi+FcQKByXUdaZYG4Ma/LcXq3ZorDWR5VIeKKGAAlWJJ9C5fk9CPR1iAi7ztdXjq7vAX
         m2Z7LSxVlvswkERBoR4OvljvnvbVcA5DRLQNjEkT7A9m+9167b9XQZcsXE3ZhoYDZEqt
         bmOOlRsE5jDwCst9zk0ubEaPJZ1Slazr0GlQbyqrbSlCuhZHHydkJy/RkY0IL+H3Qt11
         NfCQ==
X-Gm-Message-State: APjAAAUPPHXuQZWf6sxJ1NM1tRbBQadgJGmb+f59MAJXS8bSD6VlTT48
        OC7HKCdR69EDMtYLx91dpp+ptmsvRYltbEVI7GewNGZ+kuZ8Tbesey/Z0nxHhRyQ/euzLxJqSAR
        vsxYOa11+vtxdPPTOKlpgeSpo
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr14694472wrw.167.1572688289338;
        Sat, 02 Nov 2019 02:51:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw2zf793oOTw8eZP9mFlJz05v9GK0WJFS03MxDK0c2oafYGNsvzIm/OUePbHZdoEfHUhIp0ag==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr14694452wrw.167.1572688289015;
        Sat, 02 Nov 2019 02:51:29 -0700 (PDT)
Received: from [192.168.42.35] (mob-31-159-163-247.net.vodafone.it. [31.159.163.247])
        by smtp.gmail.com with ESMTPSA id d20sm14673270wra.4.2019.11.02.02.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 02:51:28 -0700 (PDT)
Subject: Re: [PATCH v4 03/17] kvm: x86: Introduce APICv deactivate bits
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rkagan@virtuozzo.com" <rkagan@virtuozzo.com>,
        "graf@amazon.com" <graf@amazon.com>,
        "jschoenh@amazon.de" <jschoenh@amazon.de>,
        "karahmed@amazon.de" <karahmed@amazon.de>,
        "rimasluk@amazon.com" <rimasluk@amazon.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
References: <1572648072-84536-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1572648072-84536-4-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d947359d-0eb8-1e6f-ef53-54bcec0410c7@redhat.com>
Date:   Sat, 2 Nov 2019 10:51:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1572648072-84536-4-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/19 23:41, Suthikulpanit, Suravee wrote:
> +	unsigned long apicv_deact_msk;

No abbrev fld names. :)  I can change this to something like
apicv_inhibit_reasons if there are no other issues (and likewise
s/APICV_DEACT_BIT_/APICV_INHIBIT_REASON_/).

> 
> +bool kvm_apicv_activated(struct kvm *kvm)
> +{
> +	return (READ_ONCE(kvm->arch.apicv_deact_msk) == 0);
> +}

Using READ_ONCE introduces a risk of races.  I'll check during a more
thorough review if it's worth introducing separate kvm_apicv_active and
kvm_apicv_active_nolock functions.

Paolo
