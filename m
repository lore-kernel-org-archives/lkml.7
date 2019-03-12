Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D922AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A584E2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="FbIpf0zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfCLPG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:06:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38263 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfCLPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:06:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id x13so2623846ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ymlGt4V2A1YccVoLFbU3ZdSsYopmaVH+Ing8sJ6T/p8=;
        b=FbIpf0zrmsa93OI28rXXxbYCDTUN/gLyl92lcnBly3e1DvKp5RhzC0LPlf3o0DX9Bn
         pC9XRVpyqHgJUdYiHTIIOkuhHaSNQknDGHqkmIOxe54QYK39NMv5WJPuGgZ9dIeCTnbg
         Y17uRhI0mRvlJ/kOB4TqLWK+o2H1pVO5lYJAcKqkX4lXMTYu9qSHqGQUNxLHheikstAs
         8inhB/PwldG0vdDHNBSgJ/GLX/zsvLtDiGJ+3sIeaVYRAxXMxIjY6rU/tQh4Pn6kxo//
         xKsxd6M4OrxC3x/Gncz9vEk11o35Tvx8qZI4h+pVdFiujHXR240HXTt9mYQX1opkgTyI
         Wa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ymlGt4V2A1YccVoLFbU3ZdSsYopmaVH+Ing8sJ6T/p8=;
        b=o37MN9W8MKvbxVUGVSzc8QWDiidefj/9Ad1Iknd8ByX7ZstaGKEsPv399yUxLNPIwR
         Eo/O3IGjYkD618+MRsj4qw7UNIne2DlqRXz0Y5dJwqt+SyLoWNaymykUcCOTOYRHmb/5
         QCmN3ErcJnIsTwaKh1EzSDV3+UaoYSjTR0XLQX8IVjf2hMIrv+SYR3NRZZYlQAA5ghUh
         7/xhhFX+XGA+0WSb/H8tubWMGbSHm76j12IOoqT1tCXT2a5kMSowQZpMxovxezKIVPh9
         MwZZ1vRTusdd6mDU7KGFRtNtlIlptdHXky4QcKWi/EQEiLV8K0/8lL+UJ7hgfaRW6uIT
         Qk7Q==
X-Gm-Message-State: APjAAAW61v516QZHzhH9XOgBBaClVTmMhjZYa8RCpPDf4evJNNX4ge5u
        16mGayNsPirBJq228S7gn3MAeQ==
X-Google-Smtp-Source: APXvYqwpO1LlDLkepAHJnV81NKidFo2mB19JhTtlXSh+2wwnBcjn7LF6Kq4bqaq4IJHFwCRZdC6LwA==
X-Received: by 2002:a2e:9d85:: with SMTP id c5mr10971033ljj.70.1552403186262;
        Tue, 12 Mar 2019 08:06:26 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.87.160])
        by smtp.gmail.com with ESMTPSA id b23sm1619771lff.76.2019.03.12.08.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 08:06:25 -0700 (PDT)
Subject: Re: [PATCH 9/9] drivers: ata: sata_rcar: use
 devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1552382374-28789-1-git-send-email-info@metux.net>
 <1552382374-28789-9-git-send-email-info@metux.net>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <a12fd539-b5f0-177d-7b91-cc203263757c@cogentembedded.com>
Date:   Tue, 12 Mar 2019 18:06:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1552382374-28789-9-git-send-email-info@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 12:19 PM, Enrico Weigelt, metux IT consult wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

MBR, Sergei
