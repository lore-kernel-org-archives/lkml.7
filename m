Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C0FC04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 01:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AECF20823
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 01:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="JI9vt3oT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfE1BRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 21:17:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34691 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfE1BRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 21:17:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id w7so7605217plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 18:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijI272WZY2aX1w5JkhA+Zc33AK5GeibsSemPmnxCISY=;
        b=JI9vt3oTgSoUPnEAwBWYZ6hBZWg0aJ7cfRqmDJso4DNcjlAHzXN5VN0XzrwQvKy+eE
         jjR6xkiRtiQGygWJMeZJtBAUuQgiSw89sZtcATPviV+PtmCL+FZGVVPnW1cKdUSlE/+G
         SWcxUMFXQIEyKp5aW4Ep452eih+RPACKands5dzbQOJEFD3FzpOpB100oC/QkdAA5p+N
         Ndk4ebBdFpul3kNTYUNae8196HOzbydq+BM4Mq78pinaAHV6/2cF53LnYHG8zlsxXj6Y
         t89uKfZK/p8G+DSPFghVC9S51XEvUYJ/nO8fy6ZpN2j9V4RwC5a7WQs8mXfIGqAPhInH
         Fgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijI272WZY2aX1w5JkhA+Zc33AK5GeibsSemPmnxCISY=;
        b=dmajBIYSObaE2I5XumjXNdrhqqOBVl/ZEAjPwPPuOsDVxszZKFtIlQcvZ50chI5Crr
         WmEe+wuKiMiX9tmTWSCOCEsv8rWAUs8SoEr8SNY9AgaCHDhmRUUITrV9ZKbdRdxe2AsK
         uBMm056bugAI7pXtAfhMeBiMpWWcx9/Ox0n63JB9cVgmR6QDPzi0cnT3s9vLqBfOFIaE
         ajOKnh+Ax++e6ZkFQ8HdU4quAiy0RhQeIsYTllBnvzsQZmhDhjboU1tn49kgBIwQu/Cc
         d43evhAnWnuGk0MYwERNCchbPqkJxbAvWiqQfj/beBOoTnuIKdPrWOthU68Uurdcnohf
         REsQ==
X-Gm-Message-State: APjAAAUNeehJ/xWRKXtiUlhG+d+N1ZAk3VBvHk3u5WyqbFeai++pb2pT
        7D3yfibhQXLL4mnzvebcrk4Kqw==
X-Google-Smtp-Source: APXvYqzcdyp+z4xSQk9fj45gFuSlS7y9Rptx7FxN9qyfQ7XHfrATfNlSn2z6giiv5tYkqyu4mOvGMg==
X-Received: by 2002:a17:902:b606:: with SMTP id b6mr133610170pls.100.1559006268153;
        Mon, 27 May 2019 18:17:48 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id v4sm13854552pff.45.2019.05.27.18.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 18:17:47 -0700 (PDT)
Date:   Mon, 27 May 2019 18:17:44 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <hkallweit1@gmail.com>,
        <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH net-next] net: link_watch: prevent starvation when
 processing linkwatch wq
Message-ID: <20190527181744.289c4b2f@hermes.lan>
In-Reply-To: <a0fe690b-2bfa-7d1a-40c5-5fb95cf57d0b@huawei.com>
References: <1558921674-158349-1-git-send-email-linyunsheng@huawei.com>
        <20190527075838.5a65abf9@hermes.lan>
        <a0fe690b-2bfa-7d1a-40c5-5fb95cf57d0b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 09:04:18 +0800
Yunsheng Lin <linyunsheng@huawei.com> wrote:

> On 2019/5/27 22:58, Stephen Hemminger wrote:
> > On Mon, 27 May 2019 09:47:54 +0800
> > Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >   
> >> When user has configured a large number of virtual netdev, such
> >> as 4K vlans, the carrier on/off operation of the real netdev
> >> will also cause it's virtual netdev's link state to be processed
> >> in linkwatch. Currently, the processing is done in a work queue,
> >> which may cause worker starvation problem for other work queue.
> >>
> >> This patch releases the cpu when link watch worker has processed
> >> a fixed number of netdev' link watch event, and schedule the
> >> work queue again when there is still link watch event remaining.
> >>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>  
> > 
> > Why not put link watch in its own workqueue so it is scheduled
> > separately from the system workqueue?  
> 
> From testing and debuging, the workqueue runs on the cpu where the
> workqueue is schedule when using normal workqueue, even using its
> own workqueue instead of system workqueue. So if the cpu is busy
> processing the linkwatch event, it is not able to process other
> workqueue' work when the workqueue is scheduled on the same cpu.
> 
> Using unbound workqueue may solve the cpu starvation problem.
> But the __linkwatch_run_queue is called with rtnl_lock, so if it
> takes a lot time to process, other need to take the rtnl_lock may
> not be able to move forward.

Agree with the starvation issue. My cocern is that large number of
events that end up being delayed would impact things that are actually
watching for link events (like routing daemons).

It probably would be not accepted to do rtnl_unlock/sched_yield/rtnl_lock
in the loop, but that is another alternative.


