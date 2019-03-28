Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AC3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20555206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+vWxTir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfC1DpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:45:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33078 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfC1DpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:45:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so2062077pfd.0;
        Wed, 27 Mar 2019 20:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VBX33lNj+ZwXpsyL+REOEB35dxU2KLuauM6csvDz2Hw=;
        b=b+vWxTir+6Y8DmNAGDKjSDCVvvIgTA3FuX6ulJJL/d18Vqge9PLIQ2YoPLGCgir47E
         mkzUbffzRRt8/EA/tGZrpQKvQP0ZvHSLTtrrj5CN6gWsrurkT5YRyclbFzCvTlZgtEtS
         VI2tB+H8ydWwLm7rfQc4hNnmWISoAtNE0UF/EfvPFWYHt47owd8Eqsbkk+bzxnG4au3r
         o6a8OAllu68cOc6kzmXE63q4EUoAsKP2U1jbkJgLHWr3iPQhN78fMLXyFFlv9zkUID2g
         xcv/46lDz+DUzEd4yHoVDYTmj4uzziOl0M751e/EjyNVq4xK+NxQusbQlxSuiCkwlCNk
         UljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VBX33lNj+ZwXpsyL+REOEB35dxU2KLuauM6csvDz2Hw=;
        b=MY+VbJm4l4RUrAK/VjcYWqtvSS3An2FOYomEGV1eCUwaIWfE3rBz76T/wmS/s4JoQh
         emBLiA/Bdt5pFxUxW29NZvsarQo8PwB2WK3o0mvTe4LgdE/Kz+On3qe3Xfb7xoU5/ocS
         hp9EBJKJRc285Ol4/PRE/DH/fVsV3mrxyZWBh9TrstvXUkkzo5dBSNrwI0O8XTsVqqA5
         OhZy50C4LUp6J+3jyFzVnn3JVkFvMtJiArEYG2Q4DXh9wHbprHAGV+b50NCaOCiynY+y
         5IqpMOvCZCfLrVuJFCVDdK5oOBR+HIkGjCDD6i3AsVApH/9565h/RmOQ3b4aMgBxapXO
         MpZA==
X-Gm-Message-State: APjAAAUtw5cQpKkHKLlZTVx8GCmVudyRkzjj7c28buahJmwKJSzCGZ4b
        jrl+hzLXTA4kvA7HBBLYjHu9B+l1
X-Google-Smtp-Source: APXvYqx2KbiHc6STLc1v0XhzHbovBQRtu2xyujoIV1nZV9C0p+VUwHEcNATZIk+TYuqdIYZVcXhLgA==
X-Received: by 2002:a63:1410:: with SMTP id u16mr36429952pgl.420.1553744704014;
        Wed, 27 Mar 2019 20:45:04 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id i24sm17815768pfo.85.2019.03.27.20.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 20:45:02 -0700 (PDT)
Subject: Re: [PATCH net-next v5 16/22] ethtool: provide link settings and link
 modes in GET_SETTINGS request
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <0ae3153e1816aea673f2ec8b4bd3898638aa07f7.1553532199.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <8fe118a8-2a51-5740-de68-300f52a81861@gmail.com>
Date:   Wed, 27 Mar 2019 20:44:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0ae3153e1816aea673f2ec8b4bd3898638aa07f7.1553532199.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> Implement GET_SETTINGS netlink request to get link settings and link mode
> information provided by ETHTOOL_GLINKSETTINGS ioctl command.
> 
> The information in SET_SETTINGS message sent as reply is divided into two
> parts: autonegotiation, speed, duplex and supported, advertised and peer
> advertised link modes when ETH_SETTINGS_IM_LINKMODES flag is set in the
> request and other settings when ETH_SETTINGS_IM_LINKINFO is set.
> 
> Send notification in the same format as the reply message when relevant
> fields are modified using the ioctl interface (ETHTOOL_SLINKSETTINGS or
> ETHTOOL_SSET command).
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---

[snip]

> +    ETHA_SETTINGS_DEV		(nested)	device identification
> +    ETHA_SETTINGS_LINK_INFO	(nested)	link settings
> +        ETHA_LINKINFO_PORT		(u8)		physical port
> +        ETHA_LINKINFO_PHYADDR		(u8)		MDIO address of phy
> +        ETHA_LINKINFO_TP_MDIX		(u8)		MDI(-X) status
> +        ETHA_LINKINFO_TP_MDIX_CTRL	(u8)		MDI(-X) control
> +        ETHA_LINKINFO_TRANSCEIVER	(u8)		transceiver
> +    ETHA_SETTINGS_LINK_MODES	(nested)	link modes
> +        ETHA_LINKMODES_AUTONEG		(u8)		autoneotiation status

Typo: auto-negotiation status.
-- 
Florian
