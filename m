Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0599AC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7502086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilRpKeAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfI3Fsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 01:48:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34915 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfI3Fso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 01:48:44 -0400
Received: by mail-io1-f65.google.com with SMTP id q10so35110548iop.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 22:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkCAgD976ImDY96J9om/FYbjb6g9HZIedNh1KFynB0Y=;
        b=ilRpKeAP4rZH7xyzGbozZmgDIH+VXF0IO9/6R7+wMU3jdJj10QBqSFKr6gV/2/3Bed
         /bXcvvRV6mhvbNm866Vd5ROihyMXRuUfGabnvlyXSnqvoMBWtJkbU+Cgtedruk6Xxh6e
         qWFpNwOrnPL8DFzzryggfJCqXyFxtSintiWwOKFYXyCb25F7dNrdF4akQuK4u10bzIDX
         JUILG/mTudAHMFQBzHojU/Z+K9iuiY9lgt0cArgwN7fIyJ+rJ/Wd8445CErGGaUVEMNF
         LFRF4bIifmMG6p8hN33ZLpkNcoqwg8lR1vDIIWZ+shtafZtS+oSVyQ6ezgo7O1zocx4t
         tZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkCAgD976ImDY96J9om/FYbjb6g9HZIedNh1KFynB0Y=;
        b=njSAaWrU2smWUz9gN61HDbifQA5gT1B7kiYoSH34YCEm1XxF3BXXQQyNDY6rg34vyV
         ueGO9PNUbQUQDkeeQdPjopv6JvdC6EAEllkxTwfVFORiJPiPOupulZnCu3wBPkWmw2tK
         2rpnOHhjFz60wSQ/YJD1X3KknFMdH4v3tPOL8xMLhSONGR6IRbIjm/wQc8wwVQwAkv/O
         ULSIynMZjTjmxWJuUgRuSwIvBykc/rL33YRgE/ytXQ9dWVqB6osNCRkpun9Xjr7wUnPH
         IfnKf7SE4WoAkxEeh/wwErkAVLRXs44vRKu4PKrbtVcwiii6FmvASr+HyzirGO1zqXcN
         w2Kg==
X-Gm-Message-State: APjAAAWBYJjtaByxpbOOGZYc2kLI2ThcQ4YlJaJFqc64DuicVfPsa6aj
        /L4ZcoScsXS5WJiiaO/jKv443eJDzT6EN7QDBb0=
X-Google-Smtp-Source: APXvYqxg0fAZhIMxwsoRBwa6Rms234LNOfOebV0h2kOk4CTClehxOO+17Kck72VWgjPfVQ5MhFy8tQ4KWZC8EwVEu4s=
X-Received: by 2002:a5d:860f:: with SMTP id f15mr4022379iol.27.1569822523814;
 Sun, 29 Sep 2019 22:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190923114904.dd63949b3433376aeb4b7789@kernel.org>
 <20190924044659.3785-1-alexander.kapshuk@gmail.com> <20190930053458.GB29694@zn.tnic>
In-Reply-To: <20190930053458.GB29694@zn.tnic>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Mon, 30 Sep 2019 08:48:07 +0300
Message-ID: <CAJ1xhMXoX1naOomzOpfq5P2VxC_gDtUQYp0e7y1_ik9wFxDcSA@mail.gmail.com>
Subject: Re: [PATCH RESEND] gen-insn-attr-x86.awk: Fix regexp warnings
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 8:35 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 24, 2019 at 07:46:59AM +0300, Alexander Kapshuk wrote:
> > gawk 5.0.1 generates the regexp warnings shown below:
> > GEN      /home/sasha/torvalds/tools/objtool/arch/x86/lib/inat-tables.c
> > awk: ../arch/x86/tools/gen-insn-attr-x86.awk:260: warning: regexp escape sequence `\:' is not a known regexp operator
> > awk: ../arch/x86/tools/gen-insn-attr-x86.awk:350: (FILENAME=../arch/x86/lib/x86-opcode-map.txt FNR=41) warning: regexp escape sequence `\&' is not a known regexp operator
> >
> > Ealier versions of gawk are not known to generate these warnings.
> >
> > The gawk manual referenced below does not list characters ':' and '&'
> > as needing escaping, so 'unescape' them.
> > https://www.gnu.org/software/gawk/manual/html_node/Escape-Sequences.html
> >
> > Running diff on the output generated by the script before and after
> > applying the patch reported no differences.
> >
> > Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reviewed-by: Borislav Petkov <bp@alien8.de>
>
> This is not how Reviewed-by works. Read here:
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
>
> for future reference. I fixed it up now.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

Thank you for taking in the patch and clarifying my misunderstanding
about the use of 'Reviewed-by'.
Point taken.
