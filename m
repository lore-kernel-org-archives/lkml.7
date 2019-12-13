Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35744C7E0A3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A9A247F8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DZbJg3jD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfLMSlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:41:42 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:46073 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfLMSlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:41:42 -0500
Received: by mail-io1-f51.google.com with SMTP id i11so599083ioi.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 10:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yd5A7ma8jHxTuZcHgFtZXqeJ8DP4wuiJ8ADgctoYPMo=;
        b=DZbJg3jD5pZD5t9zzFulKMq9+S4JOXB/LXmwhAg9206kVbdLF0zj3Pjt0IaYq33O44
         +NdEUMIt9QoxibkSFMqOJm6WblvgS472iXraOc++wfR1Kdpil3pdqzGw0adOjCxLh5Am
         ULOffSdRi7cXx1Rmv93ZCkuet2h4RuHEoLFowVdpYsFq6Wch7UWfiPDufaZfH0cRlUGL
         JnrBW7nscCYkFhApA9V6vn2kzuJpvHSRRkw6aGtsKIl0NkXKzUbMlhveZkbk9u1UQrRr
         koFnpRX7++9MvKnYld2reE8TJ0PrQowGkGlqZMj0fQ2gDuY5dbD7vDGBuKiHdT7Veer2
         sVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yd5A7ma8jHxTuZcHgFtZXqeJ8DP4wuiJ8ADgctoYPMo=;
        b=cB770viTkmlMzFSv+ax5QfQqPxpPYw3SH/nslQiBlwCMUoe2EfPyhIp8xyjRohtB6R
         aH79tLc9ylLiXedaL4Uo9ggBgUVciwS7QkxYQKeEJoqgz8bQsKfiU9IgqWLfpjbkiXBC
         CHkA7Ns52YNL3UR+RThepBBXGT/iLGcCgwDtNbzAno0p09CSJSS34xWWHFI51IqrZAL+
         v54frOS5na2H4FT50xlJsGjoQoQEh67apl3IcmeYualu1p52ZUm8hCjaFSwoiIFjNVc7
         S1il9x2Jz6rO7NjBiCqMFe5SZBz+Ijr7BX4TBxkaHyqIdeYC6TVKQFNQ8pAK1dEjy/P5
         XIVA==
X-Gm-Message-State: APjAAAXq0E6UT7+oOIwUHcjWSt4EtKocmmTpWcbW0BJTYkyaDJpAn52k
        VKByYjgOWgQ5tqQgq+2L3cAbwas4oS+rhQ==
X-Google-Smtp-Source: APXvYqwiDB+1bQ5bT1MfUZBSdIHg3ryJ47xkyuSPzD6u2tP0P/3N99wdYtImNvMSFdyJrpYa4VavIQ==
X-Received: by 2002:a02:cc75:: with SMTP id j21mr743891jaq.113.1576262500894;
        Fri, 13 Dec 2019 10:41:40 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k6sm2234070iom.52.2019.12.13.10.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 10:41:40 -0800 (PST)
Subject: Re: [PATCH v2 liburing] Test wait after under-consuming
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <e5579bbac4fcb4f0e9b6ba4fbf3a56bd9a925c6c.1576224356.git.asml.silence@gmail.com>
 <512741aa9160cc9648780a21a4bf4aa10a47193f.1576256964.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3b6a6e8f-ca6b-ea3d-5530-bfe2eab99400@kernel.dk>
Date:   Fri, 13 Dec 2019 11:41:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <512741aa9160cc9648780a21a4bf4aa10a47193f.1576256964.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 10:11 AM, Pavel Begunkov wrote:
> In case of an error submission won't consume all sqes. This tests that
> it will get back to the userspace even if (to_submit == to_wait)

Applied, thanks.

-- 
Jens Axboe

