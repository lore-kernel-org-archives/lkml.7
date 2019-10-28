Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C35CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A527720650
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xm5uuVr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388925AbfJ1NSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:18:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51878 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJ1NSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:18:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id q70so9429480wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yw1UTNtycGA9FN9cisYCGkekiRR1izJVSuYv8MiVRlk=;
        b=Xm5uuVr/oWMODLgeT1dFlpvpSzfeEpSK6+zNmxsP7iPyv/NherpEdQIi3misQ/QSRe
         sTH+YftONMDkVMNsVQEYdKR1sA4Pw7nxRhyE7+bN8a5yZ8fPFbGA/aLswiy0vrwXoomf
         7JLCmpEgc5x/ZE7qABWh5nyKMVoiNu7YRo0BqmlYYvxAFgAtAcDjrLqlSN43NwyTdk/l
         wRoAXEeY2J9MKWLMe/imam9NpmEFaFyx4xwG7he/Qet3tdVbMDIxdi1ReCo+hLN7atPC
         rovpIBU1j5fFZBcDokPOb0T5JiB7N9l840VTu2McYvr9d+mo8bRZB3jfv/rxvYPpL3OL
         vmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yw1UTNtycGA9FN9cisYCGkekiRR1izJVSuYv8MiVRlk=;
        b=DxAN10NP0m7mJuKSLOUJAI3nkUHXSG/lxpBeqfFAcFgwwkCW6mQ/hd2IqgwcY3HHOT
         8NZmXGCtQfSYWArGtyg0u6Vz/VzgO8IU3Gdoqd5PZBgW+ZrlbNrMUB1442ok3MKYmM1u
         jVrQtHrB5GrBLN36X8CIwGX6iSF6v6na8i6gj51zHdCE2qzRIneSAF6EG/E3TYdYnjwO
         4DyrGsM9b9yjBDb1iojucewPuHX16egClrVvCCEQTX+Bu/si2fUvvkXDjyaOuV4WN26J
         U/DF80AMD3Wwo5K5P26FmzlHspwePr08WpjS5unY6z94EV7VLsjdLpbm+ROimOKavbKC
         iQtg==
X-Gm-Message-State: APjAAAXFSMvFgPa18x7ZG3J0GzPwY4WxXIty6+b4OlPuz+YJMTsqQgXK
        RsC7g6HNaDiEQ4exfLA7WvDmoiDoyI63jvRqU8UuuQ==
X-Google-Smtp-Source: APXvYqxy6b4KTX9IE+ET5/6aH6sCNx/NgcZ39CN3S5h6U1S2p657qFhC6jJhL6C0HI0dYZPzNs0ydcZ4eAXll6X7gfg=
X-Received: by 2002:a05:600c:2212:: with SMTP id z18mr16924236wml.154.1572268680300;
 Mon, 28 Oct 2019 06:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f838060595f602a7@google.com> <s5hr22xau8f.wl-tiwai@suse.de>
In-Reply-To: <s5hr22xau8f.wl-tiwai@suse.de>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 28 Oct 2019 14:17:48 +0100
Message-ID: <CAG_fn=VLxj9xKd_Wxm0cA1Lo7E6YG4SBsZ9EFnFj94TbE-6aPg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in get_term_name
To:     Takashi Iwai <tiwai@suse.de>
Cc:     syzbot <syzbot+8f2612936028bfd28f28@syzkaller.appspotmail.com>,
        allison@lohutok.net, alsa-devel@alsa-project.org,
        benquike@gmail.com, dan.carpenter@oracle.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, perex@perex.cz,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.com>, wang6495@umn.edu,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 2:13 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 28 Oct 2019 11:32:07 +0100,
> syzbot wrote:
> >
> > Uninit was stored to memory at:
> >  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:151 [inline]
> >  kmsan_internal_chain_origin+0xbd/0x180 mm/kmsan/kmsan.c:319
> >  __msan_chain_origin+0x6b/0xd0 mm/kmsan/kmsan_instr.c:179
> >  parse_term_proc_unit+0x73d/0x7e0 sound/usb/mixer.c:896
> >  __check_input_term+0x13ef/0x2360 sound/usb/mixer.c:989
>
> So this comes from the invalid descriptor for a processing unit, and
> it's very likely the same issue as already spotted -- the validator up
> to 5.3-rc4 had a bug that passed the invalid descriptor falsely.
> This should have been covered by 5.3-rc5, commit ba8bf0967a15 ("ALSA:
> usb-audio: Fix copy&paste error in the validator").
Ah, thanks. Looks like I need to rebase the KMSAN tree.
>
> thanks,
>
> Takashi



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
