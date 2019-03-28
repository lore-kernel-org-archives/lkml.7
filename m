Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F540C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF34D206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQb3N6Gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfC1B55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:57:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41144 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC1B54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:57:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id 64so16840056otb.8;
        Wed, 27 Mar 2019 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ivBBs6+MUYsghOg1gzKLwHdHjR1g6lQK4p7aZ/DmP8I=;
        b=WQb3N6GvtoXZZjAPpRvCOW2Jcl82m0zqS1M1hDZj4sCG+uRZTxAof/9W4QqEd88YjK
         SNxy7aD0tKV/1RqFsXz8aos3WtWdWoqjO6Uk5u85P29tkXpSwgxytEJb4hxy+q7DZI+9
         mSN3HV+8g2+vG8fDLvYklSRRwIZMwzssJdxFGIj0ThDolBOu4mMgX7VLtWLGDYHyPjHa
         u9itl3o++BiPYEBGB0aA+c5OIxeAJRQ0bwehfyiPr6oe+7VPlro2aaXGaAhPyQcrmQ5a
         Okxzb9d7D3Wa7PPPhi5HrA/6xbal27ikpdr296I80zyPR37sFMLIi8HZXM+mpFikYBDq
         QFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ivBBs6+MUYsghOg1gzKLwHdHjR1g6lQK4p7aZ/DmP8I=;
        b=OGBh5ryB9R+4tzR+5dqhVzAaGB+DnPmsYps2ICSqUywj4KANifQF1/tcm20zQIX15d
         U5AYe2a0TcjbWbrolnLD7AIGmlifDTKU327E1bMjKKSvi9s1mimemsjoRa/kap3Ys4lK
         v4ohVt00PfGuiHjzu5gFGRpvyubTD45Ekjs2veO16DTfgDDUTmp+p+sZtWBK/Z2wjo/K
         WX7KmxounKc3oagXhQmptYFDdi4ysLfcH5fBYhlxVdwrvziL3/Ozsh4uFsYo2hyzP/S/
         5yEpmQ6EsU1huQZ56zVqOAmFiO5Mzcb7BkKzybfJ9TvXTWRfdVsGTmgqM1Yc2aUkWuh5
         CPVw==
X-Gm-Message-State: APjAAAXbFjXNTZehYczdYtFHTqLnqrNTvRjgsadFfayu6GwlXJzjf1Gf
        ditLud9exFK1XaCvU2RJhk+LrGBx
X-Google-Smtp-Source: APXvYqzjeRmELSZf/5fimecFpPeAUGfi+zMvZ7f1a5bzs8/62bgZejwZmJgn37vOpa+IALT+RfKDmg==
X-Received: by 2002:a9d:7309:: with SMTP id e9mr24057325otk.93.1553738275788;
        Wed, 27 Mar 2019 18:57:55 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id v1sm3942377oto.47.2019.03.27.18.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 18:57:55 -0700 (PDT)
Subject: Re: [PATCH net-next v5 04/22] ethtool: move to its own directory
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <9f7e273e8dbba11b085dda960f16223cd5d716ed.1553532199.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6f4f4ed8-fa4a-5ad0-ad38-92cfaf91b180@gmail.com>
Date:   Wed, 27 Mar 2019 18:57:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9f7e273e8dbba11b085dda960f16223cd5d716ed.1553532199.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> The ethtool netlink interface is going to be split into multiple files so
> that it will be more convenient to put all of them in a separate directory
> net/ethtool. Start by moving current ethtool.c with ioctl interface into
> this directory and renaming it to ioctl.c.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
