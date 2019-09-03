Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5E9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940B423878
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1Q9bi1VI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbfICOGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:06:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38122 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICOGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:06:40 -0400
Received: by mail-io1-f65.google.com with SMTP id p12so36185709iog.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0p3oWLhAQWaGVemN+5EpRiaC7HumZE71N/2ba/fW6JY=;
        b=1Q9bi1VIzUqAMTYaHO9z9TpvDFwOZ+0dH9NVanlMlykig3srm3wskTSPXdjXa6Jrbv
         1HA9BfwMkf/TPF5ev2nhry6re0D+KIJQzTm5/b/mIcWDg0+kDFx3xVuf1mbs0cEldcw0
         bJxlBU0u0D0soKewZHyXOY5hYpTi15LMaAa3ctQ8YWhToZhcZ3rXitF6ziQCUZA47GaT
         x/vdPsZUW30aYziNM+ESkpRcvfYkBt9uAjhT8ChgpTCNP0okGG0g5jVB54W4cytIaFAT
         t9cjEpdy0S6rd1jiLNmOzj6kqyfKx3lJfYKaNgr+XxD3Heed5+Y72l169Gnpcr3/oqxX
         M+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0p3oWLhAQWaGVemN+5EpRiaC7HumZE71N/2ba/fW6JY=;
        b=GjUL5/pfHpH9EQt7Trx3zSOID0U8L9YF01OcTO37LRasII7BwdOmWw8vt/yGj7fr7a
         kGfPvXktwcc8yZmzoh9BzV0hoeJMiheLy1vso/Td4qwHVMABPn4DHgm/bFvauw35uwnc
         d78cWAvQvgYUJoS6mtjxdienwSyigl4xlvHSw32Uhng7Vyjtc5RvvC34J0c3+RPQKdgc
         pHwVGoOj6jpByvJ7+O0mOv6SAP+Rot+8ge5DB1iI9B+Mj4AAhrm/NHU5qjnk6g/wGtMY
         HIX5i653/CoKVDbtZ3qtb3TJvpAgBr6cw3ssg6Ad/OdB19M830mgCTyQfd0Iygub5fWW
         8mcQ==
X-Gm-Message-State: APjAAAVrfg3E0/dcvswRmt0wEmDZpdSiTbCit8V3VbiB9UQKZk7R8zXU
        NWMLbA8l5tGOF+znplB0CH+3Nw==
X-Google-Smtp-Source: APXvYqx03uOP/C8Dqwl5Q+wDp0JvHsGemvVGA6YOvYAgWggFpmv/rcZ3Ucmu6Ek5/kCC5fF+sj+pcg==
X-Received: by 2002:a05:6602:2508:: with SMTP id i8mr29737153ioe.91.1567519600140;
        Tue, 03 Sep 2019 07:06:40 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k21sm15220719iob.49.2019.09.03.07.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 07:06:39 -0700 (PDT)
Subject: Re: [RESEND PATCH 0/4] Remove elevator kernel parameter
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20190828011930.29791-1-marcos.souza.org@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <80b367d6-393e-330a-c5df-f48e73bae86b@kernel.dk>
Date:   Tue, 3 Sep 2019 08:06:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828011930.29791-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 7:19 PM, Marcos Paulo de Souza wrote:
> This is just a resend, now with reviews by Hannes and Bob in place. These
> patches were based in linux-block/for-next branch.
> 
> Original cover letter:
> After the first patch sent[1], together with some background from Jens[2], this
> patchset aims to remove completely elevator kernel parameter, since it is not
> being used since blk-mq was set by default.
> 
> Along with elevator code, some documentation was also updated to remove elevator
> references.

Applied, but:

1) Folded patch 1+2
2) Patch 3+4 .txt files are dead

-- 
Jens Axboe

