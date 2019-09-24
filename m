Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6951EC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6A7207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503654AbfIXAhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 20:37:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503641AbfIXAhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 20:37:21 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1000756
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 00:37:20 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id m6so18411wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 17:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LHmEi+os+D0XekQst/axaZyK+/1jvY+ikX3lz8Z3eVo=;
        b=LAxvuTW7WuoF5thYjsT1ibquA+s2+xv0BLcEbxNZKn5ga/uCt0mwE+s+lChD0PPFp9
         okaE8nq3B1zbWwsoKWSyzz2pjhIEme8U9YKfOstVyKcuEJbBb56FLzCXoWvSLDyPP10/
         kQxEhaYdUpzplD/a+Jv1HKIhjmcWaFluTA+OcNmOH5eQvbVLjAtfltDBHwpeCpe8VQeM
         eqQmSs0+XboMIkjBQr2ZlHSSisM3hRp58jiScqw9d8BZYiwDKaDiF5bJlLxxvKoAdcvl
         uetnAYhSg6Lwk1mAIOtlYJ1d7ojw0EqEcF5V8PQnY1dGqVFmUtIldlVAS5bdKZ8w9mzp
         /KVw==
X-Gm-Message-State: APjAAAWYZojmGCV6iyj9NUjFdgNJfcIj9kpWRhihkupIgAzhqX1pY13N
        qg0794F3zqy00d/jCOQCpHy1BPSpYquDPQ9OdMoxk72vmADmJ48txEKx0M4xvqCIDKiuhXy1Bjr
        OzSGJ5ra3euidmzmhddpnNJ8K
X-Received: by 2002:a7b:c10b:: with SMTP id w11mr199635wmi.108.1569285439339;
        Mon, 23 Sep 2019 17:37:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpYSYti8BI01M0rZ0ppMB3xZdaOJULpHyf5Iueq0t73HDKfp0Fu4g9AC5vJdsyguZ+XhKPNg==
X-Received: by 2002:a7b:c10b:: with SMTP id w11mr199623wmi.108.1569285439098;
        Mon, 23 Sep 2019 17:37:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id e6sm64650wrp.91.2019.09.23.17.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 17:37:18 -0700 (PDT)
Subject: Re: [PATCH 15/17] KVM: retpolines: x86: eliminate retpoline from
 vmx.c exit handlers
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-16-aarcange@redhat.com>
 <87o8zb8ik1.fsf@vitty.brq.redhat.com>
 <7329012d-0b3b-ce86-f58d-3d2d5dc5a790@redhat.com>
 <20190923190514.GB19996@redhat.com> <20190923202349.GL18195@linux.intel.com>
 <20190923210838.GA23063@redhat.com>
 <b58d2305-284f-8652-a0f3-380b26642fe0@redhat.com>
 <20190924003459.GA13147@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4e5e3459-98a3-8263-f328-f2e636d5e046@redhat.com>
Date:   Tue, 24 Sep 2019 02:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924003459.GA13147@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/19 02:35, Sean Christopherson wrote:
>> I agree.  I think the way Andrea did it in his patch may not the nicest
>> but is (a bit surprisingly) the easiest and most maintainable.
> Heh, which patch?  The original patch of special casing the high
> priority exits?

Yes.

Paolo
