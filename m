Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C87C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31484222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZkZlV4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfJDWFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:05:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41259 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJDWFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:05:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id r2so5472121lfn.8;
        Fri, 04 Oct 2019 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1U1sHNHSit/75tybDvgS4j4jmfFzL9R579gD2Or6c0w=;
        b=nZkZlV4EeE83+Lga9AsP1nvv9cCzhZxi370TP9tn6hoIDUeKIjgqTvZRH9f0AJVYw8
         9vwiK6Jt12wL+rh9z6O/5bFaTtnRiJ/xGhFqZivOatnu6wM2fh4vLao8MRhcHNmAyA+m
         IZdRfMih4YSzLyID78rnZebTgQTQLsbe0jWwnUFun+Hgd+YyCj+mUNu57QMGK0v0vUbC
         8JKKzMRs+m+zQ2eSXqqpqA4x5+6xlcPK+TUMCgnlt8Bt73ha4HTPbNd0CQduq64tLYwI
         y4tukxBDvPij/O6rfu3BNaz9WEcLkW/0kKDZ+jQZKrzicDMu3gibh/sMqCzB4yC1g7qz
         jbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1U1sHNHSit/75tybDvgS4j4jmfFzL9R579gD2Or6c0w=;
        b=Y2jkT4bGwXQmiVRLQy4zA2ZCFCPRNZdxfgPvxgYkFxvgb3hzInbBQxS4WaqxPumjDT
         ln2ntf7U8Sf8uYsHBqfaX3Pb08PIdlV0tlm9pcdwJm8l/eyc2idXV5XZZ5/z7/Mw+kg3
         fkHz13dOPI6TcX/vs52QN80kFQH4SxNW2ZKi/W6tCOSY/VQQwcCiJ9gY7OT55mB86bN3
         vlDsfl32Y0KQxP4Fy41hDCJxfC0/hNzioAYtdiFhRcuLd53GwTJdINyb4nf/7G8kHdn8
         l0LFPRUdZXJ+VSwf/yp4gFaIboAFMeLO0AYsTovp4ag/H3kOV3uDYdh2Jeqyr+hbOXY4
         Is3g==
X-Gm-Message-State: APjAAAW8z8yk08DAuVgtstEm6mf2d3NWfcjgLg7/Clp2JG3A7fP07jqi
        TRodzfZVaz9Z0MRnSd9NDF2/SD8aCPn/1Kl7Gsg=
X-Google-Smtp-Source: APXvYqwFuAivknQ9HtZbl+Q/9um5UvGUEnD+GzIraTpjEfIPG8XcnNwX/+gnZrT0CjUYxWon+S3bUNPtNyGDfaWp+Ic=
X-Received: by 2002:ac2:47e3:: with SMTP id b3mr9669807lfp.80.1570226740863;
 Fri, 04 Oct 2019 15:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191004215537.5308-1-andrew.smirnov@gmail.com>
In-Reply-To: <20191004215537.5308-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 4 Oct 2019 19:06:03 -0300
Message-ID: <CAOMZO5A2QvTa1h3fDHitbqgSXf0CTc4KuZS5Er0cHb3zpkC+cA@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: Fix lpuart_flush_buffer()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Agner <stefan@agner.ch>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 6:59 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Fix incorrect read-modify-write sequence in lpuart_flush_buffer() that
> was reading from UARTPFIFO and writing to UARTCFIFO instead of
> operating solely on the latter.
>
> Fixes: 9bc19af9dacb ("tty: serial: fsl_lpuart: Flush HW FIFOs in .flush_buffer")
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
