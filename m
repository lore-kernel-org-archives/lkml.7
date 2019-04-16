Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32E4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20CD20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfDjwpDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfDPULi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:11:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44200 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPULi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:11:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so10926005pfm.11;
        Tue, 16 Apr 2019 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VgFA+NwiGZKsjD0Mje6JhM0ByXT3ane4YHJ0ByAhMOk=;
        b=VfDjwpDKGU/NqWB127z7ezXZXTJFyg0Fzpv8mhn6YkH5OEmDT9/FjYXeJ/yBhQrCsv
         BKya9fpsxuIXu6UHj4pe2pAzODgziDF1cOmXqc8YPVptlyZ/wgSpg9rQCPJVOrl/MVO8
         QY1PnXt0wKsp/LJ01jiYypy0WNmO+rQStQQJdA3299Cev43a99VS4TOjiT9LKHYIrNyX
         ISn2kmMnK6bfmYCtNeKSM8UWyrcUf9l94t9w1wgUnedlaYRZQztYwPPku5TOzbZ835FZ
         m4aveOrqH7El+QmzshuLhP03O+O3jZ5gp2Okgozis8qofBkfN7qHVMihUKt2+8izYCOq
         nChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VgFA+NwiGZKsjD0Mje6JhM0ByXT3ane4YHJ0ByAhMOk=;
        b=ZBfhw16DPeR/NeWtauSwtdwkE66gYODkKbjKnRMS56yc7EIEbfdyGvK9Yk8kmb4hn7
         gE0ReMoJLLWouzkm+eCeL9W/wIWniefsfJYBrY/JKVCWPwtb8CBEOSYINFHBJqnsjr+q
         C7eIO+j+Rbm4nEuvEBFmEkdw/3hZfvh8vK/zWzlCRS97Z5Yp+pdSuYyUDT8Kja6EDefF
         vKU1SRIvkf0n7yIxHKm6l/YqTNTkM3Xgvq2QX0zDKswjSGvU3UXFpeouEOnPOVBARIs+
         7wZGW4A7MaqDgOU/Xxzh7FYcCnZRPnwHyyhE49L4tKRVwxksBMUJ/zOsvzuNPR1rMs/V
         enug==
X-Gm-Message-State: APjAAAWqLkcgx+StoLqCLxlubi7hM91ZGRV88ODBToE7XIfODcON2sF5
        p/ECHYBroGy0NVdiJ9UgZTY=
X-Google-Smtp-Source: APXvYqzaHKm+5kF92NoD9yNTu1KBI5PWOc+1RyFZDC0ceVay/GjtmsduQCo/PgtB1TG8mBY+7b7tRw==
X-Received: by 2002:a65:6259:: with SMTP id q25mr3642915pgv.103.1555445497291;
        Tue, 16 Apr 2019 13:11:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j62sm59623439pfg.6.2019.04.16.13.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 13:11:36 -0700 (PDT)
Date:   Tue, 16 Apr 2019 13:11:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (ina3221) Add averaging mode support
Message-ID: <20190416201135.GA25166@roeck-us.net>
References: <20190416194131.29560-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416194131.29560-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:41:31PM -0700, Nicolin Chen wrote:
> The CONFIG register has a 3-bit averaging mode field for users
> to setup the number of samples that are collected and averaged
> together. This is very useful to filter noise from sensor data.
> 
> This patch adds a 'samples' sysfs node using hwmon_chip_samples
> of hwmon core, and updates wait time calculation by taking this
> samples value into account.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter
