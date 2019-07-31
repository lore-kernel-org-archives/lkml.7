Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43777C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EA120659
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XZ9J92fI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387724AbfGaOqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:46:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43274 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387639AbfGaOqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:46:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so32003441pfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=mXrN86Eu2CP26yhQ/6WETjSqBeLcHl2RwLyOJM6x5jk=;
        b=XZ9J92fIR4AGZPgrNeCSx5yVQFFaePHjv0dcyX2Ie8QcuIk1im6khj9UekqtERbXN1
         dBbp18fAdYOLxKGPTfpHPyokbm/Kt8onB6Lx1dUoRelGoSGEfEoUAFmUkMSW3+K2/HiK
         uB9EkuH8EWXiixZrhDn9eCkR1Zp4RlUfZH4CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=mXrN86Eu2CP26yhQ/6WETjSqBeLcHl2RwLyOJM6x5jk=;
        b=GeUNgS+pV6lSwx+CmeK/E8LVBrcs1F2+etoWfZ4VHcH2zXm4DMJuRVHK5A7hf+KgI+
         dRpFQqc4x6pRf+DT58XbHRwPKXbp+9B9XXDY/J62PTuSYPCtYPc6B9Pa8e6g+81FmjNW
         5jAQWHfdh/b3YM7lvgQ67S5xnTIlMx4JW0GbJZdARrv49Czr54erJf+UJG4KVxgQD0O0
         2kf+vVgkUXgb0uFqyO50AeaTvxFFzyvRe0nW/ZNI+bqI8I5lWceEyWrr1B9g5hwme09c
         rc9iJk5QqHxzyOJHHJQv+/g+GoYADuW1jA+4rwhvf6dBBauQqzuhWQSV6TymAy+pZje2
         XGuA==
X-Gm-Message-State: APjAAAV3pCy7+l3knKJgt3xbKzvVBPRdcnw0sJxL34eg7kxH3tUceXor
        CGPbOEFXjS8bbhiT42l2S5WeTQFvjnFI2w==
X-Google-Smtp-Source: APXvYqx/xFzpnnt67hw/9+TPmFCGkdhH0oYZrh5fzzpS7nJ+tW76x1zUG4gfYAOkEgaR//mtWW+obQ==
X-Received: by 2002:a17:90a:258b:: with SMTP id k11mr3249368pje.110.1564584409094;
        Wed, 31 Jul 2019 07:46:49 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h11sm69817121pfn.120.2019.07.31.07.46.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 07:46:48 -0700 (PDT)
Message-ID: <5d41a9d8.1c69fb81.bdbb9.bea3@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190731143011.GB1680@kunai>
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-19-swboyd@chromium.org> <20190731143011.GB1680@kunai>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 18/57] i2c: Remove dev_err() usage after platform_get_irq()
User-Agent: alot/0.8.1
Date:   Wed, 31 Jul 2019 07:46:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wolfram Sang (2019-07-31 07:30:11)
> > -dev_err(...);
>=20
> What about pr_err, ...?

Sure. I haven't tried to find these ones or pr_warn(), etc.

>=20
> > While we're here, remove braces on if statements that only have one
> > statement (manually).
>=20
> You can let cocci do this for you, too. From the top of my head:
>=20
> if (...)
> - {
>  S
> - }
>=20
> with S being a statement and this rule depending on the matching rule.
>=20

Cool thanks for the tip! I'll have to try it out.

