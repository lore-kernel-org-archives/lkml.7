Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F3CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B464220674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCr7EYKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDBVKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:10:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37887 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDBVKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:10:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id c16so13467358otn.4;
        Tue, 02 Apr 2019 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCyTj2OzEYxfgPEXh5Y+jLx3kRgC4d6hz4HgkugezE8=;
        b=oCr7EYKjjOchgjcVqD1naZGpEQCD95nJKZ124PNrvNj5GyyMjLktZQkNuXrEZlzJk5
         AEKQScZM3uTTNi3QOV8y49Gtb5zlM+q3HFwyOhMN1ZVDPbHXCe5PcAh+J52tQqYAq8zz
         oaxfdBQByd+4rVBPRua7D8gqsRLvUbU37ZqNdB9OywowWeDVHO5Fbi/rhAlbbE3gHQZe
         bzBX+wu/7sowdwrMuaFah4x6hIUsTZ8jy5wzS/YawI6PiGYZt0U+ZLMpb7gSflR5gG3u
         x9zENvyzslGTYJ0BPDFqoMjI+EaS+1EWlTou0asSxzGRzSYwrvIxzlJceolmkVU7q+JF
         ldLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCyTj2OzEYxfgPEXh5Y+jLx3kRgC4d6hz4HgkugezE8=;
        b=lNkWD3+BJlzQ9sE/l1mtnIQKWC4LOGNHBu2XO+LCBBRZs0liNgvgEVeNpsveAV+ZSO
         E5n3FLl6gDRbeXxTqVgyP+RSnFWbNXZtX45KriM+voHFxrR//PFNdc4sOcR8N9v5gsL7
         69CbErelG99htphvqWDP0dfU+6+NuJ5MmSHMvpvdHyzKD62sgfIi2POZvEQGwRenIT0e
         tXTmPbnioEAOJtgkHc4tCJI3TkMcpInjH0IUQ0wDWShRWcL0dGGMlAKPibugj09QQXP6
         iKeLLJjsxmH70mmd6KqPHjBINmZSADVgoMRDxTfQGaVMBErbP9m70Y0ogRr8FDawtIj+
         7oCw==
X-Gm-Message-State: APjAAAWiTXUFM2aWGJmOf43AdXlTAJGHZOWYawmwlC4ggCVK9WQW99aa
        3UhANOPEfgEsqSuNWpl6S79Kw3ARLHznB16jbKQ=
X-Google-Smtp-Source: APXvYqx/nkGdiaZm/LJ0rgPZVMA9/qE7toyw3R3ccT8e0t/4QXwN1H3o+O34FWm/aDS2SxoCF5XVSj9sMGIVhsSX1pw=
X-Received: by 2002:a05:6830:2042:: with SMTP id f2mr43384812otp.89.1554239407020;
 Tue, 02 Apr 2019 14:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190322051759.15007-1-tomli@tomli.me> <20190322051759.15007-8-tomli@tomli.me>
 <20190331190801.hxl57om56jskku5s@debian> <20190401174103.GF15736@localhost.localdomain>
In-Reply-To: <20190401174103.GF15736@localhost.localdomain>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 2 Apr 2019 22:09:31 +0100
Message-ID: <CADVatmPtQAfSC=UkYWHKUx98JK=PMcSZB29ULeQKTBLD9iPnkw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] MAINTAINERS: sm712fb: list myself as one maintainer.
To:     Tom Li <tomli@tomli.me>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LFBDEV <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 6:41 PM Tom Li <tomli@tomli.me> wrote:
>
> On Sun, Mar 31, 2019 at 08:08:01PM +0100, Sudip Mukherjee wrote:
> > Technically I donot have any problem with this, you seem to know more
> > about SM712 than I know. But Teddy Wang is also an existing maintainer
> > and I think there should be an ack from him before this is accepted.
>
> Okay, I'll write a personal mail to Teddy. I think it could be a separate
> patch to allow more time for communication, but the problem is that, if
> the MAINTAINERS and the new changes are not merged at the same time, users
> who have problems may unable to see my name and E-mail address for reporting
> problems.

git will not forget that you have done the changes. :)
So anyone who has a problem only needs to do a "git blame" to see who
has done it and the user will get your name and email to contact you.
If that is the only reason you think your name is added as a
maintainer then I guess that is not a valid concern and then in that
case I am not seeing any need to add your name in maintainer.

Bartlomiej can you advise please.


-- 
Regards
Sudip
