Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60232083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DNt6cZ2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfCLQbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:31:46 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33392 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfCLQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:31:45 -0400
Received: by mail-it1-f195.google.com with SMTP id f186so2850552ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IbgbBi+8n3MFHsUq65bw1T1rwYayxXQqXSiYF0JhQfQ=;
        b=DNt6cZ2DTEUJAQShjH93uvUcBOI2DjxRwyy3sIIlFSFJUYCDOZfJqvX4T1526qLZwH
         nXL3JwmOoo+/3JZTUAwbBSqtEmBI6gtb1eI2qZ36us6Uq1pvIQSvmWvvq3WNV5AmYk4u
         35WiV9xD/mRCE7ygpVMnnLmduXK5Pnq4ix9dfe+mm+ww3ibb++mfs2PS+hPXfGQUlCe7
         BQHqTbJkBewvr05turtBqAbSWrhD52CiOj5vdz5hW3WsUAcVYk2RcJAZSqXSVo8SSNKj
         KYPpVEZcgrlEJXollTmMgQwElDTTA4SviNEvwUeAz6UpgkWIxWytG4T2xp7mPSzpaVwO
         WDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IbgbBi+8n3MFHsUq65bw1T1rwYayxXQqXSiYF0JhQfQ=;
        b=Vy4kiBaX8FkrXa4RaSzOVB5EGLV3M2Pp4fczhN43dopOmnvfTUZEuHQRrrBpc+Nvs1
         ZeMrmaQGqL5d2BkkClTO30y+niwsGjinnqvYXeC7LA7iCGS2q2aCa0qJwcYuPMmFIlLZ
         uSv0stGUCbDhjDNGb1TJI3629CNS+fVEdAVy80LTMx+xTEmGoYDP7/51VT+AvyVlu9Ai
         jzPiyoylBut8GCkUnmldN0A5TTi4sF4aydd0joytW/r4TUCVnj2f+bReath4NGyJGjqq
         L4WoSVYsBQZRCLdYl8rlb5P+j6CrRt6T5agdYqiO8x17k2jgYSdh7Ccs9QTGURCV0siN
         vZzw==
X-Gm-Message-State: APjAAAUDbuiBnUqxFb9oEiYQNyLN+2UW29hOPm4KQLQ8fQLjOGmyNkNd
        f/D9dhO4BbcXv8ZV+oh0VFmxYQ==
X-Google-Smtp-Source: APXvYqwYOg26ugumoEGWODgzph3ouM8fQofOgdLeW9BQmVCQMF4UcThFlh9BhU3lTfSw10nHhU9bkQ==
X-Received: by 2002:a02:59dc:: with SMTP id v89mr21644578jad.98.1552408304931;
        Tue, 12 Mar 2019 09:31:44 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id z4sm3747331ior.27.2019.03.12.09.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 09:31:44 -0700 (PDT)
Date:   Tue, 12 Mar 2019 09:31:43 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] sifive: edac: Add EDAC driver for Sifive l2 Cache
 Controller
In-Reply-To: <1552382461-13051-3-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1903120927450.26459@viisi.sifive.com>
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com> <1552382461-13051-3-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yash,

On Tue, 12 Mar 2019, Yash Shah wrote:

> Add driver for the SiFive L2 cache controller
> on the HiFive Unleashed board

This should read "for the SiFive FU540-C000 chip" or something similar.  
The L2 cache controller is not specific to the HiFive Unleashed board.

Could you also please describe in your patch description:

1. what features this driver supports - in other words, why would it be 
used

2. and, if this driver was written based on any other drivers, please just 
briefly credit them.  For example, the use of the "teardown_*" function 
names suggest that this driver is at least partially based on
i10nm_base.c, skx_base.c, or pnd2_edac.c ?


thanks,

- Paul
