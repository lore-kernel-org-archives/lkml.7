Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AD8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D4120830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfCVPNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:13:01 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43452 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfCVPNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:13:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id v32so2846280qtc.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQLgqjuGvBY3XrZSZjT6RlcpWqzXlCoijPAP1jAzPQs=;
        b=ShN+HjBoBP4w5W0CImhB60z9z+GpqK34l1TDJQafQAFEIKKEgvyH+hukd0EU9wEqMN
         1j7bDEIDVXNl3Oo628+aVVRPxZ93rF6bD8/9WwotUdJL7aCj2T0he28BNs9ENNJHy6ri
         tZ0lXmVtoSjRvPkMNUM2qzL5sDGExPAHJ0sL6Xkg1pJ/2rNK6OzaMBecqQcQTyOm3d9L
         rr1LWiBAAt7IQu81X64f/RHOXCsj0Km7L6NmzwiGQ+0AqHzDe79YaaK2HJskh4jS6h8K
         QKsS19BVje1G/yUDuP8XeiqR7bzCYbe5JZm8wN1AIOBOnAO51x4QBa/APp79tQnADBYK
         kdaw==
X-Gm-Message-State: APjAAAUT/c2/JJdowJ/ijWtBJWpDvFA0soWFCIJwM115xvRZf6lD0mcI
        LWjVrb3A5vb2NnP6JZmWLP2OC7GjSPvfafN1B9k=
X-Google-Smtp-Source: APXvYqyD7QOounfBfZ+NBo+EMAQmxnBT3SC6x5DNdeiU+O2CrvrRfYXBpR6i69hD3oLebKejTEg0XnzW5GrjvZxnXNU=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr8520384qth.319.1553267580578;
 Fri, 22 Mar 2019 08:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190322140649.197027-1-arnd@arndb.de> <s5hr2az9cos.wl-tiwai@suse.de>
In-Reply-To: <s5hr2az9cos.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 16:12:42 +0100
Message-ID: <CAK8P3a0DdQ2dgbgCDvwD37uu=_iU7VGOWHN+6tp=CxeSzz8GtQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/ca0132: work around clang -Wuninitialized warning
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Jaroslav Kysela <perex@perex.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 4:00 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 22 Mar 2019 15:06:28 +0100,
> Arnd Bergmann wrote:
> >
> > When CONFIG_PCI is disabled, clang gets confused about the
> > control flow of the switch() statement always ending up
> > in the default case, and warns:
> >
> > sound/pci/hda/patch_ca0132.c:7558:6: error: variable 'fw_entry' is used uninitialized whenever 'if' condition is false
> >       [-Werror,-Wsometimes-uninitialized]
> >         if (!spec->alt_firmware_present) {
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > sound/pci/hda/patch_ca0132.c:7565:42: note: uninitialized use occurs here
> >         dsp_os_image = (struct dsp_image_seg *)(fw_entry->data);
> >                                                 ^~~~~~~~
> > sound/pci/hda/patch_ca0132.c:7558:2: note: remove the 'if' if its condition is always true
> >         if (!spec->alt_firmware_present) {
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > sound/pci/hda/patch_ca0132.c:7521:33: note: initialize the variable 'fw_entry' to silence this warning
> >         const struct firmware *fw_entry;
> >                                        ^
> >                                         = NULL
> >
> > Adding an explicit check for CONFIG_PCI avoids the issue.
> > Unfortunately this is not very intuitive here.
> >
> > Link: https://bugs.llvm.org/show_bug.cgi?id=41197#c1
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Any suggestions for other workarounds appreciated. If you can think
> > of a better fix, please treat this as a reported-by:
>
> Can it be addressed by the code simplification like below, instead?
>

Yes, I confirmed this works as well, and it's probably more
obvious what's going on, so let's use your version.

Thanks,

      Arnd
