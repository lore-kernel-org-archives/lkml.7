Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8945CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFAD20811
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfCUJFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:05:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39653 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfCUJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:05:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so4331270edc.6;
        Thu, 21 Mar 2019 02:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8P4BEIRMhxiXq5hDX6IL8w1e2X5ezLtlxNCOV6XLE0=;
        b=f/2kSFWrA2eZOR56bWfGW73jKxlWcdTrugoCgWFUxkOvrrUzrrKBSjMK/Pl/sekEYY
         Mzx9ETVZT2XJbjn1g2NPHZ6n9RWeMoajY36JK1qaATFUZZ4ewPMJPLLX7xRWZLAxqmma
         6erG84/LAcT69zZ1YdgknlkdD/vEHDZvWvE/JRi+bVQUS3hD1vomAFinE18ap5PdwB2x
         pF+UgTj8/3r4c22J1COqGyTLipx4xHEsZ2FdE0IvtFHfslhAvdQp8hZEk1J7WJTURP7X
         BTnnVC3QIWRF08ItA7AiVtjQfk4bY9Aa78OQjkZZxnYLpM3VPdf+NpXsRmemJKdXw4/I
         qJIg==
X-Gm-Message-State: APjAAAW8yxFk8+62VXacPxA0otFy/KIVVqOCpjzKYCMqsUt7zU9O7/Xn
        dDZEskzYhiIcigWrYMY+4UQzRw2ln2Y=
X-Google-Smtp-Source: APXvYqx6eGMybgpohtiLK4+ACIwiisPv8OLhcj5FEOUOk1FrnZaZqGpSybTQkC7+dcYLldob3NhM6g==
X-Received: by 2002:a50:86ad:: with SMTP id r42mr1808247eda.40.1553159150759;
        Thu, 21 Mar 2019 02:05:50 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id oq22sm925629ejb.68.2019.03.21.02.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 02:05:50 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id w1so5708713wrp.2;
        Thu, 21 Mar 2019 02:05:50 -0700 (PDT)
X-Received: by 2002:a5d:458f:: with SMTP id p15mr1820533wrq.188.1553159149850;
 Thu, 21 Mar 2019 02:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190213070457.26049-1-wens@csie.org> <20190213070457.26049-3-wens@csie.org>
 <20190321090119.5h7migh5wkn6yswx@flea>
In-Reply-To: <20190321090119.5h7migh5wkn6yswx@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 21 Mar 2019 17:05:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v64vZ+9A2qQbW5nMJdfZQZs38vAZOH5gA4O3Gf0B4qRd6g@mail.gmail.com>
Message-ID: <CAGb2v64vZ+9A2qQbW5nMJdfZQZs38vAZOH5gA4O3Gf0B4qRd6g@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 2/2] arm64: dts: allwinner: a64: Rename
 hpvcc-supply to cpvdd-supply
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 5:01 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Feb 13, 2019 at 03:04:57PM +0800, Chen-Yu Tsai wrote:
> > The A64 datasheet lists the supply rail for the headphone amp's charge
> > pump as "CPVDD". cpvdd-supply is the name of the property for this power
> > rail specified in the device tree bindings. "HPVCC" was the name used in
> > the A33 datasheet for the same function.
> >
> > Rename the supply so it matches the datasheet and bindings.
> >
> > Fixes: c56689e6f2fb ("arm64: dts: allwinner: a64: bananapi-m64: Enable audio codec")
> > Fixes: 6de8e717848f ("arm64: dts: allwinner: a64: enable sound on Pinebook")
> > Fixes: 498c21f233ed ("arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Merged as a fix for 5.1.
