Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ACEC31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682992087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfG3LgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:36:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40396 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbfG3LgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:36:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so56358124wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 04:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aNOl1k50pzAnfJwnSRhABd5Qe/PCJp3I0jRZ3rwELUQ=;
        b=QiTMCtJ2dX6jrsL2UbFW2T9n6szShrtOt1qSAAR2KdEfAGoSMuGbm3FelEEUv0JmXz
         s/Jvt4e0XfRBhqOkNQ23ePOlmq51ijsfbTaK+CZidvixJr7yR6qvItMePoajPfwO8cD8
         g5sEKWtuLsBFer0swJOTJSj3N59v8I2wvFiyMOdQ7HPxrsYTWOMvTfRrlTxLrdxXfTj9
         nLBuJblaSWUZ0h6U5wW5a4AxHcE0z1IMkml07NOIXFG0iZaSUzgWkPikXAtKNU6s3brU
         eZbHdj5Zw5Z8N+/Ne/EhVynfigFxuEkunwXOepUDQa9TRQhdLIPHOPEk6Rw56I1IeiYM
         VHiw==
X-Gm-Message-State: APjAAAXZzVc5B//CC0rc618tbJhiyErIGfpZcfH4qEAoOPTT7vSrIy2P
        MtVD49ITeFQov5bkxyY3b/fyIA==
X-Google-Smtp-Source: APXvYqz//H7WkU/sutEFkJcU6PS182g28f6mHHGiq7ODzVo9lb5F/uD9FQKY6gEBAwRpWHWEtNuWpQ==
X-Received: by 2002:a1c:e009:: with SMTP id x9mr103345453wmg.5.1564486576687;
        Tue, 30 Jul 2019 04:36:16 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id 4sm146630460wro.78.2019.07.30.04.36.15
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 04:36:16 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: selftests: Enable ucall and dirty_log_test on
 s390x
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d35baab0-8a31-f686-8302-950e4fb9c07d@redhat.com>
Date:   Tue, 30 Jul 2019 13:36:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730100112.18205-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/19 12:01, Thomas Huth wrote:
> Implement the ucall() interface on s390x to be able to use the
> dirty_log_test KVM selftest on s390x, too.
> 
> Thomas Huth (2):
>   KVM: selftests: Implement ucall() for s390x
>   KVM: selftests: Enable dirty_log_test on s390x
> 
>  tools/testing/selftests/kvm/Makefile          |  1 +
>  tools/testing/selftests/kvm/dirty_log_test.c  | 70 +++++++++++++++++--
>  .../testing/selftests/kvm/include/kvm_util.h  |  2 +-
>  tools/testing/selftests/kvm/lib/ucall.c       | 34 +++++++--
>  .../selftests/kvm/s390x/sync_regs_test.c      |  6 +-
>  5 files changed, 98 insertions(+), 15 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

(apart from the small review comment on patch 2).

Paolo
