Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425DCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A3B2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="mne8nhxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfLQP4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:56:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35665 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:56:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so11876297wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kru/p1qE5H/BCcW43apBsFqD+qqTgGNhKSFSdhalhZw=;
        b=mne8nhxlUm5JUVJvci8lY6PyqcJV58bkC/8MDX3fLFmKigBiUT2/qYAVumFGxcCQKH
         Lj2xkBkFvl4p3SnIPI1/tosatcIg9yz7/xCw01e/oYKvCYJTGjYLkiRt7lZXEkzTMDDi
         koiy7XLiHNLTtPsPdvJn0F4aRm0UoxyPXhCqjPgTanpJCHs1G08oXGcl9VrZE3+2FnBH
         VUxQHqYUdNGqdIfRAT1LOa1iiVP2JU7kEE5qzDFfdB66qbMWKkf7SdLY36Z+gFcATrCZ
         rqUX0MU6tbLJkV6Gp+ZZVn06QNbK0OBpr48hKvsnsHJejoFCmclwuyq0Vb1/l+pSWMxh
         XNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kru/p1qE5H/BCcW43apBsFqD+qqTgGNhKSFSdhalhZw=;
        b=mIcWA+lAzMOqG2034AzgbUWzUafsh3wgRgMEjbAQM6/SkrfyTQAvMDuNv3CA6FvV03
         SFr8YcofVISYgEOKw2XeovvHA19RBJZebFQy10XVvQiqJdL8g2nvHF7N8M4Pa0gWSq6S
         8/zwdwnsSV3CFJqTRANUVpLBt8GyeoTzcumwLbud3UOGJKZf7B8E4HBIBsBv6cvwhPli
         O/JjnYGWDCQWgLUtyU56COse2BuaLUO+oaL6ewRAFo5XQ5448VQDIUiuJEybfXKr6y9y
         1puHBcnAgGLuU/W1J3ON23Z3FqtMB3K0bWigB8thdXMyR/dIgXl2Sd165rr76fteYC+/
         hV/Q==
X-Gm-Message-State: APjAAAVHOIH/ubb6EL3Xuyk0iPFBcJUwZz+hm3LqXRZMkWvd3f3+rqA/
        aseACV4lkYM1fR7K510wIXhze3FPISA=
X-Google-Smtp-Source: APXvYqyNMAVe3i3HHStXWaTydu4DNl69XCzW5OGGXtdFookbpapo5jksY/g3ZK42dfA5bT/chPKB5Q==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr36759405wrw.313.1576598202967;
        Tue, 17 Dec 2019 07:56:42 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x16sm3455140wmk.35.2019.12.17.07.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:56:42 -0800 (PST)
Subject: Re: [PATCH] tty: serial: samsung_tty: do not abuse the struct
 uart_port unused fields
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191217140232.GA3489190@kroah.com>
 <e0fbb679-54fb-25c6-0e88-012d0490e291@arista.com>
 <20191217155219.GA3754999@kroah.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <c0b28ccc-7a0e-f6e7-ac6f-f310094acc03@arista.com>
Date:   Tue, 17 Dec 2019 15:56:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217155219.GA3754999@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 3:52 PM, Greg Kroah-Hartman wrote:
> On Tue, Dec 17, 2019 at 03:47:34PM +0000, Dmitry Safonov wrote:
>> On 12/17/19 2:02 PM, Greg Kroah-Hartman wrote:
>>> The samsung_tty driver was trying to abuse the struct uart_port by using
>>> two "empty" bytes for its own use.  That's not ok, and was found by
>>> removing those fields from the structure.
>>>
>>> Move the variables into the port-specific structure, which is where
>>> everything else for this port already is.  There is no space wasted here
>>> as there was an empty "hole" in the structure already for these bytes.
>>
>> Thanks!
>> Sorry for not noticing this myself.
> 
> You wouldn't have noticed this unless you build for that platform. I
> just recently made it buildable for other ones.

Ah, I was running CONFIG_COMPILE_TEST and thought that it should trigger
anything (and fixed an issue before sending). Probably, managed not to
enable samsung driver's option.

Thanks,
          Dmitry
