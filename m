Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A45AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC74D20693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6Dq1OLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbfGaNLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:11:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33057 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387668AbfGaNLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:11:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so30411650plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 06:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2rZrJCGFsWrzuSEZciTMArw8lIiKnfHQz1EQDThbtOA=;
        b=Q6Dq1OLMF0b7XkgEjjeAgXn3NEsQO13lCdg/a6K3v7SPn/wnEh+OafAD0hXR3mam4X
         2igueCKsJV2IaoUjuUL85zdguu/pBBj6as304rfdsvzWE4P16kaTP3LK26I0l9T76Q97
         g5f7/zsshj6RfO3HDm5TMgE42Xd3+tw+bRx66S1O6zg+0K031ViUjaT3thxZPCS3h0r2
         XPiYuf0GMF56wJ9PRR+zxLKjAEJG+7WIAe3wrN1bScqOPy5x1y7u4Vp4alfnl3LHEsFN
         cyKemdZocIu9irP8rWWy5E3GHGKPgdxA9bvJLhMFb+5uUBjavBZ+pJnfnScMhR7bfzKI
         Metg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2rZrJCGFsWrzuSEZciTMArw8lIiKnfHQz1EQDThbtOA=;
        b=JmRlrAjUk0PMNBiAso9ugLgpAUDuJCUYdRop4dj7zGV84q3mI4bg8gZNV/030KgdsQ
         uRLOGeSsRueN6v3iJQ66YU/bohYMmDBWh9Ae7ViiQP/tcn3NFgHXAsPX1WtuF2uLSSnX
         peCypT4HNyNWMeDbxf8+L4n9AG5vm01qkiyV96TkIyS93zTDw+n7Q27ZgmtRJheaWVyT
         iuWz8fNNwzevbox9mbxm2Cvoun28A42EK5L7DB6FEZdpDdlgEXj860btFBPP8czwaP7I
         ip2d9Dsufnl9xCHwEdbDbFxmVNOYR3Y1jW0Aa+4iQwbM2JXrWiou82p6O/mmXoXDXTZS
         eNTw==
X-Gm-Message-State: APjAAAWz3dHFMGVC1jDb21gearnTbNw7Khss2PJsF6Dl1yQA4xCvqQwT
        IvFZjHlxb9COlcXb/Z28ZklIcUJ5
X-Google-Smtp-Source: APXvYqwXJUhj2umABhcmVd6JyxgmsYysctIxTWNMxwg5vZbZtBVP+LPtAUVc4SOac1SsyFH9a47o5g==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr114157876pld.6.1564578667113;
        Wed, 31 Jul 2019 06:11:07 -0700 (PDT)
Received: from [10.0.2.15] ([122.163.105.8])
        by smtp.gmail.com with ESMTPSA id s185sm101228500pgs.67.2019.07.31.06.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 06:11:06 -0700 (PDT)
Subject: Re: [PATCH] regulator: of: Add of_node_put() before return in
 function
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
References: <20190724083231.10276-1-nishkadg.linux@gmail.com>
 <20190724154701.GA4524@sirena.org.uk>
 <af559a36-c926-e2a5-a401-aae0f6867a6e@gmail.com>
 <20190726104547.GA4902@sirena.org.uk>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <8a1fa50a-3d1f-427d-c319-be2c6f5ccb6b@gmail.com>
Date:   Wed, 31 Jul 2019 18:41:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190726104547.GA4902@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/19 4:15 PM, Mark Brown wrote:
> On Fri, Jul 26, 2019 at 01:02:52PM +0530, Nishka Dasgupta wrote:
>> On 24/07/19 9:17 PM, Mark Brown wrote:
>>> On Wed, Jul 24, 2019 at 02:02:31PM +0530, Nishka Dasgupta wrote:
> 
>>>> The local variable search in regulator_of_get_init_node takes the value
>>>> returned by either of_get_child_by_name or of_node_get, both of which
>>>> get a node. If this node is not put before returning, it could cause a
>>>> memory leak. Hence put search before a mid-loop return statement.
>>>> Issue found with Coccinelle.
> 
>>>> -		if (!strcmp(desc->of_match, name))
>>>> +		if (!strcmp(desc->of_match, name)) {
>>>> +			of_node_put(search);
>>>>    			return of_node_get(child);
>>>> +		}
> 
>>> Why not just remove the extra of_node_get() and a comment explaining why
>>> it's not needed?
> 
>> I'm sorry, I don't think I understand. I'm putting search in this patch; the
>> program was already getting child. Should I also return child directly
>> instead of getting it again, and continue to put search?
> 
> Your new code is dropping a reference then immediately reacquiring one
> to return it (introducing a race condition along the way).  Why not just
> return the already held reference and not call any functions at all?
> 
I still don't understand.
Previously the function was acquiring a reference to child with 
of_node_get().
My added code is dropping a reference to search, using of_node_put().
I'm probably misunderstanding this at some point, but I thought search 
and child are two different nodes? Or am I completely misunderstanding 
what you're explaining?
Apologies for the confusion.

Thanking you,
Nishka
