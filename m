Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573BFC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 23:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0B02070C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 23:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mikemestnik-net.20150623.gappssmtp.com header.i=@mikemestnik-net.20150623.gappssmtp.com header.b="jz7FdW3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKTX6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 18:58:08 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:46834 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKTX6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 18:58:08 -0500
Received: by mail-lj1-f174.google.com with SMTP id e9so1053717ljp.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 15:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mikemestnik-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uf3bBP1zTG40dRn3CaFvDBdOr8iUrpSEhnbpICpCTrI=;
        b=jz7FdW3BQwMjpxllSiid1nNUzpiNdYM55fHleeccu1EIV/lXYVQ3ERFKUr6K0OD6EN
         okgbAgNks4YdZFjC2264apc5qTMn/qAAPZQR9TOz2XLB96C5IKf7UB067DWFspNr47yM
         skDXCedd77S41KCos5sf5efxnt3koq4QJAkU5Xvv3A9mAkd3pj9O7Av1vCC10qE/W1E7
         qg5T4FHMlN7EI2L4atrPHLnSZBvaMoC9Cd/ifzyPEw9e8KwUIea8Bylm4yMDOqNlxkTC
         /Au+8kaKb+j5zSahW9BgnUyZdAUYW2ZzvnV4VPbmzHFCsWKwv5cQdegI6ELxbqPb3bvT
         7RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uf3bBP1zTG40dRn3CaFvDBdOr8iUrpSEhnbpICpCTrI=;
        b=izMFJEOL4PFFwcIkYsnydOweC3QmlUwKtCYoHNRqigu9DO1UOxfgGLYDrUT+2HFHR8
         6GfOxgqoWb+mKTaGNZjYo9JUDXyUYDPaFcyMbY7UBoD5UyQtggdn/rNY8XLyuH9ozf4p
         KNgSdge5iufuqPWE/MFzxdbIZV8ZjUuzyoFWbmMAEOSLi2SLtdIfG19HenM+oXUmMtQ4
         t/Istol57ean6OXv23+CR0cbMz4ENnEqTZ1ubSxV7Ow90sw3hs+plLY9oDnxzA1xM3z4
         oXfTPF4Wi71JG0NjbTWvQOapg4qj1P6PQef7f3r7dHA7VPOI9hagAdtqBh0mkWYU60V5
         sMtQ==
X-Gm-Message-State: APjAAAXSjY+TwyPR1z7m2j8uMToWo3Nr5eLRTaOgYM8hxIAnse3BQwqA
        BfgIfPW0PBwdZ5GxGb3rbXtQd+L81eikHkTnRELXLsMZ4lI=
X-Google-Smtp-Source: APXvYqwUaEjkaZiKkkh3P/R/d22CzADms8GUjVzTNGA9gZIwE/F7121oUTRYMmGEIN2+LJ0YcAz0c+4A/1QVJgEsKMw=
X-Received: by 2002:a2e:7607:: with SMTP id r7mr4968197ljc.37.1574294285469;
 Wed, 20 Nov 2019 15:58:05 -0800 (PST)
MIME-Version: 1.0
From:   Mike Mestnik <cheako@mikemestnik.net>
Date:   Wed, 20 Nov 2019 17:57:54 -0600
Message-ID: <CAF8px57gwjwLzt1cRvogEzOUV3LyXaD7_xjuZU28D47oWs3cKg@mail.gmail.com>
Subject: Lenovo E585: Device RTL Bluetooth, O2 sdcard, and rtw88. Broken or issues.
To:     "debian-kernel@lists.debian.org" <debian-kernel@lists.debian.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://www.mail-archive.com/debian-kernel@lists.debian.org/msg116401.html

Today I learned that BlueTooth doesn't work either.  I looked at the
FAQ a bit and I realise this is the worst way to initiate discussions
regarding broken drivers, but I believe these issues together
demonstrate a systemic problem that should be addressed.

I've identified 3 drivers that are completely inoperable on this device!
