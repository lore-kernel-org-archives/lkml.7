Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E71CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B4720717
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l0vYPah4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfJ3IDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:03:24 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40501 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJ3IDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:03:24 -0400
Received: by mail-il1-f196.google.com with SMTP id d83so1297075ilk.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 01:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LqFfQlPX22DAu2QQKOl89RuFCVvQ73FaW2DTKQWr2N8=;
        b=l0vYPah4wTPHZJawmtrZzxfnbMqWFBruSBwhoiny920aPMawcP0qvwMdz1Iq4oFErF
         xhPdAV7/ACTUz0kzQ8zLEK0ew+LW6WfVr/H8baxdy74XaeMmmHoETP2Ccr8njTUF9GEe
         j+zarkmIt+fjLDEGBUpbPFSLhNWVSGFlsoFIDd0OjC1EmVjwlGGsEWJVto0FV/3TghiL
         X3TxeawS2Ztx4xXuKyr8KZ1OMhY4D9UScHs6q5OxIHT6w8KvR+BTFc7tz0tVJELa9qbB
         tiutiEhaJFU51uN2IxAZMUtWhPUh+w4flEpmviaG3gFIwvB/Jy3Pu/IhyD1fECCkl2QY
         lSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LqFfQlPX22DAu2QQKOl89RuFCVvQ73FaW2DTKQWr2N8=;
        b=FakEct0jxx/1Az4zpmUYqDI1TNNGpEDC/oGBzPjapWbOBgfUHTu22HRskePLDGCnH2
         JXX5NSR/kmsrr40nbcNnW5BG4HuFTMBX8OYz08s0JP0IQ8jTCuIF+WaYfTMK/u0b6C+j
         35afDo4ireoOSVZilhp/YZWCRCPgo5q6xNngui1bdSI1mEt42ydpmETk9dMTwp90JRrr
         Uip5XN7lkreND5MjryLzGpeJSSOizqJCvWdz8rOnzkCR74rM8Tbycj2hfiT5JsadSN4U
         X7fQQcSFVgLTIFHzA4hLMdfjjsAsS6kUF5I7JMeVmwDzyqZ9Yh0ozsacz10ntVbz/2nZ
         XVnw==
X-Gm-Message-State: APjAAAWrsE3X7O+TiN1fXA20FplgzO3ygKap/ihLczxu2abVSmRkBZiG
        vgzANKof7KG2n4/n3LEWp/hHS5truCc=
X-Google-Smtp-Source: APXvYqwsxsTealkBSzXUDPGAKeJYeaYcUdHD/8GBgI8GmTRJS3xk2OHkmsBNyh1BSALOxYVarlZppA==
X-Received: by 2002:a05:6e02:792:: with SMTP id q18mr30146916ils.58.1572422603154;
        Wed, 30 Oct 2019 01:03:23 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id t27sm222986ila.17.2019.10.30.01.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 01:03:22 -0700 (PDT)
Date:   Wed, 30 Oct 2019 01:03:13 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Palmer Dabbelt <palmer@dabbelt.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH] MAINTAINERS: Change to my personal email address
In-Reply-To: <20191030043916.27916-1-palmer@dabbelt.com>
Message-ID: <alpine.DEB.2.21.9999.1910300102590.23683@viisi.sifive.com>
References: <20191030043916.27916-1-palmer@dabbelt.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019, Palmer Dabbelt wrote:

> From: Palmer Dabbelt <palmer@sifive.com>
> 
> I'm leaving SiFive in a bit less than two weeks, which means I'll be
> losing my @sifive email address.  I don't have my new email address yet,
> so I'm switching over to my personal address instead.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>

Thanks, queued for v5.4-rc.


- Paul
