Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674CEC2D0D4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 17:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38445206CB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 17:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0eX5VUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLVRnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 12:43:22 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:33106 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVRnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 12:43:22 -0500
Received: by mail-io1-f50.google.com with SMTP id z8so14162336ioh.0;
        Sun, 22 Dec 2019 09:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QXEBHKU/LB1iiDp/zcMNr6eHfoj8s9pKx9O7xAvz4I=;
        b=S0eX5VUHJVzhKIRHbq5XOMwKV2tNO0262iY4+GKv+6jVpRxlDKJXM/oeQIooJmK8hZ
         W7qCsQi+dxUYp39uor8xguHP21qRAELpo/QtIwu6y9g0XNV/pdhgto2LsriQrImvGEpC
         PkjE1+rIefky6wioRIGv8cCuwQabgpyOVCh20RPUfXZOQ1zM/iom3VFEiUi///T8jMAB
         nEcxnT7eg/Aps5oZ2Ss85cR5xVdPH4z2HNc4tsOEdISEKIG6ORAQUt6wSstv0zlcJdTK
         5WWH31QLiE5uH1tvgeR7NeefMXs2n/k2QKIAZachazi5THrPKLjnEMfUBMRlTsbh7mbN
         HS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QXEBHKU/LB1iiDp/zcMNr6eHfoj8s9pKx9O7xAvz4I=;
        b=Hd8WZvT4zQj/P7GXzrkKyFWxyX+DEOLL1CB1MkvPXAfOPVf75nyOpcXbjNS8mgrFhh
         8XXXyPnsQnOzR2QaJIlc9GKqDZIqwD7gu5CbkEZC8mmjLviDYX+Cy19yKlqZo2gyrHDg
         47ISsgUnSladaxloNVFSHuZw0YtE1783r/Kzt5I5jIL3i8/BTPrOOoObKUvl8/nOueJ2
         mKqU+R/J9NPDLhv9ovEjrKLgVTZKiwf2ZWj/Q3Ui9CT6JYpTdYco5wveteXuRR8lbNki
         D661Yo0NkmZA1XOvhednyqrEHrYSGFTl2jnFcHI080CY3K0vimI+S010v/cNErHl4VV1
         RQMw==
X-Gm-Message-State: APjAAAX+XWKoFRa9K7hNVJjBp2DcQ295KI8y8mfVGhnb+05R9tPwNmwp
        J17993Jq4YV8gU3wTKQgKmDMgzfYBLRPApxDFo0=
X-Google-Smtp-Source: APXvYqyAeaXEkJ6IbJWDM/hOy+5n4l1ZqogL4zmwk/pJx/2/DUvePrt4k3LM9CtkVCwnS+eeowhFhO2cGyXgOFLfzyw=
X-Received: by 2002:a02:c611:: with SMTP id i17mr21491833jan.28.1577036601413;
 Sun, 22 Dec 2019 09:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20191221181855.31380-1-tiny.windzz@gmail.com> <20191221181855.31380-2-tiny.windzz@gmail.com>
 <CAGTfZH2vqk1R9Hkv4DjO8ktmpHEW+mV-+xreUHPyp6ZT2D7AxA@mail.gmail.com>
In-Reply-To: <CAGTfZH2vqk1R9Hkv4DjO8ktmpHEW+mV-+xreUHPyp6ZT2D7AxA@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 23 Dec 2019 01:43:10 +0800
Message-ID: <CAEExFWtzMTs9eABBg49wZ=5sBVnFMVpbi_mmh2Z_82B365a3HQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / devfreq: exynos-bus: add missing
 exynos_bus_disable_edev in exynos_bus_profile_init
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2 has been sent.

Thx,
Yangtao
