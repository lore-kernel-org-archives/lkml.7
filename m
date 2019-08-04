Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C61CC19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 21:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D36E2086D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 21:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IDUEuEW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfHDVKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 17:10:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43268 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfHDVKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 17:10:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so38530063pfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 14:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RsLNfmS1riphbJPtUn1FZXodxBgf3MWew0rC4SrjLhc=;
        b=IDUEuEW2thNdX//5/H2F7sIWdBZpzwE1O6fgv1+otLBbbuHoThgnTawqzNW8aPnw3d
         B6X+vHCkvE4JedFZgs0aTsnsewOxCuxkiDOQVxXTXEL4lonTiNdZTUy4hrV8X8Hb4507
         XIFsHdU9Bu9kcs+7+8diRJZsWqLf0QEuPuRQa99t+GY+iArR8lz3oJkum15ZXc5LkQdn
         p3Teh5pCNBl/IKhlUeulDUMuWKUshluSEPZDMs7DkQf/ZpO81nnzrbc1hw61SxY6MXPf
         B8n7qugBxHfBrBZXdPZfczxx7hI/Cun7fcS8KH8rRMlBLT0UHWUNWWaXszAwpVQ99mNU
         M8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RsLNfmS1riphbJPtUn1FZXodxBgf3MWew0rC4SrjLhc=;
        b=QAebsh/XEUovasS6R+NIWq7zaBmEnj/kYBSH4PuEs9Y+jfo6DvuXYZWQPwjory/LSJ
         ubR3tZ4ql6tO+YySFlZ6llOK5dazSWSI3lPAPgUnLxI/yMTQb9+roE3F634A1XL7cidY
         +oKP+vJfQbMKUHi9W3PlyqGutRkBZKEZMHVu3nwBh8QpLNPHg7ts7yZS/RTyYhTg23sX
         cEPLMMjDAYsu5LLUqGa1EylizbXTdusUOAvG0+wkh8WfecEy+oWn8LYwodNvm1HqMzSj
         nh4IDB8kDEc1qdj1zqF6w910+7Jq0YJL5bXApPpzSDLzmee4CLxtGHDYR1W7oV+kP9DB
         C0pQ==
X-Gm-Message-State: APjAAAWAIvsbglSgd2iGFukpr/t64eirqyNm6h2SZ0dj0yhSBr50c4NR
        uN0t0hNLSZL3+X3GQKG04+Y=
X-Google-Smtp-Source: APXvYqwVVJgyoOJozjMp5Z5LAgOAEpxUnMtiZTtUM0IVk1qZtfxnr+PHYpa8f5tjnj62docJA8jWew==
X-Received: by 2002:a63:d741:: with SMTP id w1mr57597909pgi.155.1564953008652;
        Sun, 04 Aug 2019 14:10:08 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:9dbb:3084:352a:9279? ([2605:e000:100e:83a1:9dbb:3084:352a:9279])
        by smtp.gmail.com with ESMTPSA id r7sm96307993pfl.134.2019.08.04.14.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 14:10:07 -0700 (PDT)
Subject: Re: [PATCH 1/1] block: Use bits.h macros to improve readability
To:     Joe Perches <joe@perches.com>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20190802000041.24513-1-leonardo@linux.ibm.com>
 <a41b5530-f2e1-0932-1f39-0ce66ce902ae@kernel.dk>
 <15450f6ba169de8862e11bc2d20b3645958f4efd.camel@perches.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0ca29ac-ce51-16e7-d0b8-c90cbb4835e6@kernel.dk>
Date:   Sun, 4 Aug 2019 14:10:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <15450f6ba169de8862e11bc2d20b3645958f4efd.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/19 1:17 PM, Joe Perches wrote:
> On Fri, 2019-08-02 at 21:18 -0700, Jens Axboe wrote:
>> On 8/1/19 6:00 PM, Leonardo Bras wrote:
>>> Applies some bits.h macros in order to improve readability of
>>> linux/blk_types.h.
> []
>> I know precisely what that does, whereas I have to think about the other
>> one, maybe even look it up to be sure. For instance, without looking
>> now, I have no idea what the second argument is. Looking at the git log,
>> I see numerous instances of:
> 
> While I'm not at all a proponent of GENMASK/GENMASK_ULL,
> and so not a proponent of this patch, latent defects are
> possible in both cases.
> 
> You'd likely have to look at SOME_SHIFT to see if it's 0
> to verify the actual mask is what's really desired.
> 
> $ git grep -P '_SHIFT\s+\(?\s*0\s*\)?\b' | wc -l
> 11907

Usually SOME_SHIFT is either a numeric value, and you already know,
or it's part of a series of enums/defines (like in the case that's
being done here) where you already have prior knowledge about the
values. For those cases, GENMASK/GENMASK_ULL adds nothing imho, it
only makes it less readable and more error prone.

-- 
Jens Axboe

