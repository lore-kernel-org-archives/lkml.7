Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B222C3A5AB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5698322CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567583212;
	bh=rEMdR7knPCpbyaPsNe8NkXOsK7TFTFWjjBIahM2FlVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DXjdGvoRN5LNKEbUedd0XMm8QdYN2bBqRrqp1W17+z2FPMtAs6ztqtdg5Xin1Eo+f
	 ZYoEuCfce9HZR+nLM60kA8Dx7aNt1CqeNK1IwWYwbCgT4mS61BNqh/lzDjpu9Pjqm9
	 HIQe70LzzXjbcaoh7MiXa6jgDrdOB2Qp1S87P0Vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfIDHqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:46:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38298 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfIDHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:46:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so2368037wme.3;
        Wed, 04 Sep 2019 00:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALQJDHabIHIRVccnskz3EGkXYFFUSK5Bj/L/t8kK1RY=;
        b=jmAXbqRh8aAZTEPJ4YqjRbQvcgIhoc67V9Y8KIpE+ugbtQtXtS/6ZPzecA5S0oKCbg
         Q3n7D8gWrEtVYBvpL/fIGuDEADOI63DJfmWStYcp2+UWwK91rETmRHGh54Cr/yhymEOt
         FWguz/ETf2zt0hveZ0glw3KtKkKCLStIlvszy8brliU4nKGDEQH8F8c7XRVxXkUDd+i0
         f8mHaguh7+vncvEWmHg1iD2bqjm7VADXHNsUP00/vDpq2FIzBIKM5RUyjGTxkm0LVTVT
         vXaz8Q/Qv0VSSQgPLzMXE/kehY/sVDq6WRyaaSd6EgES1LXW0n6zEJ7zK4IKQ+u/KHUF
         HwaQ==
X-Gm-Message-State: APjAAAXjopGUIs72oqzxFPvXA7SVbvZuNEdG56jTAb27GE+yTZ2vLMR0
        U/U2rtYj8u6KyTqqgHzyXeyakqp48eHt9peQXBiAqhgW
X-Google-Smtp-Source: APXvYqzrei7rUgXpBmUZ0+Wydv6tghQcHo02w8csqHAigBwWnK5qkd5y5qX2Pt0XShEryT9Xgb+Ny0I/xcdxP4uJk7g=
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr2836990wmg.159.1567583208315;
 Wed, 04 Sep 2019 00:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <16EA1F625E922C43B00B9D82250220500871C7D7@APYOKXMS108.ap.sony.com>
In-Reply-To: <16EA1F625E922C43B00B9D82250220500871C7D7@APYOKXMS108.ap.sony.com>
From:   Felipe Balbi <balbi@kernel.org>
Date:   Wed, 4 Sep 2019 10:46:37 +0300
Message-ID: <CAH8TKc_XBksJHTue18O7jv7h0WjFSqQkJJ8Hc2aRNZaL3aRfVQ@mail.gmail.com>
Subject: Re: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
To:     Jacky.Cao@sony.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Kento.A.Kobayashi@sony.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 4, 2019 at 9:47 AM <Jacky.Cao@sony.com> wrote:
>
> The power budget for SuperSpeed mode should be 900 mA
>
> according to USB3.0 specification, so set the power
>
> budget to 900 mA for dummy_start_ss which is only used
>
> for SuperSpeed mode.
>
>
>
> If the max power consumption of SuperSpeed device is
>
> larger than 500 mA, insufficient available bus power
>
> error happens in usb_choose_configuration function
>
> when the device connects to dummy hcd.
>
>
>
> Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>

You must send plain/text emails. I'm not receiving this via the
mailing list. Please, fix your
email client or use git send-email

-- 
balbi
