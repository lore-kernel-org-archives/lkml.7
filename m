Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7788C206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6F3B+bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfC1CFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:05:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43149 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfC1CFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:05:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id m10so4196898plt.10;
        Wed, 27 Mar 2019 19:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=guzd6o9wUY5BocD6FHf8NbFcEpn822XgsgtY5eNNa1s=;
        b=E6F3B+boJJWqw2YdfePXq/YvuXTRbLZ6mr6WhMO+aFogESED+PyYiJ4amhmvi0iJXc
         mKh+S5lMIFsGLOeDR63fF0ZzXti3IfU5m2nUiLEjFKEm0OqWswl/oPc2HKsZweLzaD+Q
         ivVh+KlqHZCYGJa7fAfKBbXghqWNxS6gJzDaOlaq3Hu9/2+M8zqft6IanD+B9fX1CD3N
         2lV/mqmCL69u6AFHYQipCJKB0vnLBy5xgl7EF2PpiGJbTwSGXgtkr3y2TnWjept0DajK
         9XpEqjKSgu/IrSoMO+0qZ2VaH3eUN0d/qbNJg1lPOHOqIZ0fLaTlVp7z/QABaUY7R944
         ttcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=guzd6o9wUY5BocD6FHf8NbFcEpn822XgsgtY5eNNa1s=;
        b=JREcpzHUk0WOC6pjmrv9qFokHMJFGhv2c7/oS0A90OP9qQZLa5tW+iKgIgpJcySInV
         Yf4CwcD8ds1LSjAlpN9Px6SpOpeNBttJx/Out4wJOXQwrbywISkfA98l6Q1KJBw67N5H
         2auFjYE6QbC64/S//AXMrMrgNke0IRfk5U8zzPvGhaLWKfdOc5uG1pjVxrywNFqcf/h8
         A8UL3x1XukG4iO7sG2nQCCOqBgyPYZsjHjbdwaT1CfO/BLEJ5pA0speDnPXfeVOet2Jw
         zF/i+dL+OSysH5Hbm6NbLzERSktB+Qo4Kr1je0bVJkJZQVcbdCbNDR5UvWf1sn5cb4yE
         DUHA==
X-Gm-Message-State: APjAAAX9HM4eNJiXB/aSnfOKV3psPZxZj8j+MajIHiMcXoat81r3/5gv
        5hHVGQtW4POl0yIwXnKlYnDQOvEv
X-Google-Smtp-Source: APXvYqzxGu1jOvCJ6dhkNKVLuV3S82O7CPQeLCcjJdJy859zr4OhtiNsM6muEUTYXGytMYu6Ggf2IA==
X-Received: by 2002:a17:902:7441:: with SMTP id e1mr6585603plt.13.1553738720275;
        Wed, 27 Mar 2019 19:05:20 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id i64sm33682607pfb.112.2019.03.27.19.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 19:05:19 -0700 (PDT)
Subject: Re: [PATCH net-next v5 05/22] ethtool: introduce ethtool netlink
 interface
To:     Jiri Pirko <jiri@resnulli.us>, Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <8795d07d3315b232b4e7ebc7d109c9aa3185e555.1553532199.git.mkubecek@suse.cz>
 <20190326120909.GF2230@nanopsycho> <20190326132427.GK26076@unicorn.suse.cz>
 <20190326134251.GA5181@nanopsycho.orion>
 <20190327092604.GP26076@unicorn.suse.cz> <20190327095023.GC6979@nanopsycho>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <7e883a7c-7f1a-b1a0-4735-0ad368998c65@gmail.com>
Date:   Wed, 27 Mar 2019 19:05:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327095023.GC6979@nanopsycho>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2019 2:50 AM, Jiri Pirko wrote:
> 
> Why don't you have ETHTOOL_MSG_SET_FOO for set? I think that for
> kerne->userspace the ETHTOOL_MSG_FOO if fine. I would change the
> ordering of words thought, but it is cosmetics:
> ETHTOOL_MSG_FOO /* kernel->userspace messages - replies, notifications */
> ETHTOOL_MSG_FOO_GET
> ETHTOOL_MSG_FOO_SET
> ETHTOOL_MSG_FOO_ACT
> 
> What do you think?

We could even name the notification explicitly with: ETHTOOL_MSG_NOTIF
or ETHTOOL_MSG_NTF just so we spell out exactly what those messages are.
-- 
Florian
