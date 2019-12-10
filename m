Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7BAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC222222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tr+C241t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfLJBg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:36:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36900 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfLJBg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 20:36:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so8041432pga.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 17:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/ArZYKEfjZPBsRcDlrm2bJB7ahGFDYf0VWt4hD0Qjo=;
        b=Tr+C241trD4TLlSStYX0RZ2/acmkFLvu/V66NWO68Pgsjf+UXw0F/g4w5jP4u51yTC
         Ka81WTRlzO2b1a8sGcma60AQvixKXlL7KWoi6ioZNPudCQab6TFW6nUrh4JeHRDj9gXh
         jHxeDC9kvh98tdCZUT8ahK2e3j/ZXtpOgvR/f2SuLRXgab7OWEEIakRHl+jLVpbYHZEK
         nnTSJJq8shG8KCZGbycub0bPoZPxZ0Aultof8x7cY01uY/eSpqT4qdfOren6OUSnshlu
         2WIPjFk7VeawrmvbAc3wFL3CU0N0IJnMQaqxn/d63coWAiw8xt7UWz7Y9XqXe6igj/Dq
         3xIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/ArZYKEfjZPBsRcDlrm2bJB7ahGFDYf0VWt4hD0Qjo=;
        b=pufNpJic14GlILMjBkBGVKS8cyqT5gxA/+myzViBzaFAMPk7dJ9DVY49eTCbpnT1m1
         XzY9aEbwccxFI/ULxjykfat4Dt3NbojjXq5xHw0EMs57bwwitDgMyBxxo8zmIKgrUC3U
         WuLpG5NLDVaMOYHnhSmXBPMdMftjIMbr/UVsmZvSKoD+ndWgWaqjob3VbjUScKuBte/A
         8sr2IXnsaxddO+amMxsTIkMxj7QRALaFPekdY/gsuIJ023icrIVdKTwU+F4Bx33uLwuT
         2tYh9CerSvAtDGSsoRiY4+L0TeOv94WXYbQgolnoEnYRCtCSzM/cVf5BbEZAmGf6pbaD
         e/6A==
X-Gm-Message-State: APjAAAWzassMcYR+p2XIXCEofoyqXKZ9T/+FFSk+2OZenzNKIfDv1YNE
        zk/iDV34axn8yGaLkCHYf9v/wMW+Xr6LmtDW2S/W1g==
X-Google-Smtp-Source: APXvYqxwnem1f63bG00bEbGyduZzAk/R1lLierSyTVIwa5R8C6fowLDYtTGyFjeHedADn6m4cS1iXI5NN8u299XjvvA=
X-Received: by 2002:aa7:9151:: with SMTP id 17mr32836592pfi.3.1575941788095;
 Mon, 09 Dec 2019 17:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20191028155722.23419-1-ndesaulniers@google.com> <002301d58dcb$a9ffaa80$fdfeff80$@codeaurora.org>
In-Reply-To: <002301d58dcb$a9ffaa80$fdfeff80$@codeaurora.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Dec 2019 17:36:16 -0800
Message-ID: <CAKwvOdkbTMj92Hj7Z2ucbJY5B_AZgANZhNoeOa2Taa2YTbCQUg@mail.gmail.com>
Subject: Re: [PATCH] hexagon: work around compiler crash
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sid Manning <sidneym@quicinc.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-hexagon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        bcain@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ akpm, looks like you're picking up hexagon patches? Would you mind
please grabbing this one, too?

On Mon, Oct 28, 2019 at 1:09 PM Brian Cain <bcain@codeaurora.org> wrote:
>
> > -----Original Message-----
> > From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
> > owner@vger.kernel.org> On Behalf Of Nick Desaulniers
> ...
> > Subject: [PATCH] hexagon: work around compiler crash
> >
> > Clang cannot translate the string "r30" into a valid register yet.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/755
> > Suggested-by: Sid Manning <sidneym@quicinc.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> LGTM.  Thanks, Nick.
>
> Reviewed-by: Brian Cain <bcain@codeaurora.org>
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/002301d58dcb%24a9ffaa80%24fdfeff80%24%40codeaurora.org.



-- 
Thanks,
~Nick Desaulniers
