Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88669C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C20620679
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ACsdhTQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbfJJFhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 01:37:35 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:9645 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfJJFhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 01:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570685854; x=1602221854;
  h=mime-version:from:date:message-id:subject:to;
  bh=Xy0xPpkULCnt+hL55gCdlyQRWZEjRD9Fr0UAvbyShXo=;
  b=ACsdhTQFg7zvT7uH/+ezLE1Qu11jrDTiX2z6+84F16kXMqhK07soEneT
   7F0dLjeZE8tdoNts/3sE9hX7PvqD3G6wYjTyKtMGhdInWD4+LMP2Wz+vy
   Ln2MVkr1/A29N2ZF2bGSe5bVEmV5ewexsno6ESF7fgf2QUeT/tcf10SVw
   U22hMcRagKvd0/l9726jb9q/x6pDdoD/PLwAJ5cKv8izYXBVvmonVoRjn
   z/U1CqDcZo0VQ5QYaDZbuz1mJHju3++Fk+QHDOYdUmoCj/0uxkmk3v+O6
   7rsCR8Qnifn0hC8Zaj9jOfZnBGO1C4cGd/ggfAPOYjDtrtWixqkJ5A/9H
   g==;
IronPort-SDR: yNyCvjYRjCeD0NrapQTiyTN0iPY38/TCVRgfwnYT+vBo8ER3BBTypS9Uwbfeg5pcDr/Z6YMLpR
 lToDe/3Adb2owXp/juZ3SmSBHL7W0QdIOsYXEaIkOzM9j4GC3Re2EyZFK+1J8InAZOw7N5+2Za
 27ntkCgTSx+mwqr4OKAjVJdxniaEt4sRK23YcBKElPHBKQWM5iIZ1gS8VfW0Tm3PasM/HQn3/z
 SjcmOkO9MzFhqBQQXPISQQa1gYWJsypbUIIJ/NBFFjpk8vJpWj7SdlYmZOipry9/5P68StG+Of
 4Os=
IronPort-PHdr: =?us-ascii?q?9a23=3AmwjKRBWsxB6wcGcqKwX0pV7+6lvV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbB2Ht8tkgFKBZ4jH8fUM07OQ7/m7HzJaqsfR+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLt8Qan4RuJ6Iyxx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipcCY2+coQPFfIMMulYoYfzpFUAsAWwChW3CePz1jNFnGP60bEm3+?=
 =?us-ascii?q?kjFwzNwQwuH8gJsHTRtNj6NqYSUOG1zKnVyjXIcvBZ2Tfn54jJbxsspvGNXL?=
 =?us-ascii?q?NwccXLyEkjCx/Jg1uLpIz4IzyVzP4BvHaG4Op9TO+ijXMspQJpojW32Msglo?=
 =?us-ascii?q?3EipgWx13E7yl13Yc4KN+iREN5f9KpFoZbuTuAOItsWMwiRnlluCM9yrIbp5?=
 =?us-ascii?q?G2ZDMKyJE7xx7HbPyHbpSI7grjVOmPJTd4g2poeLeliBaz9Uis0+n8Vsep3F?=
 =?us-ascii?q?pToCpIkMfAumoC1xzU7ciHRf998Vm71TmT0ADT7/lIIUEylaXFN54s2qA8mo?=
 =?us-ascii?q?YXvEjZHSL7mF/6gLKXe0gm4OSl6frrbq3jppCGNo90jg/+Mr4pmsy6Gek5Mg?=
 =?us-ascii?q?kPX2iB9uS9yLHv4UP0Ta5XjvIqiKnVqo7VKtkGpqKhGQ9azp4j6wqjDzehyN?=
 =?us-ascii?q?kYmXgHLFRYeBOIloTpOE/BIOr+Dfihh1Shiylrx//YMb37GJnNLWbMkK3nfb?=
 =?us-ascii?q?lj705Q0g0zzcpQ58EcNrZUBfvpWQfbrtvHCFdtORazxODmBf1+25kYVGbJBb?=
 =?us-ascii?q?WWZueatV6O+/JqOPGNTJEatSy7KPU/4fPqy3gjlhtVeaivwItSa32iGPliC1?=
 =?us-ascii?q?uWbGCqgdobF2oO+A0kQ6iiul2DQCNVL0+zVqR0siM7CZO7C57rTZvrnbebmi?=
 =?us-ascii?q?q3A8sSLktGB1aDAGqgTIKCVL9YYzmVJMBJmSdCSLO7DYItyEf9mhX9zu9WL/?=
 =?us-ascii?q?jU5ypQh5Lq1ZAh9v/TnBBqrWdcEs+HlWyBUjcnzSszWzYq0fUn8gRGwVCZ3P?=
 =?us-ascii?q?092qQAGA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FRAwDEwp5dh0inVdFlDoZEhE2OXIU?=
 =?us-ascii?q?XAY1pijQBCAEBAQ4vAQGHGCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCm?=
 =?us-ascii?q?FQII6KQGDVRF8AwwCJgIkEgEFASIBNIMAgnikLIEDPIsmgTKIZQEJDYFIEno?=
 =?us-ascii?q?ojA6CF4ERgmSIPoJeBIE5AQEBlS+WVwEGAoIQFIxUiEUbgioBlxWOLZlPDyO?=
 =?us-ascii?q?BRoF7MxolfwZngU9PEBSBaY1xWySRSwEB?=
