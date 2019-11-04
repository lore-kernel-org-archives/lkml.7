Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CA4CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE08C204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbfKDVtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:49:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18173 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387417AbfKDVt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:49:29 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60D4E368FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2019 21:49:28 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id b10so6689260wmh.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 13:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W1pvkDm/bRbn3kdRoJ6Q6xczs+3XdUKsiWuExVkhMuM=;
        b=WRV77sePoBKhrHGQ8iUcYNPBw91ajmjWL/0eCPvMnkC6sVvjb2/JIBSPwLjqlMz2nm
         v5Hbbzzo+bMwoHVGebzybEAHs5IEmTU74QRLnjj3GzzvuCq76TCgKnd6PspAC+9aGKGT
         XfLu/hjeaYeSnByTKBekK+haK3f4SX1h722OZsDn4j7kCp0UhKwNw+xb4tS6BKdXowUH
         7rX81JIra4XI0JAokSEMoT/g33Puy92s+y3h9bp+YlOXhJxRN8fLJqoN8KjDVpwYnMNQ
         wvZUZbyTdIN127/yjH7UPp1PaKnB6YZ2yuaSrdOMscotQCaQDLaQb+mTwH+Db2lNTGmo
         VmCw==
X-Gm-Message-State: APjAAAX+ZEFtgrN0lfOxk9kkwQeByJtBnpeN9aACwb1V+ApGkaSGzfj1
        YFVPIHYlveurNZEzpz/1Pg+JOfSbscRPmoSjHc3VRE3jGWBY7yBwSASlakISZhdVq6ae4Zy9V1C
        wbl5AoryTH8aIv4dtwvJMvKr1
X-Received: by 2002:a05:6000:14a:: with SMTP id r10mr24262369wrx.310.1572904166935;
        Mon, 04 Nov 2019 13:49:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqxr5lZKbDC827foBtsWDyIPHBvd/JG3405gPU7PHIv2F6m5M4w1exAgx8KkInvk6L+S8M3/3A==
X-Received: by 2002:a05:6000:14a:: with SMTP id r10mr24262343wrx.310.1572904166588;
        Mon, 04 Nov 2019 13:49:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4051:461:136e:3f74? ([2001:b07:6468:f312:4051:461:136e:3f74])
        by smtp.gmail.com with ESMTPSA id p15sm15682395wmb.10.2019.11.04.13.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 13:49:26 -0800 (PST)
Subject: Re: [PATCH v4 13/17] kvm: i8254: Deactivate APICv when using
 in-kernel PIT re-injection mode.
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
 <1572648072-84536-14-git-send-email-suravee.suthikulpanit@amd.com>
 <70fb2b49-2198-bde4-a38b-f37bc8bc9847@redhat.com>
 <b4e61499-7247-d39e-cd46-c53388ba347a@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4e4bd2c3-50c4-b23e-2924-728a37a5f157@redhat.com>
Date:   Mon, 4 Nov 2019 22:49:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b4e61499-7247-d39e-cd46-c53388ba347a@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/19 19:54, Suthikulpanit, Suravee wrote:
> I see you point.
> 
>> We can work around it by adding a global mask of inhibit reasons that
>> apply to the vendor, and initializing it as soon as possible in vmx.c/svm.c.
>>
>> Then kvm_request_apicv_update can ignore reasons that the vendor doesn't
>> care about.
>
> What about we enhance the pre_update_apivc_exec_ctrl() to also return 
> success/fail. In here, the vendor specific code can decide to update 
> APICv state or not.

That works for me, too.  Something like return false for deactivate and
true for activate.

Paolo
