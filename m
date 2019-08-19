Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02872C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C605622CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Kbazf/u3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfHSXxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:53:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33601 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbfHSXxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:53:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id v38so3986794qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=AIDRHw1/KiLr7UmXvp2zhI8Bb1peNbuqWd3BSli0jwc=;
        b=Kbazf/u3dEUS6lE3K152lxnBk93g038woC5OXn4RRZKUi/vf88p+9Y9tt6NwfP+T0m
         1rNFVgLM3b6YOdsE/UZjpy6KYBPPBTVoZgS5dytw6BwQHB7P0YggksJsKzNgA4IqJd1t
         aavS1q2nDiJIsiUZZ+M2+HESurCvanWHefweTB6WWUval7EDTWQsnsvUlwsPeEYtJRzP
         zrSGiYrUgJMSo+wXP2p3B2a+J5j4ZnhYxBK1SNCI+w5K5m1qFXsh0Bpl8Ml1YzQLHpfr
         YGHaLWKPavdwVvAKCHiYGuZofSU6lYOzAPpJFLiAdhUk7mtWsJIiJADEeR7B+F8Q0ARc
         Bugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=AIDRHw1/KiLr7UmXvp2zhI8Bb1peNbuqWd3BSli0jwc=;
        b=NyOQTVrYIoxp2PEiT6M6XjWb32hAqb3ZbasEHfbml2ABncqZOBwn0EfHrAnfNSwtl7
         JhweQvqS/zIzDIA5DkYFrcm/dCZq6yM27xgtIKCzX9zpOSwPEXlnkBz2PsTESzNvWdrq
         +f4KZ9x1oJvLAR2z6PRqsZlN+wBku2Vlv0u5vY/HuVz1LHibbJhg4AKXt28yEJD/pd/c
         JGjMbBDIWI71jOBukVq5tw/KJoloa1pn0WuMdc6lnEYfTW09Sldu18IBIrBg1RbWCxXH
         6DrH5u8dCtiiJLp1B3C2FoChsse7xZFrxEJYXzjHeGWMoOiBpvMkVQcwZjSgXSNdzTbi
         Mgqg==
X-Gm-Message-State: APjAAAXwoORsOSqFw1f9nR/YmpXbt9h9yho/vMvN+tuHGUrUFuMZ8LFa
        krmEG982YXZshG0WcC2swLj91A==
X-Google-Smtp-Source: APXvYqwTgEEQlq2YXaR7J/GtQXUoLzZ9unaM7PLFTbLMXdenWb/uDryZMnhzbUXgXQYrq3LZ47NVhA==
X-Received: by 2002:a0c:c93c:: with SMTP id r57mr12120231qvj.226.1566258790089;
        Mon, 19 Aug 2019 16:53:10 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id q13sm7761210qkm.120.2019.08.19.16.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:53:10 -0700 (PDT)
Date:   Mon, 19 Aug 2019 16:53:01 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evgeniy Polyakov <zbr@ioremap.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 09/17] net: sgi: ioc3-eth: use defines for constants
 dealing with desc rings
Message-ID: <20190819165301.4922e86b@cakuba.netronome.com>
In-Reply-To: <20190819163144.3478-10-tbogendoerfer@suse.de>
References: <20190819163144.3478-1-tbogendoerfer@suse.de>
        <20190819163144.3478-10-tbogendoerfer@suse.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 18:31:32 +0200, Thomas Bogendoerfer wrote:
> Descriptor ring sizes of the IOC3 are more or less fixed size. To
> make clearer where there is a relation to ring sizes use defines.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
