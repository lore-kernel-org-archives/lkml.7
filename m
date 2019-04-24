Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C4CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB3D206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjtwjemJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391430AbfDXRth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:49:37 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39645 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390964AbfDXRaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:30:18 -0400
Received: by mail-it1-f194.google.com with SMTP id e13so7587066itk.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WHhfLu4wuVkD8pobkkPo2fIc8av3brC/CMmAV15vS3I=;
        b=AjtwjemJWW4bdhAM8ETVn5kyELe01ISf2iOLJRElsXF+0a6lwH7DGig+CCUgCEyw4P
         MKw/WJdkJ9c2FoSknYFVtjkwkODWJPgUFU42Aa8Nz9cg/8rDw+anCH+3tn1ryGisye4s
         mtGIeh+sWhpBxqiCYSYT4t2KzzTNOq3ds0vZpeFQ/sk02ubY/R/b3z6vArc4ChfFp1Xn
         ZK9wKJ5DhYu94VyafrYu96LPYMpSYeVJ3fkd/MlrhMA2HwXrSdXwnCQ0MJx8HpJmJJQi
         YDedoLBLcpzOzQfrOdrXU1TrKrHKSv9h2F6oZVA3rp5uW1wpsROejEzCHVy5mQZcfGgG
         h9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WHhfLu4wuVkD8pobkkPo2fIc8av3brC/CMmAV15vS3I=;
        b=hMjdm+Ked5wrhdVZAnZi60BXzsA02HBN5q7X8gngXCRNgqBh7eoznvX+MQgXOXPQNt
         a3lqBi78em1+oWZHNOok3dXEtLcSc4QtL18ssBDQxnF7dqNZuNKnaexI3VKnvwxL/lBK
         QU8GZdLxdbfWxTMZpuc6wT3QAUuejEbEFOFfbmWIWgEq7R+Y/r05UjW90KLyKJ9N+9mq
         SGGoQXTiZEmx0TLDdtQoYbx6iZprVnvUWU7fckfjgFvVn/w73Q0wIL/CPGhrQ0sf/4pu
         +UhL1+CCo27GK+rAez9yAD+oe3VAU8gCzrDSZoaO/yK/USFcjiEhRKvfbpOQp11RdfLf
         B5dQ==
X-Gm-Message-State: APjAAAUilfpeqZD9vUMgXunBS4ymmLIspd6gpxeHTT3REBcacOIxUuMp
        q/YOkd1tBirE5/eUaBVIJz3oB/MxcyNvt7wqNDMeNw==
X-Google-Smtp-Source: APXvYqw/1KKOdtb17KTKv/fEV8z+hZmpaUZLaHqCdkjhIfgVQqbw6/MyDqe/91K9Yoz2tlffGeVTlbuN1fwnM560ub4=
X-Received: by 2002:a02:ccb0:: with SMTP id t16mr23615766jap.137.1556127017979;
 Wed, 24 Apr 2019 10:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ4FQ9AczEXM27=Pn_5iaaAXZ=nA+6FQu7_TRdcC=5RHpDFx4g@mail.gmail.com>
 <20190424170418.GB4253@kroah.com>
In-Reply-To: <20190424170418.GB4253@kroah.com>
From:   =?UTF-8?Q?Ambro=C5=BE_Bizjak?= <abizjak.pro@gmail.com>
Date:   Wed, 24 Apr 2019 19:30:06 +0200
Message-ID: <CAJ4FQ9AQO0=_A5ueWt41JxUcLoa8-4JSGiD3_fOHQqJwKH6gRQ@mail.gmail.com>
Subject: Re: Oops in current tree in i2c
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! I just tested the patch with 4.19.36 and it works for me.

On Wed, Apr 24, 2019 at 7:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 24, 2019 at 06:59:09PM +0200, Ambro=C5=BE Bizjak wrote:
> > Hi everyone,
> >
> > This buggy i2c patch (see https://lkml.org/lkml/2018/10/27/248) has
> > just landed in stable 4.19.36 without the appropriate fix, causing
> > oops on boot on many machines. For example we're experiencing this
> > issue with the NixOS distribution
> > (https://github.com/NixOS/nixpkgs/issues/60126). I am currently trying
> > the fix (https://github.com/torvalds/linux/commit/b59dfdaef173677b0b7e1=
0f375226c0a1114fd20)
> > and will report if fixes the crash.
>
> Good catch, that fix is needed, will go queue that up now, thanks!
>
> greg k-h
