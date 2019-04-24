Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2ABC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3A32077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbfDXQzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:55:21 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33994 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbfDXQzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:55:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id v10so14868444oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yn0aFyTJCtKV7+7UNFdF1tJeLLqWxdNTnDw7QiXzMv0=;
        b=ujbDSc39ZbUzXj/k7tCBVutsXSc2PhAI6gxYyBEbMSbtcPa5IWymVshgN0DKDdb+fe
         +o+BYSX5zbyKWhlPygNUBUqol6spE64pQAd1fdu53ojGemMLS9Bo+SuLWvmYqJt2lyIn
         uMrB3xpfv57MZsrfs7HmMEezFPfwtpNugiBPkWyQWsYuetlqRYHmQhh+LNeXWlXXkwev
         RMnFYRgNe7hFauLfWKkY9ivagWmG45ov7ohpZWgbx1SwiOhw20iqyNZe+ThPpEmgt9Su
         S2sW+Iv0eijUtI0p5pqKEe1koQwC0AJmuEh43HlJAY/7a8RbduxWKAgYezTbZnb+O6Zw
         Fucw==
X-Gm-Message-State: APjAAAWV6rLOxx7C/rJtOdX+tscBw0l7rVkNpWZLqOGdT3XjwvrwM6ui
        BWdm4TquTrk83Qolgerdb/toLjCX
X-Google-Smtp-Source: APXvYqxP4+Qu709HSLEte3he8+mS7u2KzI7VNa6sKiA/yMG/NvzYPsSE1m+HulD2QnTRRYakhj6QgQ==
X-Received: by 2002:aca:3d89:: with SMTP id k131mr18205oia.37.1556124919401;
        Wed, 24 Apr 2019 09:55:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id p186sm7936894oif.34.2019.04.24.09.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 09:55:18 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Adding per-controller timeout support to nvme
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     David Woodhouse <dwmw2@infradead.org>, Amit Shah <aams@amazon.de>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190403123506.122904-1-mheyne@amazon.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fb33a464-af65-abec-5ff1-15925e7669a4@grimberg.me>
Date:   Wed, 24 Apr 2019 09:55:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403123506.122904-1-mheyne@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> As different nvme controllers are connect via different fabrics, some require
> different timeout settings than others. This series implements per-controller
> timeouts in the nvme subsystem which can be set via sysfs.

How much of a real issue is this?

block io_timeout defaults to 30 seconds which are considered a universal
eternity for pretty much any nvme fabric. Moreover, io_timeout is
mutable already on a per-namespace level.

This leaves the admin_timeout which goes beyond this to 60 seconds...

Can you describe what exactly are you trying to solve?
