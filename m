Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F3FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A3420835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku7K6WZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfK0Ecn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 23:32:43 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41567 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfK0Ecn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 23:32:43 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so14112511lfp.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 20:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2/+w5JosJ1scZlVFlMwGfpa9YngqJD9Yc3KXus09hIo=;
        b=Ku7K6WZ4GJPBzmFqi3gQW5lBRTX79tvn4SiyT+jOfHpmhgAVSsirgSMX/i8rISdgmS
         2wjex6vE6rLf2VgeQ2E1aCIzdeEsaPzfSevXC+TFy0pwxNVzhnlGItsJknLt7OlBAujH
         ipFXIBxPeoAboNg7zEqPe+pBa3KM2Yb1gQccNZ0I5dGv5ntebEb+gagDf6kuYxH3Ucjl
         Emalfl2SUjvLrH0Sosz/6XZfJXMBSRpMk38ZdoEru+mfO6mTMsrkoJ+1i667fG5n7i5i
         sW5W3AcswJHruZEpOqx+K3Gb4LxkQxDq9EqCRRNQAIS22BOiQ0MEL8qjYjwPAyNQpq/t
         KBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2/+w5JosJ1scZlVFlMwGfpa9YngqJD9Yc3KXus09hIo=;
        b=ITJ+6X2pFZvgRS8dQ90Jik4BJNEi9vljsXrNIe35+e29fhj+y+20tt3sjIMFjEyITj
         yibJ1NO2HAXBWco8TDuY+ewlJUajSyhMZPHE89EcOvjB8gMPY98UXvvA+j++NhGjEi3v
         IDxXZV9FRlrJ4OaElZOiNZfp9amUDUPw7lqMZDij5S9cN2zMxoq33WTwmhgw7F4j+p4b
         H9vvL5IsGvDBrSKtfLA6U+xALnKuvG6HL/lY75lwXnUNizqflHkpbE1WLj0f4haidtNa
         cBJU9ds7Feo/wkzbaA3Hh+QLAd6jYsg7vlg6+EECkJETpv6m9JTpW0S4loBjjBpQPybH
         bp4A==
X-Gm-Message-State: APjAAAW1hjjMQmTvp3WdWW9KtBP41KEqXSnvT9+XZLM/OcL4uJozT6Oa
        q9mdG55d4ad+xDDaCzxJlaHVUVfJfLf6J8mGIJE=
X-Google-Smtp-Source: APXvYqw16HX9U8K2zmXneNLXJH8rHjOzEss/g+vbiBWtTArINds9S/AzCm1bIxDFqFaRN0c1bEN1373EJr43gH6N8vI=
X-Received: by 2002:a19:6e06:: with SMTP id j6mr27462233lfc.6.1574829160974;
 Tue, 26 Nov 2019 20:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20191111131252.921588318@infradead.org> <20191125125534.2aaaccf00c38a9a25dee623a@kernel.org>
 <20191125123245.5ae9cb60@gandalf.local.home> <20191126091104.5e0cdc61e3b143fae4ed4cfd@kernel.org>
 <20191126175812.c6e0cd1249422989007c91fe@kernel.org> <20191126185809.91574fb8eb02f3b2dd3af863@kernel.org>
 <20191127084854.55ce1916e4f6d372f9731ed4@kernel.org> <CAADnVQK4twuXzFhD-qLHmCVK0n1h-GDENQLu+4PVV3Hp++R6kQ@mail.gmail.com>
In-Reply-To: <CAADnVQK4twuXzFhD-qLHmCVK0n1h-GDENQLu+4PVV3Hp++R6kQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 Nov 2019 20:32:29 -0800
Message-ID: <CAADnVQ+y9-JRA1u+UMD8uWjq1dt9AZrJKeOMe_zDNRL=wZ39TA@mail.gmail.com>
Subject: Re: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and more)
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        bristot <bristot@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        jbaron@akamai.com, Jessica Yu <jeyu@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 4:03 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
>
>
> On Tue, Nov 26, 2019 at 3:49 PM Masami Hiramatsu <mhiramat@kernel.org> wr=
ote:
>>
>> On Tue, 26 Nov 2019 18:58:09 +0900
>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>> > I applied following patch, but it seems not enough. While disabling 25=
6 kprobes,
>> > system was frozen (no BUG message).
>>
>> Aah, this is another bug in optprobe. I'll send a series for fix these b=
ugs.
>
>
> Awesome! I=E2=80=99ve started looking at this crash as well.
> Could you share a brief description of the bug and cc me on fixes?
> I=E2=80=99d like to test them too.
> Thanks

I noticed that your config doesn't have CONFIG_KPROBES_ON_FTRACE=3Dy
and without it most test.d/kprobe/ tests fail, but in your log they are pas=
sing.
Also do you have KPROBE_EVENTS_ON_NOTRACE=3Dy ?
Since without these two configs the crash wasn't reproducing for me.
Anyhow waiting for your fixes.
