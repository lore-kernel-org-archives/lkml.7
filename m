Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D66FC31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A51720850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essential-com.20150623.gappssmtp.com header.i=@essential-com.20150623.gappssmtp.com header.b="OX7FQRuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfFNAC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 20:02:58 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:41811 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfFNAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 20:02:58 -0400
Received: by mail-vs1-f53.google.com with SMTP id g24so631553vso.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 17:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essential-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2opkvVT34hnRoCGzOfcOB0iua9D1z55NI8XzuN4ShgM=;
        b=OX7FQRuA9OTKAXDHa/iNjbvag4WVn74BVkR1IdLp8Mya03h9QUvrCqVmmepOf57FCB
         ZNCkgpJio2iC79WzJdsDWwwTkuzWBDsTADMcf3fIBBYd7hvklVq8eELoLbIhg2bE8cL1
         tQzUWKfGZzARzUqJqedVVm+GBx5WmXDypwNz2KEY9+QGIBq8DQa+NbuQ119rXqnoV7fK
         mnohV+8Lj4oqDevRShmZySexdFGV72DG8sO+Oub3eADBjHDY1HYhvajjvnqanrPx+8u2
         MQpEvpnFF50eGJsWxnJ+6Ge84asphx74QbWD6Rgcn7GZVyVMw6AKnzapXQZv9xwb/i63
         xZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2opkvVT34hnRoCGzOfcOB0iua9D1z55NI8XzuN4ShgM=;
        b=Unkebo2cX8hE2oPXMGoJ0LJQnGzS50p9Tr8YCrSwamBJaouAd93+PrEgPOoup9okj7
         RHm+fLeIiq90HDjkn2jaStFLbUw6CdkAYe+R31kjMmkRjtrAG5NBKXKn5RSaebfbFIed
         MAtxi2DzpLojUx6RiQqEzRGhHRorVEz0BUk7EHqPF0KLkD03zBT0Yp99o7TGIjYqRK2G
         n3Ts/GkwdaFv5tHqLVBnaOaCrxGL9H7T4vOtlC+qV/MeZ5DJE+eAa06mzDaTj203/hKx
         0akHZnF/AZxX4qKz7uZGxA29xmHpxQB/yYx0p4ygNxVaXflpIys4aG024/IJcNvX8rc/
         Zv5g==
X-Gm-Message-State: APjAAAV24DpDljkqfMYEFHbnB8on8ML2SNOuYBFARfRwUM1Vw60uAlL7
        SsEnXi/lONSaXNZhHdf52MTfBdOgmzxhFPWKrUFgYq4px78=
X-Google-Smtp-Source: APXvYqzeU0eYysnKeFUi8fAY2Jki/miEPQcV78GxVnv0M+odjqOwRO9SNFqOwYI7O49jZkJEBsFwvNYxkP0T0eK/ChA=
X-Received: by 2002:a67:cd14:: with SMTP id u20mr2693863vsl.36.1560470577392;
 Thu, 13 Jun 2019 17:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXycp+Y-x7N_Yr==Xy_CT5K_a1DZYc85w1OUV+cKC5ZN+KB1g@mail.gmail.com>
In-Reply-To: <CAEXycp+Y-x7N_Yr==Xy_CT5K_a1DZYc85w1OUV+cKC5ZN+KB1g@mail.gmail.com>
From:   =?UTF-8?Q?Jean=2DBaptiste_Th=C3=A9ou?= <jb@essential.com>
Date:   Fri, 14 Jun 2019 09:02:46 +0900
Message-ID: <CAEXycpKJvSsyDQjeCC4YqmtN5tpmO15g8D-_3mrunY-NL1w4Qw@mail.gmail.com>
Subject: Re: Regression post "HID: core: move Usage Page concatenation to Main item"
To:     Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsaenzjulienne@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry - Please find the public link:

https://android.googlesource.com/platform/cts/+/master/tests/tests/hardware=
/res/raw/asus_gamepad_register.json

Best regards

On Fri, Jun 14, 2019 at 9:01 AM Jean-Baptiste Th=C3=A9ou <jb@essential.com>=
 wrote:
>
> Hi,
>
> This patch (58e75155009cc800005629955d3482f36a1e0eec) is triggering a
> regression with the following descriptor (report not working as
> expected)
>
> https://partner-android.googlesource.com/platform/cts/+/refs/heads/q-fs-r=
elease/tests/tests/hardware/res/raw/asus_gamepad_register.json
>
> Didn't see anything obviously wrong with this gamepad descriptor, so
> not sure what's trigger the regression.
>
> Thanks a lot
>
> Best regards



--=20
Jean-Baptiste Th=C3=A9ou
Principal System Software Engineer @ Essential
