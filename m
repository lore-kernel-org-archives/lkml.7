Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4629EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139CF2073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GpBur+eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbfLKPvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:51:36 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33162 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbfLKPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:51:32 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so17139324lfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 07:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JVxmozJr3Sta+dSiA5lZFDUNBwlmE17tc5tCYYXFj2Q=;
        b=GpBur+eo0Do65A3e8co1yh/LE3h06kNXdEALUBAEFcAlBOf9nWZEDO3y1FkdM9V5ka
         4jlTdMeRt4xf1pBeNK8nNeLree17dsViqpPE+IW89ovKqSQMGDIphCn3JksAnXJbVPIe
         lhPYTkVdqtiIoy+G3FGu5qvf0IlIHmS4B8uQKYz+vUGIL6fH4+3ysE24YbI7+r7OpRQf
         rk3eNbEYrGOidiQWR29W4IK+z/2NayrRBdjX1Ddgmmhcqyc/wHru+nyevCbc4BMXBigP
         DoE5xrRZXmXZqBWjZX8gBAmZQwkiJ5J1M8nQ41xOHV6VMfz/GD88HU+6PkAFpFRBd1ZP
         /srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JVxmozJr3Sta+dSiA5lZFDUNBwlmE17tc5tCYYXFj2Q=;
        b=MNuI1kq4nMb4pU3uqVk8vfv87JcLFTvIiPwkhhictRa6DAJqH5PgZCLhFbb+2hHHQq
         PeqYisNjh5ZBUYsx02H43Qk1quFgU71h65GGZZQayxwmsdxh+GwNGg9jc3USIDwurwu1
         dG08XhnzEhLbuuCNFhchC44jknvGGNjQhLMwozKs1JOVg5IiTJzKU3MLwdZIowjdXfJf
         O56VK4Nd0+vaxdC2gNETJ10/PXgVpXSnm54lv5Xounw5ol9hl7EgpLHpL501WEfI+TWn
         dwWljAHzCPuAV026L/h+B9Ga4002TJGMKmTX+oFXgD3NR6noYQHD9dOcChdLNXL/dV9S
         VZ6A==
X-Gm-Message-State: APjAAAWv4k+MODebDjSp30oWuS2sqjNgd3hT+CaiSHGzblUAM1BQWg3R
        blApOhTlOk/O9XFOJ52Aj3sQ4w==
X-Google-Smtp-Source: APXvYqxFU9Gc4o96yvCowJhC05DT/oUFClz+R86rUP1Pi66OB6W2qTh5Rg/bUqLE/VDQ0YCk4DoVSA==
X-Received: by 2002:ac2:5ec3:: with SMTP id d3mr2647396lfq.176.1576079490855;
        Wed, 11 Dec 2019 07:51:30 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 30sm1594935ljv.99.2019.12.11.07.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:51:30 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id BF295101218; Wed, 11 Dec 2019 18:51:30 +0300 (+03)
Date:   Wed, 11 Dec 2019 18:51:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: Re: [RFC PATCH v1 1/4] mm/remote_mapping: mirror a process address
 space
Message-ID: <20191211155130.gk5qcuahzo2w3qyh@box>
References: <DB7PR02MB3979DB548160D2D9D25FE5ADBB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR02MB3979DB548160D2D9D25FE5ADBB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:29:17AM +0000, Mircea CIRJALIU - MELIU wrote:
> Use a device to inspect another process address space via page table mirroring.
> Give this device a source process PID via an ioctl(), then use mmap()
> to analyze the source process address space like an ordinary file.
> Process address space mirroring is limited to anon VMAs.
> The device mirrors page tables on demand (faults) and invalidates them
> by listening to MMU notifier events.

It's way to brief to justify the new interface. Use cases? Why current
intefaces are not enough?

There's nothing in the description that would convince me to look at the
code.

-- 
 Kirill A. Shutemov
