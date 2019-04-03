Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CA7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1ED20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nc2KCtC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDCSaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:30:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39021 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCSaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:30:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id i17so5266pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ellWbfx2w0aKPBVUSIPgN4qdAkwi8uM8AI8wwl8IslE=;
        b=nc2KCtC4Q7QP7Xdf/PhbnttEdyGaENHrX53dqq5nh9VDhmQjFVpQoWgURHMkM8tBvz
         EBWKNXxAgZhNPvBXLEUxJ4lBsPIfORcF2BaCp0W92b2we09I5T0yUaqJ6FL33/0efORS
         uLR6fRjFgqIMvc+O6eYKp167H7RsgH6al1w44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ellWbfx2w0aKPBVUSIPgN4qdAkwi8uM8AI8wwl8IslE=;
        b=pmG+GBz1WBvl9KWdQW6lgtq2hwHpU61OEzvQPdeB21fL11B/fiR5jUAN0UWmkqkT2V
         UvY/dKviojnZ1kiL6fg4Na3fDfUXo3QDvFCytealM7lhDiwtIdk/gGG5wkJpAwpQMVNt
         vTtOcqtSJL41DHG2mobSs3MzxgBTkdhJ/WNUyRmLEYEjwBtlcLgRzfYLKggVo4dYVyhQ
         o81DvzvD25xdv18WwPNVxjzSSXpY8n10lo3j/w4ws9t8tiMsDByGRTnM2golltdEXYBh
         LHMlSUSGfrCFB/ubTpDR9NKLsptoBm1jue19FZgZ47knlyfUIhvQc7pneJNqymVR3eer
         ZOCA==
X-Gm-Message-State: APjAAAUmThDzPuhCWn4hyS8rrYCcDlSkjiPCrYA7efeXj/InHXn+T5Qo
        jeQnSyJi5o6dOTz6GayE1+V9XA==
X-Google-Smtp-Source: APXvYqxKxq8iNoJHxYkV0ua8gzyMvGiz8ijwKSRHjJLwm9kRkeaY1DeH2l6JP5v4bWIDKq3dx0qyOg==
X-Received: by 2002:a63:1749:: with SMTP id 9mr1180822pgx.94.1554316211520;
        Wed, 03 Apr 2019 11:30:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id x9sm30351502pfn.60.2019.04.03.11.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 11:30:11 -0700 (PDT)
Date:   Wed, 3 Apr 2019 11:30:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Randall Spangler <rspangler@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_spi: Transfer messages at
 high priority
Message-ID: <20190403183010.GR112750@google.com>
References: <20190403160526.257088-1-dianders@chromium.org>
 <CA+ASDXN-4Ya6cK5wsmARXxP0bJCGpMkoyu1t_fS7hqVFKF0ZBw@mail.gmail.com>
 <20190403181415.GQ112750@google.com>
 <CAD=FV=UC6MpTgmir+nwUy4hWk8Vvz97M5G45=-r5JAg_=z6vQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=UC6MpTgmir+nwUy4hWk8Vvz97M5G45=-r5JAg_=z6vQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:17:27AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Apr 3, 2019 at 11:14 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > Each transfer has it's own work struct (allocated on the stack), hence
> > a) does not occur. b) is still true, but shouldn't be a problem on
> > its own.
> 
> Actually, it could be much worse _because_ it's on the stack.  The
> worker could write something back to the work after the work has been
> de-allocated.  That's bad.

Sure, I said "not a problem on its own."
                            ~~~~~~~~~~

The worker is owned by this driver and supposedly we know what we are
doing. Changing a member in the struct after calling complete() would
likely be a bug anyway (though not necessarily a fatal one).
