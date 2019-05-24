Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47549C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2403321773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404229AbfEXVRF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 17:17:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58664 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391745AbfEXVRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:17:05 -0400
Received: from c-67-160-6-8.hsd1.wa.comcast.net ([67.160.6.8] helo=famine.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <jay.vosburgh@canonical.com>)
        id 1hUHYg-0006si-1e; Fri, 24 May 2019 21:16:58 +0000
Received: by famine.localdomain (Postfix, from userid 1000)
        id 3C3875FF12; Fri, 24 May 2019 14:16:56 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 344B9A6E88;
        Fri, 24 May 2019 14:16:56 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Jarod Wilson <jarod@redhat.com>
cc:     linux-kernel@vger.kernel.org, Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Heesoon Kim <Heesoon.Kim@stratus.com>
Subject: Re: [PATCH net] bonding/802.3ad: fix slave link initialization transition states
In-reply-to: <20190524134928.16834-1-jarod@redhat.com>
References: <20190524134928.16834-1-jarod@redhat.com>
Comments: In-reply-to Jarod Wilson <jarod@redhat.com>
   message dated "Fri, 24 May 2019 09:49:28 -0400."
X-Mailer: MH-E 8.6+git; nmh 1.6; GNU Emacs 27.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30881.1558732616.1@famine>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 24 May 2019 14:16:56 -0700
Message-ID: <30882.1558732616@famine>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarod Wilson <jarod@redhat.com> wrote:

>Once in a while, with just the right timing, 802.3ad slaves will fail to
>properly initialize, winding up in a weird state, with a partner system
>mac address of 00:00:00:00:00:00. This started happening after a fix to
>properly track link_failure_count tracking, where an 802.3ad slave that
>reported itself as link up in the miimon code, but wasn't able to get a
>valid speed/duplex, started getting set to BOND_LINK_FAIL instead of
>BOND_LINK_DOWN. That was the proper thing to do for the general "my link
>went down" case, but has created a link initialization race that can put
>the interface in this odd state.

	Reading back in the git history, the ultimate cause of this
"weird state" appears to be devices that assert NETDEV_UP prior to
actually being able to supply sane speed/duplex values, correct?

	Presuming that this is the case, I don't see that there's much
else to be done here, and so:

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

>The simple fix is to instead set the slave link to BOND_LINK_DOWN again,
>if the link has never been up (last_link_up == 0), so the link state
>doesn't bounce from BOND_LINK_DOWN to BOND_LINK_FAIL -- it hasn't failed
>in this case, it simply hasn't been up yet, and this prevents the
>unnecessary state change from DOWN to FAIL and getting stuck in an init
>failure w/o a partner mac.
>
>Fixes: ea53abfab960 ("bonding/802.3ad: fix link_failure_count tracking")
>CC: Jay Vosburgh <j.vosburgh@gmail.com>
>CC: Veaceslav Falico <vfalico@gmail.com>
>CC: Andy Gospodarek <andy@greyhouse.net>
>CC: "David S. Miller" <davem@davemloft.net>
>CC: netdev@vger.kernel.org
>Tested-by: Heesoon Kim <Heesoon.Kim@stratus.com>
>Signed-off-by: Jarod Wilson <jarod@redhat.com>



>---
> drivers/net/bonding/bond_main.c | 15 ++++++++++-----
> 1 file changed, 10 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>index 062fa7e3af4c..407f4095a37a 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -3122,13 +3122,18 @@ static int bond_slave_netdev_event(unsigned long event,
> 	case NETDEV_CHANGE:
> 		/* For 802.3ad mode only:
> 		 * Getting invalid Speed/Duplex values here will put slave
>-		 * in weird state. So mark it as link-fail for the time
>-		 * being and let link-monitoring (miimon) set it right when
>-		 * correct speeds/duplex are available.
>+		 * in weird state. Mark it as link-fail if the link was
>+		 * previously up or link-down if it hasn't yet come up, and
>+		 * let link-monitoring (miimon) set it right when correct
>+		 * speeds/duplex are available.
> 		 */
> 		if (bond_update_speed_duplex(slave) &&
>-		    BOND_MODE(bond) == BOND_MODE_8023AD)
>-			slave->link = BOND_LINK_FAIL;
>+		    BOND_MODE(bond) == BOND_MODE_8023AD) {
>+			if (slave->last_link_up)
>+				slave->link = BOND_LINK_FAIL;
>+			else
>+				slave->link = BOND_LINK_DOWN;
>+		}
> 
> 		if (BOND_MODE(bond) == BOND_MODE_8023AD)
> 			bond_3ad_adapter_speed_duplex_changed(slave);
>-- 
>2.20.1
>
