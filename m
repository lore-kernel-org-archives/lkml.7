Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3A6C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF66206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439511AbfIWKW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:22:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406701AbfIWKW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:22:26 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D84F1811DC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:22:25 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id 190so6441005wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 03:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fOXb2zotSIWB4X/sQrsrANj/mMFRoi6WdNsUfB4y3ds=;
        b=Cecj5dX3pmzInOw4I5MwxmIrlb1KoTXCIhxWDzK9Oxx+xFBOvk2tvPFs8jztsEeYsF
         GpPrxPisoM5alD9LuuuxPcAb2Ry+P+c6mXmt4/2RUllWLN0MAPGLqax7hJJZOtsExtyZ
         DhdQJn/fgC2fHPzrgeK+qSZvCPkRh8QM+vNIuVZi/cuSrVN+U2aUDt3O4QbnTMvG6wlU
         K2xqy3G50KH1cZfXDn2Q2Fu1HMqgWAUb63nLqqR+2UFKnTaFXunk+CMVv+HSq417goSW
         ZDV7bDNlVqGhL1mzSsz6O/kuXVoqTFSsFop9bH6KAY/F56HphDjjSnetw7svVACN7lz8
         8iow==
X-Gm-Message-State: APjAAAXsBOmuYhF0+730zaVyQIXRzKlbu/CQK+sJyaNGbZQsxHiczMBj
        yXqd76WA1rNqa8vkwJuEnB/VFqnvqT/g0KjDRVHPzGgl59oNSYdP/eY3JFQjVS9JZ/YETE4Swcu
        wAPKRthxkVAX8DuwU2FIfHGEA
X-Received: by 2002:adf:f44e:: with SMTP id f14mr19897297wrp.290.1569234144366;
        Mon, 23 Sep 2019 03:22:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz6zfWDCrO5uyrF7XiNRNtg5AchHWZTbVkzNHhwvuNee2mlm3NGz1GASMsttwusekXqn0QzPw==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr19897284wrp.290.1569234144093;
        Mon, 23 Sep 2019 03:22:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id o12sm17311097wrm.23.2019.09.23.03.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 03:22:23 -0700 (PDT)
Subject: Re: [PATCH 01/17] x86: spec_ctrl: fix SPEC_CTRL initialization after
 kexec
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-2-aarcange@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c56d8911-5323-ac40-97b3-fa8920725197@redhat.com>
Date:   Mon, 23 Sep 2019 12:22:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920212509.2578-2-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/19 23:24, Andrea Arcangeli wrote:
> We can't assume the SPEC_CTRL msr is zero at boot because it could be
> left enabled by a previous kernel booted with
> spec_store_bypass_disable=on.
> 
> Without this fix a boot with spec_store_bypass_disable=on followed by
> a kexec boot with spec_store_bypass_disable=off would erroneously and
> unexpectedly leave bit 2 set in SPEC_CTRL.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>

Can you send this out separately, so that Thomas et al. can pick it up
as a bug fix?

Thanks,

Paolo
