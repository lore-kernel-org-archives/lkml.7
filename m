Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1DCC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603BF206ED
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk32nNfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfLBVZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:25:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37419 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfLBVZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:25:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so1078441wru.4;
        Mon, 02 Dec 2019 13:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pt+naxqw/fH0eKVqxRkMbRAo9MZMH9ZsIR8OD48HKxM=;
        b=Nk32nNfdBzkzw9m7i4o2nY+rlgd3njRYG+Y7ZLPIG7N+t6YrOFqJ3nPkrVVCxPjbAD
         YoOib11V/zdT60l2iUhNqL6Kp2xrNmT0Yb4X206a15aKTMbqVXshTBE4MMG6SHdXBuhk
         DzYirL+2o9DILOA3AKXigQG1RMoPPIf/0TEwMgs6Vu78hG7bfQnaZ9wIoCoU8tzx9lp8
         Fme8qUAk0vW1GazZUglQZXhGpfEOuOXJTWhxUjIYurf9sJCIZxoZ0L6LjtupG6Mzx5RY
         +EJpRQ6VPS3VzuL/ZlMz4GKuKO1ntU6hDPll3vS++TDRbI7X3Xc5qCph2/0BAEHQA05z
         e+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pt+naxqw/fH0eKVqxRkMbRAo9MZMH9ZsIR8OD48HKxM=;
        b=pjvuUUXV6lEnwnpXDHFVFEbovEYiOU9bLKJ9qR+zB7FHQifEdrboCDa/xMO0GsrMaI
         MrYa1R+CdXIb4UIf/XOjjhljRfo+FCr/ZddSjX0R57f8LzBXZYyPfAjNDhPjDJnPWGSK
         1SItyIxG9MpQ8DedQ25WiEhmPLsC0UXkbQX0+GqV7fIUZHd2Ra+nRhH7GrXUKAauZa5h
         Jvb48DWt+notSo5oYo9mulW98lFpIbkh1DQLbTRKsJPCeJiUCAz/5DFT0/KJwj2Wn08q
         gnTJeBDe0OhgMgpodwIAul4++cTh60nCf1zpzBun6uKRCrOD846UBdbnq3Qm0WeFSiBW
         aQaA==
X-Gm-Message-State: APjAAAU4nbHnH0KGV/nfKy3N/l2tSsKgZTrQaNRcDS6pmhNu8d0Ys7v5
        qItsq1UXfpfAFBJ41Tn2i1rD9FtyaQ3FXlFYIhcgfQ==
X-Google-Smtp-Source: APXvYqw2uAWmBCbxBUOEjOUQzYSJPvI9O35Octjfy7PHavXAejTiHm0aZFlhjtyVLYvd2Lo+zpwiEix23tZpnO3ryIc=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr1177443wrs.11.1575321921005;
 Mon, 02 Dec 2019 13:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20191120172242.347072-1-colin.king@canonical.com> <9056b19a-f63c-8fc0-d2f7-6df3a20c95a7@amd.com>
In-Reply-To: <9056b19a-f63c-8fc0-d2f7-6df3a20c95a7@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 2 Dec 2019 16:25:09 -0500
Message-ID: <CADnq5_NLq7HJ6OAAW6yO9G6NC9Ytpd7mzG8TrRmsLsvHbO9wWg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix double assignment to msg_id field
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Wed, Nov 27, 2019 at 11:51 AM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-11-20 12:22 p.m., Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The msg_id field is being assigned twice. Fix this by replacing the second
> > assignment with an assignment to msg_size.
> >
> > Addresses-Coverity: ("Unused value")
> > Fixes: 11a00965d261 ("drm/amd/display: Add PSP block to verify HDCP2.2 steps")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Harry Wentland <harry.wentland>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
> > index 2dd5feec8e6c..6791c5844e43 100644
> > --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
> > +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
> > @@ -42,7 +42,7 @@ static void hdcp2_message_init(struct mod_hdcp *hdcp,
> >       in->process.msg2_desc.msg_id = TA_HDCP_HDCP2_MSG_ID__NULL_MESSAGE;
> >       in->process.msg2_desc.msg_size = 0;
> >       in->process.msg3_desc.msg_id = TA_HDCP_HDCP2_MSG_ID__NULL_MESSAGE;
> > -     in->process.msg3_desc.msg_id = 0;
> > +     in->process.msg3_desc.msg_size = 0;
> >  }
> >  enum mod_hdcp_status mod_hdcp_remove_display_topology(struct mod_hdcp *hdcp)
> >  {
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
