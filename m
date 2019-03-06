Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6217EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1CD20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfCFIC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:02:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38618 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfCFIC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:02:26 -0500
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1h1RVQ-0003e1-7W
        for linux-kernel@vger.kernel.org; Wed, 06 Mar 2019 08:02:24 +0000
Received: by mail-pf1-f197.google.com with SMTP id 134so12551509pfx.21
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 00:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=cipbrFOBC38SCv7vqFs9/49tEvuntRddjTY4k+RrhJU=;
        b=OohgAFlX5vVE5RMJvRgRV5wBYGtxU3HEI26wxdw4cgHCfuj4WRHCbgfV4NxhfdsUGw
         1cPuJNeAi0xkY+Bw7kaRZf45ScZHhZBsXCJX+fvHEhhfObLodQ5S3+vPfePPHuSElQZi
         pkd0wndLSZsT5GurOE62zfWb/rVyTnSBY2ElkJzlemkjrYtqKS9BaqLiuqOZatXnrzcs
         3jtI9V6ck6pjd5yXlzJELqD5zIaTqMV6euNwf1sQw+eXtLLnIvva88Xef25HhqlTphYf
         pf7vdDzQf4r1KWzUFpdMV/SI2NRcSTz6j7zse+iqF+5f9fWeex160HY8Jn55ojfqdEDj
         DLCw==
X-Gm-Message-State: APjAAAVlzALJE4J6upsQ2x5wFFIqIHVASWuysoVYCgJOW8GxFPLv2wZn
        iJaq48ae+eGbXs7WMDX0PJ80G1RL63U3L4Ed4inDMm4/HHPYJK6pANwJTJ92zHYCLrQfaH77Wrz
        sVtvNvk1yymz0fsH9ZYISTkM60MzSWYr4cJLabRSqMg==
X-Received: by 2002:a63:2c87:: with SMTP id s129mr5104978pgs.311.1551859342865;
        Wed, 06 Mar 2019 00:02:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqzY/57a9oAlkYNYvNF5jgobcsl22xwUDNfCriPJRfngE9MTcobgHas1CZ1Ur/DU3bmLOCOk4Q==
X-Received: by 2002:a63:2c87:: with SMTP id s129mr5104951pgs.311.1551859342559;
        Wed, 06 Mar 2019 00:02:22 -0800 (PST)
Received: from 2001-b011-380f-1636-648c-29d6-37c4-0f13.dynamic-ip6.hinet.net (2001-b011-380f-1636-648c-29d6-37c4-0f13.dynamic-ip6.hinet.net. [2001:b011:380f:1636:648c:29d6:37c4:f13])
        by smtp.gmail.com with ESMTPSA id j20sm1800398pfh.141.2019.03.06.00.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 00:02:22 -0800 (PST)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Intel ISH doesn't generate IRQ
Message-Id: <C416C03D-EFD6-4C03-B04B-9E9FEA57F493@canonical.com>
Date:   Wed, 6 Mar 2019 16:02:19 +0800
Cc:     hong.liu@intel.com, hongyan.song@intel.com,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an old issue filed at [1].

Few days ago I noticed there’s a new commit 74fbc7d371d9 ("HID:  
intel-ish-hid: add MSI interrupt support”) that may solve the problem.
Unfortunately it the device in question doesn’t support MSI and MSI-X, so  
the commit doesn’t make any difference.

Please let me know what additional information I can provide.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=200775

Kai-Heng
