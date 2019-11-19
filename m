Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89445C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5EF214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBiofW6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfKSJn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:43:57 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35161 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKSJn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:43:57 -0500
Received: by mail-il1-f193.google.com with SMTP id z12so19028704ilp.2;
        Tue, 19 Nov 2019 01:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFLe74/vzczdwackurQ4dB1dCWSikCpaNjwX9L3dv0Y=;
        b=CBiofW6eqKqHm2UpnCQVpu+7I11dVQcpq2qYynsviw3OYGREYbQgKmV6j2c3wL2cW1
         c4VLgaEhiAoj0PmkYaTdJ7TZ4Raio8xoNSrBVrd7pl2Th2j7kUpElFuPLJq/Rda9YyG2
         H9tjSTQdHJ2IIoaRlbf+Ptpj2b9lCcjla07p6+oBZIgEEGa+0+PoOa62JwUcO4AH7FXd
         HIO6SafSwc+YNHLXV35Y0+gPaYekxJtF2syy8X/IA2cLrf8TcvfUQL2c4U/OCHhQ7343
         OSEzlMurcpXNAuA+Pm7GZENAiFepFpZareOwPAl//w78eZwLowPIJc7pgD0Ue48y+JzX
         zAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFLe74/vzczdwackurQ4dB1dCWSikCpaNjwX9L3dv0Y=;
        b=SWX13ohEHHl7R7z5MWyLvgctYx9Sw1JJYdcAkjVGgQVXUBC0Q6sQJMIKAW+w2CNDjx
         Bdnyo/sfdbhkw0gBPJHTvlFwCjyzJUm2vbCZV023JqlHWBmp2+PRXSTi8/e1mHxG2yPf
         CrFXfefEleUcLPjIJ2Kup60kHHKPswIA6LAT4Tze+iT2DlVQaZA7ghLlvVlu0OT8oqWC
         31utErAUAtCW0rHb8nSrYqtoWdkYTanBubgnYtD7o0mKAIf9omhpoOeAXxbwmPsHUdE9
         ssVgJ+x8ON6I511uIpOhllTFeSRGMsiquig/6ZpBmPS7zfeP5z1kV3HQnc83P4gbyd9f
         C4sw==
X-Gm-Message-State: APjAAAXZnP5xUPbs+6FsxBF2QiObhzIvo/yY/cbPw+fgD8nuN1w6XkK9
        aiJW53QBihYtSt3K2Rkh7BRskfV8SviYlA+F9N3gbzb5
X-Google-Smtp-Source: APXvYqz/NOBUo0EyZ5JPeEtiHzQ3FRyqVRmu+VuYA/SQTBIMuFpnH0dt9ZeXjFWo9AhU6AdeRP8eRXn7Nzh9invTvpM=
X-Received: by 2002:a92:17c8:: with SMTP id 69mr21702785ilx.42.1574156634388;
 Tue, 19 Nov 2019 01:43:54 -0800 (PST)
MIME-Version: 1.0
References: <1574153778-59977-1-git-send-email-mine260309@gmail.com> <a1444cbf-3a1d-6f17-97a9-77664a95d304@axentia.se>
In-Reply-To: <a1444cbf-3a1d-6f17-97a9-77664a95d304@axentia.se>
From:   Lei YU <mine260309@gmail.com>
Date:   Tue, 19 Nov 2019 17:43:43 +0800
Message-ID: <CAARXrtmHh-7smvGi1_0J81zRfR9iiEG2+DJK2nDi_fThOKggmA@mail.gmail.com>
Subject: Re: [PATCH] docs: i2c: Fix return value of i2c_smbus_xxx functions
To:     Peter Rosin <peda@axentia.se>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 5:33 PM Peter Rosin <peda@axentia.se> wrote:
>
> On 2019-11-19 09:56, Lei YU wrote:
> > In i2c/dev-interface.rst it said
> >
> >> All these transactions return -1 on failure
> >
> > But actually the i2c_smbus_xxx functions return negative error numbers
> > on failure, instead of -1.
> >
> > Fix the document.
> >
> > Signed-off-by: Lei YU <mine260309@gmail.com>
> > ---
> >  Documentation/i2c/dev-interface.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/i2c/dev-interface.rst b/Documentation/i2c/dev-interface.rst
> > index 69c23a3..73b77c3 100644
> > --- a/Documentation/i2c/dev-interface.rst
> > +++ b/Documentation/i2c/dev-interface.rst
> > @@ -163,8 +163,8 @@ for details) through the following functions::
> >    __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
> >                                     __u8 *values);
> >
> > -All these transactions return -1 on failure; you can read errno to see
> > -what happened. The 'write' transactions return 0 on success; the
> > +All these transactions return negative value on failure; you can read errno to
> > +see what happened. The 'write' transactions return 0 on success; the
>
> s/return negative/return a negative/

Ack, will send v2 patch.

>
> And the line is now too long compared to the rest of the text, so you
> need to rewrap the paragraph.

In this patch it's at column 78, that should be OK.
But after adding the "a" it will exceed and will rewrap in v2 patch.

>
> And why do you need to dig around in errno if the negative errno has
> already been returned?

Yeah, good question, probably we could remove the following sentence?

>
> >  'read' transactions return the read value, except for read_block, which
> >  returns the number of values read. The block buffers need not be longer
> >  than 32 bytes.
> >
>
> Hmm, unrelated, but should that perhaps be "must not" instead of "need not"?
>
> Cheers,
> Peter
