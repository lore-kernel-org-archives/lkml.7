Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A882CC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE7D206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbkorQp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgAGSAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:00:50 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:36958 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgAGSAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:00:50 -0500
Received: by mail-io1-f53.google.com with SMTP id k24so268072ioc.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 10:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=z+bvT+/ytTL9caOk5nOSZNgNPK5IXu1waPag5ni3RY4=;
        b=RbkorQp7Bk9GzvnQ3IytFbbLruz3TkfpGbrhRrPVtbM8+b6CbkYyTGswCLP6z/zbre
         Nx4ep+JnqjJGAaQriJ/9YWsabLjfbybEKvwrRFQbvgbe7TutqLlJS8fNOXMbwxVHHS0i
         g+e9O25Z6MHKpq6KQeBr0Pmh8ucQs07dez5rTBGivwQRhwki6ZMPieS66j1jcsM6P2xZ
         e0rIxpP77ybYi8lpZjACsXDnmlwYuI68bUwBgZoDRZuNqvCE7RkPSB2GTT2fl3HRzmQZ
         Km/8zTeeU9eFji0NfE8EVStH+yQzZjBfMC45xhEe36ROG+Q+NPmtC3zK6Zp/sfWVAumh
         nagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=z+bvT+/ytTL9caOk5nOSZNgNPK5IXu1waPag5ni3RY4=;
        b=CCATwul0dfI1YPeZHq5OH03Eyr1Z+bxrQ7W9haxUrQwGBNkUWOOmc1mn2tjSz9zzSO
         lseJud5wtRwOXVmsTbddP1ax32SwL5I65HD3xY8IL9esYpdLULck+AsvdWR1gXWstX9j
         Fm1eWooM/C05KNPnQoyY0nsQluOI0et1MKPBW9c71wIZwCFjaKDcuwbPnr7CpTE0WZZz
         px+Cv46HNx+r2aHg05hMFb+YeMUINfims+e2iT0zxipBkw8F6VA4uY6ukEe0Q8CmyWPa
         iM+Vd6PBByVdebel1BF0azPyc7MeBEBIOyh/gEttwc4/o3GtKzm69mUvPfrLsQQYgpQq
         TLiQ==
X-Gm-Message-State: APjAAAXkSPjL0B+WiUlz7Z30JBtSpnFZG6B4YbHb8fn8Q52WZW0rdKJv
        pUoGeGjuPJhgFbiLkC51C7Nv2bkyOeqCdT28xjf/9w==
X-Google-Smtp-Source: APXvYqxIj+1Bk9V+Rh0oBa0IhD+RRl3drp1/OaGgV+JZLeWgsfQWw345vaV54vIj550/goE0nWmEyYkbkI04TO07XT4=
X-Received: by 2002:a5e:9617:: with SMTP id a23mr93671ioq.243.1578420049588;
 Tue, 07 Jan 2020 10:00:49 -0800 (PST)
MIME-Version: 1.0
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 7 Jan 2020 23:30:37 +0530
Message-ID: <CANAwSgRXd=w87CKO4WQz7ZRAk+un7ctTPCi5XSa7GfNDhjy0YQ@mail.gmail.com>
Subject: rk3399 rockchip pcie power domain is saying unsupported
To:     Heiko Stuebner <heiko@sntech.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On my rock960 I want to add power domain feature for pcie node using
following patch. [0] https://patchwork.kernel.org/patch/9322549/
I also tried to add some more cru to see below
but the power domain summary shows unsupported

# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
...
pd_sdioaudio                    off-0
    /devices/platform/fe310000.dwmmc                    suspended
    /devices/platform/ff8a0000.i2s                      suspended
pd_perihp                       on
    /devices/platform/fe380000.usb                      unsupported
    /devices/platform/fe3c0000.usb                      unsupported
    /devices/platform/fe3a0000.usb                      suspended
    /devices/platform/fe3e0000.usb                      suspended
    /devices/platform/f8000000.pcie                     unsupported
pd_sd                           on
    /devices/platform/fe320000.dwmmc                    active
pd_gmac                         off-0
...
can any one share more inputs.
----
@@ -1049,6 +1056,19 @@
                                         <&cru SCLK_SDMMC>;
                                pm_qos = <&qos_sd>;
                        };
+                       pd_perihp@RK3399_PD_PERIHP {
+                               reg = <RK3399_PD_PERIHP>;
+                               clocks = <&cru ACLK_PERIHP>,
+                                        <&cru SCLK_PCIEPHY_REF>,
+                                        <&cru ACLK_PERF_PCIE>,
+                                        <&cru ACLK_PCIE>,
+                                        <&cru PCLK_PCIE>,
+                                        <&cru SCLK_PCIE_PM>;
+                               pm_qos = <&qos_perihp>,
+                                        <&qos_pcie>,
+                                        <&qos_usb_host0>,
+                                        <&qos_usb_host1>;
+                       };

-Anand
