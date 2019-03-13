Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16403C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96C7214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TylU3TSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCMM6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:58:24 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:43976 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfCMM6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:58:24 -0400
Received: by mail-io1-f50.google.com with SMTP id y6so1529213ioq.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9/uuxg0Ww1LkBA+4wwTa5RHHcmft7KfFu7X3tJYUIKU=;
        b=TylU3TSXQDIvwd/x4usABhfKhm65K0XzvSdU//mY6Q2jO2IMJckTUGwX29pCXuuiQT
         9wdrFIXhIdQqmL4+M4lymsECCtWrnJQHnBlgACQ/SGgN/GEM2bNYN7LWxAR2FPa9LJmS
         eE5+pDaKJS0wZZxOeRKEJo/+3fEC2VBZQr9EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9/uuxg0Ww1LkBA+4wwTa5RHHcmft7KfFu7X3tJYUIKU=;
        b=kcs1JEmppzH/1D7bSMvbOfOxCxFK54i+qzgoYIyhEgitzfQd9DoNx461teZPryEyOn
         UZlXlSl4QgeONQzy7RXO1sMYSNIbgrO13qgg3kvSkWIu/gyqhQhdNYL3TuJSPWzWrc8D
         SiNGf6z2rFVYpYJi7Dxvwlqz6TNJYyIdgKLZVndtbIWmCiS7ZjgIU+YXRdsX6XAegLIe
         XN7dXDKSZxATnpzkxpS5+zS3e4fL/VkI+FwAApnHtGMUNE318yVC7zQ7OHaOzd75EKdt
         KFMBQmVbFe7o3eiKdWbpdPie3Sx24jrwDEo70M9EBXegYoSI2Dou+4CSao2Vxhy8nVc4
         MgQg==
X-Gm-Message-State: APjAAAVXuFKoAeG1trJCrSaTBMB41H2agCCEAKxl5qvDRoI3GusyvFPX
        WnRW2PTiOKtiAj22V+ooPo6QsSQ0cUvfPKhIxpC1Dg==
X-Google-Smtp-Source: APXvYqxhFwwMWcWZGNlOS4WnQZhsxjMAOUNDycCD5SoizkfWDZVaHfwiwYjeiG3TeuJwTb9c5uCmEHedPtiZtGZxytg=
X-Received: by 2002:a5e:d803:: with SMTP id l3mr19229267iok.144.1552481902632;
 Wed, 13 Mar 2019 05:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <4603533.ZIfxmiEf7K@blindfold> <CAJfpegsy31D+=VJ+By2a9TLCvZJwvAUpb+_bJ5JVTsmsbZJTKQ@mail.gmail.com>
 <1852545.qrIQg0rEWx@blindfold>
In-Reply-To: <1852545.qrIQg0rEWx@blindfold>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 13 Mar 2019 13:58:11 +0100
Message-ID: <CAJfpegvrG4LfnuC62JNtdXpCf4vb+aEiDre5YCxe7xUSQP8yjw@mail.gmail.com>
Subject: Re: overlayfs vs. fscrypt
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 1:47 PM Richard Weinberger <richard@nod.at> wrote:
>
> Am Mittwoch, 13. M=C3=A4rz 2019, 13:36:02 CET schrieb Miklos Szeredi:
> > I don't get it.  Does fscrypt try to check permissions via
> > ->d_revalidate?  Why is it not doing that via ->permission()?
>
> Please let me explain. Suppose we have a fscrypto directory /mnt and
> I *don't* have the key.
>
> When reading the directory contents of /mnt will return an encrypted file=
name.
> e.g.
> # ls /mnt
> +mcQ46ne5Y8U6JMV9Wdq2C

Why does showing the encrypted contents make any sense?  It could just
return -EPERM on all operations?

Thanks,
Miklos
