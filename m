Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935DCC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1AF20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YucMnXon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfCKTFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:05:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42317 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfCKTFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:05:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id b2so4740779pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tdTosIs+1uAy6/6Lcr3HixClUIqOs4tmhdwSXUDuzDU=;
        b=YucMnXonRZ0j6FKezKbz0TICsBotSm0FR7XY65SIgSZYBKBgpB9ZbawUonfHuJzGsT
         R00xKp1cLSAEm03j/80BD1P6awTwlJeGHL15qkR9Yx6HyUJMzXA/xZJx6lP9jXVGw7oI
         eicU4WXwQZFawr/ttbEKPnYHCKMYvfLydJ3OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tdTosIs+1uAy6/6Lcr3HixClUIqOs4tmhdwSXUDuzDU=;
        b=pNhRp1uCB0uQLSkgdxKZWFUfYmCW7RYGrQnFmM2R41eknWXLzgq7ko3ptopzVKbEjS
         dQGA1qjww7ULA5y6Jn44AE9QUWYZ7tUeOueVByE1ZJZFcxoM2/IOa/s57hYJpqaf+UaN
         5/s0tD9Gd6hWBaax+AHRt6boI+EV5uUDqpG8ITs40ZdA2SdVEhDYqTV395h/EYla13ks
         befLWAk4TaJhnh12osuBmEggBypVtB40iGtkHL1cpQUm8O8whQthspw6mLtqcgbyYx1u
         dGlXC73IqMzs8fr5N3fTmIoSiSK/vK1Yc4E1X0Ea97yn+hnnqqjqiDtaJIs0mT5AovzI
         r69g==
X-Gm-Message-State: APjAAAUvzPzqaX+e2xHcgDGRL0SVQqg38od/Ho1Y54F667vJZWjkzy7K
        chfCaZq9rwZnRavqfxsFBoTDxg==
X-Google-Smtp-Source: APXvYqxGhg4y/dJxxli0g93Ve4jMoa9a+S3hIhYXxyFDg7qf7KqfqmyRaefrFJjaUu0j/QyELfEBAA==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr34816755plb.198.1552331133911;
        Mon, 11 Mar 2019 12:05:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o2sm12961591pgq.29.2019.03.11.12.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 12:05:33 -0700 (PDT)
Date:   Mon, 11 Mar 2019 12:05:32 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Add helper function to get the
 chip family
Message-ID: <20190311190532.GA200579@google.com>
References: <20190311183831.174391-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190311183831.174391-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 11:38:31AM -0700, Matthias Kaehlcke wrote:
> Many functions obtain a 'struct qca_serdev' only to read the btsoc_type
> field. Add a helper function that encapsulates this.
> 
> This also fixes crashes observed on platforms with ROME controllers
> that are instantiated through ldisc and not as serdev clients. The
> crashes are caused by NULL pointer dereferentiations, which stem from
> the driver's assumption that a QCA HCI device is always associated with
> a serdev device.
> 
> Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm
> Bluetooth chip wcn3990")

TBH I'm not sure how useful the 'Fixes' tag is in this case. There are
a bunch of other fixes without the tag, intermingled with a few
improvements and new features.
