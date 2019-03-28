Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B9AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01668206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTeuxtvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfC1B5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:57:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38742 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC1B5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:57:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id e80so16875173ote.5;
        Wed, 27 Mar 2019 18:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZuyvGxlUFKb1IZG9Q9FQdggww/bT/ghiN9QE5z6WSTw=;
        b=oTeuxtvyOioBh/Qi4/Zg/zpqRjeTUtfJ2+39JzTOwDsYAiASC8RhvaTVaAodJkeZeW
         kPZzjlZFQJGmqZBHJf9f9Kv5y58h2Z3Xo0AHA3bP19NAGt1qWzM8i69PHbNZNG5XhQcS
         FzMYsmKpGojnU+ArV2u5isAIORVNhQUZaJZlFAJgzlVkJ2cbZ3GZSHrL715EGJSSxMwO
         PWH1Mv0j1uJnYz1UUcblF6PPs5s1XyYEps9q8rZncbrueTBO8RzOP08ngUJblgk+V5YK
         5i9Z62NtGoz7YzmkAIY1Ewl8BztbIYUZPmZPvfcO3A91yK+ElHeXouE9+SPntvWFMsyQ
         Y4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZuyvGxlUFKb1IZG9Q9FQdggww/bT/ghiN9QE5z6WSTw=;
        b=Hcpphnz71HA94gxt9ToJ2IZACpuGmmfgFFWRGYBxX4FYa7uG1st8F1EOPLoXF/El8b
         nfYtgV3lFL3aYP5veoeZ2ji/5Vfvm4U+CNcjaKeX5Tj8Myyy01qRSpy1DAUE6mnCavP6
         7ctbdJtYneYMPxF3T914cTB71Be1yhMxMv9SOXWj27i/BCoHbW9/MfdgO+n/E2CZAJ5F
         dfjR7ZLFnZl1HyGuQEnmvaYna6y4QIheDr5SLDH9DPNVX4k8Bz2boR6JXZ5Gv292Dpbo
         PTOZY5XmZICsg9zwKbhHoF1ZtGZf8RHmyB0gbuLK4P33diop758we/4QkxsT8UoLfYzj
         scUQ==
X-Gm-Message-State: APjAAAU1t2qw0P6hY6l3l6X39aypPp08ZJOwvHwKZMl4fleAkqFaTscg
        odJfa8s72hUfNWPP3DsvD0kHhH2A
X-Google-Smtp-Source: APXvYqwpYrtwMqHG1PwV+lUhcS6Grxic/GTTK3BixzgTL73QaG97jsUPBOiGrCJKgZC40QjMjExj1g==
X-Received: by 2002:a9d:ec3:: with SMTP id 61mr30325784otj.43.1553738239302;
        Wed, 27 Mar 2019 18:57:19 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id a140sm2047540oii.17.2019.03.27.18.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 18:57:18 -0700 (PDT)
Subject: Re: [PATCH net-next v5 03/22] netlink: add strict version of
 nla_parse_nested()
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <3a0ca34890256f86a4ca0c4f4582a0cff5af95ad.1553532199.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <84a36184-d456-1a01-bb33-e9f1511c7546@gmail.com>
Date:   Wed, 27 Mar 2019 18:57:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3a0ca34890256f86a4ca0c4f4582a0cff5af95ad.1553532199.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> Similar to nla_parse_strict() and nlmsg_parse_strict(), add also
> nla_parse_nested_strict() as a version of nla_parse_nested() with strict
> policy checking.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
