Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A8DC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FB82085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOoNaQnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfFZTjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:39:43 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44180 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZTjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:39:43 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so4687462iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrgKV2laxb7CmMhAO2Zht6dY5cjmqevbQFQ/CfbqMLo=;
        b=KOoNaQnzlS7is373aZlIpXHi9c/FdczNBYXNJFlghPA2DuSObQ02XSjoB1IECTklM+
         lu+Dc+nt5KYYNp13+gCQ+cSPlInpBMLEywNBGsksqwRjnrv4SgUO4PXqNuruj9JYNsLm
         kz6tlMgIJDouZH1XfpYKhctzWZ+76XIHOprLbjuymNqrlW+9lhNJvZkyzXwBn0LCXAv1
         bgQrnFzdo87+D0PZ6JlClu2ag5qEUE87IshPvZXHlnIwnO4AHs/bvDfaaqoDHucFvW0c
         JdK7yuvbRLz0qrXD7/fy4fHElKOQlRQjn69aL3tJlmmNO9FR5oavdTLDNvBKbt8YQRmt
         E+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrgKV2laxb7CmMhAO2Zht6dY5cjmqevbQFQ/CfbqMLo=;
        b=JHi7O7xX4pWxQTGnv1WS5daRptCkEpilYoPaz7pEYEoKkE+3Tx4iO0nlRgPWEuA867
         u9iHf3hm46FSsG6YH1oHLniuLr/L46Ub5j8IzEfZT9TqzyyOvntSvG89Xidee36fK+27
         Iq8SUrCKpWw0UU7hP0hayfOLOlKMWoq/4bW/Dtz1rgPRz1XPmpex4H+GMZnv1VkimGJk
         AMUnFMtJPlHUnUGMhPHgegmeVplPH+fcz5yUYaY5b13HBI9o26EW7vOOcFzbJ3N0E3GW
         GkW4sdfRZy1Iji9WgRq2D2UBjvWflwqLpvczNwMg50Ga4xb7zgLbNGPyzIxLw4eU7D88
         cM1Q==
X-Gm-Message-State: APjAAAXyGNqHSjE/JPi79eZaXOSkrG6E2Olx0Ro568KLnEvPuQo3K44E
        NlH2F1ML+WoiSqt2a3DOY38jYHaPs1wRkZQeI3yFGNRO+qc=
X-Google-Smtp-Source: APXvYqzZOm3tnncwSNKOqbGjfZFdhqffwjA+jtK7Mdjt6sdyN+pEm2CYZ51R95H0ZHN2OwG9zQHYDMww4fcojyvf4zk=
X-Received: by 2002:a02:3308:: with SMTP id c8mr4225629jae.103.1561577982127;
 Wed, 26 Jun 2019 12:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-30-matthewgarrett@google.com> <20190626090748.23eba868@gandalf.local.home>
In-Reply-To: <20190626090748.23eba868@gandalf.local.home>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 26 Jun 2019 12:39:31 -0700
Message-ID: <CACdnJuubBJxrybsV6+hyz9RyUR2AUyzy=4WJEeoYrNgbh_=FCQ@mail.gmail.com>
Subject: Re: [PATCH V33 29/30] tracefs: Restrict tracefs when the kernel is
 locked down
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     James Morris <jmorris@namei.org>, linux-security@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 6:07 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 20 Jun 2019 18:19:40 -0700
> Matthew Garrett <matthewgarrett@google.com> wrote:
> > +static const struct file_operations tracefs_proxy_file_operations = {
> > +     .read =         default_read_file,
> > +     .write =        default_write_file,
> > +     .open =         default_open_file,
> > +     .llseek =       noop_llseek,
> > +};
>
> This appears to be unused.

Oops, yup - dropped.

> > +     dentry->d_fsdata = fops ? (void *)fops :
> > +             (void *)&tracefs_file_operations;
> > +     memcpy(proxy_fops, dentry->d_fsdata, sizeof(struct file_operations));
> > +     proxy_fops->open = default_open_file;
> >       inode->i_mode = mode;
> > -     inode->i_fop = fops ? fops : &tracefs_file_operations;
> > +     inode->i_fop = proxy_fops;
>
>
> I think the above would look cleaner as:
>
>
>         if (!fops)
>                 fops = &tracefs_file_operations;
>
>         dentry->d_fsdata = (void *)fops;
>         memcpy(proxy_fops, fops, sizeof(*proxy_fops);
>         proxy_fops->open = default_open_file;

ACK.
