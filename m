Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5B2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C886620862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LPkie/+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388595AbfJCUZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:25:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44162 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388208AbfJCUZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:25:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id q15so2019992pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=KLlIoah+11WNLI7tRGDU9SjlPuD7QWpbTf5lcunsEHc=;
        b=LPkie/+xxlB4rT5PTiQ1eDCf0mu01pLM/ELzmiZ83YEqt6ip7yplZ80N4qSI/+wW+H
         QX08bofMKDuVQE+docytein2e6CLHfdn4ATCylT/I56xMs8QEWc/bRnESx1cgwVjz+/M
         mplVBgY2LOVn9MJC7OZ1o3KRHmqJ33N/WuAV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=KLlIoah+11WNLI7tRGDU9SjlPuD7QWpbTf5lcunsEHc=;
        b=TAW4LsbLa22y3aiA5Cj4pBzpLHD2ayOO0YzGzEf3bDOrSxgSnNoeH6tN/3GLIMpi3X
         1TP29JJXacbRJZm1hIt/jLbkuVPG2A2xlHdt/Tdd9FsSY+cOWVmSInJSUIUjBdPP+UIN
         kUkXb2fIryPg4gJOZH7JUIr6kze4FeZWvDxbHn7SjSfgEGnxUrLkLFYgf1Q6k4RI2fxe
         /s0XQtrFD4GGUYJRGk/1kiPtnKBVALz+cIDdrbGd386gDcFziUFsijNPtC14o7jf0nVR
         6YRC+v889ylggadzkSOiemx8Bov72RlJAKDUFZqzx2ZRXeTtZD+GcMXRjbcqyrK0yNFY
         2C6w==
X-Gm-Message-State: APjAAAXxOq5sZIPqHr9TeO7FkDML6JqxuU6pyQrDnpLA8dJJUPvc9m5d
        hBEczlmp9Cj/Cpz7EJ4Px0IxiQ==
X-Google-Smtp-Source: APXvYqwuYaxcD0abXlJ6z9Sw8JipRNWop1dSY3B1qsyhjuysv4y+JbkXu9rI9FD12OHjiA0TACGMIQ==
X-Received: by 2002:a17:902:ac8a:: with SMTP id h10mr11445338plr.170.1570134310869;
        Thu, 03 Oct 2019 13:25:10 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z13sm3901582pfq.121.2019.10.03.13.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 13:25:10 -0700 (PDT)
Message-ID: <5d965926.1c69fb81.6d844.cdc4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <01e3d855-c849-ad7f-a6f8-87c806bb488b@redhat.com>
References: <01e3d855-c849-ad7f-a6f8-87c806bb488b@redhat.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org, youling 257 <youling257@gmail.com>
Subject: Re: Problem with "driver core: platform: Add an error message to platform_get_irq*()" commit
User-Agent: alot/0.8.1
Date:   Thu, 03 Oct 2019 13:25:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hans de Goede (2019-10-03 13:20:24)
>=20
> The best solution I can come up with is adding a new
> platform_get_irq_byname_optional mirroring platform_get_irq_optional
> and using that in drivers such as the dwc3 driver.
>=20
> Does anyone have a better suggestion?
>=20

A byname_optional API sounds good to me.

