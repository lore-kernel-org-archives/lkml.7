Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23199C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB13A2063F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="kn+TCh4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfFMRDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:03:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40270 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbfFLW4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 18:56:08 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so20392457qtn.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 15:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rwIUelHuBwKm3odn4j/kyFgXxrPvIhVkoS3EqQWqZHE=;
        b=kn+TCh4rcW0ZQQ+FDGv3UGCWsJDPT3wI28aa+oyId4qNNUeddnAvKEAr7rGknnH6xa
         /r497R8WZS5cZQtEX3x193nDWpK147meOaWCyJDIQ4xp0ZNb9ylNG84Zajc+kynx05EX
         iYldzxbKQ27h3fA+0PYA5VwUiUK07M3rf9oL9Z8/wAGpNoFK0/OFXI3/epNlGobVJEUE
         kPS6xxeHkeADSGogBno96twERVvjXoDZ1SxikoFmcP/Zz6luq+NUs9CoiHvF8/wqqMQS
         G6/JQoWCpyUsCT+g2/YkzfYJQZIxQ0hx9WAUVLJnDe06BozxPMiv660nRhYODwEyWiDg
         ErYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rwIUelHuBwKm3odn4j/kyFgXxrPvIhVkoS3EqQWqZHE=;
        b=gaUEHsO1EVtSsuQhSWXA70kuWH/rQehsWd6r3DaMd28CpNV8Q5ef3RWHwWM8Sz78j6
         0J1zxe5Q2aGrXquXRsR8TyGPWjiybCa27RLUBGzwO1m3Nqa4PTU4IumFTyqPMx2NgxKx
         v2PQiqkeQZdL5/lgdOjtUuzTYtTf+tWJ3FFxpKrE9YWUTGrl03pUfUB5kcyJT9ITi3FV
         jahvr/Nc+txQlKMN9ciOZ37fxFdreoiP++X8nGVFROWaOj37KxeKHaMGN6/2chCPeWKU
         BxlyoKOiBNRjMRhDnvygYRXMFca1k9lm4OoCIpG8HuDIh2HTWBBdOxvRs110i0w+T51w
         RRhg==
X-Gm-Message-State: APjAAAULd1k6OTWPNnasp1y95MRP28zQUFylaYCvnHBTudM5YQvZm5g+
        CPh+CcsGDSPvPxxyGjMj7JcJMg==
X-Google-Smtp-Source: APXvYqy8jgn8msBHtww5Cwbc2Pc6dQy0PWQe6hRatZPYWSkA7OUB4W2Zf3oqaR3JgAqXSf/2tH6OLw==
X-Received: by 2002:ac8:2bf6:: with SMTP id n51mr72527919qtn.189.1560380167722;
        Wed, 12 Jun 2019 15:56:07 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id c5sm462231qtj.27.2019.06.12.15.56.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 15:56:07 -0700 (PDT)
Date:   Wed, 12 Jun 2019 15:56:03 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Xue Chaojing <xuechaojing@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoshaokai@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <chiqijun@huawei.com>,
        <wulike1@huawei.com>
Subject: Re: [PATCH net-next v2 1/2] hinic: add rss support
Message-ID: <20190612155603.4078ebb3@cakuba.netronome.com>
In-Reply-To: <20190611181234.4843-2-xuechaojing@huawei.com>
References: <20190611181234.4843-1-xuechaojing@huawei.com>
        <20190611181234.4843-2-xuechaojing@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 18:12:33 +0000, Xue Chaojing wrote:
> This patch adds rss support for the HINIC driver.
> 
> Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>

