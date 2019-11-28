Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7669FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CF32071F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMiddpkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfK1OhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:37:20 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43616 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfK1OhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:37:20 -0500
Received: by mail-lf1-f66.google.com with SMTP id l14so20195351lfh.10;
        Thu, 28 Nov 2019 06:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CD3KT3jDKFcdk9QWmvaW3E30/HdAFJHMaqJWnwJ9XL4=;
        b=sMiddpkzAh1DbHdi4TK1gxCXtRWKRmIF1Fdx9Ya5zPOsSJgBIAc94hJsOVJxhD2fg7
         Gbb2RKUI5vMt9+wdbeWr55qJ/H/7MAV5FqeEt7sFnL5rCv21ciS26zmAW/NVLxWEb7Le
         k299yNsK69MTRVUmTFr1IYEsgHJejdZ7gQ+CI775nQmHFkEmMDKbvOZZ4DGau5icEXCa
         ZREZAEaczLwjF5j8fslS+TCs6PrL91u5Bhwqqbo11jnYf/ScnfaLShC2UDWLnVzLN6Nc
         PyK8p0ry0L2EoqSKyXH9y0D8mC9h8m9kjiRL179mDNIvCk8N+Z/qgQRNu65ztdSyxpLe
         tmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CD3KT3jDKFcdk9QWmvaW3E30/HdAFJHMaqJWnwJ9XL4=;
        b=V70r+2lnpCiJfVqFFGwg6+20D2M2PmxSB2L8T5g1YIWwBQBo09ADHcMLJv3Lpr+h8n
         n0vOkHtDPXcuwSPnhGsD1ft7aOcipgwIHSYunF/crHDRA2zBWN8VWa6DY3xe93RJP609
         xTmBfaFbDNLSTaZaIMl4khS7yTvU+fSnt/5bXAbvIHaXkErQZVIG4ZRJZkq4q3QsNsym
         ZDBoLnrMTMojUGzn/YclP19q77sPoUgQ9fkp7kizXrkGXg2pXt4XulN3WX4mHlt0Tttb
         H+M1gjlxSdquLSSzdtHUdoRpS7+jyvOXsrnLGoj4mOAB4mgTkYa++YUL//IenEMc7R4V
         BQcQ==
X-Gm-Message-State: APjAAAUifEc8Zc/MQmdpO9Y10auuYdgxkjGXXn3c+7cxJ/v8EIW6ZM+k
        4V1Co8oLC9Uu1/jUzGEwQMRPTvxS3g7PKCwits8WUA==
X-Google-Smtp-Source: APXvYqywPe1s+wGupjSwfA7MED+XaVRLbbh/I03HLGw3/z8NAwONvdwM15MQRnyFk7FbDV//y2h7gEE9uz/3OAmNNbk=
X-Received: by 2002:a19:5f05:: with SMTP id t5mr9485674lfb.149.1574951837564;
 Thu, 28 Nov 2019 06:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20191128105508.3916-1-kbingham@kernel.org> <20191128105508.3916-4-kbingham@kernel.org>
 <CANiq72mnzeQ2SvKbFx+VMFhQnMYNeGQOXpKXy9Vz7kRZyXVbHg@mail.gmail.com> <41212589-163f-63a2-38ab-1a1fb05f4813@kernel.org>
In-Reply-To: <41212589-163f-63a2-38ab-1a1fb05f4813@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 28 Nov 2019 15:37:06 +0100
Message-ID: <CANiq72=TS=-o9s-b-tC3Ngy4gSTVP3sR6aRqh5eiu69PtF7cKg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drivers: auxdisplay: Add JHD1313 I2C interface driver
To:     kbingham@kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Simon Goda <simon.goda@doulos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 3:08 PM Kieran Bingham <kbingham@kernel.org> wrote:
>
> Do you have any experience in these various part numbers, to suggest
> perhaps a better naming?

Not at all, sorry :(

> Anyway, certainly adding in I2C would be beneficial though.

I'd go with whatever you think will be the best for whoever reads the
option in the config. It is not a big deal in any case -- whoever
wants to use this kind of drivers have to know what they are looking
for :)

Cheers,
Miguel
