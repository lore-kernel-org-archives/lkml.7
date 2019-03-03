Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2138DC10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E606520830
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551632676;
	bh=tCn41TbqxSudguWW65caUqiNZv9n6uOUq7iWhI0Vjkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=noFznt5t0+Tp21LgOTSdNOBHjDQhi81EkvWyrEKFD5Or9ihkz0mnqxbNZNpKB9i0K
	 Ja0vjvruxG7PaliGnwIqyk1kjDlRzC9y32xfCLe1X5uPEoQOx7TeYLGtb9XXqNOTMt
	 Fe8akA+zzZFmaKTtAZhY6G4Iz2dhsZdpTueDVeVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfCCREf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:04:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfCCREe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:04:34 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B42520818;
        Sun,  3 Mar 2019 17:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551632673;
        bh=tCn41TbqxSudguWW65caUqiNZv9n6uOUq7iWhI0Vjkg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v7Y1Wfu0OioOaU6RjvRx6Mo95OvOijFUaG5so/U8XhoIcpzygL2fCrbyUxIHHrUpa
         UCCZhZ5IXFF4yOQbfe50sM+Cy921rXYmOpMlaTTs3gs3leyeCZFvou4fyQyGbq/4yx
         B0UNCrdVg3P+bSJlOlrgZfqzKOV8uMfHKAJ0c19g=
Date:   Sun, 3 Mar 2019 17:04:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] iio: mma8452: mark expected switch fall-through
Message-ID: <20190303170428.1d3f631b@archlinux>
In-Reply-To: <e612e707-4a54-7b59-e350-139766529316@embeddedor.com>
References: <20190211222318.GA21656@embeddedor>
        <20190220121726.3b10e0ec@archlinux>
        <5f52a67e-d1b8-4f2f-d6f3-309e6683c02b@embeddedor.com>
        <e612e707-4a54-7b59-e350-139766529316@embeddedor.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 12:07:28 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> On 2/20/19 11:21 AM, Gustavo A. R. Silva wrote:
> >=20
> >=20
> > On 2/20/19 6:17 AM, Jonathan Cameron wrote: =20
> >> On Mon, 11 Feb 2019 16:23:18 -0600
> >> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> >> =20
> >>> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >>> cases where we are expecting to fall through.
> >>>
> >>> This patch fixes the following warning:
> >>>
> >>> drivers/iio/accel/mma8452.c: In function =E2=80=98mma8452_probe=E2=80=
=99:
> >>> drivers/iio/accel/mma8452.c:1581:6: warning: this statement may fall =
through [-Wimplicit-fallthrough=3D]
> >>>    if (ret =3D=3D data->chip_info->chip_id)
> >>>       ^
> >>> drivers/iio/accel/mma8452.c:1584:2: note: here
> >>>   default:
> >>>   ^~~~~~~
> >>>
> >>> Warning level 3 was used: -Wimplicit-fallthrough=3D3
> >>>
> >>> Notice that, in this particular case, the code comment is modified
> >>> in accordance with what GCC is expecting to find.
> >>>
> >>> This patch is part of the ongoing efforts to enable
> >>> -Wimplicit-fallthrough.
> >>>
> >>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com> =20
> >> I know Peter probably won't like this, as it doesn't
> >> read a as well, with the else dropped, but I'm going to take
> >> it as we have had a lot of bugs caught by this code and this
> >> is generating a false positive.
> >>
> >> Applied to the togreg branch of iio.git and pushed out as testing
> >> for the autobuilders to play with it.
> >> =20
> >=20
> > Thanks, Jonathan.
> >  =20
>=20
> BTW, Jonathan, I wonder if you can apply this one too:
>=20
> https://lore.kernel.org/patchwork/patch/996804/
>=20
> Thanks
Now resolved.  The issue here was the code was 'interesting/crazy' so
we needed someone with hardware to rewrite it and test the result.

Simply fixing the fall through wasn't enough :(

Jonathan

> --
> Gustavo

