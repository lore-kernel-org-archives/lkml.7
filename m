Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DA3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CECD20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554935136;
	bh=6307oQVh5NDtr0P9WC+zB/rum+BlgvYNn/rP1zl7iNY=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=Rp0hLEt0QNhqYfFqiIWe73DXUdc3K0/XCsfY9IwRAQAPwC/ZWfEvgmkNbnvdp5l9B
	 wzR3gY3T/KccjDJKOT3VHdSbabOoDqRn6x73TySvkYIWOesfhSteZlhsf/V/qH+GwK
	 kHY1yZLL+Imhz4Ye9pjnk+gdPBvxN5eH8PJX6KNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfDJWZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:25:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42262 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJWZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:25:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so4855503qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6307oQVh5NDtr0P9WC+zB/rum+BlgvYNn/rP1zl7iNY=;
        b=uexFelqIx00h8CCEpkX/N2YPTRffoW1xLDwOV6TDApo0KP0iWGS7hWExD/2aAUWFjF
         i0QmioClqEkiaaSvLe3J8fJmSVBXS1R395cFZUXbmAekqCq4IonUAdQcouTr6Q6kAFyE
         GNx21aG65fR4lLZcPQLjqE5fKhFZYFmqcYmgEIPWablNVPEcVMiyryYttuVfFW7F6E6h
         Cw6cNUlzmb4jfjFVcMMZ9BA5lmQ9xfQ45E+zSf6/Ipp3pZp5cdMCM4Jn6f0Ub3ZGXfi5
         1vWhhlG+ERume5+FqrzZ0oy6z7GKDfHiAQD0VTOAB6G9KRveWnNOrGE2SjMrztBrFreO
         dsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6307oQVh5NDtr0P9WC+zB/rum+BlgvYNn/rP1zl7iNY=;
        b=KdaYhvCHKYef+dgz9TsGKQf4uZXUoEI1Pv81gWmWyFS51AbTrz3aM2OaqzcXj/2de4
         kyA0egllDsKCWX/whNU3JPDauVslDpl5ruBsv1Hw8ci8FaQJsdXEhjnB7geCL+C7QX30
         PXg2DWuTywEy79f6q9lPlj5xg7SXX6aszcWoyi43MsulUJKFax/aCoR9GNUtm2NN0X5f
         xACc9cwImH3H3eF8L0e0S5GO9zFFGO98aEqOx6Q9uSMvHy9E5sjMA4IKagXI7lIs94Lr
         bdomhEWUnNWeHUy2nkVfWcyFKeoBfHWR4gy+uLokvCusyGS1m7ts+U/EOeJR7WB6I/tA
         QgJg==
X-Gm-Message-State: APjAAAWrNRYvOyiUsW4r7aFX87BOVSHm3gSGvGwdGciogx1Rm8wRUOC7
        ryKMSZKfTo2DqIZA6v070y0=
X-Google-Smtp-Source: APXvYqwBUD8HamV9gfbNKl2bWDNwuAycftgcMLEKIIDg1lBKdH5pAvOKgPVrzZeCJheDSZFqVafriQ==
X-Received: by 2002:aed:3562:: with SMTP id b31mr38781683qte.154.1554935133788;
        Wed, 10 Apr 2019 15:25:33 -0700 (PDT)
Received: from [10.84.150.60] ([167.220.148.60])
        by smtp.gmail.com with ESMTPSA id c9sm21416077qkb.86.2019.04.10.15.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:25:33 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v1] init: Do not select DEBUG_KERNEL by default
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
References: <20190410212627.29514-1-okaya@kernel.org>
 <CAGXu5j+uBuPjDc+gGcxW_QoJJi7sQZ8m=Zg-Q2wKDxyTt7yGvg@mail.gmail.com>
 <a9508cc3-3385-256e-2f27-c1e0a770ba69@kernel.org>
 <CAGXu5jLPxUESH9eMm6rvaTVue_9rNEdx+9dcxiV11kgi03jUmA@mail.gmail.com>
 <ac8f52a9-30a4-41fd-50f6-65c8ae859675@kernel.org>
 <CAGXu5jLsdSsgVmAU57rpBVAYK6-KxEhzDKj-w5-z2c+dsofD-Q@mail.gmail.com>
Message-ID: <a4896565-9586-981b-06ea-03b0b7c41476@kernel.org>
Date:   Wed, 10 Apr 2019 18:25:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLsdSsgVmAU57rpBVAYK6-KxEhzDKj-w5-z2c+dsofD-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2019 6:21 PM, Kees Cook wrote:
>> I can go after individual enables if you agree assuming Mathieu will
>> go after the changes in the other email. Let me know otherwise.
> How about you split it, but make DEBUG_KERNEL be "default EXPERT" that
> way enabling EXPERT will enable DEBUG_KERNEL still in the default
> case?

Sorry, can you explain what you mean by split?

Do you mean move the things I need out of EXPERT? or something else?
