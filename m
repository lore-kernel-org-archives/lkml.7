Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC0EC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC6D207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="0wFl8U6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgAFQGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:06:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43645 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgAFQGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:06:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id 9so36721443lfq.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 08:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Hm+N1Mfv4cvEt8AsOyDtrwsor+OkWnHkb2xIR+PFvE=;
        b=0wFl8U6vnb/amTRB9H7VChfQh2usnHN4k6f/dsIR+GRPdketwrRkBZ6zxRFv/Iy6Vn
         cVP0zQv/M5i47wcGbuYZ+skIBGKxYxdP36SknHyhILLUKJRXVoNwFAtjW2h/ZQAk+B/i
         nCTfm2vDxpDljMl2xFjLuSYIP7FTsL8NvoTlHeKcS6t86ayC9UvMEMPnRNzJKXTGTQL4
         rH+chiO9gAVkJV1PsUIuBAn2F6yETNSqOyzVMT6xzviC++6r2lwbUkTiDZrYRhD+cHzy
         k7YXwTB2aNpqMw2/3Fz2GycYAEIF4bMMRJ2wh0M1G4EEGL9YdWvJgueuVrgddLjyo3fy
         sz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3Hm+N1Mfv4cvEt8AsOyDtrwsor+OkWnHkb2xIR+PFvE=;
        b=lrwG0EnbQrZbH2SccXSxAl8Crls7i3YN9//ML1bq1V8wyUvGYHI33RUBtQY7ctF4mm
         JaRakKVVe8yI8+wHhG8oYBU6cliTERkNKAeDf+0I+UvjHOWvzA0XijiBDV4hUC4Yyo/3
         dfdhGSMWUnzNRwHCpr77FzWPxvQvAxjDkIp7Xa4MqQzyWiqzE/aM/oDff3adK3k7e94u
         JVjffYjlZS1uw4oy+ZkW4yPF6F7tHpBtJNFXjz+Fytw88ZczdqJ/ao5ZmDX5oOH46A9+
         kz6yY6lEkuJkO4rhFGxvSKEdIJWTycfe7J8dNVvv5MRAUSIEcln4F+bdwe/6IYiif615
         5brg==
X-Gm-Message-State: APjAAAV042Cl1BdNbEhKVwc+6JONs8gakly9BRR5ekItl8k1y+MHds5d
        jBnk95ZXb9cwGNtrIXe45sTuLPiCtiNcsg==
X-Google-Smtp-Source: APXvYqzVSIjqm4qAseu8cComyUZgjNefdGBqk7/YYwSKdRakaxIfT54mr9Nz6+Y1grtbJ1+gcKmMfw==
X-Received: by 2002:ac2:5604:: with SMTP id v4mr53198337lfd.152.1578326768489;
        Mon, 06 Jan 2020 08:06:08 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4253:5f51:223d:4ed1:dff6:3b2e])
        by smtp.gmail.com with ESMTPSA id u3sm29142343lfm.37.2020.01.06.08.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 08:06:07 -0800 (PST)
Subject: Re: [PATCH] usb: ohci-da8xx: ensure error return on variable error is
 set
To:     Colin King <colin.king@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200106130609.51174-1-colin.king@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <2c3b944c-6d31-ec50-234b-c203460ea06a@cogentembedded.com>
Date:   Mon, 6 Jan 2020 19:06:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200106130609.51174-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2020 04:06 PM, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when an error in da8xx_ohci->oc_gpi occurs causes an

   s/gpi/gpio/. And you missed a noun between 2 verbs.

> uninitialized error value in variable 'error' to be returned. 
> Fix this by ensuring the error variable is set to the error value
> in da8xx_ohci->oc_gpi.

   oc_gpio again.

> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: d193abf1c913 ("usb: ohci-da8xx: add vbus and overcurrent gpios")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
[...]

MBR, Sergei
