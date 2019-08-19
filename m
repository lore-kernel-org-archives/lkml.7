Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43252C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196922087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="YdC/NSNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfHSJa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:30:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42958 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:30:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so1136602qtp.9;
        Mon, 19 Aug 2019 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JFfcd2aWnD63uHxrGGrBMx20FuJCpjkBSuAwl0BDHEA=;
        b=YdC/NSNaLxX9MHpFGBgW6CU7EZ1XTRHLmAXFhRSy5ehgbthqvmQcm39HaAi5OGQIHb
         0eNSjYbbqlfjSDyujt1P0JDhw5rMV0WiECJiU3e+T6uleOoDaWmni9BMy+03LoVqVVsj
         Ghzy557/dBTOuqxVM7ewVAsTXoDhI/4lBqwIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JFfcd2aWnD63uHxrGGrBMx20FuJCpjkBSuAwl0BDHEA=;
        b=DBiiP9SRZTGLG7RXHvse/H6i1zcfU6U6BS84oLGOlRG0pzqX9L4noSDTEaZ4/u2gVU
         AkBO6h1rmMSO8dWF1Dp1N8iY5PhEg950J/rLO7/9Z9grPTGqG1FRwz23zKK2doSEHMO0
         zhC3Rz+6VYTqkKWMzs5mOGTzut6lSxQUyowI0E+BVGD5fPu7TxTdQqlYPBaZptS9R4V2
         gBlKBTCUZZsVUZrSWOsCsRui8GkQbYVkIgJD6/Ipf/Wq4kARNdxlvEgVDhcTVc/uT4fX
         L3NHSUsWsEJ4ClU/6psRfIY9arZtlHCSai+ogiyJqsmSzpF5aNKa3m+HBV9r8Ee6xF17
         Qm3w==
X-Gm-Message-State: APjAAAVMDBUiIs84mKU2ndRNHgo3jsK/vTYDpspNw+LL27qMUvizNk85
        Y3UPMmTAAu7RiqPQQKXZd4+fxc96xS1k0lYvrAA=
X-Google-Smtp-Source: APXvYqwdbyD050l1JQMNhqORypwCwlewcXrshUh6xNe/3T/3iFa5hXDqHmKkUkqt20f7MbKR1wov3rIhLLbsktfmLg8=
X-Received: by 2002:aed:3e6f:: with SMTP id m44mr20030489qtf.220.1566207056483;
 Mon, 19 Aug 2019 02:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190819091509.29276-1-wangzqbj@inspur.com>
In-Reply-To: <20190819091509.29276-1-wangzqbj@inspur.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 19 Aug 2019 09:30:44 +0000
Message-ID: <CACPK8XfAAU+x8d+=7ALDAUSynLG=8KUWD3zDZqaHRnh5pajDKQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] hwmon: pmbus: Add Inspur Power System power supply driver
To:     John Wang <wangzqbj@inspur.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        duanzhijia01@inspur.com, Lei YU <mine260309@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 at 09:15, John Wang <wangzqbj@inspur.com> wrote:
>
> Add the driver to monitor Inspur Power System power supplies
> with hwmon over pmbus.
>
> This driver adds sysfs attributes for additional power supply data,
> including vendor, model, part_number, serial number,
> firmware revision, hardware revision, and psu mode(active/standby).
>
> Signed-off-by: John Wang <wangzqbj@inspur.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>
