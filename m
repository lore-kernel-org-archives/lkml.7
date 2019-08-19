Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4F7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A69020843
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIEJfur6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfHSNI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:08:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42580 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHSNI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:08:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so8659414wrq.9;
        Mon, 19 Aug 2019 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGliP8V2z6rC/V1TsVyjYxuHbh1FvlQGrbLjX5U0g6k=;
        b=CIEJfur6EE/6ApcjOj//kF9mng1Plat1WW4UOQ/jeuioUW7VWIhgTGG3tFljranNVq
         e/ee7r807xMJEDBbhncTsUKaIHKqb1TOqEZE6AQlY8Gb8lXePAm0itY0OGNjaZPWdB10
         Ygf8giytV3aRNviemmPVFs9sE1ilDJO4Jhwu197NMMDZIKFE829o6n1FJwSXkKaHvNzO
         vNFGEhzjgEyG/mjfFr5vxuF5/5rpH0He2h32zE3dfYEV4GruniiHDirlOTW/ZwMV2ByR
         MOVDlycNVCTkOCsMnGoDi4qLQIsL/pNtM8doYkQ82XUKxcsui49zWsH4npMsvYURyj73
         9kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGliP8V2z6rC/V1TsVyjYxuHbh1FvlQGrbLjX5U0g6k=;
        b=XtixRxqPJjQn894WnhzaPp3PndR57PwE7kccBFHdCWdY7HOrNuAD8whvFEh3FdfeoX
         0iVdRj8AePzGvlm5GpYoYrSfG1OTRhaza/PcJK+49vYWsKsxNMWHDQnNKJqZeqKoMgk1
         EggdQ05NqZanYZ+iN4U3YtD9CRBXTDYwGnNJsorJ3jzEi2i/k4NZfBNovCg0XC65KaTW
         kdCQRjDxo7T7ogiS3m703NKj7Of+BgjwzPdSCJJ9zxzlQc8OZyly6e85fOP7Xb44mGSK
         Ec9OLQI5HwvLxPxUDRGmFiqP6/FHIywSIgkFle0VMxUAeglsGg/2i0oE+RheuMCV2HSb
         V8yA==
X-Gm-Message-State: APjAAAWtqJ5j3B+h83qI+u6nVdlWPI+SqItMRmPLsnlXs9S+jMTk/6WS
        nj8Y6oH+eaB8JNEtuYDMnYviRTfeFFCQXUpzYHw=
X-Google-Smtp-Source: APXvYqxFSg4vpkwnhd00k4l84C3iqI7jsMOwWo+lWFFN0MS3qJnjl+Yqpb3iE0iyIZnBjSU3HlJVqVktWbyqpmkA9dc=
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr27204432wru.74.1566220136401;
 Mon, 19 Aug 2019 06:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190818155957.4029-1-christophe.jaillet@wanadoo.fr> <81BEC287-3D11-4B5B-BF32-3E29F3266453@amd.com>
In-Reply-To: <81BEC287-3D11-4B5B-BF32-3E29F3266453@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 19 Aug 2019 09:08:43 -0400
Message-ID: <CADnq5_OsELJss5pyMmcHJnvVr7FpA0COJE+SmxM7ZQpfvQShYA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a typo in the include header guard of 'navi12_ip_offset.h'
To:     "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Xiao, Jack" <Jack.Xiao@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Sun, Aug 18, 2019 at 9:33 PM Yuan, Xiaojie <Xiaojie.Yuan@amd.com> wrote:
>
> Reviewed-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
>
> Xiaojie
>
> > On Aug 19, 2019, at 12:00 AM, Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> >
> > '_navi10_ip_offset_HEADER' is already used in 'navi10_ip_offset.h', so use
> > '_navi12_ip_offset_HEADER' instead here.
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > drivers/gpu/drm/amd/include/navi12_ip_offset.h | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/include/navi12_ip_offset.h b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
> > index 229e8fddfcc1..6c2cc6296c06 100644
> > --- a/drivers/gpu/drm/amd/include/navi12_ip_offset.h
> > +++ b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
> > @@ -18,8 +18,8 @@
> >  * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> >  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
> >  */
> > -#ifndef _navi10_ip_offset_HEADER
> > -#define _navi10_ip_offset_HEADER
> > +#ifndef _navi12_ip_offset_HEADER
> > +#define _navi12_ip_offset_HEADER
> >
> > #define MAX_INSTANCE                                       7
> > #define MAX_SEGMENT                                        5
> > --
> > 2.20.1
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
