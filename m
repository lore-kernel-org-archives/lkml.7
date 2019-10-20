Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9276FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5B3205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qKEkBRN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfJTRhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 13:37:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43030 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfJTRhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 13:37:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so6836345pfo.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=vmU9pgUKQcEuMSYv/BBcahpMF4UtOam9a0i9ZLAtxwE=;
        b=qKEkBRN+OgbmOLStSpTKuai/Xfu9qXtg1CINfl5SyuNp17UtrCIRg4cYlTHvTP7jvi
         iySsIaj77Mkq5ikwpFE1Xm/HeB9gXw7gMQ9+8+PbXbc8crqm0BUMsyzxHH8y43gvMhWM
         ZPqaZTwEpYG8bwy6YiqNQc1EtjsPyI3fSxBuepTvDf3qjb3uJLon9kJhgE/dinrNL/1d
         KZru/zmy2IyvTIGkhnRqVhuRfzge3ksp3hSNQjh9rO7kaCgQf1K9d8g2B0hgk4eiYUK6
         2caH3dikfd1EuVemAEzIBBhrl8BglKur+OZCB/z0GRnm39nGICVdA73ecO+5tC5KLM6h
         coHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=vmU9pgUKQcEuMSYv/BBcahpMF4UtOam9a0i9ZLAtxwE=;
        b=hi170lBAhusHMVVEhaGNS9dqp1b9PTzKV1Sf789lr5t8plfOVNt0mtyOupd/d4/NJL
         N085VvE550KusB29Sa/qj8S/fsOBFd6S0aV12TiFkPYujFTYPz3k+GS2lWGxhXdpIL+K
         fX1RHsa5bBNpl1nQqBL3vj5jZz4E8fOqymR3nzOQeyGnAui7XxaAzjOgLAAB22dkb6By
         s54b8egwkaYYxjUytm0pw0Qe5pbftrnKgnQABoP/zVsYK313TtywWMu7FEt3/JSZNlrM
         AzlOdGsuZBRp1m434j753SRwcN46E3HmmPEwke2aWuyTRAn2QWcUlByZ81Pky9refMXa
         PN2g==
X-Gm-Message-State: APjAAAUFxZWdl2UiAIoh8R0c3PVw+n3DN12vyAqA75h19HpCT4sKjuBa
        MzJ0T7Lsf0cRsOkJQs1Sws9v5Q==
X-Google-Smtp-Source: APXvYqyeYLW2YaKmo1xJfJxB58IOQE39T7c3Z1n8MrWodF2BnuK8nbT7D29rYLyZtNnd4qsV0pqqdw==
X-Received: by 2002:a63:4622:: with SMTP id t34mr21669219pga.0.1571593052820;
        Sun, 20 Oct 2019 10:37:32 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id e192sm13018937pfh.83.2019.10.20.10.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 10:37:32 -0700 (PDT)
Date:   Sun, 20 Oct 2019 10:37:29 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH net-next 0/8] net: hns3: add some cleanups &
 optimizations
Message-ID: <20191020103729.0aebf696@cakuba.netronome.com>
In-Reply-To: <1571472236-17401-1-git-send-email-tanhuazhong@huawei.com>
References: <1571472236-17401-1-git-send-email-tanhuazhong@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2019 16:03:48 +0800, Huazhong Tan wrote:
> This patchset includes some cleanups and optimizations for the HNS3
> ethernet driver.
> 
> [patch 1/8] removes unused and unnecessary structures.
> 
> [patch 2/8] uses a ETH_ALEN u8 array to replace two mac_addr_*
> field in struct hclge_mac_mgr_tbl_entry_cmd.
> 
> [patch 3/8] optimizes the barrier used in the IO path.
> 
> [patch 4/8] introduces macro ring_to_netdev() to get netdevive
> from struct hns3_enet_ring variable.
> 
> [patch 5/8] makes struct hns3_enet_ring to be cacheline aligned
> 
> [patch 6/8] adds a minor cleanup for hns3_handle_rx_bd().
> 
> [patch 7/8] removes linear data allocating for fraglist SKB.
> 
> [patch 8/8] clears hardware error when resetting.
> 
> ---
> note:
> In previous patchset, there are some bugfixes which needs below
> new feature, which is only in 'net-next' but not in 'net' now:
> net: hns3: support tx-scatter-gather-fraglist feature
> net: hns3: add support for spoof check setting
> 
> So, these bugfixes will be upstreamed when the patch needed is
> on 'net' tree.

Thanks! Looks good to me now.
