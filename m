Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B248C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E6321783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiaSk9GA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389878AbfGRKAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:00:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35502 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfGRKAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:00:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so26731668ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 03:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FFgfnC6kqNasXzV8UpG733mU8hUnuk4aGDjYgveXuxc=;
        b=RiaSk9GAGx/vZ197tf/jXWn6iRN9wOrv35h8IkQRWT2mFAWG0k+hPTlhiy2oolroEC
         hcGaqhNNyeu08mglTpxPndyLAM/+rXPUcoMPgR1Ri79pH8nPbUy0G3+KZ2Y2ipAZRYdV
         GrdgDDLkzdLmvkF4in1t4K1blNLsGksVNCocejs8XPsp7xNtw1OFRnd7sFUldrPU1NXY
         A3VQc+w78HdGXPLI7SptbNe+JUgR/l0UKBhBmIWS3mfaBybO9eX+vdYy95QeYJ3IESbg
         xra65KeaVOIEpJMVfhMwvI9t7GP0Ou/TFWOKiOGRv5Gzoh0tnW2azrh2FOPwVPq0gWXj
         akRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FFgfnC6kqNasXzV8UpG733mU8hUnuk4aGDjYgveXuxc=;
        b=Oq3HpjN9IQ3hdt+qiqPRzU6tLkKf8I8l88QvWXlmNirlZcwgh20fgXEknIIrEeVxST
         bPHDq6cFWcT2etE3XZDJqAPtEkAs1bnB1AL9Jw0YFtkHleOkqFZTr29nskM6udNighlP
         sFzWf7s16JC6Uql1GXJEp2g/4riIQH4oMD0ueaAsYc51J3WAHn+XIR0+aQiZbelPR6s8
         8LJX/Awuvy8cwBO0aNVz8Lb8vxFxGU1fmXeJaNKWVAA+LYycwttBYywv8HleOZ1BH1Hi
         zG/CQ4MiUfiX5OdT7Y1zxPpLvef+vQ1icgoBNIQyAXhERjluWCEDEBiOAoDt2DhtHnqW
         Gmkw==
X-Gm-Message-State: APjAAAUqm818xTax3TGqg8liG+0i11oSmsZNJ3oJdKHdmerOVMWueLEW
        QJvxBzLAm6xKPzRzc+XcNM97MpVv
X-Google-Smtp-Source: APXvYqzmGLV3HPu73qDuUNevF/7k1MnioPoKXgWOGKuzxw7RQSVxjt+y5Xoe5F07e28lrFB/XrQAyQ==
X-Received: by 2002:a2e:9753:: with SMTP id f19mr23650657ljj.113.1563444044253;
        Thu, 18 Jul 2019 03:00:44 -0700 (PDT)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id n187sm3896510lfa.30.2019.07.18.03.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 03:00:43 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH 0/2] xen/gntdev: sanitize user interface
 handling
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20190718065222.31310-1-jgross@suse.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <620bb347-f776-eb3a-7a8b-e9519a613d70@gmail.com>
Date:   Thu, 18 Jul 2019 13:00:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718065222.31310-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/19 9:52 AM, Juergen Gross wrote:
> The Xen gntdev driver's checking of the number of allowed mapped pages
> is in need of some sanitizing work.
>
> Juergen Gross (2):
>    xen/gntdev: replace global limit of mapped pages by limit per call
>    xen/gntdev: switch from kcalloc() to kvcalloc()
>
>   drivers/xen/gntdev-common.h |  2 +-
>   drivers/xen/gntdev-dmabuf.c | 11 +++-------
>   drivers/xen/gntdev.c        | 52 ++++++++++++++++++---------------------------
>   3 files changed, 25 insertions(+), 40 deletions(-)
>
For the series:
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
