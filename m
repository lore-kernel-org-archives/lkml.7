Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F55ECE587
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 01:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C02E21924
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 01:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="oEyO3Jbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfJBBXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 21:23:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36899 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbfJBBXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 21:23:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so9411939pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 18:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=/C36wUinGnzT8rrY5Cyg+JNcSuMeir+tSfeOcjZGD7Q=;
        b=oEyO3JbnfIMqMzafNHHg54f0APQRylbM/MziaBN0Tl76MDxdcN7kvP8rZLEY65LWJl
         ZkmB53wVKnOWptMEs6NKncv6Mw0uEZ+RIEdpQM3f2YmIaKQ0uNmZa/rTyDi21nxUSxoD
         7hyZZf1UnkOhzSIWf32UyhfgNdWxnxJoi2HXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/C36wUinGnzT8rrY5Cyg+JNcSuMeir+tSfeOcjZGD7Q=;
        b=oZTxjmSzuprPiyBelfMBNT9oBXPb/T4B1WclBpSYPibqwGOMvVXNJS87aQtUExXLWE
         578InpGdH+C/UDzTiPUeOf5Bien3BnAQFUYMAdegwjwaMdA+Il/DXpJSLeuTTN8VHTf9
         qFtNuZ53ZS4FX5bYefmSu4IRS5L0O1AgW5kuJbAquoIPBDwoHllCXvmaCttxexiaG819
         TEzUpSgWfGp6Pgg9iD8yfYFozwX4paBIJ2S1t2AqRSBdgcpjZC98K8j7/Nahvvr208Kg
         XZttR445zyt0v7IUXz1VtzWJOTYx96GS/4I4bLkrdNaAoeZ24xH1Kv43QpR8FvMr8Tck
         1rzg==
X-Gm-Message-State: APjAAAUQI+C8ZFpO6I8BP7ykLgIww+H5pfaceLf1VThaaSEEXJwAHMRk
        szOGIjV4dUiWzaD5UppyZsm36g==
X-Google-Smtp-Source: APXvYqzGuf68jpYONt9jUaE/QZfzyFEfhgDb7lWE4iWG3aqIQx4VlrFOIeTrDSkYMG7TTPlhj3siAQ==
X-Received: by 2002:a62:82c8:: with SMTP id w191mr1456666pfd.99.1569979390621;
        Tue, 01 Oct 2019 18:23:10 -0700 (PDT)
Received: from localhost ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id ev20sm3561837pjb.19.2019.10.01.18.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 18:23:09 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real shadow memory
In-Reply-To: <20191001101707.GA21929@pc636>
References: <20191001065834.8880-1-dja@axtens.net> <20191001065834.8880-2-dja@axtens.net> <20191001101707.GA21929@pc636>
Date:   Wed, 02 Oct 2019 11:23:06 +1000
Message-ID: <87zhik2b5x.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>  	/*
>>  	 * Find a place in the tree where VA potentially will be
>>  	 * inserted, unless it is merged with its sibling/siblings.
>> @@ -741,6 +752,10 @@ merge_or_add_vmap_area(struct vmap_area *va,
>>  		if (sibling->va_end == va->va_start) {
>>  			sibling->va_end = va->va_end;
>>  
>> +			kasan_release_vmalloc(orig_start, orig_end,
>> +					      sibling->va_start,
>> +					      sibling->va_end);
>> +
> The same.

The call to kasan_release_vmalloc() is a static inline no-op if
CONFIG_KASAN_VMALLOC is not defined, which I thought was the preferred
way to do things rather than sprinkling the code with ifdefs?

The complier should be smart enough to eliminate all the
orig_state/orig_end stuff at compile time because it can see that it's
not used, so there's no cost in the binary.

Regards,
Daniel
