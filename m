Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8320C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8492080F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="wmtgKbFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfH2MSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:18:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40233 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfH2MSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:18:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id t9so3613828wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pFWLKMGVr3USsr0a1cWm+DfSSpAfEVTSRCcxqOxrU7I=;
        b=wmtgKbFmXIVzs79+qMDp0xCzdOv8uq28M4avUrOGEYSn/W+dSFiqQbF9ogfUOoKHqn
         2J0T4FfqNpP8v3my/Wr4FmY0rI+FisIHK30ccr5XS/L2BPwQDKDYtVc9CUQa7Bz7o0by
         Kr2kUMXXSWVMASAKsTv6W358JnLNitrYIi9eliUV+yU1BEWnvBjOH8DgZwox3JSAVIMH
         nkreeicyyLO0/BbL1xc7BTNLquY90pmSuIIyqe+qpW0cPxN/hvuxeMOZ6JeAdP3ltpTP
         zZp0nVPM9j6oqwJVT2D9Gl22+M0NdHvidANEaVAi0CAKJyalJ+IJFUIMTrLvM9jY7NbS
         MTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pFWLKMGVr3USsr0a1cWm+DfSSpAfEVTSRCcxqOxrU7I=;
        b=U1O1DEtFVh94hYf8Egf2+skOEE/GfvsNUf4mTAVsxzNKhI3TPrP+5+nb5wvAlmwH21
         Ojs9G6br7jdp4tMhamcXOYuRkpyzRvV8MS02eFqLKHhiLD+f/CCcBLKFw+u/jd0g2w0v
         wyAWk7lOSiPOmVhO/3SSm7Fx/jrFKvQmc4KwwgsSHmLHtyM0iH3fuuVIciGqPN/qaCnk
         /o6wJp1hL92jvXRjwKoETi+zptyKOfH6XeC7MNEYQAtfaxYXKVAfEH7kz/axiGdxKqeF
         Ll3YApV4hgjx31fdINhgTOU7fAaf8DQr+VTQ6Cq0rd2OXQNs09UGU6O746kEPBf9Dl0n
         n1XQ==
X-Gm-Message-State: APjAAAXKtISv1AM/FbsBgu24YOTB21LJBwZr/Xm1XatiQ0+7CyixBH8X
        CuSNAhSIf/aZfx4zotsqrzzTjA==
X-Google-Smtp-Source: APXvYqy7Ec8bHc8q+5nwy+bHjwCusSCjNoIgVIc1Dc5ySNw35xIAKkjMFK2gPtqpvtymYbmodq2kJQ==
X-Received: by 2002:a05:600c:254c:: with SMTP id e12mr10949332wma.72.1567081092640;
        Thu, 29 Aug 2019 05:18:12 -0700 (PDT)
Received: from localhost (ip-78-45-163-186.net.upcbroadband.cz. [78.45.163.186])
        by smtp.gmail.com with ESMTPSA id a17sm2726450wmm.47.2019.08.29.05.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 05:18:12 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:18:11 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, andrew@lunn.ch, allan.nielsen@microchip.com,
        ivecera@redhat.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: core: Notify on changes to dev->promiscuity.
Message-ID: <20190829121811.GI2312@nanopsycho>
References: <1567070549-29255-1-git-send-email-horatiu.vultur@microchip.com>
 <1567070549-29255-2-git-send-email-horatiu.vultur@microchip.com>
 <20190829095100.GH2312@nanopsycho>
 <20190829105650.btgvytgja63sx6wx@soft-dev3.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829105650.btgvytgja63sx6wx@soft-dev3.microsemi.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Aug 29, 2019 at 12:56:54PM CEST, horatiu.vultur@microchip.com wrote:
>The 08/29/2019 11:51, Jiri Pirko wrote:
>> External E-Mail
>> 
>> 
>> Thu, Aug 29, 2019 at 11:22:28AM CEST, horatiu.vultur@microchip.com wrote:
>> >Add the SWITCHDEV_ATTR_ID_PORT_PROMISCUITY switchdev notification type,
>> >used to indicate whenever the dev promiscuity counter is changed.
>> >
>> >The notification doesn't use any switchdev_attr attribute because in the
>> >notifier callbacks is it possible to get the dev and read directly
>> >the promiscuity value.
>> >
>> >Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
>> >---
>> > include/net/switchdev.h | 1 +
>> > net/core/dev.c          | 9 +++++++++
>> > 2 files changed, 10 insertions(+)
>> >
>> >diff --git a/include/net/switchdev.h b/include/net/switchdev.h
>> >index aee86a1..14b1617 100644
>> >--- a/include/net/switchdev.h
>> >+++ b/include/net/switchdev.h
>> >@@ -40,6 +40,7 @@ enum switchdev_attr_id {
>> > 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
>> > 	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
>> > 	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
>> >+	SWITCHDEV_ATTR_ID_PORT_PROMISCUITY,
>> > };
>> > 
>> > struct switchdev_attr {
>> >diff --git a/net/core/dev.c b/net/core/dev.c
>> >index 49589ed..40c74f2 100644
>> >--- a/net/core/dev.c
>> >+++ b/net/core/dev.c
>> >@@ -142,6 +142,7 @@
>> > #include <linux/net_namespace.h>
>> > #include <linux/indirect_call_wrapper.h>
>> > #include <net/devlink.h>
>> >+#include <net/switchdev.h>
>> > 
>> > #include "net-sysfs.h"
>> > 
>> >@@ -7377,6 +7378,11 @@ static void dev_change_rx_flags(struct net_device *dev, int flags)
>> > static int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
>> > {
>> > 	unsigned int old_flags = dev->flags;
>> >+	struct switchdev_attr attr = {
>> >+		.orig_dev = dev,
>> >+		.id = SWITCHDEV_ATTR_ID_PORT_PROMISCUITY,
>> >+		.flags = SWITCHDEV_F_DEFER,
>> 
>
>Hi Jiri,
>
>> NACK
>> 
>> This is invalid usecase for switchdev infra. Switchdev is there for
>> bridge offload purposes only.
>> 
>> For promiscuity changes, the infrastructure is already present in the
>> code. See __dev_notify_flags(). it calls:
>> call_netdevice_notifiers_info(NETDEV_CHANGE, &change_info.info)
>> and you can actually see the changed flag in ".flags_changed".
>Yes, you are right. But in case the port is part of a bridge and then
>enable promisc mode by a user space application(tpcdump) then the drivers

If the promisc is on, it is on. Why do you need to know who enabled it?

Or do you want to use this to ask driver to ask hw to trap packets to
kernel? If yes, I don't think it is correct. If you want to "steal" some
packets from the hw forwarding datapath, use TC action "trap".


>will not be notified. The reason is that the dev->flags will still be the
>same(because IFF_PROMISC was already set) and only promiscuity will be
>changed.
>
>One fix could be to call __dev_notify_flags() no matter when the
>promisc is enable or disabled.
>
>> 
>> You just have to register netdev notifier block in your driver. Grep
>> for: register_netdevice_notifier
>> 
>> 
>> >+	};
>> > 	kuid_t uid;
>> > 	kgid_t gid;
>> > 
>> >@@ -7419,6 +7425,9 @@ static int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
>> > 	}
>> > 	if (notify)
>> > 		__dev_notify_flags(dev, old_flags, IFF_PROMISC);
>> >+
>> >+	switchdev_port_attr_set(dev, &attr);
>> >+
>> > 	return 0;
>> > }
>> > 
>> >-- 
>> >2.7.4
>> >
>> 
>
>-- 
>/Horatiu
