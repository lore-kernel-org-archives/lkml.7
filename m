Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF0C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8010E2182B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="dj+snbli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfE0O6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:58:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45494 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfE0O6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:58:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id a5so7133860pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HDorn020b95P5QjIbImPQwcjN3fb+vcklwL0uBNOB4=;
        b=dj+snbli8MeuVtvvWOX0i/MgbvyzGrxJcDF9vmnzSVKk7tykrUDOwHIe0eqGnKqEQF
         JcPGQ+qnbkHlQvwQeWdUR+LHeDyKaaPE3RFknEp5S1+TQORd4cEyFUq5EMm7dyzR4mFi
         upaD0ePc29TkvHC5B0c+5ygI+RdqlJNm5tjiPVLJF3vUf1EbGbSJ/HKf62lZMk34fsys
         MRfCsiCQF+GIlEGEJCP77ri459CbTyQ+FpWZvUXHa3syNXvzxorKjYWboz6cPuZZuNEj
         rA+DJ0hkB+h5/9Zkst1UTmXo06udSQ/RM9snSQXx7K/Xg4XmeC/cCd30X4X9/fjkm+Xk
         GByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HDorn020b95P5QjIbImPQwcjN3fb+vcklwL0uBNOB4=;
        b=PfN6uoAIW3f4Uc57cUMi/CITfYx6rn2pNSRqdZ9aJNh3Xw0V+x426sGUuifsD6jaNG
         0kT6gxHF0UvOGlEWBZJptxz3KYH9T5zM4ursLbiQDj0P1FkYaAV9Sn3J8VxahZJoaTkq
         f5oxyb/N3Z1wNlT5l8OA1kVkP+TraFn8ALI4MtkzXLjckeTf0s32fod0TCpftN+HjT7n
         6vMJbIPLecYqO0fXDjPn7MEtjdKVSVsVFq2SWbY1szCTa1GFSIAMLHjK3Ab5U/NPPw4p
         PpmAc1uv+JZgkSQZ5AtvCvIIh8BpY6luqZ6nHdCgo2SD0sbpnBWHJa3cwvUODf7sPIcZ
         gyOQ==
X-Gm-Message-State: APjAAAU8wP08rfe7TsWqokb50sEWWpF/qO/nnUOP0Tiq1UT/rQ8pPMu9
        nAvbZJrOVNj50oLqiAVWSeUlNw==
X-Google-Smtp-Source: APXvYqx7bkmiB37BGw4ZMiueOLTLzrpyuGwvCGpPwUQLdM5HBEpcaRkO1jmZENpeJmV1MMY5gGvmxw==
X-Received: by 2002:a17:902:9a43:: with SMTP id x3mr3162302plv.35.1558969121537;
        Mon, 27 May 2019 07:58:41 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id s12sm9701811pji.30.2019.05.27.07.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 07:58:41 -0700 (PDT)
Date:   Mon, 27 May 2019 07:58:38 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <hkallweit1@gmail.com>,
        <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH net-next] net: link_watch: prevent starvation when
 processing linkwatch wq
Message-ID: <20190527075838.5a65abf9@hermes.lan>
In-Reply-To: <1558921674-158349-1-git-send-email-linyunsheng@huawei.com>
References: <1558921674-158349-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019 09:47:54 +0800
Yunsheng Lin <linyunsheng@huawei.com> wrote:

> When user has configured a large number of virtual netdev, such
> as 4K vlans, the carrier on/off operation of the real netdev
> will also cause it's virtual netdev's link state to be processed
> in linkwatch. Currently, the processing is done in a work queue,
> which may cause worker starvation problem for other work queue.
> 
> This patch releases the cpu when link watch worker has processed
> a fixed number of netdev' link watch event, and schedule the
> work queue again when there is still link watch event remaining.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

Why not put link watch in its own workqueue so it is scheduled
separately from the system workqueue?
