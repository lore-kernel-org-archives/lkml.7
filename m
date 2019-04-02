Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D2BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A03320830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="bSR8i4ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDBFoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:44:09 -0400
Received: from mail.nic.cz ([217.31.204.67]:55531 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfDBFoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:44:09 -0400
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id CE433607F8;
        Tue,  2 Apr 2019 07:44:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1554183846; bh=5DGcFRdtmLbujhvaK440iaZvbLmH8kCNsxeurGbU94A=;
        h=Date:From:To;
        b=bSR8i4ffN7tfc19SD0yr7SnfXdzdoov7A+Ej0wi+2LLk43AuGFtAywcUbs4br4nQq
         A+wkGzQ0p9SJkMI7JzCTUqC6NIFPwFO3NiqKnXY1Y/FP++l14bSrP2x0J4SczgGJ7c
         ei7sWTQrp/J4n3eTne0Om+60iYAqV5wSTInsuBE4=
Date:   Tue, 2 Apr 2019 07:44:06 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
Subject: Re: [RFC PATCH 5/5] leds: multicolor: Introduce a multicolor class
 definition
Message-ID: <20190402074406.0860994a@nic.cz>
In-Reply-To: <20190401173400.14238-6-dmurphy@ti.com>
References: <20190401173400.14238-1-dmurphy@ti.com>
        <20190401173400.14238-6-dmurphy@ti.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Mon, 1 Apr 2019 12:34:00 -0500
Dan Murphy <dmurphy@ti.com> wrote:

> +static ssize_t sync_store(struct device *dev,
> +			  struct device_attribute *sync_attr,
> +			  const char *buf, size_t size)
> +{
> +	struct led_classdev_mc_data *data = container_of(sync_attr,
> +						      struct led_classdev_mc_data,
> +						      sync_attr);
> +	struct led_classdev_mc *mcled_cdev = data->mcled_cdev;
> +	struct led_classdev *led_cdev = &mcled_cdev->led_cdev;
> +	const struct led_multicolor_ops *ops = mcled_cdev->ops;
> +	struct led_classdev_mc_priv *priv;
> +	unsigned long sync_value;
> +	ssize_t ret = -EINVAL;
> +
> +	mutex_lock(&led_cdev->led_access);
> +
> +	if (!mcled_cdev->sync_enabled)
> +		goto unlock;

This lock is redundant, you could just put
  if (mcled_cdev->sync_enabled)
    return ret;
before the lock.
