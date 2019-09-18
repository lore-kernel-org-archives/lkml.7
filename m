Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BD0C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD27207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfIRUqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:46:53 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37838 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731749AbfIRUqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:46:52 -0400
Received: from mr1.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x8IKkpIK028850
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 16:46:51 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x8IKkkYD009258
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 16:46:51 -0400
Received: by mail-qt1-f198.google.com with SMTP id m6so1398050qtk.23
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 13:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=sj1Be5bh36NPSKpH99IRc3lxyYGd2Gu2Ngf5QRmZxUQ=;
        b=kF1ePxEszuy1HzxtShJ/NiPP3+w6rOrk8IGKwBhs7h4Tth4ijCCsrx52e+HJcRSgGQ
         kGVAcbJqBIrduo4Pdw4yro0uo6/QXtKaq9vtZ3+C75N2x6PptYvp25bk/QnbxfT9OEwK
         SYRrINSlfl0fx3RHw1K7u4FXgViAJBevUPJcESqQjGYshjxuuWz9iJmT7ZyJvjyvyuyd
         /LtqC0ldkMkyThj7RbxcjBWBlHppBx6nC5iy+UmCbp+Wdy5fWDzaT3ayV7WRnTm0j7k4
         MFk1yiTFgCsRB239fdooac55lydT8qnvB9lpUOcaWdt54Mq5IXLhwpehsvAW5xpBuIuS
         GMyA==
X-Gm-Message-State: APjAAAUiHlT5w38uXwbVSWzL0oATEpaygEU4c1JDIIyga4F1aAG4hZcf
        sHNXVqv+IHaSz+xj95Q4chYzQhKIuQPF+smgnxaAn6QYbMnXSKBW7mB2tPj0oikWkuAjzyBaQUJ
        KKI0yca1j9I8g37/f4wFmGthOtjqBmtvdezA=
X-Received: by 2002:a05:620a:1006:: with SMTP id z6mr5929154qkj.319.1568839606151;
        Wed, 18 Sep 2019 13:46:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzN519XpVFShhPUhoMA/uSLKMiNhSJjhYtOC4Omz0W4d+P7MVfJeueZ8N3TjGMgAuGk/d7jtQ==
X-Received: by 2002:a05:620a:1006:: with SMTP id z6mr5929138qkj.319.1568839605913;
        Wed, 18 Sep 2019 13:46:45 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id l7sm3962855qke.67.2019.09.18.13.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 13:46:44 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Ju Hyung Park <qkrwngud825@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Namjae Jeon <namjae.jeon@samsung.com>, sj1557.seo@samsung.com,
        devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: exfat: rebase to sdFAT v2.2.0
In-Reply-To: <CAD14+f1yP7qps9mpF1T9Xf7E5Osthzj7tH35VcWPr3TmxdkMTQ@mail.gmail.com>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org> <20190918195920.25210-1-qkrwngud825@gmail.com> <20190918201318.GB2025570@kroah.com> <CAD14+f0YeAPxmLbxB5gpJbNyjE1YiDyicBXeodwKN4Wvm_qJwA@mail.gmail.com> <20190918202629.GA2026850@kroah.com>
 <CAD14+f1yP7qps9mpF1T9Xf7E5Osthzj7tH35VcWPr3TmxdkMTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1568839602_2440P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Sep 2019 16:46:43 -0400
Message-ID: <110019.1568839603@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1568839602_2440P
Content-Type: text/plain; charset=us-ascii

On Thu, 19 Sep 2019 05:31:21 +0900, Ju Hyung Park said:

> We should probably ask Valdis on what happened there.
>
> Even the old exFAT v1.2.24 from Galaxy S7 is using "either version 2
> of the License, or (at your option) any later version".
> You can go check it yourself by searching "G930F" from
> http://opensource.samsung.com.
>
> I'm guessing he probably used "GPL-2.0" during his clean-up.

My  screw-up.

Original had:

/*
 *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 2
 *  of the License, or (at your option) any later version.

So yes, I dorked up the SPDX tags, as I didn't realize GPL-2.0-or-later
was an actual thing for those...

--==_Exmh_1568839602_2440P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXYKXsgdmEQWDXROgAQIC3RAAq0TrBUiC6gE5oEzKfG//YUj0gtHCuodf
bPRfKrVM5QXCbdSFd4duU0Zfiiy7Zh87J4TVwruHVI4FFqLetNvlR6MqwkLlyYyV
SEAAoVo4iS+t1ysAaRfP6Vv0XhFHy6GqbtGaecARwtaUwOfnx0tIdafJSW3/NC9a
ejVyewuIdWD97inw2avmYtqr97HOJM5Nm7egWJ65ED2W9hjeVidMbPTLnAmuPu7a
+h2zt9HKF/siYYu004Bd5ySAdnI7SiaZ7BZ5vA/G6OVG0tc48exAlJHN7wgtaxw2
20REUNG+Ypt5sYT3xF6D6Puo1MbaF7qBZ5kG0YdKXtkIvRsMvREWlPjU7Tyq1gfD
4m8vhsO1jv5mb0iH5tNphOX8vwAGpiDgCVNazbHPQ2ZM6pyfnJE1LQ5XA8ssCMf/
2F4UVgi+eUL6RnbvO9nfqotEWGEJXT2vUTYbk5mhAbpGkiNQh0hX4raSjNiaM1ae
NJo0WYZjsMomikMMQ/Qy3OJBxsJtM4J7QzUxg//JX7/psUrC+78JjVYMOQBs1g4W
1oyfEmua+BTflDy9Axx5UMLKruDAecGRX79k7yBmeYBxJg26osh1wML0+0sSQ5RW
33NQeGKDCGXdnzUKIPoeNLzz11s/xBnrXs7d8sCbsP76new0henxcuWOVjcOLElF
dGD0xbaj5jM=
=wQUB
-----END PGP SIGNATURE-----

--==_Exmh_1568839602_2440P--
