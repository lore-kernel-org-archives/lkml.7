Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120F3C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFF320657
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vktv+Nnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfFTIoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:44:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41958 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTIoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:44:01 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so443092ioc.8;
        Thu, 20 Jun 2019 01:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gCb8MwruH8dKbWAubDWJguVrt49ZLagCriEvdjUA1WU=;
        b=Vktv+Nnvh9ds+F3HFYArj+H76hfSKDTtGli8022H77ngVSBouxPFNwqTouEdE3vKpE
         /+9BVmq4pmjw+6uQqfPuh2gK675a58Hk72VvzXz3vUmXeTDogZRT6zptL0A+hsQjWNfh
         rVp6xLhXFdxuWHvOqMTVtvqPcOLM/EBIKQ6nzvlnTtuhFT7O66Ik0IpKaxn87mGtVT/A
         3/z4ci2C9enNG1cSrI0Fkibr2IilAxPHzDhrFw+FKMWLiEG2dwcQ7oi622JRTFcpEkYU
         +jS/zfSFrBAIEOQS3cvrmqD6opLlHc7GYB5VFS+fafHQsCvqlRCbahT+R7wNs7zdz2DO
         zfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gCb8MwruH8dKbWAubDWJguVrt49ZLagCriEvdjUA1WU=;
        b=B0ArAyGQ9xEkMqnD3XbXWtWZeyHGlKr9o181yFnYRhsUpd4UsRDTjAVTDZZbt69a/Z
         A/pO/sa9ENLHvhV7PV4AQEgG4/6JDYXYxVsnYxaV8Di4B5qgGlnfMaABvnl+0PtDIOAl
         ev2V31qmlao5vyCWDqiJWlTj2Bu0GGyWto5Vbf0tS1E8BbyUonjmS1VkjM82rV9m17+E
         0HkEopl4pMkFtiB9VAOZTXH6ot1TD5r1wTbtlkAaNuMHzomBQnxnKXxdov9D7tmnS9yc
         7i5dXlWEiPk16qasOokZIoJt5btdfRuKx49aqqQMNAT7qeYnmfJyMskgYmY7Mov9gsQL
         yIvg==
X-Gm-Message-State: APjAAAV4WugdBTA0fEqp5RFdEeS5+6EZ7+gf438Pi3VWPEkKauVB8REN
        H3uN7t3xHzk5tXSOBlzRPFXLT9HpU2YKi+664ag=
X-Google-Smtp-Source: APXvYqw2fVXqZFI1UAjff2P6BLRNnHwF8/qus3xVE14eeP/DMtKrOAjmBQZ8KIC+qO1xuPhi+v/Txq3ckXpJwmsrqrM=
X-Received: by 2002:a6b:7b01:: with SMTP id l1mr18358947iop.60.1561020240102;
 Thu, 20 Jun 2019 01:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <8a9ffb4b-791d-35d1-bb2a-7b6ad812bff1@ideasonboard.com>
 <20190620081142.31302-1-e5ten.arch@gmail.com> <20190620082557.GB28346@zn.tnic>
In-Reply-To: <20190620082557.GB28346@zn.tnic>
From:   Ethan Sommer <e5ten.arch@gmail.com>
Date:   Thu, 20 Jun 2019 04:43:49 -0400
Message-ID: <CAMEGPiqgoscn-20gDyrQOBYdbfzdimu91Dw0WLEjLKs+u5KSEA@mail.gmail.com>
Subject: Re: [PATCH v2] replace timeconst bc script with an sh script
To:     Borislav Petkov <bp@suse.de>
Cc:     hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Ingo Molnar <mingo@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(resend because I didn't know gmail would make it html)
Ah sorry about that, I accidentally replied to Kieran only instead of
to all, my response was "I will upload a patch with those issues fixed
shortly, in terms of the dependency as far as I know commands only required
for running tests don't count as kernel compilation dependencies, and I
don't see any other uses of bc except for Documentation/EDID/Makefile, so
I believe that bc can be removed from the kernel compilation section of the
process document and will include that change with the updated patch that
fixes the 2 issues you pointed out."

On Thu, Jun 20, 2019 at 4:26 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Thu, Jun 20, 2019 at 04:11:32AM -0400, Ethan Sommer wrote:
> > removes the bc build dependency introduced when timeconst.pl was
> > replaced by timeconst.bc:
> > 70730bca1331 ("kernel: Replace timeconst.pl with a bc script")
>
> I don't see you answering Kieran's questions anywhere...
>
> --
> Regards/Gruss,
>     Boris.
>
> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah, HR=
B 21284 (AG N=C3=BCrnberg)
