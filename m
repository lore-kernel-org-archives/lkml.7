Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DC1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A33B2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCvXoTBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfCXSdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:33:50 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:45194 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXSdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:33:50 -0400
Received: by mail-oi1-f170.google.com with SMTP id y84so5263932oia.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fH8yaGt4DFW3AF+1/cl2eO4ndvTmCL9cuV2LxLrNlmU=;
        b=gCvXoTBvl62SbQkfDSBpR7OfmeA2LlzxcUOor/SOkUAJFwbTCcbFb0MEIRv5RhiOvF
         ODPKJ+vlnkhrE1SUJXDxDhKy+fzU96qk3XXwtrscoD/6QZUBDVegjLuTXtQs9HFMSSbx
         QyljovD32Hv359UyvSsry9nqa+dPYNztqxUqGrJPgFgku1wxRxNEt1NOif/jjL5Dk0OR
         930OsKoRXSBCwacrFyWmGnDmCukHKvmr8W5Mriiwn8jjCbt3ITQL1S3cKELG3KKJ2Jeq
         0dNT/Woc3e/kwQVh+C43se0OS5EaojkuRV1te8VtGP2/n5nwLc2Islox6rsjvF6XiA+w
         bLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fH8yaGt4DFW3AF+1/cl2eO4ndvTmCL9cuV2LxLrNlmU=;
        b=tlO0g5PuFjTAa9tqZq+vJ8sFOclzlY7+QnvQmvPwWbcpI7UF5VU0yFw+nKg8oN92Ug
         8vnDlvcKr8EKlUzp2+7qGxU7uhhB+5kZTur9a8NM208Ahd4YPJ4S+62tIfMk9ryiDRnG
         R5MtgPfT/OPbRTcplq5NMalZ8X7pun9qyvTGnj2Mr3Dyo+wMg4iDCNp0EZfUcNDCqF4X
         4G9Q7FJjRU7D7+BmCTZHOCMuNP4Mzz9xGbZlhk9lgB1rqOtNGwfu1AZ8McVfW4aE2J/z
         Y0/BLL0Xb/f+BNYd+Evbl2+reVZ/u46OXqLzznKGjDWiyug4y0CJ+4BgI7uYAGDAxX7Z
         i/5g==
X-Gm-Message-State: APjAAAX0sY0h8/eXLGenOK+I9fVvCBeNI1YN7+msq9/TE0UcW4yk2y68
        QVuTH3ruxVCleG9wFLNym94y6J6J8dT96Bd7pOo=
X-Google-Smtp-Source: APXvYqxGdNfCltHIeRjkaTnWZbFRzc0EyShnnfZP0uZoh/+eFRvsgqHFeCHUcwU7X7fqWhGV1p6xORieCjToPZ3dvbA=
X-Received: by 2002:aca:d702:: with SMTP id o2mr9267141oig.113.1553452429766;
 Sun, 24 Mar 2019 11:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190212174318.GA22735@embeddedor> <4d221d8f-f4d0-90f7-dccf-3af67d4b0c53@embeddedor.com>
 <7b9bcd42-47fa-05cd-2e92-0124109f9aa2@embeddedor.com> <20190320201235.GA11793@kroah.com>
In-Reply-To: <20190320201235.GA11793@kroah.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 24 Mar 2019 18:33:13 +0000
Message-ID: <CADVatmOzJkbLgwqCM9rn2-XKFFijf_F7WQngiG1JnTP=pJHNcw@mail.gmail.com>
Subject: Re: [PATCH] parport: ieee1284: mark expected switch fall-through
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Mar 20, 2019 at 8:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 20, 2019 at 03:06:04PM -0500, Gustavo A. R. Silva wrote:
> > Greg,
> >
> > Can you take this, please?
>
> Will do, give me a week or so to catch up...

I will send it to you with the another parport regression fix I have.
Will send you by next week.


-- 
Regards
Sudip
