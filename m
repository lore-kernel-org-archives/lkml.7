Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BFAC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 20:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006502075C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 20:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmWpwbnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfKJUqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 15:46:15 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45731 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfKJUqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 15:46:15 -0500
Received: by mail-il1-f195.google.com with SMTP id o18so10133222ils.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 12:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LJJAQYCaG5MQxBY5yOQdH1551bHDz5tMT8ibNVVVZD0=;
        b=UmWpwbnIX5T6nEe7KIp0bMxWeso0YCdjSJ6OKPZz9redpu5hvRRAnfS0VC4a5VOLwy
         Klz1CW5oNE2Bce3fxdZmg718qVFAT/jt89l0k4dY0FzwryNj75o/9OecWtQhI+73rkWZ
         b4sfl2bkKAyeF5kHObIPZeuRdCqWflq4ixplGWpES6VpxZkrsutvTTWQJGJgwUKa5ilZ
         Sz1wzmyPG4Xci6yMCE+m7iEM8WupFQilIMNPVj3x9FYBEsxIq4pkTqJhMKG47YBlzDGD
         twC9U3DSlHld4rXIi4sK3V0Y6lnSRC2sAZhHcybZSKoTljOKacPmsmIWj3pLyZ03JyjH
         /ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJJAQYCaG5MQxBY5yOQdH1551bHDz5tMT8ibNVVVZD0=;
        b=rnh+ZWZUrsbDil7JMMGscTEx2AvgCl/cXdQpjtskUuPUJiY0Kh8e54ECvFFsFvH7XS
         bs0mbSQyW78/7AdgstE/6xUOrR5lK55WtZKm5WRIQyC/Y5CG1GsYyglPCVLKugcptTb/
         4r2TRFVxWneAUXXPvngIl3Ko71rtSLyPaDOEN3+aoaAimxMCrn2KgyqZG59d1NvYx1qC
         BUaUSHHlYCw+3qgxptFwgptotd7/hmkQFX3bRgqx8n6QItsOuRKVYHevQcmHnC/EOzNU
         SSGaC3FipIFlksVI9z7tWHzcBoeO9zOF+gyBq0mjcURTHXsLJoDCW2dB7vm6BbOeL1yr
         ygqg==
X-Gm-Message-State: APjAAAWiiU7Kgof3kKk3G2UoN9MEwGHGubmgR96zDDzzg0PoHkfplUsJ
        V4y91VUyknHcC5URrx+e5UPd0Y8Q0wNI0hdF+U3cKXKT
X-Google-Smtp-Source: APXvYqzBsWwFAkWDw44tpfBCODBntGL1TYQ6X6Tn18FWxBB1fYjKlFXD6uh7XrfiOl9RcRRzROvI+mksdLoL0N7hdHw=
X-Received: by 2002:a92:c888:: with SMTP id w8mr26008822ilo.153.1573418773452;
 Sun, 10 Nov 2019 12:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20191108203435.112759-1-arnd@arndb.de> <20191108203435.112759-3-arnd@arndb.de>
In-Reply-To: <20191108203435.112759-3-arnd@arndb.de>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun, 10 Nov 2019 12:46:01 -0800
Message-ID: <CABeXuvrcKuqRHObczLRtTe29WZ9cqOM48wdVopv6USE+EYadYg@mail.gmail.com>
Subject: Re: [PATCH 2/8] timekeeping: optimize ns_to_timespec64
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arithmetic looks right to me.

Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>
