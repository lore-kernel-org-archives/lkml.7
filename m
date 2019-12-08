Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B638EC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0D5206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLHQqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 11:46:04 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36940 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfLHQqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 11:46:04 -0500
Received: by mail-yw1-f66.google.com with SMTP id 4so4884583ywx.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 08:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yfl2VL45CJWy45zVJmojuHCfMhAdNkkScK26RI0Oifg=;
        b=UhaRPX7zDktVnDqqZ9jLEVG2M+7U8UgDFNfdMwu+w7gGNuKnxJbHxCxT/2zV3arjaW
         dSFtSe7yIHbwwfBZ7BG5DO8h9E1mxEsJcLrkSS+rwkJXXB/G2JnGbbH3GBTY85LK/jZI
         JSnEpWLDxRGD1oK8nKWsAkSwjsnJGv7CI53xT/oFhmGarD6Q730AAmfaqKOvUcTnPBJy
         RGQqacB/rL+u+eFgii+6BGphSJtK0RYbZs0sAVFrtdVrD+7GtZ07oD+vhaRABfSo8XfN
         YyYOJhA0VT4lf9alNyFKpkOtYhR5vSBGlun924AOuUJ+Ycq2aXjlg842YDaL9NMC1cjq
         bamA==
X-Gm-Message-State: APjAAAXNdnm9dka4gWOBOy7CM2DLFOlk59QTGLBQqm2Wf+4O0mmfnusD
        k3p7n84fwuXGXMwta7Lzwz3Ur+GZ/zt1kiDEIF0qoAKD
X-Google-Smtp-Source: APXvYqzHFOSYg6Unv1+lMreFicMCxmFLQ8Td4co2+hw1b+6VRq6Uhlx1WB6zxLNdb+5Hjj4GuXZGSKawvwEG4nZDelk=
X-Received: by 2002:a81:8986:: with SMTP id z128mr18319552ywf.320.1575823562736;
 Sun, 08 Dec 2019 08:46:02 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
 <CAHk-=wga+oXMeMjftCKGT=BA=B2Ucfwx18C5eV-DcPwOAJ18Fg@mail.gmail.com>
 <CAHk-=wj9pprDUeoJd5EeN-2x7+GXdSsm44mSv1y9f5e7MrTZ2A@mail.gmail.com> <qsh5n2$3pu9$1@blaine.gmane.org>
In-Reply-To: <qsh5n2$3pu9$1@blaine.gmane.org>
From:   Akemi Yagi <toracat@elrepo.org>
Date:   Sun, 8 Dec 2019 08:45:51 -0800
Message-ID: <CABA31DrsaqT-TsOVx=kbRBnuM5He53+=NLgwm94swY-x1UPjuA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>, toracat@elrepo.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 7, 2019 at 1:31 PM Akemi Yagi <toracat@elrepo.org> wrote:
>
> On 12/6/19 10:59 AM, Linus Torvalds wrote:
> > Hmm. I think I just saw this same bug with a plain kernel compile.
> >
> > My "make -j32" suddenly came to a crawl, and seems to be entirely
> > single-threaded.
>
> We encountered what seems to be the same problem when building a kernel
> under RHEL 8.
>
> As it turned out, this was due to a bug in make (make-4.2.1-9.el8) and
> a patch is available. Details are found in this Red Hat bugzilla report:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1774790

I forgot to mention that the aforementioned bug in make was originally
reported for Fedora. They now have a patched version of make
(make-4.2.1-15.fc32) in Rawhide.

Akemi
