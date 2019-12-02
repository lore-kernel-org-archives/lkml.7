Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1B1C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CCD20717
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xd2IhhTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfLBSol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:44:41 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36786 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfLBSok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:44:40 -0500
Received: by mail-qv1-f65.google.com with SMTP id b18so279278qvy.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 10:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lWgQk/yjEkof6+A6RJhzTS7OUGnQTEIgpDyVHRqaGKI=;
        b=Xd2IhhTZTpcta2HpOq8Glwijpm31ar4AczA2de+61pNAc9S+hIL+qWeJX+IrFMjo+C
         QJn9WAPdW0ndlQ0uEXGdj2QkVJ0ERICSD6oqEGoxCAsEWZHfGjGoYpHmWzhC4hIRQ8YD
         P/9SFpb5kuvt6vx23eENv0peanmM39eRkTqVtzyOj+EolLEkWrn0LFKhAJbZrG/LbGab
         7/7USbgyn9ZaJznvwSZ5p8H/cLsKhtfC1R9FS+lh1aGMljH9ICnSJToFTpBVpIETK0Jm
         4K2VCuOF+VkDJ1kO/su7RDF5eBISJSFBYg6XYz8Gm/QVOQre4/A9deWYTdd2laxHKO89
         VZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lWgQk/yjEkof6+A6RJhzTS7OUGnQTEIgpDyVHRqaGKI=;
        b=goohwVJHWIG/viiRkCQkY9/ckQc+A3DH+WqxZWWrK8kklK1zxQif6hFBbEBpOHxeTb
         4i9Cjc+yEqTw1qEYYpLwDqE8JdcPYn/qAi+y9rAXqA1AB9RZznEPYxbvQSGrm2Ydz9FX
         Zhj2IiDiMFMT8cuDynWXQKEY7QeCOrt+Xfr+N+osiYlblkoixsGobdQFuap3Zo6Z82Ud
         q6L58QXTL+Mj2BK8poSj4XHxORpDyNmO0my0WBoTnd8N0Yr+gDkg0JpyFt8TtkDDlQiC
         1EEv8RaCIY7QLpxFXMdg/wTjfAkZhlCJSCSQSogtsFT6sqAtBPOaREQIXW9HbqSfc0Bi
         o64w==
X-Gm-Message-State: APjAAAVKDRfjXOcEudhkrvXp8n95XcHJLG8CFnxExdm4qdM0I6JbXtLZ
        au1lkq+jFZR45bI/Qa30y+A+GCyr3rS2d69o2ETf
X-Google-Smtp-Source: APXvYqzMwz5owY2WFHcs6C3yfmFFs5JIVwGcO1bFusNGd+gCS4WlVuMUKR/2QgT03j3MXHqaDevITixc8oo/4DG7B2c=
X-Received: by 2002:a0c:b455:: with SMTP id e21mr524882qvf.72.1575312279611;
 Mon, 02 Dec 2019 10:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20191127095459.168324-1-zenczykowski@gmail.com>
In-Reply-To: <20191127095459.168324-1-zenczykowski@gmail.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Mon, 2 Dec 2019 10:44:03 -0800
Message-ID: <CAAXuY3oZSMYd8_f9dDSf_oktnC0oS6yKBJWOmcMi4Jn6C0MkkA@mail.gmail.com>
Subject: Re: [PATCH] proc_do_large_bitmap - return error on writes to
 non-existant bitmap
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus FS Devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 1:55 AM Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
> We return ENOMEDIUM 'No medium found', because it's the best error
> I could come up with to describe the situation.
EFAULT for bitmap =3D=3D NULL and
EINVAL for bitmap_len =3D=3D 0?
