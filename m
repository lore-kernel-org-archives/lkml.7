Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53674C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2490120679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565619571;
	bh=/CzpgItuJ/zcOwp1y38I4Sy2xSjjpNvMuoMEDpCuOaI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=eBdZo9LRwvPgpyJacblfX/X7yi/K7Fd+UCcGvQP9IaHRwZdeUJlitny9+M53JiZUe
	 9VasBIXa09PHCxwfli9uL5CWpp/pMlL5GxrXN293cwGPzFW1p7ap0ZiPbxkXiTHgVK
	 ia2Ls5E67WGpQQId6v1NnTNEcIYclFmWMR3HYxmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfHLOTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:19:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35385 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfHLOT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:19:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id g17so8382260otl.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IYKcaAxSUXSLWlSHYCezPjjjdoMELWaMbCrjl2NmRfY=;
        b=Pt7fCr91W6DvDkWtDDrseUuFrBpRTivsHBGGm945oUNY3jvMDupYAaBs/A6/imyoNX
         VHp5rbs2Q+y01R+frFrsKy7svjhhQSU3cUwrpBwMowOVoDjtS4wqSYSqxzLmnaXX1fyA
         1+H2C/x3LF5CFPjjEOefGHy/H+loF1NQJS28Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IYKcaAxSUXSLWlSHYCezPjjjdoMELWaMbCrjl2NmRfY=;
        b=R6t+KC7EsmYB9LrWqpEieXcAzyj9y1zTNiiipKrCtrieoM4lLU3L+ojedFbR3AFqbK
         eucW98IO5S4NOobP0WCBnCycqTWG4LcSDoXEFwwuKoIZnQQFCOjj1LBoec1X9tzaNGxW
         WUcJC5xkY6EK2qo0pjpxmz8/8GGUyeZyiUbGLlmQ9eaL1CAWfB5wZVGITzSzTv+hQmS3
         uxdZKCyLAXaiMPwc7rh5CbS2o836F1vNzuKllExh8ioC5Hy/Rr/KfrdCmdYGZgoTLgCK
         q+CSsZbZA1zZ/SchTWf7+jJIZHV5YbrtW80amsSM0Q5kNbcSxK6Wfj4ANvSTUezp37uU
         Btpw==
X-Gm-Message-State: APjAAAU3vkuk8bxTF0F/Xq/iD/8g3LG35qzjOHcTQbfADckj0IsZpBHU
        /2+ArjcycdL3825FAhrK6IgtKA==
X-Google-Smtp-Source: APXvYqwRoQCDCl9xIntsgU9V7rgFqpBRfFWdjGKdxXbtNChGf1uUzb4+He0XY+3ELPWgT+eGxZmReg==
X-Received: by 2002:a5d:93cd:: with SMTP id j13mr14863113ioo.39.1565619568913;
        Mon, 12 Aug 2019 07:19:28 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w5sm20166879iom.33.2019.08.12.07.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 07:19:28 -0700 (PDT)
Subject: Re: [PATCH 1/3] media: vimc: move private defines to a common header
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        helen.koike@collabora.com,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <cover.1565386363.git.skhan@linuxfoundation.org>
 <142cc5a6a10f75ed97de8b2d9b1e73b034a88b2f.1565386363.git.skhan@linuxfoundation.org>
 <20190810141432.GA30451@pendragon.ideasonboard.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ab0b316c-8b6d-0faf-b046-97c8065b8afd@linuxfoundation.org>
Date:   Mon, 12 Aug 2019 08:19:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810141432.GA30451@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 8/10/19 8:14 AM, Laurent Pinchart wrote:
> Hi Shuah,
> 
> Thank you for the patch.
> 
> On Fri, Aug 09, 2019 at 03:45:41PM -0600, Shuah Khan wrote:
>> In preparation for collapsing the component driver structure into
>> a monolith, move private device structure defines to a new common
>> header file.
> 
> Apart from the vimc_device structure, this doesn't seem to be needed.
> I'd rather keep each structure private to the .c file that handles it,
> and only share vimc_device globally.
> 

Right. I initially thought that I needed these global. Once I completed
the patches without needing these as global, I overlooked updating the
patches.

I will take care of that. Any thoughts on vimc.h vs. adding vimc_device
struct to existing vimc-common.h

As I explained to Helen in response to her comment about:

"My thinking is that vimc-common.h is common for all the subdevs and
putting vimc-core defines and structures it shares it with the subdev
files can be in a separate file.

It is more of design choice to keep structures and defined organized.
Originally I was thinking all the subdev device structires need to be
global, and my patch set I sent out as such doesn't need that. I just
overlooked that when I sent the patches out.

This reduces the number of things that need to be common, I don't really
have any strong reasons for either choice of adding common defines to
vimc-common.h vs vimc.h - maybe with a slight tilt towards vimc.h"

Thanks all for a quick review and testing. I will work on v2 with your
comments. I want to make sure topology either looks the same as what
is in media master. I think it is, but I want to double check.

thanks,
-- Shuah
