Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB319C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7596520811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfIcxshQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCHI25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:28:57 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44470 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfCHI24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:28:56 -0500
Received: by mail-yw1-f66.google.com with SMTP id x21so15655960ywx.11;
        Fri, 08 Mar 2019 00:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnLYg8s3LQu+SnOMdDKuSXoNPc9Vxko7mN/lAmi1F/Q=;
        b=RfIcxshQYxhH1O5QLn9KcijMqLDq3O3owYMwfJdzTUlvBHVABt6G4J+tJIe2UzzSFa
         AeOTF+8fxmahQ6NfPIRfGzythyjPp3d6rVDkBMpG7diNKt+poBUTYR5ivZiigQ25Ci5V
         +OEe6qqT4LX2vA6o+HG2ao3Bk1459fjUTXIQiBeBvAIYDpk2uOFyrI6HeyKV14uV/JAi
         q14c9E1gdYcwxyRS3YQewS+xB3yoxtHTj3HJYB2xnJTkyfFECtOj8IpPvTtTmvXhE2lG
         S9lyGKx1t1loeriZanP3uA5YL5Yw+ejqh6dBNCQzD0uL3uLAswUuU92du4titVsTixEQ
         nFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnLYg8s3LQu+SnOMdDKuSXoNPc9Vxko7mN/lAmi1F/Q=;
        b=Ta9+/jP91L/w/UJd//hYtRe8jBU90kCLM1hTyGHeDtY9ERPq0ZXLzUK9zWZJFytyRQ
         y6egRsTqe6WgnkRfkMCYtvaGOnFBmVYge6t+3ogRmaI5G5UHghMiVEcyASZgpIlr9csS
         1HP4Wtn7nOFYQQ54y3OEk9UwmMzCr1uMHjXifio6GSMsn9aNOXCQLMOQwzzTxvwb1mM7
         tW/jnXwpnjefSMpl8mx8LGGfq9rBcODiIX7Gxgu/BQM4bRXlWng7fFHW5ek6gexkYD3a
         jSmMLcE02mzrNVcd8OsNvNHUxcQD/wh56vnrWgv4CFysmHPBUYftg5q2+lRxqLWDdXHS
         7ZJg==
X-Gm-Message-State: APjAAAWxEUijE5V0L2tmuyfIYrJXNmxtHVwp7jXfp3Qp11000rgF96mR
        ljLS+A9ggfCrp4bT/S6YQte4/O7yk0QcropYpIe+2MyXkkI+bg==
X-Google-Smtp-Source: APXvYqwZMHa/KNOYZ3QPKjrx+piKuVYn59dHjK75vUshsfyYH+i65uwMGdfziS60yfpGoQu05eNFJ3DVVIrT9WnipLo=
X-Received: by 2002:a81:9a8d:: with SMTP id r135mr13283864ywg.188.1552033735424;
 Fri, 08 Mar 2019 00:28:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1552023000.git.tsu.yubo@gmail.com> <2fefb2a6962f668f76db79d2f9a2b866b077e42f.1552023000.git.tsu.yubo@gmail.com>
 <6018.1552027866@famine>
In-Reply-To: <6018.1552027866@famine>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Fri, 8 Mar 2019 16:28:44 +0800
Message-ID: <CAKq8=3KenqZO_O7H-K8ASzMxKUcZL4HMkS7JiU92ytOs=x4aug@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: bonding: fix incorrect type in assignment
To:     Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     vfalico@gmail.com, Andy Gospodarek <andy@greyhouse.net>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5LqO5rOi?= <yuzibode@126.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 2:51 PM Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>
> Bo YU <tsu.yubo@gmail.com> wrote:
>
> >There are some warning when:
> >
> >sudo make C=1 CF=-D__CHECK_ENDIAN__ drivers/net/bonding/
> >
> >drivers/net/bonding/bond_main.c:2438:40: warning: incorrect type in assignment (different base types)
> >drivers/net/bonding/bond_main.c:2438:40:    expected restricted __be16 [usertype] vlan_proto
> >drivers/net/bonding/bond_main.c:2438:40:
> >...
> >rivers/net/bonding/bond_options.c:1089:24: warning: incorrect type in assignment (different base types)
> >drivers/net/bonding/bond_options.c:1089:24:    expected restricted __be32 [addressable] [usertype] target
> >drivers/net/bonding/bond_options.c:1089:24:    got unsigned long long const [usertype] value
> >
> >So fix it
> >
> >Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> >---
> > drivers/net/bonding/bond_main.c    | 2 +-
> > drivers/net/bonding/bond_options.c | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >index 135fec28daa9..07e52d863e91 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> >@@ -2435,7 +2435,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
> >               tags = kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
> >               if (!tags)
> >                       return ERR_PTR(-ENOMEM);
> >-              tags[level].vlan_proto = VLAN_N_VID;
> >+              tags[level].vlan_proto = cpu_to_be16(VLAN_N_VID);
> >               return tags;
> >       }
> >
> >diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> >index da1fc17295d9..3a196999bd1b 100644
> >--- a/drivers/net/bonding/bond_options.c
> >+++ b/drivers/net/bonding/bond_options.c
> >@@ -1086,7 +1086,7 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
> >               else
> >                       netdev_err(bond->dev, "no command found in arp_ip_targets file - use +<addr> or -<addr>\n");
> >       } else {
> >-              target = newval->value;
> >+              target = cpu_to_be32(newval->value);
> >               ret = bond_option_arp_ip_target_add(bond, target);
>
>         I'm not sure this is correct; if I'm reading the call path
> correctly, bond_changelink will
>
>         if (data[IFLA_BOND_ARP_IP_TARGET]) {
> [...]
>                         __be32 target;
> [...]
>                         target = nla_get_be32(attr);
>
>                         bond_opt_initval(&newval, (__force u64)target);
>                         err = __bond_opt_set(bond, BOND_OPT_ARP_TARGETS,
>                                              &newval);
>
>         thus, newval.value is initially be32, but stored in a u64.
> __bond_opt_set will call bond_opt_parse, which in turn will call
> bond_option_arp_ip_targets_set (via .set), and the change above would
> swap the newval.value back to host order (on little endian architectures
> for which cpu_to_be32 is not a no-op).
>
>         Am I misunderstanding?  Did you test this change on an x86 or
> other little endian system?
Hi,
After above patch:
I have enable BONDING config in .config and dmesg:

[    0.247417] Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)

I don't have the HW, so just add printfk in  bond_option_arp_ip_targets_set
However, i don't get what i want to print.
I do the test in qemu-system-x86_64.
I do not know how to hit the driver maybe.
So, not confirmed :(
>
>         -J
>
> ---
>         -Jay Vosburgh, jay.vosburgh@canonical.com
