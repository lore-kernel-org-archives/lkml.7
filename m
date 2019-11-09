Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35886C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 00:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0575C206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 00:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hiJmGSln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfKJAak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 19:30:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37884 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfKJAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 19:30:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id z24so6609828pgu.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 16:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=FxRt4BUNwVB8zpfl5d2aejL9uK6mBbXTP9pbXJEAVIA=;
        b=hiJmGSlnDpaF08YRgBaxyr5f68zjU/4xnmI2rZb2yHXrJ1OZXYRrhl8+qkrr+c1C+l
         EbOMxgoRmtBsn2DjinkASy5uaaEf4N42L3g9V6T33JIv8OsXTEb0pvk7bbZQUMjbclEW
         XxXWO9yFY8Cc0Rkr0nqGX0uMnF5CBJyvOav2c0wtaH1l3MVAV2yngr/8YpOjwN2GYOoX
         qtHMUzLYJ1DUO2kBPcErJTGREA+ykx7mVZZbuwcK2g0qOlPdimrE2jtAmteGys5e0mhe
         Ux5OkTsaK+1mLq1wmj6ricPdwe4/SfZS7Jdbbbaz2RnCccIxpR4iKPOc3NBU9/wiPycj
         M0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FxRt4BUNwVB8zpfl5d2aejL9uK6mBbXTP9pbXJEAVIA=;
        b=QfdAf4tpTe3pWMe3KtK6fVcMdbBQdlqavi/3z/QdjeaeosQ2J3ZsFJB1zvHc4tuwba
         qlbk4r1DlWSMcd4TcS6T42eXO/fUzTcVCw1uhUV1KWpqorrXlYWzg5O+kqW8msgHxSov
         UdQ67smLsT4RlQ5rLC+jx7MyXp+YFtzyIqFoXJ+iqemRBwAIeYlFH2sdMfbUSOjmXzXd
         5QFhaT3R4pMA8HGJHNn9llgKIiTgYdIWhrr4rdvrReqip4azEip1ymsMHDniUmzXu0AV
         VVOobaXCIIL6u8ELC1I1oEGwqKvPxqTAuw1drCzaYjlpnsgyxc7TnPmfdQBgYadAOHR3
         uhyg==
X-Gm-Message-State: APjAAAVNlkf0sVQxvcLDbdiT1g5mpLsq4ib9XSkBTGCLLY9AQoS6ci4B
        nnnzNe2N3UMt9ey7i4vv8b2oAah1DzS0uQ==
X-Google-Smtp-Source: APXvYqwts4OUgpJJOzYRq313xaamUKaByPW6r3ZrRxsi3tbQNzWseZBolyT2WkJLe0WrONs9SgepGA==
X-Received: by 2002:a63:6b82:: with SMTP id g124mr20819408pgc.178.1573345837340;
        Sat, 09 Nov 2019 16:30:37 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:7c60:912:1380:6df8])
        by smtp.gmail.com with ESMTPSA id f19sm4460187pfk.109.2019.11.09.16.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Nov 2019 16:30:36 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH v4 2/4] firmware: meson_sm: Add secure power domain support
In-Reply-To: <1572868028-73076-3-git-send-email-jianxin.pan@amlogic.com>
References: <1572868028-73076-1-git-send-email-jianxin.pan@amlogic.com> <1572868028-73076-3-git-send-email-jianxin.pan@amlogic.com>
Date:   Sat, 09 Nov 2019 21:11:09 +0100
Message-ID: <7hk188stcy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> The Amlogic Meson A1/C1 Secure Monitor implements calls to control power
> domain.
>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/firmware/meson/meson_sm.c       | 2 ++
>  include/linux/firmware/meson/meson_sm.h | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> index 1d5b4d7..7ec09f5 100644
> --- a/drivers/firmware/meson/meson_sm.c
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -44,6 +44,8 @@ static const struct meson_sm_chip gxbb_chip = {
>  		CMD(SM_EFUSE_WRITE,	0x82000031),
>  		CMD(SM_EFUSE_USER_MAX,	0x82000033),
>  		CMD(SM_GET_CHIP_ID,	0x82000044),
> +		CMD(SM_PWRC_SET,	0x82000093),
> +		CMD(SM_PWRC_GET,	0x82000095),
>  		{ /* sentinel */ },
>  	},
>  };
> diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
> index 6669e2a..4ed3989 100644
> --- a/include/linux/firmware/meson/meson_sm.h
> +++ b/include/linux/firmware/meson/meson_sm.h
> @@ -12,6 +12,8 @@ enum {
>  	SM_EFUSE_WRITE,
>  	SM_EFUSE_USER_MAX,
>  	SM_GET_CHIP_ID,
> +	SM_PWRC_SET,
> +	SM_PWRC_GET,

These new IDs are unique to the A1/C1 family.  Maybe we should add a
prefix to better indicate that.  Maybe:

       SM_A1_PWRC_SET,
       SM_A1_PWRC_GET,

Thoughts?

Kevin