> +static int hinic_rss_init(struct hinic_dev *nic_dev)
> +{
> +	u8 default_rss_key[HINIC_RSS_KEY_SIZE] = {
> +			0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,
> +			0x41, 0x67, 0x25, 0x3d, 0x43, 0xa3, 0x8f, 0xb0,
> +			0xd0, 0xca, 0x2b, 0xcb, 0xae, 0x7b, 0x30, 0xb4,
> +			0x77, 0xcb, 0x2d, 0xa3, 0x80, 0x30, 0xf2, 0x0c,
> +			0x6a, 0x42, 0xb7, 0x3b, 0xbe, 0xac, 0x01, 0xfa};

netdev_rss_key_fill()

> +	u32 indir_tbl[HINIC_RSS_INDIR_SIZE] = { 0 };
> +	u8 tmpl_idx = nic_dev->rss_tmpl_idx;
> +	int err, i;
> +
> +	for (i = 0; i < HINIC_RSS_INDIR_SIZE; i++)
> +		indir_tbl[i] = (i / HINIC_RSS_INDIR_SIZE) * nic_dev->num_rss +
> +				i % nic_dev->num_rss;
> +
> +	err = hinic_rss_set_template_tbl(nic_dev, tmpl_idx, default_rss_key);
> +	if (err)
> +		return err;
> +
> +	err = hinic_rss_set_indir_tbl(nic_dev, tmpl_idx, indir_tbl);
> +	if (err)
> +		return err;
> +
> +	err = hinic_set_rss_type(nic_dev, tmpl_idx, nic_dev->rss_type);
> +	if (err)
> +		return err;
> +
> +	err = hinic_rss_set_hash_engine(nic_dev, tmpl_idx,
> +					nic_dev->rss_hash_engine);
> +	if (err)
> +		return err;
> +
> +	err = hinic_rss_cfg(nic_dev, 1, tmpl_idx);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static void hinic_rss_deinit(struct hinic_dev *nic_dev)
> +{
> +	hinic_rss_cfg(nic_dev, 0, nic_dev->rss_tmpl_idx);
> +}
> +
> +static void hinic_init_rss_parameters(struct hinic_dev *nic_dev)
> +{
> +	nic_dev->rss_hash_engine = HINIC_RSS_HASH_ENGINE_TYPE_XOR;
> +	nic_dev->rss_type.tcp_ipv6_ext = 1;
> +	nic_dev->rss_type.ipv6_ext = 1;
> +	nic_dev->rss_type.tcp_ipv6 = 1;
> +	nic_dev->rss_type.ipv6 = 1;
> +	nic_dev->rss_type.tcp_ipv4 = 1;
> +	nic_dev->rss_type.ipv4 = 1;
> +	nic_dev->rss_type.udp_ipv6 = 1;
> +	nic_dev->rss_type.udp_ipv4 = 1;

Usually UDP is disabled by default because fragmentation leads to
reorders (NICs file all fragmented packets to queue 0 while other
packets are distributed by RSS).

> +}
> +
> +static void hinic_enable_rss(struct hinic_dev *nic_dev)
> +{
> +	struct net_device *netdev = nic_dev->netdev;
> +	struct hinic_hwdev *hwdev = nic_dev->hwdev;
> +	struct hinic_hwif *hwif = hwdev->hwif;
> +	struct pci_dev *pdev = hwif->pdev;
> +	int i, node, err = 0;
> +	u16 num_cpus = 0;
> +
> +	nic_dev->max_qps = hinic_hwdev_max_num_qps(hwdev);
> +	if (nic_dev->max_qps <= 1) {
> +		nic_dev->flags &= ~HINIC_RSS_ENABLE;
> +		nic_dev->rss_limit = nic_dev->max_qps;
> +		nic_dev->num_qps = nic_dev->max_qps;
> +		nic_dev->num_rss = nic_dev->max_qps;
> +
> +		return;
> +	}
> +
> +	err = hinic_rss_template_alloc(nic_dev, &nic_dev->rss_tmpl_idx);
> +	if (err) {
> +		netif_err(nic_dev, drv, netdev,
> +			  "Failed to alloc tmpl_idx for rss, can't enable rss for this function\n");
> +		nic_dev->flags &= ~HINIC_RSS_ENABLE;
> +		nic_dev->max_qps = 1;
> +		nic_dev->rss_limit = nic_dev->max_qps;
> +		nic_dev->num_qps = nic_dev->max_qps;
> +		nic_dev->num_rss = nic_dev->max_qps;
> +
> +		return;
> +	}
> +
> +	nic_dev->flags |= HINIC_RSS_ENABLE;
> +
> +	for (i = 0; i < num_online_cpus(); i++) {
> +		node = cpu_to_node(i);
> +		if (node == dev_to_node(&pdev->dev))
> +			num_cpus++;
> +	}
> +
> +	if (!num_cpus)
> +		num_cpus = num_online_cpus();
> +
> +	nic_dev->num_qps = min_t(u16, nic_dev->max_qps, num_cpus);

We generally use netif_get_num_default_rss_queues() for RX queues
and num_online_cpus() for TX queues but I'm not sure you can do
different counts, so it's probably fine.
