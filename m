Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C862EECE58C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03F320663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYRbwm0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbfJNTP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:15:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33529 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbfJNTP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:15:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so10926073pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 12:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=9F8hNQAFSGU9OThPzn/GM716nVF6kWYeyNCtCbn6LA8=;
        b=VYRbwm0KHKfCEdgzoab6UoDFbyq/Erb0x37sSMQESYdo4L96hLczRoNX6GkkvBHH8N
         wadAqQGsvOYdH7sbyn+jLixmmlwNpROn4eMB/fAVxC+f4sOTOeotiL4tGzjRhVWzLqt3
         8S7lPFO2rZAWbZI67xInxAOHRlg+iiw/87XSwOBmij8uyljGEu2ty7sv9bcqEpJ8CPZl
         nfiTocx14Njz9SbOiUpCw8n8KhfG4xN4VpaE4p98LvFC+hTjsUg8qHT8oKvqxZTAj3/n
         DXGzUFCexLCT58lwVnxe3VmH+LjX0rNHyHILQ6A8GbwOjR5TKjHlLYJhYCiPqTpYDlmz
         MVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9F8hNQAFSGU9OThPzn/GM716nVF6kWYeyNCtCbn6LA8=;
        b=M1IpzDScVpyrQ/Xa/WNvokPjbgdOUu1qhnUwGY0BLPjyfEOLTEZEDkDfdQYDAdaX5n
         gPI89dRzjD/A0F8ThZHk3TKBfHxilqLvQZmFeY0cAeE1znEQmkt1up0c43N4gs+Y0ShQ
         Ojl5waZmi8oEVcOBIkcAc8P8AFdwlornxL9OfQGTxnsB24Xh2yx3XpEAjf/fAncqhHTv
         yVijYlUb/mWpu8hlIUZaxI9XrSGJJygIor1BF8NdCEfD7CB0teX4i82U+KMWK0LUMjzO
         8OXuk0ant4wAHgMcdl2dooU0HGJExOXy7PWLFLxjkDsr4H1aXjMYcT/CqkI/9SUvbXTN
         P0BQ==
X-Gm-Message-State: APjAAAWG/oJ9CbFkm3P7nognP7RwbTc9Syyu56qiZCZEUqP9BCVtAgVr
        yML9sWGKVJyZ3XCgNdNYejM=
X-Google-Smtp-Source: APXvYqxKkrOzMXpy+Lk+2GGeemh0FoDZOvoANcNVp3EiYNz+v4cfciEQvcsDBkHxGSeZCkd5Si3YvQ==
X-Received: by 2002:a63:6486:: with SMTP id y128mr35065638pgb.444.1571080555097;
        Mon, 14 Oct 2019 12:15:55 -0700 (PDT)
Received: from iclxps ([155.98.131.7])
        by smtp.gmail.com with ESMTPSA id ev20sm16730196pjb.19.2019.10.14.12.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 12:15:54 -0700 (PDT)
Message-ID: <c4bcdf14e0a60a679429eebd439b2380d97dafe9.camel@gmail.com>
Subject: Re: [PATCH v4 1/2] lib: devres: add a helper function for ioremap_uc
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        AceLan Kao <acelan.kao@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Date:   Mon, 14 Oct 2019 13:15:53 -0600
In-Reply-To: <201910150232.F7RTW83B%lkp@intel.com>
References: <20191014153344.8996-1-ztuowen@gmail.com>
         <201910150232.F7RTW83B%lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-15 at 02:46 +0800, kbuild test robot wrote:
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=sparc64 

Oops, I'm not sure how would we best fix this. Clearly the patch is not
intended for sparc64. Maybe adding devm_ioremap_uc is rather not safe
right now.

Although, We could declare dummies for these architectures like it has
been for powerpc.

I just noticed another driver having this issue, and fixed with direct
calls to ioremap_uc().

3cc2dac5be3f2: drivers/video/fbdev/atyfb: Replace MTRR UC hole with
strong UC

Tuowen

