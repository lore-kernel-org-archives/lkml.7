Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA8C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455A52070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfJGPFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:05:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbfJGPFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:05:20 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47800CA377
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 15:05:20 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 190so6342285wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2o0eUn9XQmaO3vyP+98zE6rGqN0+sCYt7aS5tzY/kSE=;
        b=Bh4Bbi8GX8MviYme1KjyrI3XvmgRijm7s5lbPNWAhTu3HmzHEgnj2iUiVnnzKQI0DG
         1rzhV7rh0pAAA2Stl6Pp1lUCDRe3qgVlsCzVcrAfjWpWPjq8pgGNpo9Pxu7As02zWGEk
         T3yHZVQyNS7arNjSbL5eoPfH4l8QGSDvT/QkwfKxxOqmWjSDipwy4TC9C8L9HtMNzFdG
         TF6lrRqFm1MpLK+Knv9lEQc1gJwMPDDTIz5eL1VaTpXl11dnCNWXTR2DHIyedessxGSS
         d3ixourOfB+8GfF7bnHhjcq4Fa7aW/zbASCKGZ9/2PVL+ZCECksbnO4k8gfTsG4+8B0j
         av8Q==
X-Gm-Message-State: APjAAAXu+DSSgx3IQgBPtGa9mPFMeb+bTyWlvaZcCC9tPrz7RnU99rIm
        IPhDTSBCmOEq91hn4lToa0HDFGwb7pymuITJNTx+KX3Kiiz+fj5uemwkvz8VcIoZB+TwFhFEztw
        1v0nu9vry/6iRL0+slzGGH+8/
X-Received: by 2002:a05:600c:2219:: with SMTP id z25mr20024674wml.109.1570460718619;
        Mon, 07 Oct 2019 08:05:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyIU66r9y4oav+Rzm1fzptGai1Lcazr1wdhLwhSB/QvFMIl4Mjhy4H/OXPK9OCnD92in26wxw==
X-Received: by 2002:a05:600c:2219:: with SMTP id z25mr20024634wml.109.1570460718321;
        Mon, 07 Oct 2019 08:05:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dd9:ce92:89b5:d1f2? ([2001:b07:6468:f312:9dd9:ce92:89b5:d1f2])
        by smtp.gmail.com with ESMTPSA id r20sm30166993wrg.61.2019.10.07.08.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 08:05:17 -0700 (PDT)
Subject: Re: [PATCH 1/3] perf/core: Provide a kernel-internal interface to
 recalibrate event period
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, peterz@infradead.org,
        Jim Mattson <jmattson@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        ak@linux.intel.com, wei.w.wang@intel.com, kan.liang@intel.com,
        like.xu@intel.com, ehankland@google.com, arbel.moshe@oracle.com,
        linux-kernel@vger.kernel.org
References: <20190930072257.43352-1-like.xu@linux.intel.com>
 <20190930072257.43352-2-like.xu@linux.intel.com>
 <6439df1c-df4a-9820-edb2-0ff41b581d37@redhat.com>
 <e2b00b05-a95a-3d03-7238-267c642a1fa0@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4a2c164f-4a83-436b-c177-0d641d6be529@redhat.com>
Date:   Mon, 7 Oct 2019 17:05:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e2b00b05-a95a-3d03-7238-267c642a1fa0@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/19 15:25, Liang, Kan wrote:
> 
>> On 30/09/19 09:22, Like Xu wrote:
>>> -static int perf_event_period(struct perf_event *event, u64 __user *arg)
>>> +static int _perf_event_period(struct perf_event *event, u64 value)
>>
>> __perf_event_period or perf_event_period_locked would be more consistent
>> with other code in Linux.
>>
> 
> But that will be not consistent with current perf code. For example,
> _perf_event_enable(), _perf_event_disable(), _perf_event_reset() and
> _perf_event_refresh().
> Currently, The function name without '_' prefix is the one exported and
> with lock. The function name with '_' prefix is the main body.
> 
> If we have to use the "_locked" or "__", I think we'd better change the
> name for other functions as well.

Oh, sorry I missed that.

Paolo
