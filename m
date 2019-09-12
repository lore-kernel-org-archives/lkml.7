Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F22EC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FB320830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qAyF1gfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbfILOMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:12:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36386 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732256AbfILOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:12:17 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so54964599iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2jEDb1QsqevepCdtGya/Z1Hoe5KmOvpZIUb+tzy0XM=;
        b=qAyF1gfc2XLgWPdNN+uNXOErYtAROTxvSjSIWSeLv9dbc2rSX2QVNQJTRvvkY+f4zP
         /PDMieEcHude39r+jtjKNYwhvg/+xJmwORvdwUHfi1Fedd0Cd9YzENBl1pdykyd2RZnU
         SXpBBaaCdY1VlZVryNfe7tJidn1OvXpIi+2c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2jEDb1QsqevepCdtGya/Z1Hoe5KmOvpZIUb+tzy0XM=;
        b=Wi5yB1zjE0MxlUFiAAkq8E1BPhuJiOW9iZfiUE8zCHeXWGptMJ8cnBsq/f0BnG3+u1
         37u987spMp1nrUojuO2lyurBTRM5Dz3msNEIAGjThXK8EX+ZZ9QBKUTnSVb7HGM962XW
         4ePykX8UgXeF51bavcFwmwj7yjkYXDHpz+8YZCbGnRxLqux1bdprG45qYZXzjFem679J
         a1hV4xYkKKN6E4vkexUCl1ESzfC1tk41aO3Z58nnuGyeU8Cp76oOiOxltSEH+8hhvk3K
         85e/AZY4z90PwG14Pa8H4ZoYRqEeGMryZPwEcrnlNb9H4GuU8foLFpK/8KaCeiQ937tX
         GLyw==
X-Gm-Message-State: APjAAAVGJhFK2iPqTEHLIUdala+86akWBKhZB746NJhOsssoSTYBwZPO
        pDaRSXGiLyTFl9/CJ7oaHixsdjFOZ/cf8NfDCUaCMg==
X-Google-Smtp-Source: APXvYqx7aXVKjwtG8nManBSqWbGNQkn9aHInKjBA8WsbuzX4//8mA5DikAGQD5Xi2EEnGxvCyyxVbyXVjjfH2sUuy4g=
X-Received: by 2002:a6b:6602:: with SMTP id a2mr4431129ioc.63.1568297536300;
 Thu, 12 Sep 2019 07:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190910151206.4671-1-mszeredi@redhat.com> <20190911155208.GA20527@stefanha-x1.localdomain>
 <CAJfpegsorJKWoqRyThCfgLUyXiK7TLjSwmh5DqC8cytYRE4TLw@mail.gmail.com>
 <20190912125424.GJ23174@stefanha-x1.localdomain> <CAOssrKc=jv7RfzUWp-SoH7Bo-58XspSKpN1Asz-QMrA6wsVXdQ@mail.gmail.com>
In-Reply-To: <CAOssrKc=jv7RfzUWp-SoH7Bo-58XspSKpN1Asz-QMrA6wsVXdQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 12 Sep 2019 16:12:04 +0200
Message-ID: <CAJfpeguWB_6M1kr0ORQCvLgk3EQKxHisk0bQ2Os++dysfuXKmw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] virtio-fs: shared file system for virtual machines
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 3:07 PM Miklos Szeredi <mszeredi@redhat.com> wrote:

> Is this a regression from 9p?

Let me answer myself: 9p seems to behave similarly: after
suspend/resume it hangs.

So added -EOPNOTSUPP + pr_warn() to the freeze function and verified
that this fixes the bad behavior.

Thanks,
Miklos
