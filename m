Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D97C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F94E20637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brA1NQR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLIUjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:39:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43769 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLIUjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:39:22 -0500
Received: by mail-lf1-f68.google.com with SMTP id 9so11803099lfq.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 12:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w33D8YlO2VCmd0REKmfpLnJ7eSFQMkbZwyL94W5JDso=;
        b=brA1NQR9xRXdNcnZQqlwqXlPSet22bI6+cOP5l+y2Zh4/HUu6M2aV1JiNTTzsZtOua
         WGJdNQjul6ZLVNO9+gZDS9xbwlrXXZtiZAPbFjRca/Mf0zbZDn7d8NK+E+7XzMAn3cyR
         eur7B2ELVxAuPu77vg6fYbMNnYfGfqAIiaE4iuKBnwfl80PQ16yacXZA3Zx/w+ozcG+W
         AmJLPc9p5oskfyRuf3NCxkeFNpGxCOaOCNi9c64aV4NS1YT9hli1ZvD01F+vA9ZspwB5
         Oon3NR3LsgfH9iAqPsFLS0cwpOm2aUdZrd44cp96I7DVSGwnidr9k2hcYIUEU9XiyUQr
         J/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=w33D8YlO2VCmd0REKmfpLnJ7eSFQMkbZwyL94W5JDso=;
        b=CjA9Q8Z2UU3Hh1qorZ1V4NKjcMy7Zt7MF0LQyxXSFYDHdboQGogy6+wZKytT0iEuPU
         N4myYYCZpjdQ8vtW6UeKkD49/83jlmIfEIzC+YUTwf3M6ws48jKGeEwVe+ejNQv4yQmW
         y1aRwV16ycSlAdsvtEHv/cskUWMED2fikZbZ0XRJDjGgM9lGGjE0BmF8st5jOchxsX+p
         vn5DSvKvOuI0CTxFEywQJwOx76aFqvNn3HaKPJweZ/BqXZwynut3uspqzEGlu5GfCzIO
         lpGHN3c80kvHuXx48odX2IS98Tp06vo4vX4rYBNAVhMV2x+oHZXKDzxjVbBgLTsRBEkz
         h3zg==
X-Gm-Message-State: APjAAAWDNPUlS95mG6JnNt+Dg2Ehm+gv9NZHRFFcaq6AztKgH8mLLlCq
        2yUCSpCWwjP61Z1GtzN9N5YOqA==
X-Google-Smtp-Source: APXvYqyhPHrQ4wTGeljgNUPixik/HHZ7qCZyiiPk8/Y482i9XuSeM21JS91O8PrU1IkOFn8Wj36pyw==
X-Received: by 2002:ac2:4adc:: with SMTP id m28mr16246054lfp.26.1575923959975;
        Mon, 09 Dec 2019 12:39:19 -0800 (PST)
Received: from khorivan (57-201-94-178.pool.ukrtel.net. [178.94.201.57])
        by smtp.gmail.com with ESMTPSA id c23sm470663ljj.78.2019.12.09.12.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 12:39:19 -0800 (PST)
Date:   Mon, 9 Dec 2019 22:39:17 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: davinci_cpdma: fix warning "device
 driver frees DMA memory with different size"
Message-ID: <20191209203916.GA26682@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org
References: <20191209111924.22555-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191209111924.22555-1-grygorii.strashko@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 01:19:24PM +0200, Grygorii Strashko wrote:
>The TI CPSW(s) driver produces warning with DMA API debug options enabled:
>
>WARNING: CPU: 0 PID: 1033 at kernel/dma/debug.c:1025 check_unmap+0x4a8/0x968
>DMA-API: cpsw 48484000.ethernet: device driver frees DMA memory with different size
> [device address=0x00000000abc6aa02] [map size=64 bytes] [unmap size=42 bytes]
>CPU: 0 PID: 1033 Comm: ping Not tainted 5.3.0-dirty #41
>Hardware name: Generic DRA72X (Flattened Device Tree)
>[<c0112c60>] (unwind_backtrace) from [<c010d270>] (show_stack+0x10/0x14)
>[<c010d270>] (show_stack) from [<c09bc564>] (dump_stack+0xd8/0x110)
>[<c09bc564>] (dump_stack) from [<c013b93c>] (__warn+0xe0/0x10c)
>[<c013b93c>] (__warn) from [<c013b9ac>] (warn_slowpath_fmt+0x44/0x6c)
>[<c013b9ac>] (warn_slowpath_fmt) from [<c01e0368>] (check_unmap+0x4a8/0x968)
>[<c01e0368>] (check_unmap) from [<c01e08a8>] (debug_dma_unmap_page+0x80/0x90)
>[<c01e08a8>] (debug_dma_unmap_page) from [<c0752414>] (__cpdma_chan_free+0x114/0x16c)
>[<c0752414>] (__cpdma_chan_free) from [<c07525c4>] (__cpdma_chan_process+0x158/0x17c)
>[<c07525c4>] (__cpdma_chan_process) from [<c0753690>] (cpdma_chan_process+0x3c/0x5c)
>[<c0753690>] (cpdma_chan_process) from [<c0758660>] (cpsw_tx_mq_poll+0x48/0x94)
>[<c0758660>] (cpsw_tx_mq_poll) from [<c0803018>] (net_rx_action+0x108/0x4e4)
>[<c0803018>] (net_rx_action) from [<c010230c>] (__do_softirq+0xec/0x598)
>[<c010230c>] (__do_softirq) from [<c0143914>] (do_softirq.part.4+0x68/0x74)
>[<c0143914>] (do_softirq.part.4) from [<c0143a44>] (__local_bh_enable_ip+0x124/0x17c)
>[<c0143a44>] (__local_bh_enable_ip) from [<c0871590>] (ip_finish_output2+0x294/0xb7c)
>[<c0871590>] (ip_finish_output2) from [<c0875440>] (ip_output+0x210/0x364)
>[<c0875440>] (ip_output) from [<c0875e2c>] (ip_send_skb+0x1c/0xf8)
>[<c0875e2c>] (ip_send_skb) from [<c08a7fd4>] (raw_sendmsg+0x9a8/0xc74)
>[<c08a7fd4>] (raw_sendmsg) from [<c07d6b90>] (sock_sendmsg+0x14/0x24)
>[<c07d6b90>] (sock_sendmsg) from [<c07d8260>] (__sys_sendto+0xbc/0x100)
>[<c07d8260>] (__sys_sendto) from [<c01011ac>] (__sys_trace_return+0x0/0x14)
>Exception stack(0xea9a7fa8 to 0xea9a7ff0)
>...
>
>The reason is that cpdma_chan_submit_si() now stores original buffer length
>(sw_len) in CPDMA descriptor instead of adjusted buffer length (hw_len)
>used to map the buffer.
>
>Hence, fix an issue by passing correct buffer length in CPDMA descriptor.
>
>Cc: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>Fixes: 6670acacd59e ("net: ethernet: ti: davinci_cpdma: add dma mapped submit")
>Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>---

Reviewed-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

-- 
Regards,
Ivan Khoronzhuk
