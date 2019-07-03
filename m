Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36EAC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64E82187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfGCXtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 19:49:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46811 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfGCXtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 19:49:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so4181639ote.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 16:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=iYkGpwMXKxVNcmLKnQld70dQP6ASPjx6Ir+lpUcmRbeaCLNxvoPbZdbtjpO+02wvjj
         4tt7dBbmpdK6C8YBbjvVzu3cwBQcNieJfp8BGuljGCzf4UV3p0y1a0xoDDPFf59llgJx
         ZF+XMXns7N33mPqM7xg9zWd+Zn/ATL2/KT2E4HmjygdfzKpchJsj0afaC4tu3HrbCyXt
         r58+DTDBJm83/3mL48DbPH1FNyKFNWK/4JHrlFZuysD3qniRz7OfQXZyESyxivDAoI3x
         5qWKQx/gkT5jtoLDoVsV1KiShI/GyqNT0/hGdD3YpUaRQUe/NV8P0y3lmgnFGVo9s2+8
         BKdw==
X-Gm-Message-State: APjAAAXOP9cWicD/uv4X5/JBkUCRToqhw5IE3y6Ie7mHk++t+UzItdCu
        +TN4snShckxGS2Qwy8lCpV5QTWen
X-Google-Smtp-Source: APXvYqxEbFi5posAe2vKH3wHGzt+E6AjNnOUpt4KA77N6dTLlE/YyRtTIGKg7Wa3P92Zgd5G0pxitg==
X-Received: by 2002:a9d:65ca:: with SMTP id z10mr32303635oth.334.1562197772109;
        Wed, 03 Jul 2019 16:49:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id n106sm1409132ota.31.2019.07.03.16.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 16:49:31 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] nvmet: Fix use-after-free bug when a port is
 removed
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Stephen Bates <sbates@raithlin.com>
References: <20190703230304.22905-1-logang@deltatee.com>
 <20190703230304.22905-2-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <87f99bda-3e94-2d49-2ef1-4537433c5e3f@grimberg.me>
Date:   Wed, 3 Jul 2019 16:49:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703230304.22905-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
