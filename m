Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DDBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B62206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyEDN1hX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfC1Dqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:46:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45847 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfC1Dqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:46:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so9841646pfi.12;
        Wed, 27 Mar 2019 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J1Eo6nU3SVGXH/jrNcm5d/MjgzYaIWSDTPeTwACAfL8=;
        b=TyEDN1hXTk3o3XqxejY1ZcdkC+FUSaZom83i2AfEVPMa3SfgP4OVpfySZ297r/553p
         ci+eENWvH9lz21gEHtgXnBNuQPeNgnmbykun7aWni5YLTkb0yMIs+0XdbxTumrRrFy49
         IjIhKXGgSQjxVH/g9KIC3j+AFDQllwtDtCoahaF4x/AjfI7SA+yrGnmkz6/QD7lY00Bu
         S5iz934vzwMgiJTfSVTEYQ2lK2SAchRL9YM7O+voYy4YDtikePmX+2dWD4liIWra3oz1
         Y9V6PkuP6rgEPvCZ3w4VfoXEeTYtc8GR/zSxynAMoe4ivBJJskKfzgbl87N7m99HYHkP
         8Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J1Eo6nU3SVGXH/jrNcm5d/MjgzYaIWSDTPeTwACAfL8=;
        b=Upc2tKGIvlaDw5bbthenjoAcAI2Fguoptf8t9tAau50q/BHnLqVF3VI0lwyYPTfD+z
         TxE+odqrxe4YyO7wHBXYOIJCrW83HO9DafGGtjGEXc4MLvvf1Bv/rGFes19DBhaUAJR3
         5yvJmTbEtvH/ghy3avIUPSamjiWXrsHdIxMPsRPBrMq82xwWBT60NpOHMp8FdB7GXHSe
         yZGdHQi+EPPVzfi0kxH2YLBvsKycHtJGuFFN1EJKKASgQtKgfyhy3CJTZp0EC3p+WMFO
         qDi6UPbEpDRRjoWar4YXsTz+oQtiQ98tjgvYTchGFULDrkdrMYE4gyzJ7RanYVDMqFfc
         4eFQ==
X-Gm-Message-State: APjAAAUKXGIQ4+ohy6Wfigj7ubyn9WiFNU8OjgoOLTuv2/sQnTy8xGeb
        8xMbbTPLIMdpA+UYBBe0TvaVxtD+
X-Google-Smtp-Source: APXvYqzRLcTM8RcokjsC1Qnb/bwflSmsCr+ybzkzIv5H+l7uC/0j6E11PSVAVqR1kKGeUoOb/aptdA==
X-Received: by 2002:a62:3186:: with SMTP id x128mr21353737pfx.30.1553744804966;
        Wed, 27 Mar 2019 20:46:44 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id g4sm8668224pfm.115.2019.03.27.20.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 20:46:44 -0700 (PDT)
Subject: Re: [PATCH net-next v5 21/22] ethtool: provide message level in
 GET_SETTINGS request
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <2eb71652408bf0cd97194069f68d264cf8070693.1553532199.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <02fb81c1-506c-4116-d4b6-590e27871a00@gmail.com>
Date:   Wed, 27 Mar 2019 20:46:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2eb71652408bf0cd97194069f68d264cf8070693.1553532199.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> Add information about supported and enabled message levels to the
> GET_SETTINGS reply when ETH_SETTINGS_IM_DEBUG flag is set in the
> request.
> 
> Unlike in the ioctl interface, "message level" is called "message mask" as
> it is in fact interpreted as a bit mask. It is put into a nested attribute
> ETHA_SETTINGS_DEBUG to allow future extensions (e.g. an actual verbosity
> level).
> 
> Send notification in the same format as reply when message level is
> modified using the ioctl interface (ETHTOOL_SMSGLVL command).
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