X-IPAS-Result: =?us-ascii?q?A2FRAwDEwp5dh0inVdFlDoZEhE2OXIUXAY1pijQBCAEBA?=
 =?us-ascii?q?Q4vAQGHGCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCmFQII6KQGDVRF8A?=
 =?us-ascii?q?wwCJgIkEgEFASIBNIMAgnikLIEDPIsmgTKIZQEJDYFIEnoojA6CF4ERgmSIP?=
 =?us-ascii?q?oJeBIE5AQEBlS+WVwEGAoIQFIxUiEUbgioBlxWOLZlPDyOBRoF7MxolfwZng?=
 =?us-ascii?q?U9PEBSBaY1xWySRSwEB?=
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208";a="13447400"
Received: from mail-lf1-f72.google.com ([209.85.167.72])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 22:37:31 -0700
Received: by mail-lf1-f72.google.com with SMTP id o9so1078252lfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 22:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vkLjkXwl3hWsyvy/ZQWrrN8uTBfkFbAgqdrjHxTVCjA=;
        b=nWTp/4XAvjPkZd4RXKXX89ct3ktn5F7tde7VJ46t3c75lhyNXEezGM/vi07BTYY7JQ
         gFmJjysTw5Mj2ODvsbX/xOi3CIQal0Pq+L6MOw00W+KpnnnSnPIyXLVpR5eNeCrhJNs8
         ///tgYDaGHdSqf7h0kgKw/AbwsHdukHvEZT3rO7nsHZs2/bdxSdxNPRKzznQi1DUeVkl
         gEvz8fQ3nJcW2P0WyBsozPbEtWYgNobBqg7b3TAAWu92n1T/HyrnJnwXk0RPx+Zc4c1O
         VxnSDCc3qkZ6tf9ixrZnNMnCy1BXttUs96jDg2wdwf5o5rYHAwhhZk+rjtPV4o/kLWUL
         /lsw==
X-Gm-Message-State: APjAAAUJ1sthJoviNUsUSLnBuoDrSQ2jWzfoZ8bz8GI6HwB6s6JoVWWh
        G5JQp37V+dIcX4XNC6Q3XaueRyLc+CEazSTylk+iX4sirBj+G1UAZ49tGFZ7N6+24jjnC08+vuI
        fDoqS+gljmnXMWxKHtmdq8cwoO9vQwVZ/poYvX7cpyQ==
X-Received: by 2002:a2e:6c0e:: with SMTP id h14mr4946620ljc.92.1570685850188;
        Wed, 09 Oct 2019 22:37:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBa7eGL1/6qnPzIY6RKFJAtUZRnNcZZsQw99WnHp6fw/68G9kF7paHHurL0HqgrVYHa5tUDuOi5ELJRyEjQXc=
X-Received: by 2002:a2e:6c0e:: with SMTP id h14mr4946609ljc.92.1570685849997;
 Wed, 09 Oct 2019 22:37:29 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 9 Oct 2019 22:37:04 -0700
Message-ID: <CABvMjLToYzmCue-TiDhR4Yu4v3+Z+-UV9WhixV7uvwoMh2m5Lw@mail.gmail.com>
Subject: Potential NULL pointer deference in spi
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

drivers/spi/spi.c:

The function to_spi_device() could return NULL, but some callers
in this file does not check the return value while directly dereference
it, which seems potentially unsafe.

Such callers include spidev_release(),  spi_dev_check(),
driver_override_store(), etc.


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
