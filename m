Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2643C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A253720665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565620055;
	bh=CeDbMIv7fnNuo3ESRXtbf9fp7MZ+ChvMZ4DP83hBzpQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=bDGH4axtOxi5yDgQvTxQwh44YhYCGNb/oLBfg4isvOe4YA0xOcmdWc4ix+CFJzA2t
	 VlygoKr4lfx2hOIZ2lQtXD2vsDsAYaikHDOdkjFKGzzYOot4GVr3MheR7ZevT2XPzu
	 5ln23qqFDYsHgfCVwUJTcdG0FL8vAHUcvD9KRzAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfHLO1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:27:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36756 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHLO1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:27:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id k18so27299172otr.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iB0JWM7h1gxHw3EITq7Z+ghm7p6Q9nTkPir7Y/G4NH8=;
        b=TZc9ggBowRmmtGuC8ttoadFm5vz2RNC35ZL0jQEW8J4nIC/wah+7aT1ZVTL8JXEnt9
         Pfu07LhqpOmZZ46/ccWdmiRlXjW42Izow1P9kDlGqDd7Hd2czIF2QlOF2N28AcnYdtkX
         JDn/O9InIP/aYT4ciYOi5C+4hFHdJM1sgwXJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iB0JWM7h1gxHw3EITq7Z+ghm7p6Q9nTkPir7Y/G4NH8=;
        b=sWiaSge2J1mhRKXgz+5B7yqK4NQXhxb1o2NK0l/i+Dgw2oLjmmrvbacEliUvuqRcJQ
         Q9ZK/XqaVsUp3rqM+oQveSrrKMM0piWoBsS+A+BCf8Z8uOTy15f/a8OKrmvYVA+y/34C
         hkI5IfwIRWeIFfmYil0u5xdwJjnxlM/lZK1/BNeMTLQ8NZoqOIE6W6+x7StfoyL7ZqZ0
         bL9qaWq6YVB8FJkTmvkrbJQVZ4pmPh6bjogH56eJ7mYmL8rQUkolMthyEMjjTsnPsOKs
         J58DfApZYIXQ757sZCfwOOaoAf/V5SsOSlj0c/rLIAU1WPb/+4JFiYIrA0mvfzO1jtNg
         5w6g==
X-Gm-Message-State: APjAAAU4LpLTaNZTC9pLNq2hg1EnNNw+nZqBcHT3gbMtB9x1GbtaJWzn
        gRuydI0HgrWtf0RKjquP7qLIGQ==
X-Google-Smtp-Source: APXvYqxKpM3w/vMiS/JBa38QJi5ADvN199ViP/KkzVP1/OxWlB0VBqt0i1aaSCaBQG+ri38z3vnHQA==
X-Received: by 2002:a6b:730f:: with SMTP id e15mr33995089ioh.74.1565620053420;
        Mon, 12 Aug 2019 07:27:33 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d6sm20462220iod.17.2019.08.12.07.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 07:27:32 -0700 (PDT)
Subject: Re: [PATCH 1/3] media: vimc: move private defines to a common header
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     helen.koike@collabora.com,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        mchehab@kernel.org, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <cover.1565386363.git.skhan@linuxfoundation.org>
 <142cc5a6a10f75ed97de8b2d9b1e73b034a88b2f.1565386363.git.skhan@linuxfoundation.org>
 <20190810141432.GA30451@pendragon.ideasonboard.com>
 <ab0b316c-8b6d-0faf-b046-97c8065b8afd@linuxfoundation.org>
 <20190812142447.GF5006@pendragon.ideasonboard.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8e5206fe-240e-e5d3-c675-255aa0df7d57@linuxfoundation.org>
Date:   Mon, 12 Aug 2019 08:27:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812142447.GF5006@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/19 8:24 AM, Laurent Pinchart wrote:
> Hi Shua,
> 
> On Mon, Aug 12, 2019 at 08:19:27AM -0600, Shuah Khan wrote:
>> On 8/10/19 8:14 AM, Laurent Pinchart wrote:
>>> On Fri, Aug 09, 2019 at 03:45:41PM -0600, Shuah Khan wrote:
>>>> In preparation for collapsing the component driver structure into
>>>> a monolith, move private device structure defines to a new common
>>>> header file.
>>>
>>> Apart from the vimc_device structure, this doesn't seem to be needed.
>>> I'd rather keep each structure private to the .c file that handles it,
>>> and only share vimc_device globally.
>>
>> Right. I initially thought that I needed these global. Once I completed
>> the patches without needing these as global, I overlooked updating the
>> patches.
>>
>> I will take care of that. Any thoughts on vimc.h vs. adding vimc_device
>> struct to existing vimc-common.h
>>
>> As I explained to Helen in response to her comment about:
>>
>> "My thinking is that vimc-common.h is common for all the subdevs and
>> putting vimc-core defines and structures it shares it with the subdev
>> files can be in a separate file.
>>
>> It is more of design choice to keep structures and defined organized.
>> Originally I was thinking all the subdev device structires need to be
>> global, and my patch set I sent out as such doesn't need that. I just
>> overlooked that when I sent the patches out.
>>
>> This reduces the number of things that need to be common, I don't really
>> have any strong reasons for either choice of adding common defines to
>> vimc-common.h vs vimc.h - maybe with a slight tilt towards vimc.h"
> 
> The vimc_device structure fits nicely in vimc-common.h in my opinion, as
> it's used by every component. I don't care much either way.
> 

Sounds good to me.

thanks,
-- Shuah
