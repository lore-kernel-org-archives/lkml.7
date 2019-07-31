Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8623C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE86208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfGaM5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:57:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41919 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfGaM5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:57:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so66355010wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JZf3ntVvlrIXripUKO5rZBanmNCibf9/L/ozsw4HA8o=;
        b=exNavQIHpfFaXKeEWSbv/N6iIlL75137KC6EHP7ffCenbG0tgpJwo5zmkn+Ol54l2I
         yUiC9TSoX+1dvAXDJ3DcQ3N59jN+U2BkNwfzX+3h7yZVFuSQFcTPFf6rNqajxk/h9T/9
         vQbqEo93+2yzejmuRIhRbuv4C3PRR+zsPmpKSL/ERsYhex6iPi6YO97gv3j7gnkoY+Pm
         mW47eKV/pLOZpjxM8NkqDNws/8AWROHLb5o+OjiGNsw9oR/cgl4vLnNAyBvdfLqxJLR+
         9zQJIXXwEnsZBKxqmixu7jVaGnu3E0ukRSFJ9lWKVbNdt8w1Tzqse3wlZtvsVmYJ/jAz
         zOtA==
X-Gm-Message-State: APjAAAXpLX4gtfIk5AMNaD3keAdGi0b3kgJVJA7Z7/7KdtgVO4XORfSL
        pRRFZFA0T6O9xrzyOSoSqS3tw7VlwOE=
X-Google-Smtp-Source: APXvYqw7bOP3kc6TQ9IqEEedb7bS/T5LWV18de5oQMupwOl7c6btl9JW5t7pYEd70NAd/6Zc55OWqA==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr41721246wrx.72.1564577858774;
        Wed, 31 Jul 2019 05:57:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91e7:65e:d8cd:fdb3? ([2001:b07:6468:f312:91e7:65e:d8cd:fdb3])
        by smtp.gmail.com with ESMTPSA id c1sm155407528wrh.1.2019.07.31.05.57.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 05:57:38 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: selftests: Implement ucall() for s390x
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
 <20190730100112.18205-2-thuth@redhat.com>
 <20190730104807.7uzuvd52foybakgu@kamzik.brq.redhat.com>
 <d9cb3c86-6390-3803-f2c6-d47f5c24139f@redhat.com>
 <20190731102849.x26rdan7cddmpvhe@kamzik.brq.redhat.com>
 <0c38beb7-7383-a7ac-13d4-9d4bde4a21bb@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f7a103fa-51ef-533d-d3a4-7764fb742e44@redhat.com>
Date:   Wed, 31 Jul 2019 14:57:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0c38beb7-7383-a7ac-13d4-9d4bde4a21bb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/19 13:16, Thomas Huth wrote:
> Or maybe even better: Let's move this file into lib/x86_64/ and
> lib/aarch64/ instead, since there is more different code between the
> architectures here than common code.

All good solutions, just choose one. :))

Paolo
