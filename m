Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CE4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296FC2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="n4LbfsiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbfIJKq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:46:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42689 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfIJKqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:46:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so15895866lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uyraNbBmmkbMfViHOc096IVYSM7nk5xLDXtsUxDse+U=;
        b=n4LbfsiRDj8XVLb9CiZdNdzrhARpW7Rl4oaYD1tEqgxa3wpWgXGzvZ+qVVxnyCcZ6m
         9FDwTURZ65xoPFSQJ/lamFPxrqT0KOloQlnNqCsL4yalQZdM4obseh/QZYJ7LgzP7m/C
         h32gyH2XIKMNjClIJr+2NyDMddANiRK7CJZngqeeskrLe2gO5t+2myzPGdoZ+wULdtYH
         QwP6KqDvDx9EBHCt1HitGbHxPBPxB52NyODN0Dm5aipFdUGdA7jVbVISlP/vTJVjTRpK
         w+SQc50UrCDQwejCP+8SRUep7Sk1MzSbWEB4U5p+YMHfcqZmeZwPk4e0RwVOEgOxM5Za
         KP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uyraNbBmmkbMfViHOc096IVYSM7nk5xLDXtsUxDse+U=;
        b=tAcMB54uu6M2Prk4bRC0950YExc1bwmHxSpGWWG+Lx4v9NvD7FLvApBU50JMmhxH7t
         W8zwIANXAnELtTyjZKEbuTF7nYq3adaRCQXGvM+SwYG4xtGsInTocDZmwmptmmlgc+T6
         mXsEqSHhSpstKDAU5aW7OY8pD6bD+HwxRAP9GD9qaC6OE3tgO8Z4s5IxyanrrRA6ShBt
         J/8vuJlB9PuXRKN1OX0X1sm0WlSKn8NPB/oxQOGupcNimO6vYT21tSnFasrBcHXeZjP4
         N7pCz0hDd2y95xqAaE5129hRwH3MnRTJoTF3teuLDE9tuQmfzJaBqT/l7QSRpRaBubZ+
         WhXg==
X-Gm-Message-State: APjAAAUV4VB9kwhiVnPL0+LZvVT0ABwg5W/SGv7o4XHCD+bcUXpYfO1c
        s778HiMJh3CQBL9WiIQ2oeaoeA==
X-Google-Smtp-Source: APXvYqxjJDtoCEdJJkL0Ta4dVC6Djzpe6k7l3h7A8eeWy9gkyrOpk4MQDRVqXSOrO7dq60dtMtLmNg==
X-Received: by 2002:a2e:6c18:: with SMTP id h24mr4979333ljc.227.1568112411723;
        Tue, 10 Sep 2019 03:46:51 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:29f:2049:ec7c:4ff3:ee75:27b0? ([2a00:1fa0:29f:2049:ec7c:4ff3:ee75:27b0])
        by smtp.gmail.com with ESMTPSA id e29sm3664764ljb.105.2019.09.10.03.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 03:46:50 -0700 (PDT)
Subject: Re: [PATCH bpf-next 01/11] samples: bpf: makefile: fix HDR_PROBE
 "echo"
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, ast@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, davem@davemloft.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
 <20190910103830.20794-2-ivan.khoronzhuk@linaro.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <55803f7e-a971-d71a-fcc2-76ae1cf813bf@cogentembedded.com>
Date:   Tue, 10 Sep 2019 13:46:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190910103830.20794-2-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10.09.2019 13:38, Ivan Khoronzhuk wrote:

> echo should be replaced on echo -e to handle \n correctly, but instead,

   s/on/with/?

> replace it on printf as some systems can't handle echo -e.

    Likewise?

> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
[...]

MBR, Sergei

