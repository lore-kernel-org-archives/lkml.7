Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C617C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F33214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="tlyhI/dg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfJJXXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 19:23:54 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:40657 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfJJXXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:23:54 -0400
Received: by mail-qk1-f176.google.com with SMTP id y144so7228845qkb.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 16:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=fUaQ6WoSH6XzjkSQgTq8RJcJ124XJflOmu0VJ/xFwSM=;
        b=tlyhI/dgeHfL8cy/la9LnR3LBzP5aNKC+skbXWUYHxVngx4Qd2VBY3gUiuLPtHuB4g
         anHx/g6Anr9byMffHo4hxd6lmH53cSpO7ltUqSgfQg1bHnuWRVyw6pjPA+wmP1rkEdjv
         gD92kwNTkgLBLijQMbrhUWNg4bkE17FJ+JSqvjeWK7K1u3dgGjLNvzdlbl2YZUQAVoRo
         wPoSW8JjoMVy/5XKsXMSOHnzvOz6ExxfvvKik1zQy+7aPKJUDpAY6+O+CMVj1YYZlx4p
         bKOsnZezhAD+0rEb6beB8jxaAnzzW5aH8UrZC5G0HOHtpe/ZjFUKfgDcOr92Vw/fkvTX
         M4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=fUaQ6WoSH6XzjkSQgTq8RJcJ124XJflOmu0VJ/xFwSM=;
        b=DaNZJHZk2Rf/UyqMAlbPxoc0vOmyX8jj8Q2+q33iyUjuO/UW90QAK5fWO7QYwe3lhi
         j//CuIAQXxBGl/0LQUnTWP2USxny94iQ/aj4MqTwCP9tzzoGleDOe3sDieDbyYYhjKlx
         aeZqQvZX4h29YaD3NHJGtfRzDA8pfFr5ycIn1H5XnQ4fQ7R2HXHSSjRQ9lyQmQJxDUoC
         ncSvOH4TVlJTs0T9ccUecDeDFhPC+P081JbaMrrNbtq7eU3saFDYaYJVMLBY5D8Oux+z
         jkIFNIYLNo/IbOOlHMWzu4ME4uI+BKjRLypFJz6QlZFx22gNIN66+lsU0ZUn75q0+giV
         C8/g==
X-Gm-Message-State: APjAAAUitE7Pg/SoYjOtCeYc+wnsfVqi++2pI+0Qq40GxFuKBjyJXaP4
        IevT3cJtjdvzKj2sLz1G6jeGeA==
X-Google-Smtp-Source: APXvYqzMYq0NiWofLSStCkmGWGdyZv7L0Qj9i1dRTXNZ2atw4FNlU6Csd0E1t8EKDOgbujFaY0yzrA==
X-Received: by 2002:a37:9007:: with SMTP id s7mr12407714qkd.384.1570749833573;
        Thu, 10 Oct 2019 16:23:53 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o28sm2868621qkk.106.2019.10.10.16.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 16:23:53 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:23:38 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <richardcochran@gmail.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] ptp: ptp_dte: use
 devm_platform_ioremap_resource() to simplify code
Message-ID: <20191010162338.66e975c1@cakuba.netronome.com>
In-Reply-To: <20191009150325.12736-1-yuehaibing@huawei.com>
References: <20191009150325.12736-1-yuehaibing@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 23:03:25 +0800, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to net-next
