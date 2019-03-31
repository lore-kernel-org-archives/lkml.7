Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8C2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BE920870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJGK0ouP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbfCaMSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:18:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37148 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfCaMSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:18:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so8022826wmf.2;
        Sun, 31 Mar 2019 05:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uNmantTOKY1oW99YbXr3s/NTpKXyOXxz/h/Gbxvn4wM=;
        b=jJGK0ouPvM/+KdusK30k6OiX9sbV7NeOV01rR4SJ3h/Ia4mI5g55lPK2N6yEiLdv2/
         175ERP6wBFrkwyZUX8GOklWgkxgJR5bavfjHqEtUeY8zfBNgnZPytDcVKcCt9uuezXE8
         QEEmxdQDdpYXDPx9DkGu5RzqBsXxuhty/SD1/zgdKcr4X5iK/9NvxlIrQSqdikqWGx3x
         PSoUmcGFu6oFcmM1dzPkZ1N5+IWbUx1AWtuSmtpunCp+W2wseTqdKz2IsqzpMWodD8SE
         p9tvap0jxrrgkMCMAWr9LFOodPHO94xZvkIfmzi3F/DtsFQ3fLI78jo9bj5iZTPzDyPS
         pjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uNmantTOKY1oW99YbXr3s/NTpKXyOXxz/h/Gbxvn4wM=;
        b=GdmBiJQOV4j+DKOYoEauP9DykncNzaNRrx3H0JDO0mkkRZd17fuONoZY/tjHFFyAbT
         YvLOYSJMJE/0P3K6//fqNd7zIKlZwYImlN+l4bzlEqjqPlx5eGnJh4h9V5PSvxktxD9U
         /jGKLJ1SfbVNACOS+/xOlyyES/G8fhm+SSjrn2ltsGwC9xVUaOOXjC5zJrnCJtBo5zsy
         ZEHaMOOTV80qJQiy/5Oo+2eBGxdSgm6hIvJRCCZvxpN30KVtJbtC5lv2Ghb1U72UFKFG
         5dafCZ0DP/x0irTXGQ/qp4BeG41Kpsf6zbAjy/YykIz9g3B9dOmbqEqRS/M3V6uVsPdP
         U8YA==
X-Gm-Message-State: APjAAAXdXg+rncDxjW8UHYvcOQqWp/f7/ZzDATXyN1Ek5N9GDPgZC3Wn
        BmpmokrOS+E5T8iQi5XbafQ=
X-Google-Smtp-Source: APXvYqzl2/kyo0vnJuDmSMvO7nOXbq8ukN6xIh8Tr88HHV8c4fUXJAG5MQK9Vb8o6Oya2L1wDggTsA==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr9646425wmi.69.1554034685323;
        Sun, 31 Mar 2019 05:18:05 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id j9sm10341288wrr.93.2019.03.31.05.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 05:18:03 -0700 (PDT)
Date:   Sun, 31 Mar 2019 13:18:01 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] fbdev: sm712fb: fix a series of lockups, crashes and
 gliches.
Message-ID: <20190331121801.ftwwm4dw2iev3xzf@debian>
References: <20190316222504.27170-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316222504.27170-1-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 06:24:56AM +0800, Yifeng Li wrote:
> Hi all,
> 
> This patchset contains a series of important fixes to various problems,
> including lockups, crashes, screen gliches, and missing video modes.
> These patches are crucial to the correct operation to the hardware,
> especially Lynx3DM+ (SM720). I have tested and verified them on x86.
> 
> Please review and queue them for linux-stable.

Thanks for the changes.
Verified the register changes from the datasheet and also tested the full
series (separate test for individual patches) with SM712 on little endian
for any regression.

--
Regards
Sudip
