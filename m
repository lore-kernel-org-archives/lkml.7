Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DFEC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF51C20700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIjB1SR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfDEGvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:51:42 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43701 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfDEGvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 02:51:42 -0400
Received: by mail-yw1-f65.google.com with SMTP id j66so1932060ywc.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 23:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLXKMFd7hLBxddsS98FVfEFrGR73aGgg+JOg4CGZs+0=;
        b=MIjB1SR6MDd6UoIN3Pr4xkRlC7W3j6nb4pDl9X9a4q0NPBWa+ub5eLZTQIF9mDsnDo
         gZ9QwXwB4R+bZaQMfn7HJHWyjDEzNpWZgsinSzgCzHn9xymXcqGAaPwqnHlDTPu1qGDo
         ZcRsazTlWwGG6/WHCLYW76FnaTqcvRa0ze9lcCsUHZODpo7pUFHmx1SbAunbP5jGRMrE
         C9WEIl85Sc44vj7gwk/b9kD6uY9ngyp7U7bcoxlL1wXkXdVL7hD5pb7SVSJcPe8hTihJ
         wNwwFPQL4eFji8N7He2hiBiO66+Yh508l6tpKb6bEH6Nqr5Fo7Cul7wQcbT9fkPlD4M/
         UCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLXKMFd7hLBxddsS98FVfEFrGR73aGgg+JOg4CGZs+0=;
        b=p4M3D+ymp3vmE246YOQ0rrK0JLeWuRjH+2SCX4WXxM5cKep4xQhenRrTrGcVi8qEUf
         sKytxWyuI+BrlIi5Ftt1Vim5/B4i+GxRIdgPKQmy5FfpBCfJ79SDB45poi0uMfR6DE7h
         upJy4AoSHOhnBvfHMb831aH7iax3nTSmbsxzLkn/H8QZSx9xnPeSRFyeJKykKK1DmfyH
         b3nADJLzxmJ2klrJskXvsCayJ0LGscE3d6opGkplVSeU1nlo7Ycnvbx3gZQcrS1jowkk
         FaKYDhaNa7+jNepaxO5CHXAqnHdvFLbg0LEp5z+pBTcXGXidvNdpuptC9vcPyXK4XylZ
         Cskw==
X-Gm-Message-State: APjAAAWeuQf7J6y6ltZYOe1RwyliDcvRNmtQJEt68wvE+8lb66UsX4gz
        T+U3hpS4AXyq8/taYKwOdGlFL2N2qDKf0Nf7EAM=
X-Google-Smtp-Source: APXvYqy9NkWPBCnBpIusqqTZWHBijuQ9sgEgNa9uxubq9D1kRhZneVGFLRyXZXLUfvsjRljLepWWEYmr4tJnSz+uGw4=
X-Received: by 2002:a0d:e895:: with SMTP id r143mr883978ywe.201.1554447101533;
 Thu, 04 Apr 2019 23:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190405044602.2334-1-kraxel@redhat.com>
In-Reply-To: <20190405044602.2334-1-kraxel@redhat.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 4 Apr 2019 23:51:30 -0700
Message-ID: <CAMo8BfL3Y6BZwOR7i9FiUdoRBtdy31_VC0t4FWrUr8L9pKvxJw@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: move drm_connector_update_edid_property() call
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 9:46 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> drm_connector_update_edid_property can sleep, we must not
> call it while holding a spinlock.  Move the callsize.
>
> Reported-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This change fixes the warning for me, thanks!
Tested-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
