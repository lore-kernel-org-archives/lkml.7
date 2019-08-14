Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41295C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C4A206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlksZd0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfHNKUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:20:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40726 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfHNKUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:20:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id e27so9138554ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LNONNFXrGqvOtXZDbhestEqwQXax/1n3/5TNvc5DICg=;
        b=mlksZd0gBWCNSchq/6oBDjmyQUZ6kOe8L/P2I4bi1TJUahRnht34+T+2RqEKyNMgY7
         YsjszEkrTju9J1/CBMIebMjOtA9fF5RfTRCaEuKmqsWuYw1w2aJaq0EMBO1n844voqrs
         d+Tjt/K5G3Wo/W1f1FozlZZR9M+5fSjWGQKmtQD/OC/9xPWTbVp0Wad0ugJBltv2bFhX
         jf71A7tGUJgiFOvPwXBeX5V8hrOJF/d7/x0wJ6k6Ah0V3mniO3qWFIdsxEwJNzaZwLud
         1CjdbNoEsKg2cZqDCeAzG/xsOLaVD00eiRlVEzhjqLoOLBeu8iCBW4m0ysvnW7/tHsep
         kZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LNONNFXrGqvOtXZDbhestEqwQXax/1n3/5TNvc5DICg=;
        b=kHP68xJl0UxUxaLQ63+epZWu0gcM7POLQ01akbfrbQIqhYk1GRXQB34pNE/iKWlOYw
         Dks6rcSVytRDu5b7N3tc2LT7uSzF7cFsgy1BJWPNxZ2A+KMuhX2KAUOygylbMo+xuSex
         /1Pz22FLdxMhH2X4f4N/qJZyFE/41gbyNZa6tly0T5IjakQKwkloAVrflo+QkkCrl3fK
         iaGPI6MzNRW0GDwJBaus2FlvGlDfnraVZ8CvoKcUHtSdvxqMSfMXdKRBs95Of5i+K0fp
         /Gpt4o8WB6CF/tKQ8q2rLo9VTvLtK3iVqW5j+FbRgxkAHlrJOvkbRpY2FItIieFH9w/t
         i7aA==
X-Gm-Message-State: APjAAAX9tbIVs9hOL3nFxJj/ONTV7tXfrQ1HE5/GSGdvbbBxwxroqgwd
        pk8M4qdw4RzXls97Ssg1z1mV9g==
X-Google-Smtp-Source: APXvYqyPW+JUeUyj8OH23+74Qvhhy6dvjThEquM3C2xwT+kZ++cix1fxH6nw1BxpuKzD+pif73Er/Q==
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr7672871lja.180.1565778000259;
        Wed, 14 Aug 2019 03:20:00 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id j4sm1605560ljg.23.2019.08.14.03.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 03:19:59 -0700 (PDT)
Date:   Wed, 14 Aug 2019 13:19:57 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     "magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
        "bjorn.topel@intel.com" <bjorn.topel@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/3] libbpf: add asm/unistd.h to xsk to get
 __NR_mmap2
Message-ID: <20190814101955.GB4142@khorivan>
Mail-Followup-To: Yonghong Song <yhs@fb.com>,
        "magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
        "bjorn.topel@intel.com" <bjorn.topel@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190813102318.5521-1-ivan.khoronzhuk@linaro.org>
 <20190813102318.5521-2-ivan.khoronzhuk@linaro.org>
 <05e5d15b-5ef9-b4dc-a76c-0d423fb2f15d@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <05e5d15b-5ef9-b4dc-a76c-0d423fb2f15d@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 12:32:41AM +0000, Yonghong Song wrote:

Hi, Yonghong Song

>
>
>On 8/13/19 3:23 AM, Ivan Khoronzhuk wrote:
>> That's needed to get __NR_mmap2 when mmap2 syscall is used.
>
>It seems I did not have this issue on x64 machine e.g., Fedora 29.
>My glibc version is 2.28. gcc 8.2.1.

On 64 there is no the issue.

>
>What is your particular system glibc version?
>So needing kernel asm/unistd.h is because of older glibc on your
>system, or something else? Could you clarify?

It doesn't fix build issues, only runtime one on 32bits.

If no such inclusion -> no __NR_mmap2 definition - just mmap() is used ->
no problems on x64.

Is the inclusion -> no NR_mmap2 or is NR_mmap2 -> no problems on x64


-- 
Regards,
Ivan Khoronzhuk
