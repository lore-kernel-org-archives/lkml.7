Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F992C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D5F2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfFFRgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:36:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54638 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfFFRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:36:23 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7669714DD36DF;
        Thu,  6 Jun 2019 10:36:22 -0700 (PDT)
Date:   Thu, 06 Jun 2019 10:36:21 -0700 (PDT)
Message-Id: <20190606.103621.340824426867229259.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, tanxiaofei@huawei.com
Subject: Re: [PATCH net-next 01/12] net: hns3: log detail error info of
 ROCEE ECC and AXI errors
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1559809267-53805-2-git-send-email-tanhuazhong@huawei.com>
References: <1559809267-53805-1-git-send-email-tanhuazhong@huawei.com>
        <1559809267-53805-2-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 06 Jun 2019 10:36:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Thu, 6 Jun 2019 16:20:56 +0800

> +static int hclge_log_rocee_axi_error(struct hclge_dev *hdev)
> +{
 ...
> +	ret = hclge_cmd_send(&hdev->hw, &desc[0], 3);
> +	if (ret) {
> +		dev_err(dev, "failed(%d) to query ROCEE AXI error sts\n", ret);
> +		return ret;
> +	}
 ...
> +		ret = hclge_log_rocee_axi_error(hdev);
> +		if (ret) {
> +			dev_err(dev, "failed(%d) to process axi error\n", ret);

You log the error twice which is unnecessary.
