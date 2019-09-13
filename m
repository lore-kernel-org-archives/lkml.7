Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDE5C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A7D2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnMuApb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389811AbfIMVZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:25:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34671 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389617AbfIMVZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:25:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id h2so21921017ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SqwwqelpURFmzfGjcJ7oMuOIQ2kIqB4BOKfM3/6ZLAw=;
        b=WnMuApb47J6Z0Rih0VYsR4YDdRoc78S/yxGZJAvId+d8Yg1MDSWITJwp7ZHrb+BWJV
         HQb6CVECMx0VXHfotKY+2mVS5HDo5ua/8sNi6JTgrD7fxuehRYGKwiVO568kKzNs5ewW
         93a2BV+VKPvyw3og+4qjBC5AD/FEOB8lANOlb6ZKcnvp3ia5ouQIgDbBPdoJQ8Fd8BVd
         TrqxaefOXxrS+sFrw315ejQi9GmrxDFxb54ELx0uI1Xgv9fxrG66XXAw0WTecgnPnvr4
         yaxlvgFYy6yZHXPtXCVPkBkjSNUc06neLsA73Jr6/8rYwo63cGGSYwRIZWRfeANuO3uE
         rGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=SqwwqelpURFmzfGjcJ7oMuOIQ2kIqB4BOKfM3/6ZLAw=;
        b=sr+yD3guOxEqqfrqYZRiAtsNcU4fMowqSWjjdkaQKxJCtRtG+aoZWgxHZhmNcz80SV
         u2X5vyUhgxl3CXsuk1hn5e1g60MiOdAtY7bDGrsLVQXbi3I0px3QSGvNzBg+4A8NlQS2
         aHVRlbGR94CAbvYOAYe1omqIjWAStLqQABmvDAftjE20qv1Zu0Y8KyL6wEoPZmsL0AW8
         ZZkBah2D1rPTVa5TguPI7mX1w7I3xRuLBaa3xwhD2HyUNzhuIYSXPobLuZHZcb/GHkyy
         3b1BTy8fWzflq1JMO60fEyPM0Umqx7RbXA3YcrV4R8hNQgnI38PUJi7HSIlhgzjkNQa5
         xKCw==
X-Gm-Message-State: APjAAAVoqJe2zBeUMb297sb4VFhdObDRTTCvY4wiEUAbZ1aLxm1eUk7x
        vetW0V5301NANRtpODbYpGDuqg==
X-Google-Smtp-Source: APXvYqzGOytq6JjzyFTSvv67HdgbwowjWgQmmIFRHLTWAVYagXaSOG/LQY+ywezFZ1zJzyx+H/qbbA==
X-Received: by 2002:a2e:99c1:: with SMTP id l1mr25527331ljj.8.1568409948002;
        Fri, 13 Sep 2019 14:25:48 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id y3sm7053303lfh.97.2019.09.13.14.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Sep 2019 14:25:47 -0700 (PDT)
Date:   Sat, 14 Sep 2019 00:25:45 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH bpf-next 02/11] samples: bpf: makefile: fix
 cookie_uid_helper_example obj build
Message-ID: <20190913212544.GC26724@khorivan>
Mail-Followup-To: Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" <clang-built-linux@googlegroups.com>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
 <20190910103830.20794-3-ivan.khoronzhuk@linaro.org>
 <7f556c1c-abee-41a9-af83-1d72fc33af4b@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7f556c1c-abee-41a9-af83-1d72fc33af4b@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 08:48:37PM +0000, Yonghong Song wrote:
>
>
>On 9/10/19 11:38 AM, Ivan Khoronzhuk wrote:
>> Don't list userspace "cookie_uid_helper_example" object in list for
>> bpf objects.
>>
>> per_socket_stats_example-opjs is used to list additional dependencies
>
>s/opjs/objs
>
>> for user space binary from hostprogs-y list. Kbuild system creates
>> rules for objects listed this way anyway and no need to worry about
>> this. Despite on it, the samples bpf uses logic that hostporgs-y are
>> build for userspace with includes needed for this, but "always"
>> target, if it's not in hostprog-y list, uses CLANG-bpf rule and is
>> intended to create bpf obj but not arch obj and uses only kernel
>> includes for that. So correct it, as it breaks cross-compiling at
>> least.
>
>The above description is a little tricky to understand.
>Maybe something like:
>    'always' target is for bpf programs.
>    'cookie_uid_helper_example.o' is a user space ELF file, and
>    covered by rule `per_socket_stats_example`.
>    Let us remove `always += cookie_uid_helper_example.o`,
>    which avoids breaking cross compilation due to
>    mismatched includes.

Yes, looks better, thanks.

-- 
Regards,
Ivan Khoronzhuk
