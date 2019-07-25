Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E845C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BA0218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfGYSQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:16:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41220 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGYSQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:16:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so52602392ota.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mf72JOljqEcmy/ZUQX00VafBUJnQdMDqI/qYe3vWrws=;
        b=jEyGieOA7gUO24xZhyKFme0LCNdgEZCP6fQsNbaFCuOGW/xrsOFYQNX4W+Li/G5+fF
         RHak2r5mFOZC3VfX58miT6FjHzvSm8hJlRJGRy7HBcp/zFAA92hvFOeOZugfOWsN1ka+
         D+nWtANK5TdR5BkMJDzMoxrzUVS1HS3u7tALBE48tbxo2ync2aA0AWIpBh3rzNUpJqCg
         Vv991N5zr3nHocHqq1asrdej1tLwdChySxB59A6/z58YZE7uGhgdU7GOF+iq38CD7hP3
         elOuSoL01cadF+IBbEDTGQMRVtF7O2JvNti5cSypjLjRrGS51lMc4IWOJ5RPYOy6j79B
         7OHw==
X-Gm-Message-State: APjAAAXuaC6S7ahkUIA121rJHH+gMS93ILq2dHOr87eZgo55RFFosGkl
        +H1U+qD3EhH6YJhe2osLkdM=
X-Google-Smtp-Source: APXvYqzWyC5LGwa7S/tk013os40hH9axD/Rug2eI5+1oAwwQK+sE9JCzUCD15+hYOGLOfgvDJyHE1w==
X-Received: by 2002:a9d:6282:: with SMTP id x2mr33856955otk.223.1564078605742;
        Thu, 25 Jul 2019 11:16:45 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id t11sm16793290otq.13.2019.07.25.11.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 11:16:45 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
 <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
 <6deea9e7-ff3c-e115-b2f2-8914df0b6da7@deltatee.com>
 <dd287560-2cb3-28ab-c22d-fe9f3682c609@grimberg.me>
 <021b5195-9a09-4cc2-064f-940ada9cf764@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b501f53b-48e9-87a3-9023-8597ed1efc6d@grimberg.me>
Date:   Thu, 25 Jul 2019 11:16:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <021b5195-9a09-4cc2-064f-940ada9cf764@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hey,
> 
> Sorry for the delay.
> 
> I tested your patch and it does work. Do you want me to send your change
> as a full patch? Can I add your signed-off-by?

I have a patch ready with a proper comment in place. I can send it
out... Can I get your tested-by and reported-by?
