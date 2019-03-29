Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD25C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAD4218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfC2Une convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:43:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41540 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730238AbfC2Und (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:43:33 -0400
Received: from c-67-160-6-8.hsd1.wa.comcast.net ([67.160.6.8] helo=famine.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <jay.vosburgh@canonical.com>)
        id 1h9yLX-0000bo-TH; Fri, 29 Mar 2019 20:43:28 +0000
Received: by famine.localdomain (Postfix, from userid 1000)
        id F2FA660868; Fri, 29 Mar 2019 13:43:25 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id ECDF39F839;
        Fri, 29 Mar 2019 13:43:25 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
cc:     Jarod Wilson <jarod@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] bonding: show full hw address in sysfs for slave entries
In-reply-to: <20190328102921.11680-1-khorenko@virtuozzo.com>
References: <20190328102921.11680-1-khorenko@virtuozzo.com>
Comments: In-reply-to Konstantin Khorenko <khorenko@virtuozzo.com>
   message dated "Thu, 28 Mar 2019 13:29:21 +0300."
X-Mailer: MH-E 8.6+git; nmh 1.6; GNU Emacs 27.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4733.1553892205.1@famine>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 29 Mar 2019 13:43:25 -0700
Message-ID: <4734.1553892205@famine>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Khorenko <khorenko@virtuozzo.com> wrote:

>Bond expects ethernet hwaddr for its slave, but it can be longer than 6
>bytes - infiniband interface for example.
>
> # cat /sys/devices/<skipped>/net/ib0/address
> 80:00:02:08:fe:80:00:00:00:00:00:00:7c:fe:90:03:00:be:5d:e1
>
> # cat /sys/devices/<skipped>/net/ib0/bonding_slave/perm_hwaddr
> 80:00:02:08:fe:80
>
>So print full hwaddr in sysfs "bonding_slave/perm_hwaddr" as well.
>
>Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
>---
> drivers/net/bonding/bond_sysfs_slave.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_sysfs_slave.c b/drivers/net/bonding/bond_sysfs_slave.c
>index 2f120b2ffef0..4985268e2273 100644
>--- a/drivers/net/bonding/bond_sysfs_slave.c
>+++ b/drivers/net/bonding/bond_sysfs_slave.c
>@@ -55,7 +55,9 @@ static SLAVE_ATTR_RO(link_failure_count);
> 
> static ssize_t perm_hwaddr_show(struct slave *slave, char *buf)
> {
>-	return sprintf(buf, "%pM\n", slave->perm_hwaddr);
>+	return sprintf(buf, "%*phC\n",
>+		       slave->dev->addr_len,
>+		       slave->perm_hwaddr);
> }
> static SLAVE_ATTR_RO(perm_hwaddr);

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
