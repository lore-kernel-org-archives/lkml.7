Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF725C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 03:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE7E218A0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 03:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562297291;
	bh=zgyK+Eu7zqLO/BtcJotgRYO4v9dObt0Cf2+AFvQYMKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gida/Oci1jkAxKliOz7oVpX3JHuqiO4Uad4gsp7H7LAcTOd5Vgk/OW0/gVEWJQRms
	 FRktmG0M5HCs5kKNHF7svlp19895rqaHbJN8PDbFAIBd29Ztjr+aVjtPbwNONs/Bcr
	 47nYytXXBuf6Aoc5ZZcEwOje4wo+zVf9X0PNuFW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfGED2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 23:28:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36124 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGED2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 23:28:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so7819249ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 20:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TgCG2v/18aLvVnJHA93hfe9UUNoDJjfM4smfbeOmGTs=;
        b=ZKAENLkGf1r+fUGMW12YDOU0HGdQRO+qsTxUG0bZTYQqCvkduK6W3gq0wUb+5AXGha
         ecmSYa9uzB5kyzf/pLjBmRSSMG3uBQqWlnqvMd5F2KGYxmAA06Xu2NofTloVlimN5tio
         RNP8VVKzRv1mW6VhS6LEbSnR6Y4vCzkYijDRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TgCG2v/18aLvVnJHA93hfe9UUNoDJjfM4smfbeOmGTs=;
        b=c5BiocTYv7dKk2AuV9S+OP/kDcxUvAoYfCt3pvozMz+d7e9EsA+9kU1ILBqiRkEeQI
         MCAizATshOIY9fxE5yLLLlvqb4fIMb45aroL4nGYkdd/PkOkevq3+PA/qlqf4ZrGPr+h
         72VpSDZ2TYEYeF2gGbIeeZJZJXkU/uNJMmsr43hgsbahfZUmImlh76nuk2b9BkQk1oWx
         CTUkipS8AyzXlSXYBozVTHeYResiQ2n8DIfieS7eSvSzt26nr0yBBclbjWv57TxyG4QB
         qxI2ryVuzWJEApVK9vwYI2WpSJTs/o5+BpbgdiuCx79BRFS4ymEJljxMeBsiUC0crqfH
         31iQ==
X-Gm-Message-State: APjAAAUY6IfpOI0CB7bnzwdXwpiPDPWsy0EPCbktRpKm64uANNmKui0a
        QmBZsWsDgHuMdpLBGoTEkgOZpRHz+osJZg==
X-Google-Smtp-Source: APXvYqw2ixwtHgyYwmC+go1be6OYl2nLLipOuvjSEEJ3BrWxznlIU8S7NXXkiZm/9cr3MD7gYuEk0w==
X-Received: by 2002:a2e:9754:: with SMTP id f20mr719433ljj.151.1562297287642;
        Thu, 04 Jul 2019 20:28:07 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t21sm1152045lfd.85.2019.07.04.20.28.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 20:28:06 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 205so7799424ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 20:28:06 -0700 (PDT)
X-Received: by 2002:a2e:b003:: with SMTP id y3mr781826ljk.72.1562297285520;
 Thu, 04 Jul 2019 20:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190704195555.580363209@infradead.org> <20190704200050.534802824@infradead.org>
 <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com> <41D6F2E2-C4CF-41DF-A843-FCBD03B7BEEB@amacapital.net>
In-Reply-To: <41D6F2E2-C4CF-41DF-A843-FCBD03B7BEEB@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jul 2019 12:27:49 +0900
X-Gmail-Original-Message-ID: <CAHk-=whzQDR+hjhontUhsCbQOryU7VZ9K79EVjL2KCduZWDc1Q@mail.gmail.com>
Message-ID: <CAHk-=whzQDR+hjhontUhsCbQOryU7VZ9K79EVjL2KCduZWDc1Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 12:16 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> If nothing else, MOV to CR2 is architecturally serializing, so, unless th=
ere=E2=80=99s some fancy unwinding involved, this will be quite slow.

That's why the NMI code does this:

        if (unlikely(this_cpu_read(nmi_cr2) !=3D read_cr2()))
                write_cr2(this_cpu_read(nmi_cr2));

so that it normally only does a read. Only if you actually took a page
fault will it restore cr2 to the old value (and if you took a page
fault the performance issues will be _there_, not in the "restore cr2"
part)

                Linus
