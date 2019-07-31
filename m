Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6F5C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18228206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfGaM61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:58:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40798 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfGaM60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:58:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so69556042wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5fP2qCBEwihSuFPG1uN/AQ6+YLyq3LrKayldIArWOpA=;
        b=BNtoYH0lgO6tCXLfb9wYlOPKbA4RUKr44110fu+NwrTodlt1lIwxzlBnwPH8GF/eFC
         PUnXfwWVPfV00jKFL1CZ1DPXeG26lF73eTrn3eFLur25F+zo8ifApSwN5IYJ7L4eVDNf
         mkH9qgQbFEfDnbqn35hoVWgXnZ+RpXN+DTWHUp+K7kN0cw11Hthj+8b7TzYd9dtI+O3r
         ZspX5sFHvn2/dDPjryFurydpY9Pe/4s/u0UH4PCWq/z/x6rejZhwPvylHNsrGesGET8B
         zR5bJgH0uLbq04dHppkjWwVelwRmnr66AhmjcQ+zcYkTXoB1z029aACElJgLxe4Uu3ha
         b0tg==
X-Gm-Message-State: APjAAAVZQIQ5S/sE0tJPv4fqplbdIpSJCya8LSZIdrHLXtqmRHHsjRXx
        PAlb6m0Uv5Eag5gLi3aREv4PkY4uNaU=
X-Google-Smtp-Source: APXvYqw1s7YQ7Musw4tNdkwIb4qMQbr7VmKUKXvia/n7SbLvxes86b9xZXW+ODrBjEijk/QTUhcq2w==
X-Received: by 2002:adf:de90:: with SMTP id w16mr37579726wrl.217.1564577905024;
        Wed, 31 Jul 2019 05:58:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91e7:65e:d8cd:fdb3? ([2001:b07:6468:f312:91e7:65e:d8cd:fdb3])
        by smtp.gmail.com with ESMTPSA id g12sm100117916wrv.9.2019.07.31.05.58.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 05:58:24 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
To:     Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
 <20190730105721.z4zsul7uxl2igoue@kamzik.brq.redhat.com>
 <a9824265-daf8-db36-86b8-ad890dc73f14@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <afdf2b18-47fd-aa48-41b7-130122590068@redhat.com>
Date:   Wed, 31 Jul 2019 14:58:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a9824265-daf8-db36-86b8-ad890dc73f14@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/19 10:19, Thomas Huth wrote:
>>> @@ -293,6 +341,10 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
>>>  	 * case where the size is not aligned to 64 pages.
>>>  	 */
>>>  	guest_num_pages = (1ul << (30 - guest_page_shift)) + 16;
>>> +#ifdef __s390x__
>>> +	/* Round up to multiple of 1M (segment size) */
>>> +	guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
>> We could maybe do this for all architectures as well.
> It's really only needed on s390x, so I think we should keep the #ifdef here.

Yes, on non-s390 we should keep covering the case where the size is not
a multiple of BITS_PER_LONG.

Paolo
