Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19D2C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B388F20652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="CMfvCiQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfGAH5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:57:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38401 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfGAH5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:57:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id a27so10260190qkk.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 00:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtyfCDkCjq5RHAVYhMnNoIQKBSXSMCI67JdQ5H2fFB4=;
        b=CMfvCiQ9YcwZMzl4gxArCw2oFzR+5VwPbG22HvLIBEuInytw5vIVm3X8wYi+SLPMqf
         ShzzQOvX3lx4nDaIXJXgZZyzdvFqMcBoLGxeMrzy2SO48kTtUJeWHbZS0rHeWMWuYKYU
         ZElTKLFd6vSjn93nyBlLvaWF8mgOyX3DoT1GF6/CwKdg5a0A1s7neYlcm47XEUKmdqET
         AUKk1MA6xlA+kQplohG8lWA+u7uDzG3RpZ5sm7LCv5CjjP1wNyDFNpJGKwIYsGxClHXS
         o9kSagK/mZ17fupgVAwYkWbPaz3/+UHmAbC6POxg3z2lC0AxI5oCNWJbdf4zGN3fH8cb
         GrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtyfCDkCjq5RHAVYhMnNoIQKBSXSMCI67JdQ5H2fFB4=;
        b=Pz5VvPKiRhgsr0+I20xm5qPeGkLY/rCb+ggH1kMWuokmKNLzu3wJ9295kfDH5c6g/3
         18lwEx3hd7IqUUtMos+mtoqYMDcejYAxLHVbhtRF6fl5UCq7F5YmAyEqWT1xgtZWMjNN
         Vl6gT/Z+Gd+aNBikHfG/ON2uyBxy5gXvvNnuiVGQGZDoJHeekU/OTkKm2YQEj/nOcvDw
         ubRH3ShOdoZ53vdNeYod6HqCpRiDd6M6wpeTVRrmhgbzrEMqDmaW87m1K+TiigDQbtwg
         i8W3cVpk7SLorQ9ZlQnLkVNvw0KvZ9JEKPN2qoTekRPBjThnLFDwylAeS5Endnmgu4/X
         E4XQ==
X-Gm-Message-State: APjAAAXVxH0dd83+anDO4kj2hq93i28z7L5BzaCfCqWUSzORmQr9LM/3
        j0f47gGFh8QAGvMNlK/x/KtbT5kzu0V4iP4X6P9kYg==
X-Google-Smtp-Source: APXvYqxC/e7W+DgJp9+vritpFFPsVD69EJBRr3ZtHuge17WlBjm2xWd+OHXCNSjuto3JiVwTQToBG8Zo+1zk586Z/Us=
X-Received: by 2002:ae9:e306:: with SMTP id v6mr19147089qkf.145.1561967856075;
 Mon, 01 Jul 2019 00:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190617065600.40405-1-chiu@endlessm.com>
In-Reply-To: <20190617065600.40405-1-chiu@endlessm.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 1 Jul 2019 15:57:25 +0800
Message-ID: <CAD8Lp46vNbaDkC4sYaw6GijMtHiK41EcS0Wjwp61MdyfcwcqgQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5] rtl8xxxu: Improve TX performance of RTL8723BU on
 rtl8xxxu driver
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 2:56 PM Chris Chiu <chiu@endlessm.com> wrote:
> With this commit, the tx rate of each data and qos data packet will
> be 39Mbps (MCS4) with the 0xF00000 as the tx rate mask. The 20th bit
> to 23th bit means MCS4 to MCS7. It means that the firmware still picks
> the lowest rate from the rate mask and explains why the tx rate of
> data and qos data is always lowest 1Mbps because the default rate mask
> passed is always 0xFFFFFFF ranges from the basic CCK rate, OFDM rate,
> and MCS rate. However, with Realtek's driver, the tx rate observed from
> wireshark under the same condition is almost 65Mbps or 72Mbps
suggestion: add:
, indicating that rtl8xxxu could still be further improved.

Then remove this paragraph, I think we're in agreement of the approach here:
> I believe the firmware of RTL8723BU may need fix. And I think we
> can still bring in the dm_watchdog as rtlwifi to improve from the
> driver side. Please leave precious comments for my commits and
> suggest what I can do better. Or suggest if there's any better idea
> to fix this. Thanks.

> Signed-off-by: Chris Chiu <chiu@endlessm.com>
Reviewed-by: Daniel Drake <drake@endlessm.com>

> +        * is supported and no iface_combinations are providec.

typo: provided
