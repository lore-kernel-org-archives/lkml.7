Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A73CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4187B206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="sk59Sxa2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKNRA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:00:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45751 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfKNRAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:00:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id k1so2830687pgg.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 09:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=6bO7e6hWYl53t03anT/Z1zUE/FznVpwaBWq+FDBPOFw=;
        b=sk59Sxa2ql+seW2RmX9NyqQTrkbW9s/bSh8AA1Z5jYFL/X7vqVEwE93ZDDJ/q8Ymbj
         Fmu1zUaUHdrvARX7jQ53KEP23AgKmakA97LTT01nZdvxL9+qWFff/I0gdTt3ITzqu4Ny
         4r/sWDtJg054Fhg90F1n3K+hTuI6KqA9ax4gUQTWvaSGsJlPK5qgZr1nouxPjuE14qof
         9f8jmkityB8eL0Kw7oTGeVuecjfmoLzbj7V1zb5TC0Rc5PPOz3HDoPWEc6SY2LmsqRmQ
         30WOdXNzT63MinUon6Zf/uGxvAfk0FNL+Eiegcbf1KVwmvgpBlpCueVTOja6xctBQ7sa
         +log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=6bO7e6hWYl53t03anT/Z1zUE/FznVpwaBWq+FDBPOFw=;
        b=mG4aMwgRLqAwkIcExYV6SSQFRhm84bgJPhax1cIz3Yb0Z66ATSvq+6C4zTQMtJEriz
         gdj2kxMAJ6jSeJC+gbdVa3tJi7Km7fEflnVOmI+SZqi4Lk/OeHWLt+3k0LrNKYFcpRRF
         G4YvGoYQ+zU6EIQJcBkMfS+GteDZB9d223byf50DWOGBRBAydIhnCnz/BWI/apVwsonY
         sYGBy2RWHq1sztKdmVPU2aEns56yZphpj7/mlgDRtSqtr5MS8LjZ/eY1aIIlrLAHRYqR
         4/J5jS6XxONthzs2SJGTmUjyi2lq2zdw/V3Cb/YA8W3mZN53MKUXpDoftUwP4cW68BUi
         +F9g==
X-Gm-Message-State: APjAAAVJx3Ld4YeK068bOamfvm82LOtollq26+U2ZGzP14E2s8CwlgYC
        ToA36iN0QPvT5HUJlfePTlxfrQ==
X-Google-Smtp-Source: APXvYqx8uPXf4czd3iKUV0VVk5MDGgysrPrpM6yFUYmtbUIKVtFNriO8qzyTyMZgTmgiZz3P1aI5bQ==
X-Received: by 2002:a63:cc56:: with SMTP id q22mr11217252pgi.439.1573750854560;
        Thu, 14 Nov 2019 09:00:54 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:e18::3])
        by smtp.gmail.com with ESMTPSA id d25sm8101407pfq.70.2019.11.14.09.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 09:00:54 -0800 (PST)
Date:   Thu, 14 Nov 2019 09:00:49 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <borisp@mellanox.com>, <aviadye@mellanox.com>,
        <john.fastabend@gmail.com>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net/tls: Fix unused function warning
Message-ID: <20191114090049.47cfee19@cakuba.netronome.com>
In-Reply-To: <20191114073946.46340-1-yuehaibing@huawei.com>
References: <20191114073946.46340-1-yuehaibing@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 15:39:46 +0800, YueHaibing wrote:
> If PROC_FS is not set, gcc warning this:
> 
> net/tls/tls_proc.c:23:12: warning:
>  'tls_statistics_seq_show' defined but not used [-Wunused-function]
> 
> Use #ifdef to guard this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
