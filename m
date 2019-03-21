Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDADC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F8F218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTKVpzlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCUVXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:23:47 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:37766 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfCUVXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:23:46 -0400
Received: by mail-wr1-f45.google.com with SMTP id w10so159523wrm.4;
        Thu, 21 Mar 2019 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GlEgjC7rM/FH6ai247TwK0lttdcBNFbYswanrV+V0Pw=;
        b=oTKVpzlKfMnSuqZlTNnKHZ4INNdhQvAnpRKFzL4pEL9jyxU5goerdpCO84zyqTpe2F
         M5w+HIhlPtHHxp+peCO9poKWUFdkXYJ8vXw7kdvwSJgb0OpgtNO4xTomppFrCwp4OTCk
         cdcwOxfEIOymxmIVF0iI1K+ng9XaNuu6GTE6FvbFohLjccAyGbVSg7N4Gjm7Ss90ZMrS
         /kNtWMNk/WeTMp/LLJX8ylSnFkibW0vTPV2vAx7WX3I0cPX3f5wUvOHWpCKIyTEXdnES
         I4xZevExF5FBWWt64ad0n6d8phS7VIhGljQ5mnt9BCQiv35uPuzJf57HceeS5Ajhb1iY
         st7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GlEgjC7rM/FH6ai247TwK0lttdcBNFbYswanrV+V0Pw=;
        b=OvMxCctDt5gm6GptLf+KIYOMwYllci1iahFE+wMGSHjjgKQAbCRYMnHEdkBvTrUqw6
         eRcfWnQAQOF7QHxG32+kRgNCtKUcHqkV0Xto0VTCMglC3mRa/w/5burZLElKVX4sCKAb
         P0ufD+NSeZmneadXmQrR723lAVP+/tOO4nOFe8jHN0c5kJl9dEi8LajroqSRHD3tP9B5
         09YGb3m2l052q/IAQNVfEJ7lVBK2y/3EyERI82sDLFwFcvCLN/j2mtyp57r+ozIgvf5s
         uJPhKRQd1JKiAJy8o8/ppMOHODwvgkA66wuCpQECEm4iZuKmmqNpRCifd+dw+xDudwDK
         zrWA==
X-Gm-Message-State: APjAAAUOWMlStf8doTTs8B777NfO6sflHZSHR0SxFv91dSZScKNI96e1
        1agGH1Sc7ctCP2GST517Z1o=
X-Google-Smtp-Source: APXvYqwKmuzeHPUaSiKmDr86bmzepk+dkVNaANnVEg+duOc36OVSfclp2Jd0NREoykOI1wy227TZCQ==
X-Received: by 2002:adf:cd90:: with SMTP id q16mr3889509wrj.75.1553203424989;
        Thu, 21 Mar 2019 14:23:44 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bc4:dc00:8497:d0ab:971a:d627? (p200300EA8BC4DC008497D0AB971AD627.dip0.t-ipconnect.de. [2003:ea:8bc4:dc00:8497:d0ab:971a:d627])
        by smtp.googlemail.com with ESMTPSA id n13sm8806897wrw.67.2019.03.21.14.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 14:23:44 -0700 (PDT)
To:     John Linville <linville@tuxdriver.com>,
        Michal Kubecek <mkubecek@suse.cz>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: New ethtool sub-feature and ethtool-netlink
Message-ID: <4ecd48b3-92d6-38a1-11db-5c7b6a0ae341@gmail.com>
Date:   Thu, 21 Mar 2019 22:23:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal / John,

I have an ethtool extension in the pipe that adds one more PHY tunable
sub-feature (for Fast Link Down support). Are smaller extensions still
ok for ethtool, or IOW: When do you think is ethtool-netlink going to
be stable enough so that other developers can add features?

Heiner
