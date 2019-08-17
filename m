Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4032C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A2021019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4KSK8xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHQDbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 23:31:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38662 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfHQDbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 23:31:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id o70so4089742pfg.5;
        Fri, 16 Aug 2019 20:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2RIYBSqaW9B0+jqKPfPWcoOlSXjDrR85LCXqcPmva5Y=;
        b=A4KSK8xpkCI5Eg4uytjiDcOxddY1LTdB9kMK+2t3QiiiRTN31DfrMlGurMYGrBKZe6
         1o5mGpMo0/4FYb1tgNfzxvoUDtYIXOmRvqs2oWb61cgMEir4fjQZrNOAbBqmCSysnAcR
         /xfMaxgkzWEcKSO614pEVXPz6GUD5EnAW8TikjfkRv/TiT/NMgF11b+URLF+WsXfUuY4
         OGy0AfBpeF9NgtZbV6x6bomr/yIKnswkLzcv9+wHLi8GVlgehWcpM/UaCQzjvgiZq4lS
         +Ud1mP7Squxy22v9rX/c8rFwW2HH7Rsr1yaWxiINCEEmEp3XhDeuwmDWuQetdkg2qsvU
         Jk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2RIYBSqaW9B0+jqKPfPWcoOlSXjDrR85LCXqcPmva5Y=;
        b=cv9c5GFYp3MRH4ocE0QUIQrDyUxvmfzAX0io4yHfiHsBCvvi3qoftGLkdEXquFH4Ud
         7UvFpN5doQnqgkwszaBTofERYMEvronGhtTqJSMzJCkj+1LHFTCaxssl3rkMsikdrWEd
         CKa9iUAgk3g5QFAHE6unZPZ43dmFYn6hjKVg6CAvysn8nK+z0XNG02+u5LWevmnxBLPH
         RCjmCZMxAHiyEiEo+4pgIfO4wxh7GYHyrUPtoe7frxJczmtGgbCUOl0G1fK08VIvxc9P
         YRZuB+1HgC9nVLxU+dPJJfZu88oc3E/TVGNU4SN22anFtfOmqFpnTofz/FgBgGP1sn9T
         SDvQ==
X-Gm-Message-State: APjAAAW42RMAaUKXziZMO68B5y7xYhANWWMLoK7tqYp80De3EKtXqMK1
        WT9B6yP+m4fyYK0GEBmucpoyy0fp
X-Google-Smtp-Source: APXvYqwMUquunuVYuLKbURtCv8yQ4wtOlAgnC/mGp4ShPvgD6Q2h+3vm9ie1RuUl74KBoPF9DwOXTQ==
X-Received: by 2002:a17:90a:b947:: with SMTP id f7mr9716422pjw.112.1566012662979;
        Fri, 16 Aug 2019 20:31:02 -0700 (PDT)
Received: from localhost (c-73-222-71-142.hsd1.ca.comcast.net. [73.222.71.142])
        by smtp.gmail.com with ESMTPSA id o14sm4854056pjp.19.2019.08.16.20.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 20:31:02 -0700 (PDT)
Date:   Fri, 16 Aug 2019 20:30:59 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Hubert Feurstein <h.feurstein@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 1/3] net: mdio: add support for passing a PTP
 system timestamp to the mii_bus driver
Message-ID: <20190817033059.GA1336@localhost>
References: <20190816163157.25314-1-h.feurstein@gmail.com>
 <20190816163157.25314-2-h.feurstein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816163157.25314-2-h.feurstein@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 06:31:55PM +0200, Hubert Feurstein wrote:
>  
>  int __mdiobus_read(struct mii_bus *bus, int addr, u32 regnum);
>  int __mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val);
> +int __mdiobus_write_sts(struct mii_bus *bus, int addr, u32 regnum, u16 val,
> +			struct ptp_system_timestamp *sts);
>  
>  int mdiobus_read(struct mii_bus *bus, int addr, u32 regnum);
>  int mdiobus_read_nested(struct mii_bus *bus, int addr, u32 regnum);
>  int mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val);
>  int mdiobus_write_nested(struct mii_bus *bus, int addr, u32 regnum, u16 val);
> +int mdiobus_write_sts(struct mii_bus *bus, int addr, u32 regnum, u16 val,
> +		      struct ptp_system_timestamp *sts);
> +int mdiobus_write_sts_nested(struct mii_bus *bus, int addr, u32 regnum, u16 val,
> +			     struct ptp_system_timestamp *sts);

Following the pattern, you have made three new global
mdiobus_write_sts() functions.  However, your patch set only uses
mdiobus_write_sts_nested().

Please don't add global functions with no users.  Let the first user
add them, if and when the need arises.

Thanks,
Richard
