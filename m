Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30F1C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB0D20578
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHQtFjof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfG2OFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:05:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42330 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfG2OFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:05:07 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so89826996iob.9;
        Mon, 29 Jul 2019 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VMcai4khoRvrF5RKnXnT8t3DrfpcvVq85sIbML95LIc=;
        b=oHQtFjofELxdWido6MPsVTuC9kqmT1TND8RwEhvmbm83u1Iz4ciEkQyzN2OTCc+anf
         ENheL0fVBbSk9QBDcpQ4i2wlIIP9temOiyx011ugvwSoBL7RXHVc9FH/qQCNa/en1/eA
         Rc/hHw7nlBDcEGXPxIKU4c64j5YujibUlxe8FqJB80D6de8TuDpZ0P2BR3VhX7yu54Wn
         paznY4A/kSr1XqDfloFWBW5MFu1AJ8JQE8AadfJ2/Lz+sCl8qaFH33a3ghQs8C1G2P+B
         aUu+Pt5Z0VAJZPJB+g92h9gmybgy7dkuiCCJihuVfteWwbjVad6onPLBp6EQAhgNINTP
         g4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VMcai4khoRvrF5RKnXnT8t3DrfpcvVq85sIbML95LIc=;
        b=Z81Tdt9TQv8iO2ZuoLbsxqW88Eju6fOc5Mo3kgQfpBZvNJ1oOc21WQB2Gd+pO8A+fC
         ZD94njkXaSx0Tmps5f8a3Vkc2bWjf7PEFx1KInYnPFILYTHQMO60ygF6mQbZC6ywbEUu
         +4uUNFHclxWP5rpYZUMIHQbu4GMFPx46daM+RM6AACzGrePEidJEbOjHLvqJnOE+u9QZ
         2ZXINJW8x8jvHlILcknEPXvxzKmJdLXhNZzv2oOZMfx94iu7mNuxhMU0tdoBNJAjclTw
         Rj0ec1eSaxU+/yy9S4V36f4SM/KpJlRuUNttZVqhsnhu4FudOqreRKAa7/2H1GW+9gS/
         KbPQ==
X-Gm-Message-State: APjAAAVJeew16p4Zt2Sx6MOiAC1BAxYpfPu/B13PdcAaAe2fO3p8p/mv
        t+l2z9JglNcjledrC7gQLDdU3y//HMc=
X-Google-Smtp-Source: APXvYqwXkEdL8BrfU2Ol0Di5Umaf2nxK/sPkasu/PWvCI0tN/59BYryeAXMOs5nmXb/IjzOPq2RdbA==
X-Received: by 2002:a6b:621a:: with SMTP id f26mr91956754iog.127.1564409105953;
        Mon, 29 Jul 2019 07:05:05 -0700 (PDT)
Received: from localhost ([8.46.76.96])
        by smtp.gmail.com with ESMTPSA id y18sm58632533iob.64.2019.07.29.07.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 07:05:05 -0700 (PDT)
Date:   Mon, 29 Jul 2019 16:04:38 +0200
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     ronald@innovation.ch, nikolas@gnu.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: applespi - Fix build error
Message-ID: <20190729140438.GA2372@penguin>
References: <20190729031455.59400-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729031455.59400-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:14:55AM +0800, YueHaibing wrote:
> If CONFIG_KEYBOARD_APPLESPI=y but CONFIG_LEDS_CLASS=m
> building fails:
> 
> drivers/input/keyboard/applespi.o: In function `applespi_probe':
> applespi.c:(.text+0x1fcd): undefined reference to `devm_led_classdev_register_ext'
> 
> Wrap it in LEDS_CLASS macro to fix this.

No, we should add "depends on LEDS_CLASS" to the Konfig instead.

Thanks.

-- 
Dmitry
