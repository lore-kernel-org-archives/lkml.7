Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D50DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE552067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKLUMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:12:08 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48918 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLUMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:12:08 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 27653154D23BD;
        Tue, 12 Nov 2019 12:12:07 -0800 (PST)
Date:   Mon, 11 Nov 2019 14:38:30 -0800 (PST)
Message-Id: <20191111.143830.839461521636004353.davem@davemloft.net>
To:     grygorii.strashko@ti.com
Cc:     f.fainelli@gmail.com, netdev@vger.kernel.org,
        ilias.apalodimas@linaro.org, andrew@lunn.ch,
        ivan.khoronzhuk@linaro.org, jiri@resnulli.us, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        m-karicheri2@ti.com, ivecera@redhat.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 net-next 02/13] net: ethernet: ti: cpsw: allow
 untagged traffic on host port
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191109151525.18651-3-grygorii.strashko@ti.com>
References: <20191109151525.18651-1-grygorii.strashko@ti.com>
        <20191109151525.18651-3-grygorii.strashko@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Nov 2019 12:12:07 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Sat, 9 Nov 2019 17:15:14 +0200

> +	ale->p0_untag_vid_mask =
> +		devm_kmalloc_array(params->dev, BITS_TO_LONGS(VLAN_N_VID),
> +				   sizeof(unsigned long),
> +				   GFP_KERNEL);
> +

devm_kmalloc_array() can fail and you must check the return value and
cleanup with -ENOMEM if necessary.
