Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BFBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2248221773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLiUPXgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfDXMWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:22:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37870 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfDXMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:22:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id h126so3856840lfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bXQvlRnNM+KcXwHZRouKMVIQAty+h5VGb8o/6gJGFzQ=;
        b=WLiUPXgXeO20vnfjlOLWWkQpS4Qs6AMqBC7I07TRXd32a5Z/oZ05BGy4fs89rE62ql
         7k6AgjQylmvvdca9118fJiJKQRnZMuMAy869Z6wftGY8rUs8rXk57Sm0Ai2JBUL5J9Ed
         MgGFGEJgruGwed6gPphiSVRKHF4zJfjrMC0/6s1c3qbx7o7GUAfYYlxqoqCRnPfhbLVC
         mdI5vA7SJ5AwozDAuUz7yo8h0WdSp5an9gMr7RlT8Nld8lBkYzOong7DD3u2VHAty3u6
         IpsRrYsDFFLmq7x/lhSSyiG8AXyjLEYH2Ggwm9/2f5XZMxjxpwKnsZ9in7RV+98lmrTu
         U1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=bXQvlRnNM+KcXwHZRouKMVIQAty+h5VGb8o/6gJGFzQ=;
        b=gq8ASTiwIKJAXh9WVjOMH+Qx8XcQbmH4QVUYLhmainRTw9RB4zwJB7z4hU3nYcAUYj
         zn4WWNWiVo/673cURoJDUCrUCME+cZ3dUAg7TD9wcpYVnLLvWPUNIYt0h54C3eg721H0
         RzvgTo6cz44HhwGB8jeQnn9qO3/hFuLg0vxEXqJmq05Jiujqwzhmatjc5nctSa47Wm7t
         ugwbvFG3QQ3IqIEI7LXwanrnk2OQ+/b8EKwEK3JJlTOiG56zyTkrKdUpSscrnBjMEKKa
         htUVici6r4C30t7dVcCVFP1qItnFnKeZ7uGGmnkEnbxbZxKWZkBywsfFkBYM+AOjIb9V
         2tHw==
X-Gm-Message-State: APjAAAVIBxWrfDEhcDNdr9vmd1nXgF7BZBtdhxTlykLfbBkV2YaucKqO
        JlxO15Yq4s61dZxD1eZDKo6BGA==
X-Google-Smtp-Source: APXvYqxPGlcz8pA37rVguwsAFS8XOTKMvUPCsKm5GUGyrgszgUyDU6AMbfAPhwZ+CrOegM+vS1GKfw==
X-Received: by 2002:ac2:5a11:: with SMTP id q17mr17324879lfn.145.1556108554839;
        Wed, 24 Apr 2019 05:22:34 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id s21sm5388895lfb.0.2019.04.24.05.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 05:22:34 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:22:32 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH net-next 11/19] net: ethernet: ti: cpsw: fix allmulti cfg
 in dual_mac mode
Message-ID: <20190424122230.GA6075@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Murali Karicheri <m-karicheri2@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-12-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1556024950-20752-12-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:09:02PM +0300, Grygorii Strashko wrote:
>Now CPSW ALE will set/clean Host port bit in Unregistered Multicast Flood
>Mask (UNREG_MCAST_FLOOD_MASK) for every VLAN without checking if this port
>belongs to VLAN or not when ALLMULTI mode flag is set for nedev. This is
>working in non dual_mac mode, but in dual_mac - it causes
>enabling/disabling ALLMULTI flag for both ports.
>
>Hence fix it by adding additional parameter to cpsw_ale_set_allmulti() to
>specify ALE port number for which ALLMULTI has to be enabled and check if
>port belongs to VLAN before modifying UNREG_MCAST_FLOOD_MASK.
>
>Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>---
> drivers/net/ethernet/ti/cpsw.c     | 12 +++++++++---
> drivers/net/ethernet/ti/cpsw_ale.c | 12 ++++++++++--
> drivers/net/ethernet/ti/cpsw_ale.h |  2 +-
> 3 files changed, 20 insertions(+), 6 deletions(-)
>
[...]
>+		vlan_members =
>+			cpsw_ale_get_vlan_member_list(ale_entry,
>+						      ale->vlan_field_bits);
Seems like declaration for cpsw_ale_get_vlan_member_list() is not
part of the patchset


-- 
Regards,
Ivan Khoronzhuk
