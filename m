Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA7DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA43218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="TiRxLVa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfCWD74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 23:59:56 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:50046 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCWD74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 23:59:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id B5CBDE05
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 03:59:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aRzv23tNDLWf for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 22:59:54 -0500 (CDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 70757DE4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:59:54 -0500 (CDT)
Received: by mail-pf1-f197.google.com with SMTP id u78so4185314pfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 20:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kbLUaSkzG1k2scHHzUxC15KlkXaxuyP58YKT+Se2aT4=;
        b=TiRxLVa87PIbxL3FuXhkwuBB0QtTcOzdZvLj13T4VhqUaERna5B4n8iTo0RY/lV8ct
         4+1v2XtnAYbjaW0E0vX6n9TFR6dyGaunNbfPFFAsDp5h4vbQMSj7+9003JBekJY2KW+u
         lfz+kZpP9Q8PJ1LwibAHXwI71XFXzhmrJ1WxFW639wDEsAV/b/LHw2dP4L3XzB/y6KXT
         YhaNoegf52tjZRqdom3T0T58acXDcKXseXNDaQTGdh5h3BeT9Xc67wpf5fd8IqUK+oJJ
         R5n8DdN2uPPQ5/9xGXiTNNdM4OpUQA9JzVky3dMr37He9pjGEsNM2Bn79OxXn0SOphNS
         7qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kbLUaSkzG1k2scHHzUxC15KlkXaxuyP58YKT+Se2aT4=;
        b=cPfoceTlgH9rFvbRrI3QhObDYxDgr1J2aVstXu7P5yr2wesXUMMg2DwLbs/tA4mY6b
         NoOhKXH68qutipfBZsn3S8lX2a6oyQVcMpIHhgHFFXR5qv7CMdD1dxc/m+wtuCAMdFJK
         s+gPyzkODqddbHlArr4E3dYeOVLPVYGAZIDF3y6Ac3itAbqnZkRL95dGPnIkXjTyLlTI
         xrIsySeq0bujv5eqwHLQBvvyOu8Yo0pMh74+pTDN/Xnnoz2snxE6Bdqxu/C5MeDdcCFd
         LMLACkmsB5+TdVSrETaWg46U8WlKIsK0heBgfjax+mkEhYgWVsss7fsXorOIl3argE0D
         DcDA==
X-Gm-Message-State: APjAAAUmMAewdbFZYito8MlmhXW3hn5at2px+vjJW3Ef9TKd9MHf2kOr
        TiDUaCAzK4j5FV+XqDPV6mN4jGCpP2akHT/4bGayjtpqi/yfywCPia+cUsHPW9dUvM8yzaNzK0V
        +RUVOub5hCP85NOyX/hp2rfwr2yc6
X-Received: by 2002:a65:62d4:: with SMTP id m20mr12477503pgv.416.1553313593832;
        Fri, 22 Mar 2019 20:59:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzFmrNYmDfE7sro7m6tbkgr3shsk+L+XOf86dbqj/J5DztcqH2KLaskPjalaMlwzaCs09NDlw==
X-Received: by 2002:a65:62d4:: with SMTP id m20mr12477485pgv.416.1553313593619;
        Fri, 22 Mar 2019 20:59:53 -0700 (PDT)
Received: from [10.184.4.71] (host-173-230-104-21.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.21])
        by smtp.gmail.com with ESMTPSA id e15sm11032031pgk.30.2019.03.22.20.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 20:59:52 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] net: rtlwifi: fix a potential NULL pointer dereference
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <20190312075633.573-1-kjlu@umn.edu>
Date:   Fri, 22 Mar 2019 22:59:53 -0500
Cc:     pakki001@umn.edu, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AFBB09F8-46AE-4B74-BF53-1045814476B0@umn.edu>
References: <20190312075633.573-1-kjlu@umn.edu>
To:     kjlu@umn.edu
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 12, 2019, at 2:56 AM, Kangjie Lu <kjlu@umn.edu> wrote:
>=20
> In case alloc_workqueue fails, the fix reports the error and
> returns to avoid NULL pointer dereference.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> drivers/net/wireless/realtek/rtlwifi/base.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c =
b/drivers/net/wireless/realtek/rtlwifi/base.c
> index 217d2a7a43c7..ac746c322554 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/base.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/base.c
> @@ -448,6 +448,11 @@ static void _rtl_init_deferred_work(struct =
ieee80211_hw *hw)
> 	/* <2> work queue */
> 	rtlpriv->works.hw =3D hw;
> 	rtlpriv->works.rtl_wq =3D alloc_workqueue("%s", 0, 0, =
rtlpriv->cfg->name);
> +	if (unlikely(!rtlpriv->works.rtl_wq)) {
> +		pr_err("Failed to allocate work queue\n");
> +		return;
> +	}
> +

Can someone review the patch?

Thanks.

> 	INIT_DELAYED_WORK(&rtlpriv->works.watchdog_wq,
> 			  (void *)rtl_watchdog_wq_callback);
> 	INIT_DELAYED_WORK(&rtlpriv->works.ips_nic_off_wq,
> --=20
> 2.17.1
>=20

