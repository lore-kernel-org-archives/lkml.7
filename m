Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC6C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C221A21670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iCYCAb3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbfIFVCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 17:02:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35057 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfIFVCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 17:02:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id g7so7948890wrx.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 14:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWTPA4QfT/u7KTpMZfkRfalR4VSn/NKlHg21Ui/OIDk=;
        b=iCYCAb3lmKvS7toXdPufd/dlWaKSRFbbE5ldGZEmOOJ7hmmtkwHCGqG2wPHaurJapi
         DQK3za+Zr2DI3lINdL/cwKlNGMqUoJOHgy32OAvgWIetKPL/FXFqSZ6mbhHV5DnaviW2
         OO0Zm5rZpMtwbBYKYbFYi8MagfpyMDmeHzBow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWTPA4QfT/u7KTpMZfkRfalR4VSn/NKlHg21Ui/OIDk=;
        b=LoizBGru1ahCCYUryabzJP6kEjTacHl3gSHFQcUsL9dcAmTtQI2lUSvayPGwvfU2fY
         t4pdl8Gj3u2n4hjiJp4wMEKYHftYgm9ct0UEgH+zeOKr66KGzhCON0gk5TdekZ0Y5sDt
         ZDlcOOkWy/3pWn59/0Ae34D3QakvhtgrEcTK9/bTsCSpdrMIKfn1TJu0Pp1P2K4dJe4h
         iVJmbf87MlPXgJUWZ1aI1yJ8B/qdoagHK8X5znoe9qX/uJbNYiPx8tpVRn5Ph064J9OS
         PNyKfaZ8tx0mB3QZgTtX7pnpitIjjQwvIj980REnh+uSUDc4wAOJWhnU/d6EjWY0rdN8
         XwTw==
X-Gm-Message-State: APjAAAU+NYy/KKJvvPYIQzBOtNoDzt908D1+iyzv7z9oDxzAS3xILJ3A
        WymvpjGA5aS/dDUzmjSn/1aQE9R9KC/YrcF4wmRK0Q==
X-Google-Smtp-Source: APXvYqzTpeQnofOOEHooWUc0GkE/tyjL8IOg3Cj5aUeG9aIpdqyy8lUYfaNt8qj//u253apeEtSpih3zrNBb2FezOwk=
X-Received: by 2002:adf:f284:: with SMTP id k4mr9018630wro.294.1567803734187;
 Fri, 06 Sep 2019 14:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190903091953.GA12325@kroah.com> <Pine.LNX.4.44L0.1909031009250.1859-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909031009250.1859-100000@iolanthe.rowland.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Fri, 6 Sep 2019 14:02:00 -0700
Message-ID: <CAODwPW-FybmnZ97eTfShya_z1Oxrc91ofe6yC4vNN2ri51V5fw@mail.gmail.com>
Subject: Re: [PATCH] usb: storage: Add ums-cros-aoa driver
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <greg@kroah.com>, Oliver Neukum <oneukum@suse.com>,
        Julius Werner <jwerner@chromium.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        Dan Williams <dcbw@redhat.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, I found a suitable workaround now to get my use case working
with existing kernels: I can do the mode switch from userspace, then
after the device reenumerates I can manually disable any interfaces I
don't like by writing 0 to their 'authorized' node, and then I write
the VID/PID to usb-storage/new_id.

I still think it would be nice in general to be able to force a driver
to bind a specific device (rather than a VID/PID match), but it's not
a pressing need for me anymore.
