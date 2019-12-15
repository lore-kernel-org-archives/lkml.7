Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2FDC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B9F20700
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="xJxXeatC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLOTcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 14:32:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44699 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfLOTcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:32:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so2389371pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=SD6710XuCGfLCRjEaTIYpMnkGtQ6zZzJk7TYgaQ/Siw=;
        b=xJxXeatCAJCU30I9wwZmedY0avOrIT77KoTok0JQ/JbFO9lmaK+0DfZ89kJwB0PnQH
         vuqLgph7k+ofwTsPyEL9u2khQekl5nD5+qrkeNIqdcOguBAfTjcQsMOuQ3Gq4fdzpp50
         2uwVakow0BOR4CG59dBrETZ2NnXytgiVlYinqOvoy8gANeId4a4KH7WxV1aHKvk1zbyT
         n7LuQeeW+7Y1v1j9HVLAbRjTt0poRRMSVVpQ7lsQUyZL86mK6mCiEzrioyaGxJT9Cs6H
         y9jM9vZnshGS8Ay/Xhicf9E5k0Kk7JKMW5CvYpLz36LKYETiZL81fF59+LD3MStjEGre
         dd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=SD6710XuCGfLCRjEaTIYpMnkGtQ6zZzJk7TYgaQ/Siw=;
        b=SWwyVrpL/30U+Mm4ZUvs9PxsNq2U5KVJZzIdQdbBgAzCemIYIBcuGjX1GjbeGEmTEt
         Isa2j7zO7UfKi543DSLqB4gc4pn4ZpjFVOusby3eT5cGjwKiY7Kn4Zid4rWOLIA0DcgO
         xqPAhksRZnW6Xw4qyCE2F22306Xln94x2K5K1tr1k0TRW9azn88E1ocE3pplJqb70pQj
         NPd01nB0cPborfEAqYnFM8+ic5dt3cqICDApgb/w2LgINmm+EPZEgSdbaED3q/zKc3bY
         Y2puN29lFvfzzQsL9LQKbZAbXlUvB1CZgChDH7FsCHYpsY9aZdJ2qMtzpBBjilW8anD4
         DExg==
X-Gm-Message-State: APjAAAUmRUWl5Q/7Lrp1Rt7dUtSZ5J6yQ7GpIaLyRoJgWw2oj0kSqV21
        21GrBpNFgN2+RovXWxywXaKlww==
X-Google-Smtp-Source: APXvYqxYeiVnRfIk5g9EJ6vrTN8Y+jTHPgtnkXSmDuJTA/McKpsjUR7LQKN3ZfU+1S+Sk+mQAszwLg==
X-Received: by 2002:a62:fc93:: with SMTP id e141mr11845222pfh.262.1576438331400;
        Sun, 15 Dec 2019 11:32:11 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id d23sm18846406pfo.176.2019.12.15.11.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 11:32:11 -0800 (PST)
Date:   Sun, 15 Dec 2019 11:32:08 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Cristian Birsan <cristian.birsan@microchip.com>
Cc:     <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: usb: lan78xx: Fix error message format specifier
Message-ID: <20191215113208.7378295b@cakuba.netronome.com>
In-Reply-To: <20191213163311.8319-1-cristian.birsan@microchip.com>
References: <20191213163311.8319-1-cristian.birsan@microchip.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 18:33:11 +0200, Cristian Birsan wrote:
> Display the return code as decimal integer.
> 
> Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>

Applied to net, thank you!
