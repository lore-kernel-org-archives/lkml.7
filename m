Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ECDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F802147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJQoTbrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfCML2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:28:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42218 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfCML2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:28:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id p1so1167831lfk.9;
        Wed, 13 Mar 2019 04:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9/qclrmrrk7hPObbqA9eWSUjxZEdmBmfh9T6w5dL5g=;
        b=WJQoTbrNGo/OQniR3YKOXVanWcVxbA+ctKMObE80TAjyJ2KiUk8XLOObu/VBgBmKPA
         TpfjWzkU5DsPoJkBVTwV6yhvvR4qP4Gg9fq32Ol5d/QpGeeUUHc1AXAVdrDZMD5165yy
         wjoxdVyUyk/PRM5denDgUJXFzH2LgADzp6Hfigoo2Wk2fZ7vuJInGnEHIsk+KhGfduQU
         KS2Q4t92cM54Gu/YZubxeoCu8HpmL7x0gVJkiaeWJOe2jXmGxT3nBV6A7FkLMw7wuIqI
         2A/vJrN38mjDc+PvS4AzjE38Gc/mcBD2MS//l+73mCselNd6WnrxvH+SMPgGHP4AR3jG
         RDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9/qclrmrrk7hPObbqA9eWSUjxZEdmBmfh9T6w5dL5g=;
        b=S/mIo8BR3a7/aR0L7qSdk6OobkOeixA1G7f6WLMmH58+evLfC7a6D7mlhF6VOU+BfJ
         EEBWJkd2NTnj2LWu8qdHcdNesveyuMtjFJ7vMSr4XwX1+D6JXI/u4i+2tWN1OdYPABvX
         L+LITUgsQ7V4e/RnMv65EqNPLFxQL782VkPFQwtcCAA+ado5i0nw8MSj+9aNYu0KFQO1
         i2e9/jnRt4NQKS1fhvwEDFQ2KJL1G1A6gESoQy8yrcAvszI9I0IeGtWB4YiKHPCIVDgb
         YkjKXiFLW+R760HSzzx5+jGWKhMybVEIj/6r0jbs3dHZSW3kIW+bjh5nJHdD8Qcf+1mF
         fvmQ==
X-Gm-Message-State: APjAAAVLNz8Ijkctnaq/4j7+2ui0pykjL9VRZrCyIepOhYtYz7Nszv+5
        IlKcYLCAlUx/pIckoTENl/PukqZQumEvlZniuig=
X-Google-Smtp-Source: APXvYqxsTaDjP4C3IbgvOcli7qrbzUyJ41YVNEf6OaU/F5EzpS9DG3I4+0MI285MfTFg9mVfl7voru+Z/KZTOMNsoN4=
X-Received: by 2002:ac2:5386:: with SMTP id g6mr15344615lfh.88.1552476526505;
 Wed, 13 Mar 2019 04:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <1552402660-31730-1-git-send-email-info@metux.net>
 <1552402660-31730-2-git-send-email-info@metux.net> <20190312163356.GB13549@kroah.com>
 <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
In-Reply-To: <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 13 Mar 2019 12:28:35 +0100
Message-ID: <CANiq72=SBFzRVhpkH8V+=5E-adzJ4v6UGAPKfr18wnCB0rcoQA@mail.gmail.com>
Subject: Re: [PATCH 1/8] drivers: tty: serial: 8250_bcm2835aux: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 8:03 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 12.03.19 17:33, Greg KH wrote:
> > On Tue, Mar 12, 2019 at 03:57:33PM +0100, Enrico Weigelt, metux IT consult wrote:
> >> ---
> >>  drivers/tty/serial/8250/8250_bcm2835aux.c | 12 ++++--------
> >>  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > No changelog or signed-off-by, sorry, please fix up the series and
> > resend.
>
> Maybe the threading got messed up somehow (at least my tbird doesn't
> show it correctly), so you've probably didn't see my intro letter: there

The intro letter seems to be an independent message with a different
subject line -- not sure what threading you expected (?).

> I wrote that this is yet WIP, not meant for actual submission, instead
> just to ask you folks whether my approach in general would be work.

That will indeed cause confusion. If you are requesting comments only,
please do so placing [RFC] or similar in the subject of each patch
(you did in the letter, but that had a different title, and it is
not how cover letters are usually sent, they are normally patch 0).

Another option is sending a message with the repo URL where
development is happening, so interested parties can take a look.

However:

> Of course, when the stuff becomes ready for submission, all these
> things will be cleaned up.

Even if you are sending some draft patches, it is still a bad idea to
send them incomplete. Basically you are making it harder for early
reviewers simply by not having written an explanation or at least a
reference to the explanation.

Cheers,
Miguel
