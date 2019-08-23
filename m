Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12E0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EFD22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH6tm+I0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392268AbfHWGA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 02:00:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32971 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390268AbfHWGA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 02:00:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so7502101wrr.0;
        Thu, 22 Aug 2019 23:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bnx3drhgBojsxXSjNz/LX/58PzRZIyvtnFmVl/O9W9o=;
        b=FH6tm+I0vXfXBNn5kT1vWdfewrWGcpstqwWmY0QrNr6B20tsUhVnlk3iWqwT6sXB5i
         mS8rh5Qhe/Uw8gP9IeOkzkyZvJiiEvIA4qa9yRj7wtqcJINC8OiNa0vHUVE9Ji9Xomff
         TPn+7T1qWBwOwlX1ICCQrWwVg5tRj9AvMhKaW2N7OOGnvR+8Jw1dy9TTM/yQtjO38LTQ
         FlfUZX1OwDbnh5GeruNVPP/erEwlRfHcM0cVdOOixNPZiTuNkQ2cjrRAF4oETO/Ol2k2
         LO/9TB5v840soGQd8KF+Mn/D1wr/92VfLCqxGAVVXAXix5I5FHRfYdGkuj0MSZhSfyE4
         QtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bnx3drhgBojsxXSjNz/LX/58PzRZIyvtnFmVl/O9W9o=;
        b=XGKaGLt9YAywchsSBCU6pR/4hft0a2rD1LEb5p+qynKpsW8fDOHJdIbvieztZmn9Aq
         9WbLUojph+gey2LL+IaTuRHtEdrGplPsUlkuCPyMuZdtAr5KSB/++1I0UK1NZHYehHe7
         HUK7dtP667pehoTviEU3awd/mJZoBG5R63fpYSQ2yLX1d+Wk55i/WFViqWz6x2Enqw6u
         dk9FfnbNT1amlEVtrrzOY644aWaR8ukfhaslY7Ay23yCvy6c6US9e9bRSMjCYPgNyTm3
         b/jhodiIBm7lQAcLih4pZdcfMMG1Bm7S9t658lQkmAHKJnSJgrqUDvR1KJxKifWA3tOt
         Vavw==
X-Gm-Message-State: APjAAAVULGx3U4q5ofhPiy8LcG1/1FlaBi0P6JzGU3xVGoALxoc3I3UW
        bQBNGFt0ORIXwYT4PxMvV6E=
X-Google-Smtp-Source: APXvYqxk8r6PbJIj0ibaNZgUr3m/89W6CTkUXCnjqwA/febJ0SgN3dmw6nHP79rW5I1HVa7+vy9sRw==
X-Received: by 2002:adf:ef05:: with SMTP id e5mr2922124wro.158.1566540054822;
        Thu, 22 Aug 2019 23:00:54 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:34d1:4088:cd1d:73a7? (p200300EA8F047C0034D14088CD1D73A7.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:34d1:4088:cd1d:73a7])
        by smtp.googlemail.com with ESMTPSA id u6sm1501142wmm.26.2019.08.22.23.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 23:00:54 -0700 (PDT)
Subject: Re: [PATCH v2 net] Add genphy_c45_config_aneg() function to phy-c45.c
To:     David Miller <davem@davemloft.net>, marco.hartmann@nxp.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, christian.herber@nxp.com
References: <1566385208-23523-1-git-send-email-marco.hartmann@nxp.com>
 <20190822.161520.1087789793326068678.davem@davemloft.net>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <8369d425-adb3-8332-b2e1-7464a74d2809@gmail.com>
Date:   Fri, 23 Aug 2019 08:00:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822.161520.1087789793326068678.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.2019 01:15, David Miller wrote:
> From: Marco Hartmann <marco.hartmann@nxp.com>
> Date: Wed, 21 Aug 2019 11:00:46 +0000
> 
>> Commit 34786005eca3 ("net: phy: prevent PHYs w/o Clause 22 regs from calling
>> genphy_config_aneg") introduced a check that aborts phy_config_aneg()
>> if the phy is a C45 phy.
>> This causes phy_state_machine() to call phy_error() so that the phy
>> ends up in PHY_HALTED state.
>>
>> Instead of returning -EOPNOTSUPP, call genphy_c45_config_aneg()
>> (analogous to the C22 case) so that the state machine can run
>> correctly.
>>
>> genphy_c45_config_aneg() closely resembles mv3310_config_aneg()
>> in drivers/net/phy/marvell10g.c, excluding vendor specific
>> configurations for 1000BaseT.
>>
>> Fixes: 22b56e827093 ("net: phy: replace genphy_10g_driver with genphy_c45_driver")
>>
>> Signed-off-by: Marco Hartmann <marco.hartmann@nxp.com>
> 
> Andrew, Heiner, et al. where are we with this patch?
> 
For me this patch would be ok, even though this generic config_aneg
doesn't support 1000BaseT.
1. The whole genphy_c45 driver doesn't make sense w/o a config_aneg
   callback implementation.
2. It can serve as a temporary fallback for new C45 PHY's that don't
   have a dedicated driver yet.
3. We may have C45 PHYs not supporting 1000BaseT (e.g. T1).

Andrew?

Heiner
