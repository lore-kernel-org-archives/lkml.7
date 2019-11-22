Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C9CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41545206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YJIHNZEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKVAjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 19:39:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38081 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKVAjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 19:39:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id s10so4459231edi.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 16:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHj++TIMg4Ens0F3aJfk7j7E8iHr52gJeFlshV/ISiw=;
        b=YJIHNZEUFsgL4TpJs14+fbdITnHvxz0M9LOs/Dgy5BnL6M72oTwQRtOfHbO+T05ufJ
         1/h2bu5CbngwpOk9xEAXUGoL47+0wPGVl8kzdVFg01KrkZWwGTKp9iyOPCAMdvcn1fFt
         OMdq3ceEnzKogu7+hA4aBhv8w2Jc3Ofz5LZnK7luVq1GrJUQnU/fVoBM6h3G2vQprGJO
         dfL6DlR4mjWJ8D5CyC68cL6TvpB2mRxeylMzeU5xftSuNDAa8J9opSHNTrz+YLpFlpWc
         KfWihhOYnN6H7SyWReveUP0uLF3kZEWSuZ5asTyXPmCHwKTW3sgqpxJeiC1yudV73OrE
         HZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHj++TIMg4Ens0F3aJfk7j7E8iHr52gJeFlshV/ISiw=;
        b=riNLRkglWgqXTv3OG5fsCykbTXnmV1OjNxVcQ4Ydi6QTFm19clW+kag8gL9hW4PAE5
         iu+BQ/hGmc9CRGDamxuYlTv7XXM7ecBZbigHb3rHkCn7sDWlHvDcftUxu6Ve/r50EVLV
         XVJQzrwZTKndaiY7b4aIZ/BnTN8ihMe3quoQfN4ylTihm2Gi3TQjq//5o/GxcgTU3s9W
         OfzrMn6YPcH39v/Ef7Ts7MS7igPC56DQ5hXOHrItZsao+XRLrv4EdiOyEZ2pkkBJSSQ7
         dYHt14MnYDc5kzztYwk7TJqAg6nG378N3y2+H1y3LL88hVi13/gkKtJl6uNjKquaut+Z
         3efA==
X-Gm-Message-State: APjAAAX7/9sgIvu8MWAtZpyfKD2c5pkgOTs6NcoptrCTYtlV4LV9NX5h
        LeKJc3Ohcsc5iOSnnsfcJhC+RY29Ude/SvSVVupSPQ==
X-Google-Smtp-Source: APXvYqwrtfAyjGP3wgLyPbLQNwjFVQfaBija5h4rX527rHpvOeFUrxNZS7l2iyVXlFryl9sSPZTcyswY1QHfRpt/xos=
X-Received: by 2002:a17:906:b30c:: with SMTP id n12mr17585915ejz.96.1574383173304;
 Thu, 21 Nov 2019 16:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20191121184805.414758-1-pasha.tatashin@soleen.com>
 <20191121184805.414758-2-pasha.tatashin@soleen.com> <20191122002258.GD25745@shell.armlinux.org.uk>
 <CA+CK2bDtADA2eVwJAUEPhpic8vXWegh8yLjo6Q6WmXZDxAfJpA@mail.gmail.com>
 <20191122003403.GG25745@shell.armlinux.org.uk> <20191122003524.GH25745@shell.armlinux.org.uk>
In-Reply-To: <20191122003524.GH25745@shell.armlinux.org.uk>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 21 Nov 2019 19:39:22 -0500
Message-ID: <CA+CK2bAm0r8zLMz_gdq30zF8io5RzVnbXFSV9NkyT_uUxKJwLA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm/arm64/xen: use C inlines for privcmd_call
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, stefan@agner.ch,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>, boris.ostrovsky@oracle.com,
        Sasha Levin <sashal@kernel.org>, sstabellini@kernel.org,
        James Morris <jmorris@namei.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        xen-devel@lists.xenproject.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>, alexios.zavras@intel.com,
        Thomas Gleixner <tglx@linutronix.de>, allison@lohutok.net,
        jgross@suse.com, steve.capper@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>, info@metux.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > That may be, but be very careful that you only use them in ARMv7-only
> > code.  Using them elsewhere is unsafe as the domain register is used
> > for other purposes, and merely blatting over it (as your
> > uaccess_enable and uaccess_disable functions do) is unsafe.
>
> In fact, I'll turn that into a bit more than a suggestion.  I'll make
> it a NAK on adding them to 32-bit ARM.
>

That's fine, and I also did not want to change ARM 32-bit. But, do you
have a suggestion how differentiate between arm64 and arm in
include/xen/arm/hypercall.h without ugly ifdefs?

Thank you,
Pasha
