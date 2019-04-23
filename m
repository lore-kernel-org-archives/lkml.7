Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7ECC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7A820685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNPzXuPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfDWIoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:44:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33901 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDWIoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:44:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so7137527pfd.1;
        Tue, 23 Apr 2019 01:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4BCmLrn9XjloUMHDFcLSGBgSblmX+pc4aRTHqZMNgSM=;
        b=uNPzXuPSuNlAX27x5umeqjkfmmvqx+KrVN+LRBNQSPtzR+SZIbLIcP1l0ve1LI+Cnf
         ONESixui6EBweKuJC9jgappYBXvchwm87qVXIrPlLPBOcQxYLtFOnf9YA5uU5GdDdD0J
         NDyOeJs13yxYE7KwxNXZPs94Kt/pMHSuNmDD9jUdWelE1TnEBxRzWYSDeWEzYjY9WbM8
         J6oKp8U4ke1ZAKBT2s2iTuFOAzMGjuF3J4BoiKrSr1Zd4/49zLZaiOS9CQP2r0W2HX2W
         X/HzW+bmo37JJMqO/OSnN0Nxa+EoqmcF35g+iS7mc2YZP6eaRAf9agUQXHnSx06rKH42
         muyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4BCmLrn9XjloUMHDFcLSGBgSblmX+pc4aRTHqZMNgSM=;
        b=LMcRcw144Vojr29XRs8gAX/n6PV+Uqp9YsE01CH/ltnZMZMWw8+sdqwfE8HDoKwQZS
         hVjRJDyCLQIWn9YM1o3nPlUg1sjaWGQiJfISmVcGeqekH5cdgOW8pWatMTMw18b2BLUg
         d3pqnT1d7CNpfe5TNXQY4Mhqg0vmXdIeF7VN2D+2HrGdpFhCUx9gc1ycAYPkzAU7ZQ86
         vI/8pihdb7OGKyyoQkptVR6D/Rg+O9Z6I2+NDleVawm8R81CuP7SuMjq2GWIiAne8kWy
         5FoZXdHluNmbLL/OXARVFmpkAC+QHNUEbuR7qhgIA7J+DACoxnoGuF00uNbfzdAthmQl
         rIrQ==
X-Gm-Message-State: APjAAAWMnHBj5FcZdfzNh1v5xWg7QGM/QoIOflKHYt8B3zG1HYHguA51
        bGPDtjesZDR+lq4KiWEM+b8=
X-Google-Smtp-Source: APXvYqzQepngjZBl7cXxfzuQnonTn0bFcHmtfgE745U349AWrePtc8biWbCX49kiaK9+GLcJuh9TiQ==
X-Received: by 2002:a65:6686:: with SMTP id b6mr23788734pgw.419.1556009054323;
        Tue, 23 Apr 2019 01:44:14 -0700 (PDT)
Received: from localhost (p1962055-ipbf905funabasi.chiba.ocn.ne.jp. [118.15.107.55])
        by smtp.gmail.com with ESMTPSA id b2sm19915034pfo.150.2019.04.23.01.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 01:44:13 -0700 (PDT)
Date:   Tue, 23 Apr 2019 08:44:18 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH next 09/25] input: keyboard: Use dev_get_drvdata()
Message-ID: <20190423084418.sekqt5jeiqctvofe@penguin>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
 <20190423075020.173734-10-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423075020.173734-10-wangkefeng.wang@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

On Tue, Apr 23, 2019 at 03:50:04PM +0800, Kefeng Wang wrote:
> Using dev_get_drvdata directly.

This assumes that generic device's driver data is exactly the same as platform
device's driver data. This is true today, but does not have to be true
tomorrow.

What is the benefit of violating the layering and accessing "parent"
object's abstraction directly? Performance impact must be negligible...

Thanks.

-- 
Dmitry
