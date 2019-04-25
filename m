Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BC8C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E86A20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ndlPLVXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbfDYUlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:41:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41157 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387630AbfDYUlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:41:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id f25so1692185qtc.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rFkuRoZpW9B1+mnRi6GIJHPd/ZmNnu23V00acyhNpeE=;
        b=ndlPLVXqVncSFQU6FslADOsq4eWWRmGac2xQY8r7SZnZLXiI6pTFyWTO+fJUu5bHC8
         i9056v4K+3hDmz8sYBVAFnGPYZfWfy26UJ0Dt4jrBBbPnW63mMvbsC0IvPBiBg1033f6
         tXA/gAbEUklZQq1sF2xbQYSJse5WFT3xSKOFRPaIQq4vvTxJ0KcszgV2aRhJpu4g/pNR
         Tbu6gDv3iF36SDW6Va34gMvqS0R7SDUdpsMrLPqcjOhfu4RWWdU1YvyIqQV1Iwsf0/Eu
         IUQ/ZdX7jw1DLo9L69O8r0qFlHIkGmEevc7Z0UL6Ce8NpVqO+Kz2vxKB1YJrdetDhlht
         YQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rFkuRoZpW9B1+mnRi6GIJHPd/ZmNnu23V00acyhNpeE=;
        b=ROAmthsCCZG83YDzSCqOaumGQFwkADZV7bjCNQYKNcGI/MiJ7cDg4Ly8A+/qHo8+dt
         STuJz8Fo1WhBZC0leQRjyA7GOXxpHdfL5nUj+1Y3LV//bA4v4G/zxQy/acKrsCESmAXx
         VA880jFuuc4sVlWPbpSXPEUGfjKPAd3vtRH9eg43zUQjw/aKWlDFeIQimA/Na01PUzt9
         7ssO7+SEnXQdbbF1HH6chMAU7c6jgeYb2udAkG0iUFTCwYv8glpIhGzlH4bZ49GbDDX+
         SXkP5p+YuB51PJmLiLQAuoFO0KhrJocHgNV0XH+g58u6XJlamATpbgPBSDf7wJczJ4W3
         N5OA==
X-Gm-Message-State: APjAAAW+uulc62VyAL0Ss5wgtaXAYI0k4k1XnnQa7PoOX0iv/R129v4u
        SpG3DeyWSosSZLD94jXKAEoiHw==
X-Google-Smtp-Source: APXvYqymVZwuTWLHCoWxQ+sBOspKpD6WWahDFt4CesQwKFVG/zLIvnp+DB4HEaOoPef6l/CrGxokeA==
X-Received: by 2002:ac8:2234:: with SMTP id o49mr1676401qto.104.1556224859219;
        Thu, 25 Apr 2019 13:40:59 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id g15sm14767105qta.31.2019.04.25.13.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 13:40:58 -0700 (PDT)
Date:   Thu, 25 Apr 2019 13:40:55 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>,
        <nhorman@redhat.com>
Subject: Re: [PATCH V3 net-next 00/11] code optimizations & bugfixes for
 HNS3 driver
Message-ID: <20190425134055.4a3c933d@cakuba.netronome.com>
In-Reply-To: <1556196175-65389-1-git-send-email-tanhuazhong@huawei.com>
References: <1556196175-65389-1-git-send-email-tanhuazhong@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 20:42:44 +0800, Huazhong Tan wrote:
> This patch-set includes code optimizations and bugfixes for the HNS3
> ethernet controller driver.

LGTM
