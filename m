Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39F5ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 23:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDC921882
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 23:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKlYMgY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfJNXfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 19:35:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39786 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfJNXfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 19:35:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id s22so15272052otr.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwUiRmL5zHRuSpoZacB+KbqGLwUbPV8zfP2jjwTQZ40=;
        b=TKlYMgY6BIO0a2BCP9NIZ0RDFSDCMHEJtY2x9DKJYW3dkv4cc3dMdfoEXPfq7nao1A
         FB8isuIUIz37YiDdrnt6tj2rZPqxphRoRXt7DnRZ9IRAcs5kglsAJ0mmTwG9hxcsL0bX
         eb0MFM9vaJmNbvXkyarJwKDErv8tEnSOvMvyg4JE7a8MGMig61jXeS76iRZsnKC2L146
         kFdCa9XX3huj52KblSP/OsgJS7fEJJD+2W4wxnDz9el2/wmnB6wInAj4eZtqdJW4Cno0
         lEyXvrUNPoUnOLU3oA01VMyMsvwUSEJW4ECh+yngbOn7WGb14cG6u4SCGTI79ftXco6x
         5ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwUiRmL5zHRuSpoZacB+KbqGLwUbPV8zfP2jjwTQZ40=;
        b=S1zYNfBIKlGzwvM6r7vPa6u9lYhDWj03Km89vbhusyiSIsM5udhZxJ1gq5OoORSkxH
         YltpUAXOWprkyi8y4icFXBSuvCOBQqKxHugunyZXKJY7UmxitfUa/HgatkCLp8Y0zpXf
         Vuhbde0CgcILdvqAEicS1EMDDvmCOkizTFFeVa1wvxU1/cIDkd7f5dCHk1MPaDzJNODP
         xGZuTSAJ9bbvox4nCXtRyp7TQK3V5PdsZ8mGYNNGDUB7bMWPBphL0W9nc1WqqytuNljV
         erCn62rqyUiJBsSHGxSTbtWhcVOCcylpWXkjAef2UiwgX9uoU1XyojrwiczPmS8GjLy9
         kQNA==
X-Gm-Message-State: APjAAAWe3z3ADI5nxsLfqCShm98j2bb+lJEola45QSjDlkdPSISZ8wwI
        s2ShQO5WCQyqbeEKaO3kph88lnko/H1Uh45iRwJAhg==
X-Google-Smtp-Source: APXvYqzEMn4iiEvRoFnPWid2cqOI3VZG7sGt2CV0SkehdxGAGwKggzD4OaekfLnZ7//zX1O/DAxwc3wOaYMFld0l4Fk=
X-Received: by 2002:a9d:66c5:: with SMTP id t5mr26275692otm.225.1571096148769;
 Mon, 14 Oct 2019 16:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191011191521.179614-1-saravanak@google.com> <20191011191521.179614-4-saravanak@google.com>
 <20191014232828.DA62E217F9@mail.kernel.org>
In-Reply-To: <20191014232828.DA62E217F9@mail.kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 14 Oct 2019 16:35:12 -0700
Message-ID: <CAGETcx9ke3+nGS+dBDOE9EhFhd=w6o5N+P5F7R-xNSi5fRLz_w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] docs: driver-model: Add documentation for sync_state
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 4:28 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Saravana Kannan (2019-10-11 12:15:21)
> > The sync_state() driver callback was added recently, but the
> > documentation was missing.  Adding it now.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  .../driver-api/driver-model/driver.rst        | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documentation/driver-api/driver-model/driver.rst
> > index 11d281506a04..baa6a85c8287 100644
> > --- a/Documentation/driver-api/driver-model/driver.rst
> > +++ b/Documentation/driver-api/driver-model/driver.rst
> > @@ -169,6 +169,49 @@ A driver's probe() may return a negative errno value to indicate that
> >  the driver did not bind to this device, in which case it should have
> >  released all resources it allocated::
> >
> > +       void (*sync_state)(struct device *dev);
>
> This is only in -next as far as I can tell. Will this be combined with a
> resend of the patch series that introduces this hook?

Based on what Greg said in the other email, I think he's going to pick
this up for driver-core-next.

-Saravana
