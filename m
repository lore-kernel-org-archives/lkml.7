Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF1FC2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B46206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVT0/zuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfLaTPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:15:10 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52391 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfLaTPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:15:09 -0500
Received: by mail-pj1-f66.google.com with SMTP id a6so1472224pjh.2;
        Tue, 31 Dec 2019 11:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TbFdMRwsDwrVRhSr4fXNZgyq0tBrF3Naz329XDmz+JQ=;
        b=fVT0/zuIPIoa3+zheP+Xi4xB9iw8A+Ju2xLq4Amg+9jgoHVb/DtbfAGQRZQnFxjMIz
         zOjIO2eEV2tSIgvOZjfZ3Q16F/TmlIF+5yvcpuI7dt9MmG8IVlTle8D3W94Y1zkaNwjT
         jIrKJLr/6mp3FH+EgWMDws/5PmBlsbtT1UaKZfNO7kQk/ReTUUNNYnHyshA6VvHUEatj
         Yg+aQzwDyEVV0xRN+qrV+yrPC0loOHsBSL/K2OuRPY5iRxpuNkwxlh20PThnKhbFGAh2
         xeYeySGCKdDO1oLVc+dCKtQNDShM37mWx3xiW9GU5sQlCdBGFnJ3po4aGjo/k4lzQbat
         SF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TbFdMRwsDwrVRhSr4fXNZgyq0tBrF3Naz329XDmz+JQ=;
        b=QFueFX6rdggf2mfIINruJz6mqyAaEFcQ+XE/bK4zi84Ffk+EAMc4XGU9aJYYObmDyW
         RzTdmUzf2+5t/8r8bTcKv9Wz3HXq3yG0ROGD1EPpI+BZJzLBopA5Qf0oqfvTUnXlVS2s
         627kIiINAu0lXvoRCFzUtQaohFWeAv8JLUXMnw/LmKGrV/3WnaBFht/mhbNSRUOWJ4Nn
         VmPhh46xekKbxUaNnR+NKyNP+/wYPwFmIcmeq4Di7MhUWJsAf/HJ61iAmORp9nEFxoJ+
         vSkngHZCpJkup3lAZC9Wy9cZK1Xl9Dju+kzM2VlH1uKyjR6csZl3mGM/qT6PoSM9nrEz
         aqJQ==
X-Gm-Message-State: APjAAAXILmxy05LCzeyc9xGfOREwnwGJmOaWsWp+kYFOSJgP8fw5Vauk
        2kxBjfawHAreF4wFTb2L58o=
X-Google-Smtp-Source: APXvYqxJncWlLsvGB12dfYWmOfOGkuRhv6SWAyyjOAEhxEQ5ldop6Il/xKZrK9dDCaRlN0Nx8mBEgg==
X-Received: by 2002:a17:90a:6a81:: with SMTP id u1mr8122549pjj.4.1577819708890;
        Tue, 31 Dec 2019 11:15:08 -0800 (PST)
Received: from ?IPv6:2804:14d:72b1:8920:a2ce:f815:f14d:bfac? ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id m45sm4488158pje.32.2019.12.31.11.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2019 11:15:08 -0800 (PST)
Subject: Re: [PATCH v2 2/8] Documentation: nfsroot.txt: convert to ReST
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <cover.1577681164.git.dwlsalmeida@gmail.com>
 <92be5a49b967ce35a305fc5ccfb3efea3f61a19a.1577681164.git.dwlsalmeida@gmail.com>
 <20191230121807.3a1f5f38@lwn.net>
 <47e2ea6e-a808-5012-6f9a-8800fbd3be00@gmail.com>
 <20191231083213.0786bda1@lwn.net>
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Message-ID: <ef2785ae-5205-9840-e0b1-3ab920b35482@gmail.com>
Date:   Tue, 31 Dec 2019 16:15:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191231083213.0786bda1@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Changing text in an existing paragraph can
> result in line lengths that are inconsistent and ragged, leading to a less
> pleasant appearance
> and the temptation to "refill" the paragraph so that the
> lines are all approximately equal in length.  The problem with yielding
> to that temptation is that it messes up
> the diff output so that you can no longer easily see the actual
> text changes that were made.
>
> Thus, when making such changes, it can be better to not refill the
> paragraphs - as, indeed, you did not.  But if the result becomes too
> difficult to read (as in, it creates lines that are waaaay to long), it
> can be good to create a second patch that makes only the cosmetic changes
> without any associated text changes.  I was suggesting doing that in this
> case.

> Does that help?

Yes, that's better!

Thank you.


