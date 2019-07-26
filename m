Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71CFC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A159222BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSAZlnZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfGZSNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:13:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33169 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfGZSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:13:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id u15so40918054oiv.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BjjJlV879zvacGB1X8HxFWmHBaqpdGed0atAco6+GI4=;
        b=uSAZlnZzyGiKPoCZ8+of5If/Ok6jwYvMpWp47EZKlveWuK/2L7ypuBo3a1g3d+0BsD
         Ae5DvIsVjS76bw07fhxEcjr4zrD0W3xEMp7QxI4FAsiCKhzS511beMZ6pRLE5IkwVDTL
         ZS+Ex7H7QOT/SkzeeGu/UUjW89Zg0ghrtRZFyUaBIkq0fuKzMH8sXeeFhZSNyJ7H0xpx
         NVsQFr4e+BVi1+uGtP1DWFy9tPM9p7xC1nSJolb4uOK9nyVKxpqFidwnmZ6EBSW5U44g
         Uv7XgZbmIYEusq6JvFiepec7P06UFLs5SQmYGd/yTzAhL2S6hP7bKcl0kNprA9PtqbmY
         3JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BjjJlV879zvacGB1X8HxFWmHBaqpdGed0atAco6+GI4=;
        b=RaCyByO0PbKHZgLy7jBTGCui1Z64dtiFHoSd1Ok79HODPmT9UsnRlsvYaETzvLyCRU
         LbNkTbaKrX/Uh9YJQv7LhSB4bJzt2cIvx+my8O+hASc5zXFKlfngi38URZ6x5eBWgUAe
         eL6CoLVFq2ozJ4HebD5mtP6n+cyTeQs9XS2tu8LuixF05hdiG0Kf+p6ge2OkG1nzLoYE
         U1bEHzhhppNRUv3Hnp5sofZbcpw6iFEm1jXnRiV4oOZNwDCy1qfIYKyTWAlbMMEjDTPW
         J+eq9FwxdHJV247DqMohF9tGNiW4sUoxQlA8lgD5DH8tFmHVIYhAUQXViK606DBGN0iM
         dqdg==
X-Gm-Message-State: APjAAAWfuWvafL14cIwCMmj6XeKPqutWrrjGv0Fy0SzAMUbLEte2Zfl1
        mHlpREVI6rGqd9f06A8Uo9mZROa6
X-Google-Smtp-Source: APXvYqxzbcrzWnJw3FqAdbdLrQjkNLG84WMtD4VcLg+nDfDrkn9yp7NmR/WCGhXBsDqr+TBOyuBkaA==
X-Received: by 2002:aca:ac4d:: with SMTP id v74mr43043303oie.66.1564164820904;
        Fri, 26 Jul 2019 11:13:40 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id i11sm18347154oia.9.2019.07.26.11.13.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 11:13:40 -0700 (PDT)
Subject: Re: [PATCH 1/6] staging: rtl8188eu: add spaces around '+' in
 usb_halinit.c
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190726180448.2290-1-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <500253ca-41bf-b374-ada1-84607455bcbc@lwfinger.net>
Date:   Fri, 26 Jul 2019 13:13:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726180448.2290-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 1:04 PM, Michael Straube wrote:
> Add spaces around '+' to improve readability and follow kernel
> coding style. Reported by checkpatch.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/rtl8188eu/hal/usb_halinit.c | 76 ++++++++++-----------
>   1 file changed, 38 insertions(+), 38 deletions(-)

If they apply, all six of these are OK.

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

