Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6C1C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01EA20700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Q/ym5/fN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfDEMww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:52:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:46335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDEMww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554468765;
        bh=vXSDomUnLiJ+uBbA6YtrqFgFnMYyMhAKEQ3lEaA7f6E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Q/ym5/fNsUFPCI0xOgOaqAqWxMg9TVx2sAUVQphHwlXnx+OZTyENe36tgpCkvyxbo
         TdxaT42GTTQ5PG4sn1vmZak7MiwuWD4dYoKLeF5W33cs7DekcnRYhExzDTqLeJuL9e
         mpsInz5rAaLEaAP3Wdh65d0YVg5KmU0K29jgLNKQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [45.33.50.49] ([45.33.50.49]) by web-mail.gmx.net
 (3c-app-mailcom-bs08.server.lan [172.19.170.176]) (via HTTP); Fri, 5 Apr
 2019 14:52:45 +0200
MIME-Version: 1.0
Message-ID: <trinity-8d6161e4-195d-4885-a75d-62d071c59212-1554468765740@3c-app-mailcom-bs08>
From:   "Chengguang Xu" <cgxu519@gmx.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     dan.carpenter@oracle.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] chardev: code cleanup for
 __register_chrdev_region()
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 5 Apr 2019 14:52:45 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20190405123246.GE2299@kroah.com>
References: <20190405112711.25275-1-cgxu519@gmx.com>
 <20190405112711.25275-3-cgxu519@gmx.com> <20190405123246.GE2299@kroah.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:6IVBWgazUj5kBXGjYJ4892elvQOCN8xCvp8jkJ53wPOBImYLW0JVjwZ2nHXOo+aNpyaDg
 B6g+o4wfFv1Fpt3c3mvFtmhSHxgE+UApKh+mdxQ/q5SaZGrh3ziJB1VuTkS7F4hmvJitRfGtWrGE
 L3VQM2jrNWp0kKUHZPcer7LOrwjrvYvBR3Q/Jq2MGyPiqMqRQIvIYeKyDumyQ1YvZI9u6PwHmOH3
 QcclLqMj96ak8bFvxRc2Bs/Un24qLRpFmnfLJTnu/6823h7VQHI3UV6p79g6KYfKh4u8fwJI0TVt
 /o=
X-UI-Out-Filterresults: notjunk:1;V03:K0:URroLL+E7OQ=:CUEqpajrcKq+rtJ0W8isAV
 YRpIk0AkYGcE7WCG3YJ6u+8nbGlwDQF/PkxrEhuwnePs4H5ogOVsOcOC6pDP+PZGFUbY1adV6
 OMsqkLvx9RZ8B6aZ6B5VDhQMwj4Cjr+WWtzGg23sM5T0OkZWaRceyEXvclYo0LgZtqYdWV+DX
 Ol/rrJF4P7EemYVz7VnwZn4hlA0qLdQWz5WNNrXmwCf/laZt3fHfYKQnYIxlsgfVqOu/A4eWg
 WJVytc0xOVx4oMAXrYze7vZzwXz8vHgSjRXLbPecJvGS2DtkBjIFSiFsTzAeGhYELkILEJ/uk
 EqRgXqvaEeGsmdNwkQTWaDDS9Bw+inHGfqGppi5PXNRxLwY4QdIfR5PPG3vpPfVV9n0/w7Feh
 2Yil6zazGInBGdX6novs8NieLVDhp1++hDnLFdxW174iMvCa1/8qKolslegJ+jaXKaeWUz4Wl
 N7F/me7OAav62HZvHVPeiuziZ4xf+k9UrltgCWXGmk2umGYanP+dsVDVfo8H8mAQcWhl6s06J
 1aKe1e29J8pDxHvqs02pUyWZ/ZMbOyHngj/ilcDG9DIwfvl2tKdtGoq2JXgC3EDrdDWc+uO4R
 NJ1yJT6D8ftts=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sent: Friday, April 05, 2019 at 8:32 PM
> From: "Greg KH" <gregkh@linuxfoundation.org>
> To: "Chengguang Xu" <cgxu519@gmx.com>
> Cc: dan.carpenter@oracle.com, linux-fsdevel@vger.kernel.org, viro@zeniv.=
linux.org.uk, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 3/4] chardev: code cleanup for __register_chrdev_=
region()
>
> On Fri, Apr 05, 2019 at 07:27:10PM +0800, Chengguang Xu wrote:
> > It's just code cleanup, not functional change.
> >
> > Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> > ---
> > v1->v2:
> > - Split fix and cleanup patches.
> > - Remove printing minor range in chrdev_show().
> >
> > v2->v3:
> > - Set variable ret to '-EBUSY' before checking minor range overlap.
>
> Can you just send the follow-on patch that does the v3 change as I have
> already taken your series.

OK, I'll send another patch for it.

Thanks.
Chengguang.
