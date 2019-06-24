Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79719C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDC820663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Z88sjk6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfFXTFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:05:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45565 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbfFXTFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:05:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so15648562qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=AyuRS8Lwp7vEBwCUi0j+D6xyHz2b0vyBNyOhbTtwtYU=;
        b=Z88sjk6Oy1WaO3+yCDQDFOSbz8ukF6kaN/e53K7UPw19c9G4PMe0KXNDQ/dKqFnmAd
         shxS/mq9FNfhBZyQ1N7StT8XRemQpqA+DWEpZRLx8HYuRDM1LcZF3ad4u3N+MEEUbbVs
         L89mZKHlHmWYcVoWMxIwO9TQn0z35be2TPvWCxBIFvfZEymZv+U7erpPcW1rrjKdgg/G
         JUD5T+rmZ9+Oln1tBy8vI8dH1gwVHQO/w2jApOPAtPrzi1U49hfyDC5ANRj1HFzo8/XP
         yqlbRBXHrgcii9xwRgeGGfWEdxKtgadBpMBv6xmtpcXRmRxv2mWl15B2K5XXGJayEIGD
         xX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=AyuRS8Lwp7vEBwCUi0j+D6xyHz2b0vyBNyOhbTtwtYU=;
        b=qKJrYcaGZFp2LSIErJ8xyOJmGGFOlw9foQqVvvKLNrEXMkQm0Q6rd5wv49ALVQVjEv
         6K+/BGYlwmtrDZbsrp+1aTu/urdfhuuqkaXsHwAaxbqJSvXWUCoPFMz/f1x2pa81mnTR
         74Mo3csS78M9QFzBk4HdS3jSF8IaJNS7VvKRaVDv0XpqARYMHElxa9X8Wd+r9Hua2oi7
         Lzx4nq/nwPJrqAINJEKgiulMJmTzA4FKgMIu6GgynK/ntca0IzZ0Qci/Y9RjDL5T1Nv1
         bPXn6Lt1WVmLoUgfjlTmaeOP/IraDnLHTQV4jDQzoyU3iGUxEVWJEVuKV9Bc6n24kGhC
         0ovA==
X-Gm-Message-State: APjAAAX9jSjIvXTLfyRP33CgJc0aJHmFGxIhjtptz7pHeCmGlle4b/qu
        wvqA+e/KYI0lSNILgPQJKL/Rqw==
X-Google-Smtp-Source: APXvYqxxKgDZPrZjQ+nMk6dZ1YsT4ETp55XKhQk8ZqXTj/pbdZwyLqfTdPwdA59WtozoaqyvZJNf3Q==
X-Received: by 2002:ac8:685:: with SMTP id f5mr57301924qth.9.1561403124388;
        Mon, 24 Jun 2019 12:05:24 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e4sm7095824qtc.3.2019.06.24.12.05.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 12:05:24 -0700 (PDT)
Date:   Mon, 24 Jun 2019 12:05:19 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Xue Chaojing <xuechaojing@huawei.com>, <davem@davemloft.net>
Cc:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoshaokai@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <chiqijun@huawei.com>, <wulike1@huawei.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v2] hinic: implement the statistical interface
 of ethtool
Message-ID: <20190624120519.4ec22e19@cakuba.netronome.com>
In-Reply-To: <20190624035012.7221-1-xuechaojing@huawei.com>
References: <20190624035012.7221-1-xuechaojing@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 03:50:12 +0000, Xue Chaojing wrote:
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> index be28a9a7f033..8d98f37c88a8 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> @@ -438,6 +438,344 @@ static u32 hinic_get_rxfh_indir_size(struct net_device *netdev)
>  	return HINIC_RSS_INDIR_SIZE;
>  }
>  
> +#define ARRAY_LEN(arr) ((int)((int)sizeof(arr) / (int)sizeof(arr[0])))
> +
> +#define HINIC_NETDEV_STAT(_stat_item) { \
> +	.name = #_stat_item, \
> +	.size = FIELD_SIZEOF(struct rtnl_link_stats64, _stat_item), \
> +	.offset = offsetof(struct rtnl_link_stats64, _stat_item) \
> +}
> +
> +static struct hinic_stats hinic_netdev_stats[] = {
> +	HINIC_NETDEV_STAT(rx_packets),
> +	HINIC_NETDEV_STAT(tx_packets),
> +	HINIC_NETDEV_STAT(rx_bytes),
> +	HINIC_NETDEV_STAT(tx_bytes),
> +	HINIC_NETDEV_STAT(rx_errors),
> +	HINIC_NETDEV_STAT(tx_errors),
> +	HINIC_NETDEV_STAT(rx_dropped),
> +	HINIC_NETDEV_STAT(tx_dropped),
> +	HINIC_NETDEV_STAT(multicast),
> +	HINIC_NETDEV_STAT(collisions),
> +	HINIC_NETDEV_STAT(rx_length_errors),
> +	HINIC_NETDEV_STAT(rx_over_errors),
> +	HINIC_NETDEV_STAT(rx_crc_errors),
> +	HINIC_NETDEV_STAT(rx_frame_errors),
> +	HINIC_NETDEV_STAT(rx_fifo_errors),
> +	HINIC_NETDEV_STAT(rx_missed_errors),
> +	HINIC_NETDEV_STAT(tx_aborted_errors),
> +	HINIC_NETDEV_STAT(tx_carrier_errors),
> +	HINIC_NETDEV_STAT(tx_fifo_errors),
> +	HINIC_NETDEV_STAT(tx_heartbeat_errors),
> +};

I think we wanted to stop duplicating standard netdev stats in ethtool
-S.  Chaojing please post a patch to remove this part, the other stats
are good.
