Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E94FC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B72920861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfFQUea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:34:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37906 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFQUe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:34:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0231215110457;
        Mon, 17 Jun 2019 13:34:28 -0700 (PDT)
Date:   Mon, 17 Jun 2019 13:34:28 -0700 (PDT)
Message-Id: <20190617.133428.1681715924857496492.davem@davemloft.net>
To:     xuechaojing@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        luoshaokai@huawei.com, cloud.wangxiaoyun@huawei.com,
        chiqijun@huawei.com, wulike1@huawei.com
Subject: Re: [PATCH net-next v4 1/3] hinic: add rss support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190617054601.3056-2-xuechaojing@huawei.com>
References: <20190617054601.3056-1-xuechaojing@huawei.com>
        <20190617054601.3056-2-xuechaojing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Jun 2019 13:34:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xue Chaojing <xuechaojing@huawei.com>
Date: Mon, 17 Jun 2019 05:45:59 +0000

> +static int hinic_rss_init(struct hinic_dev *nic_dev)
> +{
> +	u8 default_rss_key[HINIC_RSS_KEY_SIZE] = { 0 };
> +	u32 indir_tbl[HINIC_RSS_INDIR_SIZE] = { 0 };
> +	u8 tmpl_idx = nic_dev->rss_tmpl_idx;
> +	int err, i;
> +
> +	netdev_rss_key_fill(default_rss_key, sizeof(default_rss_key));

Since netdev_rss_key_fill() fills the entire object, you don't need the
variable initializer for default_rss_key here, please remove it.

> +int hinic_rss_set_indir_tbl(struct hinic_dev *nic_dev, u32 tmpl_idx,
> +			    const u32 *indir_table)
> +{
> +	for (i = 0; i < HINIC_RSS_INDIR_SIZE; i++) {
> +		indir_tbl->entry[i] = (u8)(*(indir_table + i));

Please index the array normally using "indir_table[i]", I also suspect
the u8 cast is also unnecessary.
