Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51D8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DA720883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OFKrDeeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfDBMJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:09:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34092 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfDBMJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:09:58 -0400
Received: by mail-io1-f65.google.com with SMTP id n11so10676967ioh.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxZ38+geJohEa6bsRd06GnT7jq/DqWsytD7WLbIy5qs=;
        b=OFKrDeeqBv9PQ9NPUpLnrNvlElU3fCTHWiuNwR1tlzpYqLutj+AuFor0D2yrbO6EHR
         QVqRT4LKLIQaodOKa5hubDDZRlG6hZSS5zjBD+BjmRYGMfESOZTV7BD1j/KxIX/6K7Z4
         hd1s/k3zQGp/yMnXfRVU26LM3C7U0qtXH9Va8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxZ38+geJohEa6bsRd06GnT7jq/DqWsytD7WLbIy5qs=;
        b=lgpglnE7di8aaroeWwyH2NrO5PBVkJuMUYqzBYF9kYm2p/vi9JGDXbbhfGtCXCLrYd
         EMh98bjizBkyUkBrjkoBPlwGDNubgPujQ9eYoNogBsZBzn3aDod2+vSrlMmeFPDP17tT
         jcmT+0NAOZtqJlMfoqjGaZSbxrvfpfrcIu1al42HD5+9w8fc/G5/EbEoTjmEhYWyBY4Q
         af3ANXNJY+7PK7a3D7buKJWcq+F3oAQbv4t2r09t6qjAHAAc0CEbgeZ/r5XffsLnWkUs
         avmjfnyIJlh4b9qtqmBaHUwZxE8UltzEoSEvPCWhw3VqOGQHbrkhPOeaxREG5yXQ9qka
         Y4Cg==
X-Gm-Message-State: APjAAAUZrPDBhNvrmCe7nzPpGFwkg+ArUmC9UEmA2depITGk4W8SnjPE
        yOQXf39tq6ghe66HZC960/panLa8YZfjdVybagVw0g==
X-Google-Smtp-Source: APXvYqyzTSJxyP4umdHQsKGf4C9WWPu5UoTrV0LyBklzDRcYW4BFyzNLh5tkYE6EtLtFWaBA5f57938DiSovuDuvO0s=
X-Received: by 2002:a6b:7519:: with SMTP id l25mr35735916ioh.51.1554206997597;
 Tue, 02 Apr 2019 05:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190314114511epcas2p2a9669714177b00989bd3195300f7d3a6@epcas2p2.samsung.com>
 <20190314114500.8336-1-kraxel@redhat.com> <33cf37dc-8456-0316-0b48-fca7c92caa28@samsung.com>
In-Reply-To: <33cf37dc-8456-0316-0b48-fca7c92caa28@samsung.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 2 Apr 2019 14:09:45 +0200
Message-ID: <CAKMK7uEs+OaoiEmd9Dp6K_v5Pz4pf197DP8KFkvhNMYXv9tYxA@mail.gmail.com>
Subject: Re: [PATCH] fbdev: list all pci memory bars as conflicting apertures
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 4:00 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> On 03/14/2019 12:45 PM, Gerd Hoffmann wrote:
> > Simply add all pci memory bars to struct apertures_struct in
> > remove_conflicting_pci_framebuffers(), without depending on the
> > res_id parameter.
> >
> > The plan is to drop the res_id parameter later on.  For now keep the
> > parameter, use it for sanity-checking and warn on inconsistencies.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Patch queued for v5.2, thanks.

Might be good to also stuff this into drm (double merge or topic
branch, whatever you prefer), since that's where all the users are.
Gerd also has some follow-up patches to apply on top of this one iirc.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
