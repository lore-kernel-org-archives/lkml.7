Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D37C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A6F215A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ng6lE0qi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfK1Mr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:47:27 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:39569 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfK1Mr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:47:26 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id db9d9fa5;
        Thu, 28 Nov 2019 11:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=JWrJMMQI7xcRH9JA9rmWSPbtPaE=; b=ng6lE0
        qiP3CR9yJpgauKGmvai0abXNjrKak/sIPsHkwMQGUKDxCzQ/vW1NZJyJ+SwjpP3x
        I3DIJQTw+6Nc1RpXSUCy/RONCU1KKbAppCjBgrIn2DSIDcIo2tCP4OHLQQBbrkXU
        YnH6HQcB68oQ2jYWMJGzdPT6FPrkSQSRmzdulYdSuOpzcl3QOK9KNTkB2U8W7W0P
        1ZnYHj+lgEb6T+rlGlWm2J0Pt0FgfJnnhKBG4mk64LxHAV6+q/9pu/Yqiek3PWij
        H6CqydFIgvOiGtC14XOIg01vFpr6mN6dA0hET/MLIVM7SVCl6vXWamtc8Ds5bcEc
        cvyJAnZias5JXQLg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1a5a440d (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 28 Nov 2019 11:53:24 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id l20so23200001oie.10;
        Thu, 28 Nov 2019 04:47:23 -0800 (PST)
X-Gm-Message-State: APjAAAXYoHOgaeCg+X0GXMEY2sKkOAanhkWEScpJIrVQBQqoaPi9z4DB
        kx/LuII+gJgst5b01sAxJA+x9Mh4CTAp+7lDpUU=
X-Google-Smtp-Source: APXvYqzeVCxssZpzO5edbpWpxx6KjrwlgZzbotvXWLRC9YbNC1MtYuhfauThDHga/WjFuthpM4cMXys/DpWcXkoscLk=
X-Received: by 2002:a05:6808:906:: with SMTP id w6mr7805253oih.122.1574945242419;
 Thu, 28 Nov 2019 04:47:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9oqT_BncUFaJRpj0xtL1MPcE=g5WQG_qE7oC231USQCPA@mail.gmail.com>
 <20191127.105506.1224335279309401228.davem@davemloft.net>
In-Reply-To: <20191127.105506.1224335279309401228.davem@davemloft.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 28 Nov 2019 13:47:11 +0100
X-Gmail-Original-Message-ID: <CAHmME9oo0GbTC6mxOoBkmHPWCgt9H9C9QJ9_oyP9OQjWY0AFgg@mail.gmail.com>
Message-ID: <CAHmME9oo0GbTC6mxOoBkmHPWCgt9H9C9QJ9_oyP9OQjWY0AFgg@mail.gmail.com>
Subject: Re: WireGuard for 5.5?
To:     David Miller <davem@davemloft.net>
Cc:     Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 7:55 PM David Miller <davem@davemloft.net> wrote:
> I haven't read the patch and plan to do so soon.
>
> The merge window is open and thus net-next is closed, so we can put
> this into the next merge window.

Okay, no problem. That means 5.6. If there are comments on the v1 I
sent, I'll send the v2 when net-next is actually open, per the norm.

Jason
