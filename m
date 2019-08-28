Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB11C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF4B20679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="WzCFTqXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfH1XT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 19:19:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46382 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfH1XTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 19:19:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id z51so1796745edz.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 16:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=M+altPdUhJXeOTwHA/oSnIsndgm2Hmqt8quJCF+sxbc=;
        b=WzCFTqXfFkywaGuT8K4gAg5rA3m05yrJhWcL3uNHs7TQEHC64XLGOH3p0KU9yPvVMq
         kTpzlVn9Vs13K6FdRPi4V0bUOiMxvklXizkiAPwJZv+Wn/Zbcaq3oonB5XtdMeacvw8Y
         xEOkSJkBrtqXU3v+wdu5IGZJJe+6uOPxj7cv+pgZICiZQTud2rhyo8EUe6f+OctuWSjs
         zDWZJH4YImndwQUNzX3HD70AqZRR4x7twtRqwue/5+0wO6z8mTieCark4wFzI6je+67+
         f4hDKZzOwmTZPBlfFfBb9q5igpart7Yx9Asjucgx3SmDMpjcUwNYW74AVS3AgfngiNzF
         U50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=M+altPdUhJXeOTwHA/oSnIsndgm2Hmqt8quJCF+sxbc=;
        b=YXSN1IT55oT/oo24E6SuZXawvSARfUE8dE4AWIfzU5J9kc7puSx6ku1wTTHWByxDbc
         4FO1fn+zNr20BxEZV14EKi0Ej95Akidn/o6VeHhzEnk2MGU9XgOOLUSf8PxgXR2/iKh0
         q6urv2F2CdHkfegfCbBiK9EgNIqxbxdg0nB0OPasRZP6cGYwrATimJURldG8aU+Fe55a
         ek3irDLS2K9BuEy8zpZj0JkNceXB/XUGBhLPNlrchau3wup5+LBBjGmhiTWfzfWbRdVU
         MVVYOwREGwj5oiuS5xijIgQbfJmi9lVVJBCj59vFFvg8ZSiI2tAWEb7H5egAMwQeFgcz
         P4FQ==
X-Gm-Message-State: APjAAAVtQerDD+I2c8vT2i69DX1y5XIw3PJ7u7ZlxynGFwC5OtmCVjYK
        Nk63dJL1II408IrJThVKRAh04w==
X-Google-Smtp-Source: APXvYqxCHpyV+rsCxYbI2mAgGsXNwr5OfEHodnscKaidhDW/FKVB9MkvcPQOD611LZru5nvF1mWwZg==
X-Received: by 2002:a17:906:f742:: with SMTP id jp2mr5333218ejb.87.1567034393780;
        Wed, 28 Aug 2019 16:19:53 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id d20sm107011ejb.75.2019.08.28.16.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 16:19:53 -0700 (PDT)
Date:   Wed, 28 Aug 2019 16:19:31 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 00/12] net: hns3: add some cleanups and
 optimizations
Message-ID: <20190828161931.1789697d@cakuba.netronome.com>
In-Reply-To: <1567002196-63242-1-git-send-email-tanhuazhong@huawei.com>
References: <1567002196-63242-1-git-send-email-tanhuazhong@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 22:23:04 +0800, Huazhong Tan wrote:
> This patch-set includes cleanups, optimizations and bugfix for
> the HNS3 ethernet controller driver.

The phy loopback (patch 10) could probably benefit from an expert look
but in general LGTM.
