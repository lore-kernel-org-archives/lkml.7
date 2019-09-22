Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD88C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 15:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D626208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 15:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QnVzUVvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbfIVPvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 11:51:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39673 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387494AbfIVPvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 11:51:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id v4so2840765pff.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cSJSMSobZih7iY3IhyRNQHQ9trYuF7BXMloT2eMFo9M=;
        b=QnVzUVvSs4BIFdsaW7E5fTuQQQprJgQTi9gtK1XEcjuRjNI/q/A9rVZ0G5aq1lFHlk
         CNsAWEFFLMuoXYKjrm1hJbfg/uwPplVRk03DqrAgaF7c31VDVbWXx9S5edh1qzxkXePy
         lzVsnBkCcE6dwe+Jld0ISy1dUEDSDGpUCkAXyxUQk9C1uxjnA5PUzETW2vU/zMHsvVCY
         GmWxDO3dbohqYhGdhQzSfUlzTcBkD7oBbSv8f1euSkyEyxbagwO/UQ/r2mIHMNR2aDkw
         qIa+Kc5LKpwlDCS5YDxXDpE9aV2iheJHk1yeBms5DWygFHMW/BrpEYa3hsAKMY0hTe/F
         HxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cSJSMSobZih7iY3IhyRNQHQ9trYuF7BXMloT2eMFo9M=;
        b=Je9rWiPMcvNScQjReGNG6xPPKZuxjmQDnxbges9lcJy+pawY6DmxGIxWKFaMhOYVXo
         TXhq2qf6bT/31n2UAPKDK23b0itLQ96LV80QrFPQFdVOrU3mqgvgYpkQ6Tm0qaiFvhaQ
         TV0ZxUKH5nTV3MKXrTpkUwwPzmcW6CxPoREbnFTkZE9sxnJ2I238ip+ircxWhO7HmGhZ
         68SEpsekNO96Gp5hN2U8gcly6Tiq3IYL/OtpSOog386w7oV43eGQupwRUbh5KtcCdhsa
         yxTyhFSxCL7ukvYSDLvSROPwGLz4AYfl/wIK730LZnalS7pyBqAqqGNMtDDIF1WQgHuc
         iYyA==
X-Gm-Message-State: APjAAAU+LZXwi0nFcVRiR3LYCIh14DZylgWZfKma6auIE4Id6EyD/rDB
        UGPyns/AsXpXy37WryLynJ2Y9hnimcylxw==
X-Google-Smtp-Source: APXvYqzvHZEqYuBfQuM7+ql9Sp59tQsGdv0b8NqPjLVSdDIFI68S8txssldHRXN1n25ugPJKCz2MzQ==
X-Received: by 2002:a63:2884:: with SMTP id o126mr4154856pgo.279.1569167504896;
        Sun, 22 Sep 2019 08:51:44 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id i74sm11402148pfe.28.2019.09.22.08.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2019 08:51:43 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
Date:   Sun, 22 Sep 2019 09:51:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1569139018.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/19 2:08 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> There could be a lot of overhead within generic wait_event_*() used for
> waiting for large number of completions. The patchset removes much of
> it by using custom wait event (wait_threshold).
> 
> Synthetic test showed ~40% performance boost. (see patch 2)

I'm fine with the io_uring side of things, but to queue this up we
really need Peter or Ingo to sign off on the core wakeup bits...

Peter?

-- 
Jens Axboe

