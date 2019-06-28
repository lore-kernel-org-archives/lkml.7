Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF4EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CDE20656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PlfixOl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfF1E40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:56:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40865 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1E40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:56:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id a9so3073957lff.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 21:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Volcz+38jFTPOHhlSCwFUXULczOSSWdKlXjynAvXZDg=;
        b=PlfixOl+QPoGMyaFe2Hbgr7TdZEGndH1m9uWyDNz30knzSu4v0OqSV1jZjRpegQuon
         JyW7CENbD7XnwFyJzLjt84XB2fT/64UHTpHcz/E/9dtFSysS0SqOPgXDb8HS47OX1f89
         K8pPh311m/Yv1NK8pQ5/b/UADCH/nk1O0ChludFMf1bWhV+8jfnnNXjnknGTJSleKP8q
         Obcx3GVTQTRUpERYC/FPi+iZrZEOP2o38tbH0QU5v2dbZQeW8lGL3QzeinimF1gOc14F
         Px8jxHBHiXyRcuuWyi/itTtAWe6QbrGaajI4wjEzxDS5mChRAIFYbd3ENwM0OxiD0mpW
         HM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Volcz+38jFTPOHhlSCwFUXULczOSSWdKlXjynAvXZDg=;
        b=H2E3Xfa5Be5SVKCrqib8vDp+DPf6K9rx6u3onsAcQ9XBSeydKMZqs9rtFYmf6wMDrk
         ssPOE84d2zJybDxuukvHPB2rbuuzRSW50hZ7drHoGHojgKxrRJFZyi8aBNtCQfNBDL8K
         X7WLh4H0NaVnZIjoKIlXDCTcMis5VqKoyMkXY47vMWy/20RNF7Vlx5ltMsH3lTifgzg6
         gV7B7hzQdIU+BmZoFBg3VSIbIfwLpwrJcqPDi1Q8GTDIf8D6xIvLSko0EZaOLwV/Csiv
         RRJhJ9y+PFgAFvtk0wgt4Q20YiWYKu+yNDRjbElf3grMGufzAMhScWEvwVv0dmH8LUE5
         Kgnw==
X-Gm-Message-State: APjAAAWCF2XzKYEC+HlfdgMj0uuOLbILJxuMYMsPxvvI0c2BusFoHntf
        o9rhXfCGkHOaC/6cjqh4tgwkap1tDUSQWk5Xh5oDaQ==
X-Google-Smtp-Source: APXvYqzlzqZOsDs2VTwjk724loQUgJL+eZ4KD/HJzBLf212IMOapwwrzRfTAmHgtC+qcnuRrWo1dAJmH4ez/SKwGT1g=
X-Received: by 2002:a19:6602:: with SMTP id a2mr3799436lfc.25.1561697784041;
 Thu, 27 Jun 2019 21:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <1561624486-22867-1-git-send-email-yash.shah@sifive.com> <alpine.DEB.2.21.9999.1906270911270.12689@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1906270911270.12689@viisi.sifive.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Fri, 28 Jun 2019 10:25:47 +0530
Message-ID: <CAJ2_jOGVJotV73YP9JTr4hDDWgH-Jr6Cfn2Pscx49wR78JocNg@mail.gmail.com>
Subject: Re: [PATCH] riscv: ccache: Remove unused variable
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 9:43 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Thu, 27 Jun 2019, Yash Shah wrote:
>
> > Reading the count register clears the interrupt signal. Currently, the
> > count registers are read into 'regval' variable but the variable is
> > never used. Therefore remove it.
> >
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
>
> This is a good start.  Could you also add comments in the code that
> describe what those reads are doing, as you did in the patch description?
> Otherwise they look pretty mysterious.
>

Sure, will add comments and send v2

>
> - Paul
