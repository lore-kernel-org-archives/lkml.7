Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441BAC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63AD21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Im0DR1UF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbfGSUQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 16:16:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40344 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbfGSUQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 16:16:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so30102681wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRQ+uU5wn2WQEQOnZ2UubgfeFVqhZgd9kjVnCaHPrfs=;
        b=Im0DR1UFeZCq0zpB8KVCXvKG4l8B7MMe+rdKU9q1VGpDDB5w+wAaQZF6rnhC1qRfWy
         rcJTvwWi6fHM7Ba2khVUk6x8u++hR78UsmpytMV9E/jZmM/uSWALP4WQRh76lXsD3JKm
         JG3pMxHpuN+1zi+Kf5xUGmAj/PyY1nU7rp3gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRQ+uU5wn2WQEQOnZ2UubgfeFVqhZgd9kjVnCaHPrfs=;
        b=JkgplKKf8qBSot78bA2oTnaRkVjugvJHK1IYwuvQnIKFaRsyriRVIYtRc6tPVfEvhi
         rCB9Rln3v1akkfhGrLCD9v46g9KGxP5sL0gy68Ypr4/AFaBoLwaiwRS2iZK0K2ul0/aJ
         +mjvecMESxI9ACnsKK9nExhkiBNsEYNl+bToJI5bIMq/2n8sTU9fTdoNMc6jmXiHOZt4
         RLweU2tY+vsPggndH0fSUwc/QcdHCoTVwNowWlvJuk53B3E4+2B3tKzFN3GTzSjBWNEa
         bkyUbr5bO9cgjkIkVae+j2+WH/26+cHa3QsBFsHEaDmtrZR0/PrMLODZbYkDA2gXcZvK
         dSAw==
X-Gm-Message-State: APjAAAX1PGN1cnU8eiKzJC9RTg2vT2/KP+zpWTKCirZ/8TuJENl5Uygb
        dgtEk3MqRIIbzl06Jsdv0kvYggFfOjOVVFbgDJjX7w==
X-Google-Smtp-Source: APXvYqwUUphzrItlkDPidpodRtl/C08h8HR9wxM4T7PXeAtVwjCeOoOjvdEgpCVdshASDZhounhK56wQQqk+6ddCGKo=
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr51072312wme.145.1563567374453;
 Fri, 19 Jul 2019 13:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190708154730.16643-1-sudeep.holla@arm.com> <20190708154730.16643-8-sudeep.holla@arm.com>
 <CA+-6iNyFToC8QSf042OcqvAStvaF=voy_ohayvQBVCppgtyD7A@mail.gmail.com> <20190719110320.GC18022@e107155-lin>
In-Reply-To: <20190719110320.GC18022@e107155-lin>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 19 Jul 2019 16:16:02 -0400
Message-ID: <CA+-6iNwgza49jmDbTM-_MUx+VPDFpG=1fN8i8v5vXdQNoOk93Q@mail.gmail.com>
Subject: Re: [PATCH 07/11] firmware: arm_scmi: Add support for asynchronous
 commands and delayed response
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 7:03 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Jul 18, 2019 at 05:38:06PM -0400, Jim Quinlan wrote:
> > Hi Sudeep,
> >
> > Just a comment in general.  The asynchronous commands you are
> > implementing are not really asynchronous to the caller.
>
> Yes, but as per specification, the idea is to release the channel for
> other communication.
>
> > Yes it is is "async" at the low level, but there is no way to use
> > scmi_do_xfer() or scmi_do_xfer_with_response() and have the calling
> > thread be able to continue on in parallel with the command being
> > processed by the platform. This will limit the types of applications
> > that can use SCMI (perhaps this is intentional).
>
> Yes indeed, it's intentional and async is applicable for channel usage.
>
> > I was hoping that true async would be possible, and that the caller
> > could also register a callback function to be invoked when the command
> > was completed.  Is this something that may be added in the future?
>
> This is how notifications are designed and must work. I would suggest
> to use notifications instead. Do you see any issues with that approach ?
>
> > It does overlap with notifications, because with those messages you
> > will need some kind of callback or handler thread.
> >
>
> Ah you do mention about overlap. I am replying as I read, sorry for that.
> Anyways, let me know if we can just use notifications. Also the current
> sync users(mainly clocks and sensors), may need even change in Linux
> infrastructure if we need to make it work in notification style.
>
> It would be good to know the use case you are referring.
Hi Sudeep,

Well, I'm just curious how you would implement notifications.  Would
you have a per-protorcol callback?  The Spec says that multiple agents
can receive them; in our usage we have only one agent and it is Linux.

We have one use case where that this patchset will do wonderfully.  We
have another use case where we would like to go crazy on the
asynchrony of the messages (caller's perspective, that is).
This usage, which I don't think I can talk about, would like to use
notifications and a per-protocol callback function.
>
> > BTW, if scmi_do_xfer_with_response()  returns --ETIMEDOUT the caller
> > has no way of knowing whether it was the command ack timeout or the
> > command execution timeout.
> >
> Yes, I did think about this but I left it as is thinking it may not be
> important. Do you think that makes a difference ? I am fine to change
> if there are users that needs to handle the difference.
I can't think of a case where it would matter.  Just thought I'd mention it.

Cheers,
Jim
>
> --
> Regards,
> Sudeep
