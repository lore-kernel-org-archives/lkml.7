Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845372075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FA+sFyXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbfCZOJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:09:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42785 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCZOJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:09:16 -0400
Received: by mail-io1-f68.google.com with SMTP id c4so10856698ioh.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 07:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PmCiw7U2fRSButHB7uTB0IgSTpuxr7FUffBuDlrMWYU=;
        b=FA+sFyXyOczcfou8jmtTknHLR9ZpFntjUzctPLiqhK9ANYNDOcLgBqiFCpIIawAWgt
         ltL3Y4kyqdUpJZsSgDP7ReaTIIZiL2VvSXFLbqY7lBjfHjciciJzi8KqndLiEAlgdWMI
         jf0Ju3oLv2s4/kbneUjJYgoyUA74PAi6QIv77gxbEhlDArw/NFyMZrJP5E/cj8pTVnrX
         w7jqQThI9GBqQ/bI32foHWCspJZT4e8DDTtEs6ZeMQAgR0yy8DLnunRERt3gFUUORLx7
         PLsbqsEPEEvWoszD7irjMZc64lAseQs2IzGA3dLijIr8sV6APBegJGmm2sOQx3IE7NM5
         1L3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PmCiw7U2fRSButHB7uTB0IgSTpuxr7FUffBuDlrMWYU=;
        b=Ze8MC0Lhz0s2K3v9JjbaiVKBbsEEs0p3l2sAlt6dX86M+hSG4IGUsTgafELPAPDUli
         5bthG7BuLgjN0N6tVnn94bjZukwLHgcmSN7hKi8mD7EeHUwYZrXxfV/pxq9Qyfpel6Ml
         RepiQaHaV5oymJHwpUWr+0RTUXPmT05vHnfzMvnjsjZxUnnEu4gHAwA5wIpZyYuZwPxg
         Yva2kD4cZe4Cd33My6TtFlkG9H6qNhernrSoLIAZb5COk4IU98JYJiGZtwTnCriSp5rz
         koi3MpphmZuQq60VmmgA70tULvhr+wPOSjfUSc+ax6vXi3Zba2Dix91ldTtvJtHsQ+f+
         byWQ==
X-Gm-Message-State: APjAAAW3Y8gbY+bOYFVJvLt+0IwLFf3p4v6sL+sbFn5Mw9zt31dSkcLp
        kpn7kNIWJc6YKHY5138IZ1Ly0w==
X-Google-Smtp-Source: APXvYqzAbJJ2vas9ddM7kVofV4wa/FfXE5QPvfBGRPI6wYLaeAVmHteGVMrm/yz1865xzAt7jGf3Bw==
X-Received: by 2002:a5d:8b41:: with SMTP id c1mr21277241iot.173.1553609355878;
        Tue, 26 Mar 2019 07:09:15 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h78sm6184075ita.30.2019.03.26.07.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 07:09:14 -0700 (PDT)
Subject: Re: [PATCH] libata: fix using DMA buffers on stack
To:     raymond pang <raymondpangxd@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <CAHG4imOAn7rcQWj--XMV2maBLgp4DynKGxwcbSzrcxk0a8n=8Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <742c1607-1e28-3674-65ca-8e5f111e243e@kernel.dk>
Date:   Tue, 26 Mar 2019 08:09:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAHG4imOAn7rcQWj--XMV2maBLgp4DynKGxwcbSzrcxk0a8n=8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 9:07 PM, raymond pang wrote:
> When CONFIG_VMAP_STACK=y, __pa() returns incorrect physical address for
> a stack virtual address. Stack DMA buffers must be avoided.

The patch looks fine, but it's white space mangled so it won't apply.
Additionally, you don't need to use kzfree, just use kfree.

-- 
Jens Axboe

