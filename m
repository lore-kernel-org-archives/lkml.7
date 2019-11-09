Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BE4C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B4121D7B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmMZ4LJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKITDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 14:03:12 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:45699 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKITDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 14:03:12 -0500
Received: by mail-io1-f41.google.com with SMTP id v17so8835946iol.12;
        Sat, 09 Nov 2019 11:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3uHaDtX3ciBcivMZkabAXv4IXjFfi/2JONmJEnyS4M=;
        b=NmMZ4LJqCxJPLeBf6xArQxQsQO6ErVQt2cCjY8KBFH4G67+l3Rs9BQIoSxg0+jGZtn
         S9PimTEifbhD9esyvMAgH/B33bLdrdoMROuDwjFBhgRDNajMMGdb67tVcudkmgcx8Dqy
         zachBRRJJISEetvgkXiqXaI8qJNKV23z7IumoNOVt7O9FMOCfztm7MymFqSD4c2Ohy2I
         J1r8FLE9KhgngxCjl1lJdYbJAElwYiC3ZQzC7BCV7kx7CQ9raZYyYyljUD+ab3H7Aj3m
         qrUJZa/TcDLFaMnGY87hfRTVfuYj2lZws/nAdAoBwPKSyp/VqU3v31/4pCCTIHLRS8NG
         S7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3uHaDtX3ciBcivMZkabAXv4IXjFfi/2JONmJEnyS4M=;
        b=amu6kEw5DKbSdY97vKb68SCG2cboNv6165XkKa1f6jrU0W8xMrfJdOxY+hkXQgJalr
         kUWWl1FnSml14uUNi1t1R5B/IH8VqOtL6n8n/CGOVp+dwj4X1R3Mnrwq9uZT4KgWbUVO
         WGp9gIzMVi2yfBCD/FCIvEUG/sxLAtqJAAP/7gqIuutZsO4udFNhNjZ1EV0QEw+aZXrv
         dsZy2WVAFTiojrqTL7X1EKterIf7lch4anhRBB0QqSfNBV6Ru9u7B2IwNOl8ML6wtaDc
         beZv7a4GuFY1L4FZ9gLjtKHqmvbuPnGXRW/T0R4PbvQ+eHGJFte8BYVj0UqZVPlNWO5y
         WdOw==
X-Gm-Message-State: APjAAAUEFBY4nT06rbOlpPkX5dDYg7EGX92ce7ZhJ/Pb3qtBPM5Kzcxd
        627SDKal3Y6eBUwM6HzIw0H/T9HfQTp89uwUXcr5Zg==
X-Google-Smtp-Source: APXvYqysSrZ72Erb5fCqguE49DVsPOHz3DVQqqKIfKDGobud5hSXqtOseYG12YY1l4VIkPrWU6fShOm+jo8x57PN2XQ=
X-Received: by 2002:a02:694e:: with SMTP id e75mr17973550jac.85.1573326190136;
 Sat, 09 Nov 2019 11:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108210824.1534248-2-arnd@arndb.de>
In-Reply-To: <20191108210824.1534248-2-arnd@arndb.de>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 9 Nov 2019 11:02:58 -0800
Message-ID: <CABeXuvp7ZR4kdUOUZEKcMnQP2qHNyNzbhZ9UoM2r4wp+C7xoZQ@mail.gmail.com>
Subject: Re: [PATCH 02/23] y2038: add __kernel_old_timespec and __kernel_old_time_t
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>
