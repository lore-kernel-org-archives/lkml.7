Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571E5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3467E217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfKDKyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:54:10 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:34418 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728507AbfKDKyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:54:09 -0500
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA4As3C8023480
        for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2019 05:54:03 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA4ArwoX031077
        for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2019 05:54:03 -0500
Received: by mail-qt1-f199.google.com with SMTP id g5so11670648qtc.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 02:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=O4sSEohI+9ePFu7NIh17h34X06dA5Ss7wezIrk0/sMM=;
        b=d9ljh9R5xG/+7QR72GGfasMWBOyNaXRRpMAc9+nGQs7GoCPqmZ18fnf/oWKFaD107S
         7Shor1AhBo9/Io46NmIlGz9JRUixGTT5k+Rua+TvFPjaoBEi2oouDeHbWz6dY1GGBp6r
         jdLpuJSCDZSt0irmVA4dgZq0UIOojVr8GlPmNrYMALld6kpO+IwBcWtP8fHQQymqUyGm
         fAxLDDQCBp0OkzCz2WX21+2psK+s9qG/rO2cffxWmlQqAzxflHA7OUOosW5RTTdG8dDK
         U6AAC9TwCibEWrK0SoOKZleWP75bp+3E/O9ffyqf0VzSavob6dpqrxATtpzs97Sz/KP6
         +eXA==
X-Gm-Message-State: APjAAAUlxm2OOSXvDtn8SIgdlNSRQSZj3/1ICI1lsf9ejl31scitbYR6
        ecnOTk/xuW/2f/T9xUenAH/GExXd/wySa+FVltFDIdXmIYEF3Mno2cdHs6OEvZevVoGlYxAsz9t
        r1i2HQAibitYF4ggryqgitcnnSLoKSxzR9Ew=
X-Received: by 2002:ad4:5349:: with SMTP id v9mr19958008qvs.55.1572864837962;
        Mon, 04 Nov 2019 02:53:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwstpqpeboZZUEmIXv+bMXs6fTpFWmQmyQJOF4uLfKs2q0utFPvv23/qq1PCoH4UlOCj6735g==
X-Received: by 2002:ad4:5349:: with SMTP id v9mr19957995qvs.55.1572864837661;
        Mon, 04 Nov 2019 02:53:57 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id l124sm193608qkf.122.2019.11.04.02.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 02:53:56 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] staging: exfat: Clean up return codes - FFS_SUCCESS
In-Reply-To: <20191104100413.GC10409@kadam>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu> <20191104014510.102356-8-Valdis.Kletnieks@vt.edu>
 <20191104100413.GC10409@kadam>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1572864835_14215P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Nov 2019 05:53:55 -0500
Message-ID: <128761.1572864835@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1572864835_14215P
Content-Type: text/plain; charset=us-ascii

On Mon, 04 Nov 2019 13:04:14 +0300, Dan Carpenter said:
> On Sun, Nov 03, 2019 at 08:45:03PM -0500, Valdis Kletnieks wrote:
> > -	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
> > +	if (sector_read(sb, sec, &bp->buf_bh, 1) != 0) {
>
> It's better to just remove the "!= 0" double negative.  != 0 should be
> used when we are talking about the number zero as in "cnt != 0" and for
> "strcmp(foo, bar) != 0" where it means that "foo != bar".

"Fix up ==0 and !=0" is indeed on the to-do list.

This patch converted 82 uses of FFS_SUCCESS, of which 33 had the != idiom in
use.  Meanwhile, overall there's 53 '!= 0' and 95 '== 0' uses.

In other words, even if I fixed all of those that were involved in this patch,
there would *still* be more patching to do.





--==_Exmh_1572864835_14215P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXcADQgdmEQWDXROgAQKAchAAtemIJM4rEnk/fzHoPM8wtbMrApsfS8oQ
xZk0xQ6DGVGwCR67LvNuy3qU5sgSXDuI6+0Egf/63qzQdyZ4C87x49m0p3J6dctU
wFwVlDwlr49ZbCcHDWD/lI7B3cc+1iwxAcMYVXQGMsF4dNckVLzHXjP7PEq0eMnP
xZKkGxU9pvJLpiuCckiJTda+qG9xPJDh9BqsT6L3XQD/yN8ajurYPVkv1FXRiiBY
Xzxw1Vd3vM8lxLyE2KtSB2VVlWGxK8HC9fw49p1RkKpcdXLBYPnf9dy7umSpTM4U
7nPYVj/MMvis4pDb7dRDBicSqgoQd+Np3dz0bHRvHCmq5i3zrxhaYuCaJ+RreRXi
3i4nanOeI43RZ5qfUkUZJm2AthINcNCRLysmprSherVa7jvCr7QJXtkizJgVeYou
Kx/ND16wpQe96G8TzyQXHQx1Ki+0jnjkQLOp1xZ+I4/Zua8KPqrKXafIfzBhQSOx
5FJCXe07qrjJUAfKR/oVTtlzqOQl6tbRNIjClPiJRwfocpEaZi5XBi8Og3cfEi44
+RR9euNuePOCK4wpTOn9u5GBlCIy8IpRdOfMaU3Amh1uzo3rS8cU7fRQYfovmySI
Js1wW1Jc4vdXm6Zx9ijVxxECcK/DfjxGKSTeCqt3Hlo3JxbBX2Q7jvGm4fu066bq
/etC95DRebU=
=E3XH
-----END PGP SIGNATURE-----

--==_Exmh_1572864835_14215P--
