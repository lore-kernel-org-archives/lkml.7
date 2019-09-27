Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D00C352A9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC77217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd/IfVGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfI0Cj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 22:39:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44505 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbfI0Cj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 22:39:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id i14so2588292pgt.11;
        Thu, 26 Sep 2019 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sXqrW7yAo32sElBZR5xyrbNlxSROErm0IRlzCqPpItk=;
        b=kd/IfVGYmMQNbQcDDOCSY55fwhH56/Y6UCJzE30CmzH3SGhBwitZue+fzuNuJUyUud
         kTiLuo05tHAmYhcOBYX2GGrbfYkifOyTGWbuCrBaK6zYdJ/N1utzoN0QpOFj6DPLtlXy
         8UuhuEU9LcRBRr5A5B56tMngTaPZLRIytqXaeK/khvr0+l2Y2gGO2z3nlkGbYDQT3upD
         Ub9czauyLNoYKQWbvlnuh+4QhVcpT9w+ObXYNACW2uyQuCtRTGxRZGBD5Mz1Hlf6xSPm
         w/onnvel587eomsUQXPQmKOnrmB74R1MPSoofeoEL36yFaiK7Q+H7ySup4B+GLi4O/UZ
         X3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sXqrW7yAo32sElBZR5xyrbNlxSROErm0IRlzCqPpItk=;
        b=dw9WLEnzQDGTu0Y1bANTHhZK+Xs7a94jGKCw6eBLA9/ZkrLv7TIebBoTIYBIOzOu36
         bvSDtotN3skOZGzy/sPJfg7crtUAOasbdg6dgdgifXJ7yxdIv2+J6q5k6YXRQYQFGusZ
         E4CIH5uByD4XNhvfsYunmnvxltYnP57pRGQCEhms19pq6gpo70/HL8rqSbQRcVgl5vPu
         aV2oSbqAbuRQOexeOoY8kJWm0UxI98OjL3q4AwyfcYGlMk8rctGIBH3iJ3tozlTJv6Ms
         sENlv5ZUvDG1W5m+cC9zR3uP4TtXILa94KxL0ZwrEVYvGlhqgjIVnmTXIUrdQqNEC7C6
         FNQQ==
X-Gm-Message-State: APjAAAWTz66pZDtrJwsYSujH1TQr5MYW1DEgvm2E82EJj6EC1eqxiPm7
        2lZaurVCPOVi4r+CKRC7f2U=
X-Google-Smtp-Source: APXvYqxOQkZ3iq3kRdAdGTUbVVnAaakSBf11kzxBS9IG7L6YJnXsE330Ur0jVyoucW/fKMDuRzmFew==
X-Received: by 2002:a65:530c:: with SMTP id m12mr6826662pgq.309.1569551968268;
        Thu, 26 Sep 2019 19:39:28 -0700 (PDT)
Received: from [10.230.28.130] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m4sm2813746pjs.8.2019.09.26.19.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 19:39:27 -0700 (PDT)
Subject: Re: [PATCH V9 2/2] mailbox: introduce ARM SMC based mailbox
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1569377224-5755-1-git-send-email-peng.fan@nxp.com>
 <1569377224-5755-3-git-send-email-peng.fan@nxp.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9dff720e-2e81-a7b8-ff52-1f2c3d257368@gmail.com>
Date:   Thu, 26 Sep 2019 19:39:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1569377224-5755-3-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/2019 7:09 PM, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This mailbox driver implements a mailbox which signals transmitted data
> via an ARM smc (secure monitor call) instruction. The mailbox receiver
> is implemented in firmware and can synchronously return data when it
> returns execution to the non-secure world again.
> An asynchronous receive path is not implemented.
> This allows the usage of a mailbox to trigger firmware actions on SoCs
> which either don't have a separate management processor or on which such
> a core is not available. A user of this mailbox could be the SCP
> interface.
> 
> Modified from Andre Przywara's v2 patch
> https://lore.kernel.org/patchwork/patch/812999/
> 
> Cc: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks for your persistence working on this!
-- 
Florian
