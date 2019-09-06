Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCA0C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C2D20842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua9CQ3q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392625AbfIFWsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:48:30 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:33526 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389569AbfIFWsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:48:30 -0400
Received: by mail-pg1-f169.google.com with SMTP id n190so4332859pgn.0;
        Fri, 06 Sep 2019 15:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CL+6i4L4mR3Xt/R2XdXojCt+U8Qw2PXus8JVhAwDP54=;
        b=Ua9CQ3q9MgDKxHQ3KdHdRkpYgxKS1WlyUI9Gbv05HnwxYVaZYuB0Uu0F/amVWVciVC
         0vtxG8p7e1SDMYA7luq0Z0oSOIdojwUzlB0IaRwbwnIP6QRgLUuLE9M/SIUzPQNC4InP
         rFKxlbdI/lWP+f/IuoiSORY9MonzGrwxoWOWxVVok8KgrMbcm/zIT2AcZadEmwyd5FQv
         PQRcV1JW+mT5sp25z2bB/B/qSMBTmXRK3L8e94T+BSuN0yeUeT7OegEXibWH1YtcrMaV
         H7sGa7h/iQ62s8zrwvwAHrcPtBbVcg9Jqlnp3O6Dkt6m7UXVc6VhSW8om/pMu9Jjx1QR
         qYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CL+6i4L4mR3Xt/R2XdXojCt+U8Qw2PXus8JVhAwDP54=;
        b=MrT8Rb+8QQTbZ/hoHF7hm6Zj4x8WFjhPKJp/wqFcMjKK8uy0PaE95Dx+rTgATKHrWD
         58t9xQfkvSltuyOnrAf3WxhFLevm2tsjG51cQ7ihh2CwOx7M0wgLh1Sle6tl8HRzgny6
         SgRU6+RfAgB4xREA0xxfMGaO6EOUGGeV3+W5WgdBQMmAb1eeoHYgMQlJzKuSqKiJ6eOM
         jsoQqBIUOeAFuPjcfa4IWaAEQjaaHzrJSJAEFBtMjz8bfjg5OT1FoKAJxuuPOV67fqlk
         B+QBfnAYQEU8/D/+n0PIOBruVkcRHnyjBwcH6N81oIScpEMph4bltyHUvCtgiCWMLy4i
         O0Lw==
X-Gm-Message-State: APjAAAXIPm2k6sKBd3fWWrwRo7Q0+k/GpHdtcXlIKSEl+EnfckH1Q4SG
        cV/Im6q8Gm+s5iVzfc2Ftg+/kVs4
X-Google-Smtp-Source: APXvYqySWUGMsXaIaJQLEzjsfFzOdChWGvRxC2CgDS0rb12L9Ze+hjchGjT37ZtUGWGa9l9RG0OS8A==
X-Received: by 2002:a63:2148:: with SMTP id s8mr9831092pgm.336.1567810109422;
        Fri, 06 Sep 2019 15:48:29 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id s141sm10342576pfs.13.2019.09.06.15.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 15:48:28 -0700 (PDT)
Date:   Fri, 6 Sep 2019 15:48:27 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.3-rc7
Message-ID: <20190906224827.GA211076@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem - a tiny update from Benjamin
removing mistakenly added Elan PNP ID so that device is again handled by
hid-multitouch.

Changelog:
---------

Benjamin Tissoires (1):
      Input: elan_i2c - remove Lenovo Legion Y7000 PnpID

Diffstat:
--------

 include/linux/input/elan-i2c-ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.


-- 
Dmitry
