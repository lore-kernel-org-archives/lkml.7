Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08629C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29712067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568666321;
	bh=EY6tme3ahlxbvqIuWhhP/CP4BgEmcGv1d6xzN7Rmy2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qIThZZBrh57thwCa/PJCoT+OoDO9kYFSWKV0k+rA5xdLI1mCIG83KhVMJea4fw5Lz
	 zonXDkCBURk3fSGjR36cVVPcMD/iz/jU2sWGvtfG3Kyvy1MpIzv1idl8nL9jSK/hSG
	 0kWd+H+HjZHGOI5mKSfekJpCCLSls3IZpYbCFOTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391424AbfIPUil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:38:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46562 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbfIPUik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:38:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id e17so1188958ljf.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=me/tNrvpc38oLBmNgQpuGD2wwLksgIc0n84g04Pq6UM=;
        b=hFnsr4SQxJjjqereCuTP+xGrGqVFwwB7+2ShWDl5Qp8pLxb4+MV1NinHIOPm4UaO/I
         66LHrIpJRtRLDqw3UxiqboGbOYFJm3hraDsxkxsG2zVzCjIxcW00JkhtL3B0fbXwayOw
         0lnLYFaWHXA2YaW+8dkcHiVuHzVd/UG+TSCPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=me/tNrvpc38oLBmNgQpuGD2wwLksgIc0n84g04Pq6UM=;
        b=tlwdpBl/JWxkEGCK869cS2M1i3rGT2b+RswYdFv1Idn4kw7GWIuVsgbgBBuVcaITWE
         2RKQSJ1j1tFpYFIMO0atJ/aGOp9uLdOW+4YQxGHGG/z/1iqtTjnvlfwUNY7dIhDC17Q3
         mdzh3KovoZua9KfhRy+V5EnXufyIqXcQ1/k4xOxzuQ2SfDJ9yoZ+c+XXUNvQxGUrHwMd
         mDoRYfuKx6YqOaY8LEMGWjwO227EF1wGbByKH4cvgh6ZeBPrTtZ416Rn85uUe4NadnbA
         3JJsqeZ/smM4AgIeNqn2s5fja4nsXcWQrQD5AALS4Rh0HLb+/kCSxDJk4OW13ytFmraR
         A/GQ==
X-Gm-Message-State: APjAAAUn3nC1ZoZVEukCMq4zwyZzy0HY9enpwGnQOAH0afow6E8++r50
        ZRr6bqCBjpJJZUGrNm37WdkuujOawkA=
X-Google-Smtp-Source: APXvYqyl6hcK9+45echxoQ21CSKODD1j3Y7j8UhreRzzk/+XKLDDOV4W5Did/ImU4ZufSw31bt0Dxw==
X-Received: by 2002:a2e:5c09:: with SMTP id q9mr843599ljb.4.1568666317468;
        Mon, 16 Sep 2019 13:38:37 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id w17sm9222708lfl.43.2019.09.16.13.38.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 13:38:36 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id y23so1252760ljn.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 13:38:36 -0700 (PDT)
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr801701lje.90.1568666316121;
 Mon, 16 Sep 2019 13:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <1568237365.5783.39.camel@linux.ibm.com>
In-Reply-To: <1568237365.5783.39.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 13:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuzoK+sP+feizU520p7ChHqdX8pmwyCnnKTyUNJKngZA@mail.gmail.com>
Message-ID: <CAHk-=whuzoK+sP+feizU520p7ChHqdX8pmwyCnnKTyUNJKngZA@mail.gmail.com>
Subject: Re: [GIT PULL] integrity subsystem updates for v5.4
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 2:29 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> The major feature in this pull request is IMA support for measuring
> and appraising appended file signatures.  In addition are a couple of
> bug fixes and code cleanup to use struct_size().

How is the file signature any different from (and/or better than) the
fs-verity support?

The fs-verity support got fairly extensively discussed, and is
apparently going to actually be widely used by Android, and it an
independent feature of any security model.

What does the IMA version bring to the table?

             Linus
