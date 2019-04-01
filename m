Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA95C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039C820883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="OwFbV8jG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfDASV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:21:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42127 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbfDASV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:21:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so11796399qtc.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 11:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=jrTVSfFUTaSkdCEtitxBp3U8hSAuryvisq47B3A3FWE=;
        b=OwFbV8jGsmAOhHnI2T/rGNhkQrKTYN47VEHXk5aWTgAywRFBb0Unvxp6l4Jd2p7T5g
         2E1Rfcnw6dYw1p3FKBnYHGhwWiRnF6K7j6ayprh0bljr0Q+QFA8Lpggc27SMf4NKBug1
         uDRNKaTs06G/FnUct8HDP2Dhr81kZSQXupzZWeOr/2FCIUwGwbR8D6KWys3FcZxCqCVW
         8hv783bU1YHIVyr+0mnPLGft8VARetfHuDGZQIobUAecKyTCm+r8myebDTHMHpCvDfZf
         /gLPcvtsyxUo4tgGgEXQ1q2AMEr40Du+4FHzB8M7k1xq5vqUVbMrtiQiYkB4MIUedH+O
         iCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=jrTVSfFUTaSkdCEtitxBp3U8hSAuryvisq47B3A3FWE=;
        b=XZ9vgUNUbJY3JpRyvYQ1+9iDRIz9PDIRjkukep0wouiU2Zq4EANU/5oEVp6Dm+FSEZ
         YBJ7l6q663O+/d+skfUShieVnXeLB8m/hbMiICQfTrTO0qVtKqCOgxhQZf+FSktSocWo
         NodwlvEuT7frwxlbzZevxV0zENazMT0fuz8T3r4lxkkj+CATNEprJfSGp/xoYKsb/h28
         MkzM3xJeM+Pm52HTONWOnql8O1KK5OQgksALQDbLrRAx8c+bU6in7aC6gHvCrZAFZaWx
         rgmEhYpBXmwG+LP5Hljs7P8Rjfndr0qChhwZm9tdvNzendfV/xeeBBGtokjz8TV6qFwQ
         6Hqw==
X-Gm-Message-State: APjAAAXwGeiZgoBLkTNJeeAga4QTerenhRdzUvjF8+wJ9wBzGOP3x0Cl
        iM1XHL5yJqI5os5BHLALjoRNng==
X-Google-Smtp-Source: APXvYqzzDz53LR0csR6x8m13qylP3FaqKI8qGw5qtG0BEmQYfV5j6Bf9kNotpirrM83xpUjBQvv0cQ==
X-Received: by 2002:ac8:3517:: with SMTP id y23mr56403563qtb.57.1554142918663;
        Mon, 01 Apr 2019 11:21:58 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id a19sm6198289qtk.35.2019.04.01.11.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 11:21:58 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:21:53 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     peterz@infradead.org, tglx@linutronix.de,
        David Miller <davem@davemloft.net>
Cc:     ard.biesheuvel@linaro.org, yamada.masahiro@socionext.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH 0/3] locking/static_key: improve rate limited labels
Message-ID: <20190401112153.2f9e87ba@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20190330000854.30142-1-jakub.kicinski@netronome.com>
References: <20190330000854.30142-1-jakub.kicinski@netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 17:08:51 -0700, Jakub Kicinski wrote:
> Hi!
> 
> This will be used to fix the static branch disabling in the TLS
> code.  The net/tls/ code should be using the deferred static
> branch type, because unprivileged users can flip the branch
> on and off quite easily with CONFIG_TLS_DEVICE=y.
> 
> Second of all we shouldn't take the jump label locks from
> the RX path, when the socket is destroyed.  This can be avoided
> with some slight code refactoring in deferred static_key as
> it already runs from a workqueue.
> 
> This the series (and a simple tls patch which makes use of it)
> applied opening 0.5M TLS connections to localhost (just calling
> setsockopt, no data exchange) goes down from 37.9s to 12.4s.

Once/if we get positive feedback from locking folks, would it be
possible to merge these via net-next tree alongside the patch
converting TLS to rate limited branches?
