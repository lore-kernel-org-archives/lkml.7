Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ECAC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0604206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfq/1cXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbfLMBf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 20:35:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39683 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfLMBf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 20:35:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id e10so796923ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 17:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2aAusbyO0ZJhdBGgk0vE0ZLNHLW0UM7ubt0/byYfBc=;
        b=Rfq/1cXMCKlYio/d+++kQsSLbWozVhG64R+G4fWp0ZgsOTmifOxcMN6seP/hZ5uhJX
         tmwolUE07j/Q/eJEGtRuGH4Ui9km0oftsNBAOThzLkRFz0RI+PF0+IDySHaapQldacrr
         WZwTYK9LwKb3UCN6cF0XrQADE+4T/souylHmtPYvcEaD5VQoh63r4qXgMjelclBCkdo1
         bx6E7ryTyEvjT3MYFZ9Hta6+BlLDP/cXI3dX2i+qakc5SethYG612DofPd02V24okpRw
         XVnsq5AMjbbg4HMuOZ1m3LXX8h/E31Dxa/FlR27JUj4EJLwhD2KYbMjWZsME5r52R6Sq
         dxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2aAusbyO0ZJhdBGgk0vE0ZLNHLW0UM7ubt0/byYfBc=;
        b=c8Dkd7qw9bGEW6VC+isX38Tu0I3trBibtW48PqEiNvBJNgpq98/u6RebhsLLOML9y4
         aiQ1bjQc/uGUrKZwp/zuno2ad0Cvw5I0DyT0MQKjvw0NaRQ/T5QBThFKF/r7xZpvrdNV
         m52SxEDUhbHVdKCtiyo4tuAEX0mHrvBavZEWhkcweO0iEEstAtQayng/qUVPtKq/FNu+
         D0VHfXamurvxQKAYlnN8TDrCyiybcYbn/+xtmDhPpiNH0FiTKC9SpYsiRBaG4zX2Clfa
         zso6/xYI5D7JVq38RckXiW0DIrqwUwJhcNQyy7Vu7Rsy0yqphjxm8J8u50QYwitpIAz6
         aDdQ==
X-Gm-Message-State: APjAAAWHAT3kx2qR23dSJid3uGmmpevg8FCeLBGIBFe+XM0GFgvmc6wn
        L03LcQcBG3U79vNi+WWctH5GswjKWd1F1jiAvozM+P5S
X-Google-Smtp-Source: APXvYqxrsNx9ZdNkFMKeW66nM3zszjEh5QELTpNwM8DBnJtY6H730jTC1vh0jMCn7pta/UrfylyvqN2K37hc406PJ+8=
X-Received: by 2002:a2e:165c:: with SMTP id 28mr7537897ljw.247.1576200927195;
 Thu, 12 Dec 2019 17:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20191210022742.822686-1-jim.cromie@gmail.com> <20191210022742.822686-7-jim.cromie@gmail.com>
 <26c09145-b3d2-52e0-4c31-bfb11a78be31@akamai.com>
In-Reply-To: <26c09145-b3d2-52e0-4c31-bfb11a78be31@akamai.com>
From:   jim.cromie@gmail.com
Date:   Thu, 12 Dec 2019 18:35:01 -0700
Message-ID: <CAJfuBxwggurCvoUq23ZVcDJ1P6TaPVvCvAWkmxw9p9__sx8OTQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/16] dyndbg: fix a BUG_ON in ddebug_describe_flags
To:     Jason Baron <jbaron@akamai.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:58 PM Jason Baron <jbaron@akamai.com> wrote:
> >
> > +struct flagsbuf { char buf[12]; };   /* big enough to hold all the flags */
>
>
> ARRAY_SIZE(opt_array) + 1
>
> max number of flags + string termination.
>


Ok  12 is generous.
v2 had xyz flags, for a total of 9+1 flag chars.
figured a multiple of 4 was sensible, almost went to 16
then didnt think about it anymore.
