Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2E6C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179632087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfG3Lf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:35:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53110 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730368AbfG3LfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:35:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so56793325wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 04:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y244Xl4lre8/Rj1RhE87snrTTBEmuS8COkuSeU6uG1M=;
        b=gOyQOX3RpskK2neInLkwZJjaUbw0miNDnlPnuLeFDHPtb3HG7m5JD2NJZlUl4aWmI0
         iCIvqwzQ6vy6zGJfKKska6srBWcOBRZuUtGZmehWa//wUb0dHi/HkW63dsokV0aOeIXI
         lO+njDvPT7STe5MzX4ttNDU/hdATD5amSS+JlBuql4LBrPF1tuaLr9XmhdonyUXM0Mb+
         zNNH+ltnziEUeNWt9NvhnL3T+P6CaouPs9P6q81zQb8ddQJUrxxoDOxbvqQNU1MuFtE9
         TO6kpmdbzLwkFyDQtq2229kSj2SNbpt3WE8kCdLrc+BoSCYh/UMsWVr+iWBbmfIMyTIR
         mwNQ==
X-Gm-Message-State: APjAAAV+pLKb1STRjJuiwb+d1zwWy65tZ8tVBa6SH78bwsF95IcMrLIJ
        5BEBsbN4Y4dP0FKF6EuUfaSSlw==
X-Google-Smtp-Source: APXvYqzkH9Q1Qg/qmKmzEMbzb79yFSlC2/AlPs26tGR5Hv2Po5wEl1eHp6jRHjCYU18erlFW03Sryg==
X-Received: by 2002:a1c:4e14:: with SMTP id g20mr28937377wmh.3.1564486523302;
        Tue, 30 Jul 2019 04:35:23 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id s10sm72854605wmf.8.2019.07.30.04.35.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 04:35:22 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3092bab6-8ab9-c404-a5bb-64ca89eccd12@redhat.com>
Date:   Tue, 30 Jul 2019 13:35:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730100112.18205-3-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/19 12:01, Thomas Huth wrote:
> +#ifdef __s390x__
> +	/*
> +	 * On s390x, all pages of a 1M segment are initially marked as dirty
> +	 * when a page of the segment is written to for the very first time.
> +	 * To compensate this specialty in this test, we need to touch all
> +	 * pages during the first iteration.
> +	 */
> +	for (i = 0; i < guest_num_pages; i++) {
> +		addr = guest_test_virt_mem + i * guest_page_size;
> +		*(uint64_t *)addr = READ_ONCE(iteration);
> +	}
> +#endif

Go ahead and make this unconditional.

Paolo
