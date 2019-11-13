Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F9CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966CB2068F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMqN99Jg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfKMSdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:33:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57178 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727361AbfKMSdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573670020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=YViUuCyqAWYmlgZIZCpAbQbISPMVKXMOPDNBVlmFZCk=;
        b=IMqN99JgqsIna7J06FmTREhEYvGtxDrL3OCJ6YQKpLro9NtDWRk2+QJOlYOlXnpED8KAmQ
        WaklC69t+x3lOdk+twrZ8/vqImbKple/eBBx1DtonYY+PHKLH5Y5tMNlijmeWMu8dbqMtD
        ucCIVU5QwJq4xX5Pi0EeSUzyCjOPB9Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-zW1qzqhiPP2tfgHTROSkVg-1; Wed, 13 Nov 2019 13:33:39 -0500
Received: by mail-wr1-f70.google.com with SMTP id w9so2162917wrn.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 10:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lVOhJPf9GSOQQjGFFHeta0KGsKrjystXekCjo1ib0Wk=;
        b=lC98Rs6V+GDD0IwnGqAWlpLKLKWnJnnLWP1iBsVOaBvawF01OgMLqCLurGX7Tca+gs
         Fqh593X5zk9FCmToD+Uzatn4zXC8X88F51RCkYlMP3X3e4tIR52cXiJl8DlUShI7wtJX
         9kNNxBNLIkFfZC+yJSLO71+ZEAVhscFdKTOJMbfGVhrr5DQ1HvExamrwmhIFLEUWIETu
         kpB7ho6rmQB2xP6LlBzUvLG1EGsBSailOtxmwTKQgZBJ+gQLN9lEqtszPYj0dO1N+fx5
         76ouKs9pDYPcKTwLvFoa5NdM9PKDuNRrv8xvkWKVsUtw1XbNGvtmDcLiEf6JtvzVJ2Sd
         hKYA==
X-Gm-Message-State: APjAAAXkWqqxF8Gmy4/My9HK3YYct6NZmXzDnlzBD6c6kigATTF6ZCI0
        uUcABkXHjwY3K6t47KcCAI+56Ww7T6MQlGbwLeogqYAFW+DWaqwS/N6hhJlBgl6ljq91Frn9wcN
        GsORrtLM/IY5hvPgF7i8PDMeD
X-Received: by 2002:a1c:80c7:: with SMTP id b190mr4204119wmd.3.1573670018332;
        Wed, 13 Nov 2019 10:33:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyR1i+Ci0i2jOPtXGGJwsiqFYOI8TIbUFgzvoVt4nRS/4fN52m1rHKQTdCnvLVUlotn56DbGA==
X-Received: by 2002:a1c:80c7:: with SMTP id b190mr4204095wmd.3.1573670018016;
        Wed, 13 Nov 2019 10:33:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8c9d:1a6f:4730:367c? ([2001:b07:6468:f312:8c9d:1a6f:4730:367c])
        by smtp.gmail.com with ESMTPSA id 200sm3781427wme.32.2019.11.13.10.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 10:33:37 -0800 (PST)
Subject: Re: [FYI PATCH 0/7] Mitigation for CVE-2018-12207
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1573593697-25061-1-git-send-email-pbonzini@redhat.com>
 <DEF550EE-F476-48FB-A226-66D34503CF70@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fa4a67e8-50db-a42a-3186-072327ea538a@redhat.com>
Date:   Wed, 13 Nov 2019 19:33:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <DEF550EE-F476-48FB-A226-66D34503CF70@gmail.com>
Content-Language: en-US
X-MC-Unique: zW1qzqhiPP2tfgHTROSkVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/19 19:10, Nadav Amit wrote:
>=20
>> On Nov 12, 2019, at 1:21 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> CVE-2018-12207 is a microarchitectural implementation issue
>> that could allow an unprivileged local attacker to cause system wide
>> denial-of-service condition.
>>
>> Privileged software may change the page size (ex. 4KB, 2MB, 1GB) in the
>> paging structures, without following such paging structure changes with
>> invalidation of the TLB entries corresponding to the changed pages. In
>> this case, the attacker could invoke instruction fetch, which will resul=
t
>> in the processor hitting multiple TLB entries, reporting a machine check
>> error exception, and ultimately hanging the system.
>>
>> The attached patches mitigate the vulnerability by making huge pages
>> non-executable. The processor will not be able to execute an instruction
>> residing in a large page (ie. 2MB, 1GB, etc.) without causing a trap int=
o
>> the host kernel/hypervisor; KVM will then break the large page into 4KB
>> pages and gives executable permission to 4KB pages.
>=20
> It sounds that this mitigation will trigger the =E2=80=9Cpage fracturing=
=E2=80=9D problem
> I once encountered [1], causing frequent full TLB flushes when invlpg
> runs. I wonder if VMs would benefit in performance from changing
> /sys/kernel/debug/x86/tlb_single_page_flush_ceiling to zero.
>=20
> On a different note - I am not sure I fully understand the exact scenario=
.
> Any chance of getting a kvm-unit-test for this case?

No, for now I only have a test that causes lots of 2 MiB pages to be
shattered to 4 KiB.  But I wanted to get and post a test case in the
next week.

Paolo

> [1] https://patchwork.kernel.org/patch/9099311/
>=20

