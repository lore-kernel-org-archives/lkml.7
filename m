Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D719CC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40672184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNQS/PTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404411AbfEXWjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 18:39:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51642 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfEXWjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 18:39:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id f10so3369664wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 15:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyZi6v0mcgKSC16RURy0qopnByCgnXY1K2U9goxfA1Q=;
        b=JNQS/PTGqlUgYcpzMAYHuZqlDvD2sNfGPlDoRvlyNpPQfxbTZutYHgHCSjsSJCCw05
         5YmVB59KP6XFcHrAKqxOqRTk6Hr9wRl/t3WLBPgNtb3FGdbcbWTLcHAG8wVVbZqX5ja4
         9e08U9URC16u5tUAjjOWPTrjp9emoLdkHQ0gikVaBB/CDY/xofJWr5/JmNvBDV7cHUTw
         XcxwQUgNMMwd8fo0Eas9iV1pSTWD3TghtD0rDuSCLTb3c3Fn4yeh1DBbBaVGUgyKG3tK
         opPLbHpuRD8/V0Rlas0cihCTst7HIoJ/xDApIijjD/5PGhOoh/stcZc5gpOkc5HLQSYP
         wI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyZi6v0mcgKSC16RURy0qopnByCgnXY1K2U9goxfA1Q=;
        b=D86zpJQIpFFu6PFqho9J27k3/7Qnv16lCH1xPt+5tQCzz9m0gybPGAgGJ0sz34iA7h
         ikTvxqs8YxQ3WrHZd0uyuZSkNe4/lXswRtc52/XAb32I4IlR9V03trARB7Bs7akDds8L
         yyt1mREyRZyBT3B0qHaKCE11Y0UVp4HOHoe7OurkHyBoNRmGh4gJJTMjUKCLujywz+fR
         V1J4ISc8m/QqT8Ll8+3gZJohrO4n1YHVGnKtkxjZaqkNdY0IiaIAS8VF2SrvoFJs53CP
         NTZzds4wT0sj26rKDKI+yrj8wuzoz11aiEzeXmy8wJCkg/cz6cHWT155vJLHIZo+LnjZ
         KYPQ==
X-Gm-Message-State: APjAAAVlFXu4FDQ5+0dWfURl+1/rdIuE5WT1Q58pST0eiJHxKRRuNwpx
        1qBeP8Ui04R6xrgJNeFx2wGU86PPnbX16HbtHZRIag==
X-Google-Smtp-Source: APXvYqxW2n5H9vt7mX4JNr8xeJxdoAikSxRfwl4bvPXYtUPI7AS/sOyLcEt10h951ycbvpy5lE6/mmoD6w3q9rCJBPA=
X-Received: by 2002:a1c:2e0a:: with SMTP id u10mr63993wmu.92.1558737537847;
 Fri, 24 May 2019 15:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190524134928.16834-1-jarod@redhat.com> <30882.1558732616@famine>
In-Reply-To: <30882.1558732616@famine>
From:   =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>
Date:   Fri, 24 May 2019 15:38:46 -0700
Message-ID: <CAF2d9jhGmsaOZsDWNFihsD4EuEVq9s0xwY22d+FuhBz=A2JpKA@mail.gmail.com>
Subject: Re: [PATCH net] bonding/802.3ad: fix slave link initialization
 transition states
To:     Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     Jarod Wilson <jarod@redhat.com>, linux-kernel@vger.kernel.org,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-netdev <netdev@vger.kernel.org>,
        Heesoon Kim <Heesoon.Kim@stratus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 2:17 PM Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>
> Jarod Wilson <jarod@redhat.com> wrote:
>
> >Once in a while, with just the right timing, 802.3ad slaves will fail to
> >properly initialize, winding up in a weird state, with a partner system
> >mac address of 00:00:00:00:00:00. This started happening after a fix to
> >properly track link_failure_count tracking, where an 802.3ad slave that
> >reported itself as link up in the miimon code, but wasn't able to get a
> >valid speed/duplex, started getting set to BOND_LINK_FAIL instead of
> >BOND_LINK_DOWN. That was the proper thing to do for the general "my link
> >went down" case, but has created a link initialization race that can put
> >the interface in this odd state.
>
Are there any notification consequences because of this change?

>        Reading back in the git history, the ultimate cause of this
> "weird state" appears to be devices that assert NETDEV_UP prior to
> actually being able to supply sane speed/duplex values, correct?
>
>         Presuming that this is the case, I don't see that there's much
> else to be done here, and so:
>
> Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>
> >The simple fix is to instead set the slave link to BOND_LINK_DOWN again,
> >if the link has never been up (last_link_up == 0), so the link state
> >doesn't bounce from BOND_LINK_DOWN to BOND_LINK_FAIL -- it hasn't failed
> >in this case, it simply hasn't been up yet, and this prevents the
> >unnecessary state change from DOWN to FAIL and getting stuck in an init
> >failure w/o a partner mac.
> >
> >Fixes: ea53abfab960 ("bonding/802.3ad: fix link_failure_count tracking")
> >CC: Jay Vosburgh <j.vosburgh@gmail.com>
> >CC: Veaceslav Falico <vfalico@gmail.com>
> >CC: Andy Gospodarek <andy@greyhouse.net>
> >CC: "David S. Miller" <davem@davemloft.net>
> >CC: netdev@vger.kernel.org
> >Tested-by: Heesoon Kim <Heesoon.Kim@stratus.com>
> >Signed-off-by: Jarod Wilson <jarod@redhat.com>
>
>
>
> >---
> > drivers/net/bonding/bond_main.c | 15 ++++++++++-----
> > 1 file changed, 10 insertions(+), 5 deletions(-)
> >
> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >index 062fa7e3af4c..407f4095a37a 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> >@@ -3122,13 +3122,18 @@ static int bond_slave_netdev_event(unsigned long event,
> >       case NETDEV_CHANGE:
> >               /* For 802.3ad mode only:
> >                * Getting invalid Speed/Duplex values here will put slave
> >-               * in weird state. So mark it as link-fail for the time
> >-               * being and let link-monitoring (miimon) set it right when
> >-               * correct speeds/duplex are available.
> >+               * in weird state. Mark it as link-fail if the link was
> >+               * previously up or link-down if it hasn't yet come up, and
> >+               * let link-monitoring (miimon) set it right when correct
> >+               * speeds/duplex are available.
> >                */
> >               if (bond_update_speed_duplex(slave) &&
> >-                  BOND_MODE(bond) == BOND_MODE_8023AD)
> >-                      slave->link = BOND_LINK_FAIL;
> >+                  BOND_MODE(bond) == BOND_MODE_8023AD) {
> >+                      if (slave->last_link_up)
> >+                              slave->link = BOND_LINK_FAIL;
> >+                      else
> >+                              slave->link = BOND_LINK_DOWN;
> >+              }
> >
> >               if (BOND_MODE(bond) == BOND_MODE_8023AD)
> >                       bond_3ad_adapter_speed_duplex_changed(slave);
> >--
> >2.20.1
> >
