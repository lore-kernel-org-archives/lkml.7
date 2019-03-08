Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E89CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F78720854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfCHGvP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:51:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36732 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfCHGvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:51:15 -0500
Received: from c-67-160-6-8.hsd1.wa.comcast.net ([67.160.6.8] helo=famine.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <jay.vosburgh@canonical.com>)
        id 1h29LY-0008I7-Pr; Fri, 08 Mar 2019 06:51:09 +0000
Received: by famine.localdomain (Postfix, from userid 1000)
        id C231760868; Thu,  7 Mar 2019 22:51:06 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id BA7AF9F839;
        Thu,  7 Mar 2019 22:51:06 -0800 (PST)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Bo YU <tsu.yubo@gmail.com>
cc:     vfalico@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuzibode@126.com
Subject: Re: [PATCH 2/2] net: bonding: fix incorrect type in assignment
In-reply-to: <2fefb2a6962f668f76db79d2f9a2b866b077e42f.1552023000.git.tsu.yubo@gmail.com>
References: <cover.1552023000.git.tsu.yubo@gmail.com> <2fefb2a6962f668f76db79d2f9a2b866b077e42f.1552023000.git.tsu.yubo@gmail.com>
Comments: In-reply-to Bo YU <tsu.yubo@gmail.com>
   message dated "Fri, 08 Mar 2019 00:34:05 -0500."
X-Mailer: MH-E 8.6+git; nmh 1.6; GNU Emacs 27.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6017.1552027866.1@famine>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 07 Mar 2019 22:51:06 -0800
Message-ID: <6018.1552027866@famine>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bo YU <tsu.yubo@gmail.com> wrote:

>There are some warning when:
>
>sudo make C=1 CF=-D__CHECK_ENDIAN__ drivers/net/bonding/
>
>drivers/net/bonding/bond_main.c:2438:40: warning: incorrect type in assignment (different base types)
>drivers/net/bonding/bond_main.c:2438:40:    expected restricted __be16 [usertype] vlan_proto
>drivers/net/bonding/bond_main.c:2438:40:
>...
>rivers/net/bonding/bond_options.c:1089:24: warning: incorrect type in assignment (different base types)
>drivers/net/bonding/bond_options.c:1089:24:    expected restricted __be32 [addressable] [usertype] target
>drivers/net/bonding/bond_options.c:1089:24:    got unsigned long long const [usertype] value
>
>So fix it
>
>Signed-off-by: Bo YU <tsu.yubo@gmail.com>
>---
> drivers/net/bonding/bond_main.c    | 2 +-
> drivers/net/bonding/bond_options.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>index 135fec28daa9..07e52d863e91 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2435,7 +2435,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
> 		tags = kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
> 		if (!tags)
> 			return ERR_PTR(-ENOMEM);
>-		tags[level].vlan_proto = VLAN_N_VID;
>+		tags[level].vlan_proto = cpu_to_be16(VLAN_N_VID);
> 		return tags;
> 	}
> 
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
>index da1fc17295d9..3a196999bd1b 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -1086,7 +1086,7 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
> 		else
> 			netdev_err(bond->dev, "no command found in arp_ip_targets file - use +<addr> or -<addr>\n");
> 	} else {
>-		target = newval->value;
>+		target = cpu_to_be32(newval->value);
> 		ret = bond_option_arp_ip_target_add(bond, target);

	I'm not sure this is correct; if I'm reading the call path
correctly, bond_changelink will

        if (data[IFLA_BOND_ARP_IP_TARGET]) {
[...]
                        __be32 target;
[...]
                        target = nla_get_be32(attr);

                        bond_opt_initval(&newval, (__force u64)target);
                        err = __bond_opt_set(bond, BOND_OPT_ARP_TARGETS,
                                             &newval);

	thus, newval.value is initially be32, but stored in a u64.
__bond_opt_set will call bond_opt_parse, which in turn will call
bond_option_arp_ip_targets_set (via .set), and the change above would
swap the newval.value back to host order (on little endian architectures
for which cpu_to_be32 is not a no-op).

	Am I misunderstanding?  Did you test this change on an x86 or
other little endian system?

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
