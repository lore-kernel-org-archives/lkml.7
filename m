Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C54C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741AA2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do4KGfFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfDPSGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:06:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45836 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfDPSGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:06:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so10703490plb.12;
        Tue, 16 Apr 2019 11:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2U6piKmCXuthXhtzKPuF9xcIED8L2ChcKUQw0IQFHg=;
        b=do4KGfFSoeMQssYLpt4TXa1gJ6k+JkJJQ4B4yHt074Rf8RyL+7Wn/P4xmSCp+ODW++
         M2Rg+2ARz0y43fp1KNKapMvkSiuM8RwgQHEftKup3+0Ayx48MQw8oHOOrf3SaKD+Tdmt
         xWaxA/VX45BEkPffChuPbHuTZSG8YHpUGMxktjuTQm/NpPgvD6FKtP2FxpYhZzFu9Bjb
         kqQF4EHG2yDj6/Hpjb7KRQJYZCGxgjkcUAwaLvCkAd76rNibwWS1m+Hyh/l17SrdbtKq
         p4hVnorAP8jHv+fdz1L7xl15cf6k6pyqHmSDwJ/D1tK4AK0/1juoZR7OHdShQJTJN8mG
         EtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2U6piKmCXuthXhtzKPuF9xcIED8L2ChcKUQw0IQFHg=;
        b=aqhPrDKfRk4/gR9l2Yu9dqRixMJt3caPtYv05AQM+Jc7xDMI38Yp5guIpOXg25JU+u
         fGI+oSvL5zZ4uKnP+yTL3nrGoe8kcLxsloikI/scuF1CdAY/v18NXNqCYaC92v63ow3f
         Jh+XroxOnFnZqOvKT3s8kv11fLNDLgLXZrBYucpZf6dE44rI1IrDJQxLqp2yTbNUgjqk
         3LOJoOdK7rTOr8H1K6V6CfnZL3ulOZz9EZOqcaA/z43uZV4jDLOXQhPgpuGsgv1Cd1K7
         pmN1vMkWQFg04xYixKWmYkkugE2h9AHLgbn6J9EGb/VrRuknCByWv2gizYTN7momW6Sw
         XOTA==
X-Gm-Message-State: APjAAAVaNGsOot0xDrayVrOqYFq3sjfRTG+okvd83SoQ4iNABZvYHLKU
        gAWPsgV004ZVuG2i6z+4EF0XU0Vkgsns1eeJgmY=
X-Google-Smtp-Source: APXvYqy6WspfDtNZ4xyqcUo0hfCiHTRfvlXA1yICwWpZ87s6Gu4wTtyw4Uq84d7f/QjwWfceUsHUwhCs0By9WAEDQt0=
X-Received: by 2002:a17:902:2965:: with SMTP id g92mr67419593plb.267.1555438000086;
 Tue, 16 Apr 2019 11:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416012001.5338-2-xiyou.wangcong@gmail.com> <20190416095852.GA31772@zn.tnic>
 <CAM_iQpU6+xD+LmVtd=GPVp2zXgmLjT8tstRa7ia0pNgO0AcaPA@mail.gmail.com>
 <20190416174259.GK31772@zn.tnic> <CAM_iQpWPq8p3L1v_h0_iEkq4Lcw=E84boZEQYUJxxuJtgHDo9w@mail.gmail.com>
In-Reply-To: <CAM_iQpWPq8p3L1v_h0_iEkq4Lcw=E84boZEQYUJxxuJtgHDo9w@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 16 Apr 2019 11:06:28 -0700
Message-ID: <CAM_iQpWnM9ZRon8RALSCTD3RDxgLmBaDFNMgJtP0OVVu8zO95Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ras: close the race condition with timer
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:00 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> As far as I understand, two works in the global workqueue could
> be still ran in parallel on different CPU's, this is why I said it has to
> be an ordered queue to guarantee the serialization.

Never mind, I think we both agree to hold the mutex inside the work
too. I misunderstood it.

I will update my patch to use delayed work.

Thanks.
