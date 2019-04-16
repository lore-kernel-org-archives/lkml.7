Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C826CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8103520880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsbQvWPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfDPXtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:49:20 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44265 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDPXtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:49:19 -0400
Received: by mail-oi1-f195.google.com with SMTP id i21so18507616oib.11;
        Tue, 16 Apr 2019 16:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sj2bGXUzG9rxu4l2125e6zPez0HcyhxtivIaPAodRK8=;
        b=gsbQvWPE2dO9Rhvm4zpfOvvelcHWz7TN5/addB9J4pHGUdOSWIm3nTGGcGICBwsq0d
         AzGOZ1GhXJb4h6MK3YqWdM7MXEnu0FYUKizTfHyEhh0OtNdkatQh82jtp3/UVvW4Foxk
         Q4tM5lO9UjoV2KZQ2nU5OK63eT8cg2hPK4Q4OD8RfEDm395vWrDENXbNkXCaHaxhAX28
         5yTs6XlLPNLmezmuc4X2tTNt2HxRDqtslZX7HM3URmbZROkQQVSE7KFfRo2TSWqvzIcd
         LvciMhUh+Xt+GETvuzqJWsgLBTYTXGjizuy/n2NfSgmE6r0JVvkVLX6XCDEA350fVtoj
         KMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sj2bGXUzG9rxu4l2125e6zPez0HcyhxtivIaPAodRK8=;
        b=TD/r/7btfO3bvJCYEG6dvJQ7ND+2G6NbIvVK72C0KsD5a+6JdezP3a13pGaAXsmREr
         JiwXfab7HQKv0WcOqYbztZSRqEI5Fj6ST9gggvmztYkjzIOhzuYG92WnkchoEh/r9pVj
         Oq/UeAMsfK4ns/LS1coB71Y8zjtlGORyJK8xV3SPllmRbrlL3P+LZ+nlFkgijCYGBCu1
         CWOP8TzkpJkd2K7rUIcLstumQ+gc804hsYw6LPnzWPIpr+nk81jHEIBd+9LCSnB4Dd3F
         wl2MzsWfmRpSuzg7WrU98s2Q9n/qcsyic3zyAallaupsqszZI6l1+Oeyj/Fh+PtdUAW1
         Dg0w==
X-Gm-Message-State: APjAAAWgAOlIY0F+PjLv/n2jHN7EX6FxCA+pIyqmzESylLgfF40jB/rO
        1ZYqGeMpcpvT2pDhmeL8/5M=
X-Google-Smtp-Source: APXvYqylp3H3mHmhQL7UynyBND5NWP7mtT5xxp8PdhJGkUlmT9gKXqhm3d3ST2Uwhcn+u4zuQ6/u9w==
X-Received: by 2002:aca:d7d5:: with SMTP id o204mr25175707oig.23.1555458559083;
        Tue, 16 Apr 2019 16:49:19 -0700 (PDT)
Received: from [192.168.1.2] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.googlemail.com with ESMTPSA id o5sm17204409otl.44.2019.04.16.16.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 16:49:17 -0700 (PDT)
Subject: Re: [PATCH v3 net-next 05/24] net: dsa: Add more convenient functions
 for installing port VLANs
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-6-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <21ae55ee-a8d8-f1fa-1997-614e2b90930f@gmail.com>
Date:   Tue, 16 Apr 2019 16:49:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190413012822.30931-6-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2019 18:28, Vladimir Oltean wrote:
> This hides the need to perform a two-phase transaction and construct a
> switchdev_obj_port_vlan struct.
> 
> Call graph (including a function that will be introduced in a follow-up
> patch) looks like this now (same for the *_vlan_del function):
> 
> dsa_slave_vlan_rx_add_vid   dsa_port_setup_8021q_tagging
>              |                        |
>              |                        |
>              |          +-------------+
>              |          |
>              v          v
>             dsa_port_vid_add      dsa_slave_port_obj_add
>                    |                         |
>                    +-------+         +-------+
>                            |         |
>                            v         v
>                         dsa_port_vlan_add
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
