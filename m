Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42665C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160BA20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FJ8biDWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFMPs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:48:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52409 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbfFMJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:20:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so9377936wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kotA5N9EoUxhGkMwLE3/QhHcmiICXj1ka23TDvB3rSM=;
        b=FJ8biDWxyeoMYEpxvOrTcrucGhSnQZXA9kUvxSyUo6V4DerOufEcXA7Z1ssTQwCwpS
         bsMvySOAoDvKrrCgCPIAOT9GsWHNT1Lp06Gmqoh0hYboenGzdtTEFPxoJI7TkX5RvpFv
         Qcvq3eguvfL78hi5YEQeX5T+wEB4ZO5EMX3tN5H0VT6SIwcmPEmdzNfEDwT0AphM03M/
         US3ZxjNlsuUuoZTu9OUJOUVj6a7Y5rBQuqnHbssIC91vYa45GPMIhTkUZ6g4Gi+1DhR9
         DEx4zragsgMC8MkmxzjP2O2ZA9dE/1drWvrKZd1Z4kNecJK8UGR90l/mp7hMMVCxo5jS
         lkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kotA5N9EoUxhGkMwLE3/QhHcmiICXj1ka23TDvB3rSM=;
        b=s5qdMHFBDL6ecwlxPTrkDd46wY07BL0kvtWhpeWnwA32OeDlV2JRBW+qp0g1swWYLA
         0GLvc3baUsBHQC+dhpFQHWQit0riE4K5Z7lUr1qG2s/koEiPrD9AwkFzPKgqs06YlVWu
         /suKGDXkEhN1CsXD26ihEmQSXKWBs6HdbH/zx3Z2rs04cYJSZ7N5JCV2bWduoE0O2YzF
         n6dnvrNwQXdKEFsu2scsbXW1Npl/ctDqzkNeLP3aAW2OPxqrZwaVO3mE4I5hrDbB1VZk
         u8YDshX4qRhhyTcK+p5RHCCUFk9feUXN4A8U1V0EL9aJufz5mkj48JbvnTSiqJ4zfHxX
         ygiA==
X-Gm-Message-State: APjAAAUMRBXLPI6N1t4+OS3j2+ME95G/7x5420Ufcmhis995SKwkuGAB
        KI4hsqiKpUt5sxvD9fee0a0cOclg5NW/IXWfwNZtpA==
X-Google-Smtp-Source: APXvYqyF4beCFeHK+yRlaCF2vVGkbOQNCZTufPhtT/Uyk+odeT53Xmpq+5vVT2nuqZWItux6aLxsRUiBbqTIUkv7Yv8=
X-Received: by 2002:a1c:6c08:: with SMTP id h8mr2990087wmc.62.1560417618124;
 Thu, 13 Jun 2019 02:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190612144218.26149-1-colin.king@canonical.com>
In-Reply-To: <20190612144218.26149-1-colin.king@canonical.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Thu, 13 Jun 2019 11:20:07 +0200
Message-ID: <CAMO6naxDNmsqUVgAJ2uMBsQPUjsYK6zLhgubNfeEB-GEdD7sOw@mail.gmail.com>
Subject: Re: [PATCH][next] staging: media: meson: remove redundant
 initialization of mpeg12
To:     Colin King <colin.king@canonical.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-media@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,
On Wed, Jun 12, 2019 at 4:42 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer mpeg12 is being initialized however that value is never
> read and mpeg12 is being re-assigned almost immediately afterwards.
> Remove the redundant initialization.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/media/meson/vdec/codec_mpeg12.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/media/meson/vdec/codec_mpeg12.c b/drivers/staging/media/meson/vdec/codec_mpeg12.c
> index 5398fbf7ce20..48869cc3d973 100644
> --- a/drivers/staging/media/meson/vdec/codec_mpeg12.c
> +++ b/drivers/staging/media/meson/vdec/codec_mpeg12.c
> @@ -63,7 +63,7 @@ static void codec_mpeg12_recycle(struct amvdec_core *core, u32 buf_idx)
>  static int codec_mpeg12_start(struct amvdec_session *sess)
>  {
>         struct amvdec_core *core = sess->core;
> -       struct codec_mpeg12 *mpeg12 = sess->priv;
> +       struct codec_mpeg12 *mpeg12;
>         int ret;
>
>         mpeg12 = kzalloc(sizeof(*mpeg12), GFP_KERNEL);
> --
> 2.20.1
>

Thank you for the patch.

Acked-by: Maxime Jourdan <mjourdan@baylibre.com>
