Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE38FC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE39A218CA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfGEL6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:58:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36810 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfGEL6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:58:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so9692256wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 04:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sSP7etyox4aCXSbmmXqtAa/Z3YWMIdovt5LD60sC6pk=;
        b=b1GubV26mCucORC+H6e+5Ch2iVMC4wdaSizxeCTlAYziLQI8U3gOyZ0pA9nLYZAxaQ
         Ml3xn7US5BVuBHuk8Tc7Givas3zfC7DddUzBdqwxzM27SSCsnKQ/Q822SzD1nJjcmhXO
         B3OfgoGF3bpT3Wpj4pRiAHN5mMAXcHE3KtRw1rfnj8QnYoFa5ZaG8ZGd5h6uisx9VbwD
         g6VG5E/P+3xJVDDekI2zPinW2aPO9KBMaguoIhkFBhDzWCQbO4gwxElgDO4syCOOuh8P
         NRnJKJ89iOk+mRpLU6jazaIBdEgW4JPFBlTDewMqeQ85AhmU3HDbwaNdkKHHMOe9pSjh
         AlOg==
X-Gm-Message-State: APjAAAXtdyvqmyYLZjoPbM5gvBEDrAqzYRCzMiKt0R5OEEg3OHaFKJsK
        ncdELRcvxqSIJF1ekg8+547CHA==
X-Google-Smtp-Source: APXvYqxyhtfq5EKToa35JCnlw7GpbLScGtHw2moWsKyk282RbMxrzF+Y3/E6uFyVJoI/9J7VWPQvkg==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr4049000wrv.128.1562327921117;
        Fri, 05 Jul 2019 04:58:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e943:5a4e:e068:244a? ([2001:b07:6468:f312:e943:5a4e:e068:244a])
        by smtp.gmail.com with ESMTPSA id 72sm8576148wrk.22.2019.07.05.04.58.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 04:58:40 -0700 (PDT)
Subject: Re: [PATCH 0/2] scsi: add support for request batching
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org, stefanha@redhat.com
References: <20190530112811.3066-1-pbonzini@redhat.com>
 <746ad64a-4047-1597-a0d4-f14f3529cc19@redhat.com>
 <yq1lfxnk8ar.fsf@oracle.com>
 <48c7d581-6ec8-260a-b4ba-217aef516305@redhat.com>
 <80dd68bf-a544-25ec-568f-cee1cf0c8cfd@suse.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c2cf159-9ba2-da39-6e1c-95dea7e111ba@redhat.com>
Date:   Fri, 5 Jul 2019 13:58:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <80dd68bf-a544-25ec-568f-cee1cf0c8cfd@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/19 09:13, Hannes Reinecke wrote:
> On 6/27/19 10:17 AM, Paolo Bonzini wrote:
>> On 27/06/19 05:37, Martin K. Petersen wrote:
>>>> Ping?  Are there any more objections?
>>> It's a core change so we'll need some more reviews. I suggest you
>>> resubmit.
>> Resubmit exactly the same patches?
>> Where is the ->commit_rqs() callback invoked?
> I don't seem to be able to find it...

Stefan answered, and the series now has three reviews!  It may be late
for 5.3 but I hope this can go in soon.

Thanks,

Paolo
