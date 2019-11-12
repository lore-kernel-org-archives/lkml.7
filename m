Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D25C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2703D21783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YQjFpZVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfKLLos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:44:48 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38558 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLLor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:44:47 -0500
Received: by mail-lj1-f196.google.com with SMTP id v8so17427631ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 03:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AGTZ4z4pclCTP3TaM1mEYITa39uvJa7zWe2VFGpsFtQ=;
        b=YQjFpZVeaTEeO+20aG1CP57qzaQF/K4s2mQxLVMo5aM1+z9UfnwfSbr7sBrXNeUdSb
         pNj4MTofPx+/HhftTnVorbdrJyVPud+NQIUoL22TugPPO+/VITy8aOcQJDyHzDHybi94
         wduFdCh0K/RrDq1CbsTyyRTTX8ODY/dacP36k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AGTZ4z4pclCTP3TaM1mEYITa39uvJa7zWe2VFGpsFtQ=;
        b=gZzUza3Ey0RyCntqckSa8XWs3jWsLXfUJnmWkx3RmKLpAaiWJHZI1VxDBNz/MsZYeg
         w3wEQ2n+M0Xb1JtjGo/CNjzNy7ZMeFwbTRmtdIPDS9KdngGfH4juQaUXu+bZVSvxfRI/
         wjG+OO3vSNye9q8qN6bBwbXYRVcLFMtenOK+6yD8+50FmPiQKtQOY1cFpVqpYbTpPnS9
         1hAxGfiWkELO91whvaWnO8zmt+Xqy7E49994TjJfuOVvnLTemxMRDhr35Mao6pRwdCjN
         W0D/p/xXAPsV9z6h0jzOAvPOzMoBSkA9bcM6krNlXjIui8aUH32f4E85XDoWLv2w/8Gr
         uikw==
X-Gm-Message-State: APjAAAXFBOcLizKOJkP9ePeuSRefckbH5GcJhWnRNnVPIdnCkhHXz6Pl
        /2uazNSUMY1jkO40Vbz5mGo0uw==
X-Google-Smtp-Source: APXvYqy+lw2SLMQFCUkQpJRfNsuioc2JKvqERf+YtVC3KryQWbQkhR/tX0NqbPKizKDXtkq4OOdBtQ==
X-Received: by 2002:a2e:8e28:: with SMTP id r8mr19360726ljk.21.1573559084029;
        Tue, 12 Nov 2019 03:44:44 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a22sm8189817ljn.58.2019.11.12.03.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 03:44:43 -0800 (PST)
Subject: Re: [PATCH v7 0/2] Add support for Layerscape external interrupt
 lines
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>
References: <20191107122115.6244-1-linux@rasmusvillemoes.dk>
 <ea802f081d1f1d4c5359707ff4553004@www.loen.fr>
 <184b684a-7712-a280-fdc2-83d7abd3cbd4@rasmusvillemoes.dk>
 <8e1877ab5a1fecace3b2383789bdf404@www.loen.fr>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <02f7a8ad-be85-b43a-be36-988d96ced056@rasmusvillemoes.dk>
Date:   Tue, 12 Nov 2019 12:44:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8e1877ab5a1fecace3b2383789bdf404@www.loen.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2019 11.58, Marc Zyngier wrote:
> On 2019-11-12 11:27, Rasmus Villemoes wrote:
>> On 11/11/2019 11.24, Marc Zyngier wrote:

>>> Applied to irqchip-next.
>>
>> Thanks! Can I assume that branch doesn't get rebased so 87cd38dfd9e6 is
>> a stable SHA1? I want to send a patch adding the node to ls1021a.dtsi,
>> and I hope not to have to wait another release cycle.
> 
> I usually try to avoid rebasing it, unless something really bad shows up.
> 
> Now, just adding a node to a DT shouldn't break anything, right? You
> should be able to do that change and get things working magically once
> this code hits mainline.

Well, yes, but I wanted to refer to the binding documentation in the
form of a reference to that SHA1. But I suppose I can just do that in
the cover letter or below ---.

Thanks,
Rasmus
