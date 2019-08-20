Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B4FC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E7522DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="0Ltr1//G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfHTRsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:48:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40135 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbfHTRsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:48:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id s145so5215034qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Txs8pbiiUnD89seXj92NZ1C3XJDqPD2UGuLKY8IPMFc=;
        b=0Ltr1//G9vd0nPfrA5jE6D7NlTNa45ay6WkHgCO3SsE9r8mtxOhvowGF12dnlV6zMh
         pnGAE9sya4jpc2H0o/0w5cpxzllguT+n4iPUX4U9hMlIZbyR7VxYkK4cE4JZCiDpjhR1
         axU62EYZfHkwYqhhEHUoiat3tnrSBTmeuNgmBVXNExDN6+M0xfHoKpdx8/crQUG0l0yy
         lfiZtHGiVxY12xyox95uW7gcsnklHJoMEt7/Sd9oMI3WIgd6ZhFNFRIHNBxhLGshSbnO
         WgiEUX8quOHmIe68//amkAhfiGF/3yqkT6CxL/LYx92enCID0ecXx2xHPBVfaJcJUlPQ
         UlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Txs8pbiiUnD89seXj92NZ1C3XJDqPD2UGuLKY8IPMFc=;
        b=lr3Y6c+6rGsAmQNxqKv6RYX7t6mAMsWLY+PtGQTwP8mrkuS+DFin478C11ndkR4hwi
         z/RoLo2MCw/EwhWCaumck1lothGqKYahv9cgQmLkvsq7bAt8F5YRVqf19fzrnR/d4obg
         vSUMpcSrvpBF7BbaPx2AfY4GuvFw8VwLG3brqi77RYmtzpYlrx20h89pDSfNfQdBzc1b
         mhYklCpo5huOTWSmn7d0HIPsFNieACVUaG5P+k3cMbUQVUL+j+H8iymQ6xrnjxHvNKq1
         36CxTFb7Lv1VwmTFnf4hRcYfiA6YXruaP+qc0akYk717NFwH/ZaKYkkGHPBoBiN5UQ+s
         qAfg==
X-Gm-Message-State: APjAAAUkH3GkXWu36BgUlOltGzZ0ih7JlK7aK1VQBpZ3xFmmj58YhkLH
        B3bjyc2fDqu2+0lPvFXMpSSSYFq6y4c=
X-Google-Smtp-Source: APXvYqzCCCSEvOkdqThKLK6ees6Nv3F3TFwKOs7TGo8msawi5kZi9dyH1dNAftj9ZcCgWcnoC+7Jkw==
X-Received: by 2002:ae9:e914:: with SMTP id x20mr26126049qkf.57.1566323324654;
        Tue, 20 Aug 2019 10:48:44 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id t5sm8892207qkt.93.2019.08.20.10.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:48:44 -0700 (PDT)
Date:   Tue, 20 Aug 2019 10:48:39 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <idosch@mellanox.com>, <jiri@mellanox.com>,
        <mcroce@redhat.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] netdevsim: Fix build error without
 CONFIG_INET
Message-ID: <20190820104839.511367fa@cakuba.netronome.com>
In-Reply-To: <20190820141446.71604-1-yuehaibing@huawei.com>
References: <20190819120825.74460-1-yuehaibing@huawei.com>
        <20190820141446.71604-1-yuehaibing@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 22:14:46 +0800, YueHaibing wrote:
> If CONFIG_INET is not set, building fails:
> 
> drivers/net/netdevsim/dev.o: In function `nsim_dev_trap_report_work':
> dev.c:(.text+0x67b): undefined reference to `ip_send_check'
> 
> Use ip_fast_csum instead of ip_send_check to avoid
> dependencies on CONFIG_INET.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: da58f90f11f5 ("netdevsim: Add devlink-trap support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thank you!

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
