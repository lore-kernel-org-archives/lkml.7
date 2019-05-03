Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C562C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2035206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556911161;
	bh=SIJupZM4xQzu2jtyclWLaYPyvNuOiK7IIuEm2BLYF9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ut3YmCK5h3z7MrnNNCu5P809EXeeZ/gMLGImAwtKFzCi9A9E8MmPehycbh/VEbMzT
	 TeE/Dx0uhXNYrsU+meZavIjnkv2q6RMyyedmJrEI18UBaxnhpyr5n4XjAvs751Pwtp
	 dCmXHm4sO1JF/mivqFx1Su06dvpY6fFxXl++rTdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfECTTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:19:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45182 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfECTTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:19:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id w12so6100670ljh.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrZPNFycjIPCS5MGk9MAG+nKHJrhm1Q0xvifSIf+zuk=;
        b=OEfmC6eJF2GPkWPbvs4stvkodrbQDXUL+PPqhjLUfk1i/pl6J+3SSY0xZI0I1g2RFb
         diBNMWHW/rqTdKWhuupppKaljsSj6VtB1P1+GlwSP1NRVFF3v/NVGneYtUDR6DkQKMp+
         sCaMQ/861on6pkLTiIark2/tC7R2z4uluIE84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrZPNFycjIPCS5MGk9MAG+nKHJrhm1Q0xvifSIf+zuk=;
        b=png8RdStsH8bPifcEFp5nZkmMIC2ngXduXYcf6U+xBkf7PsXb1h3+m1Utc3b7AEmWd
         JIJ72GxcwwyPnd7yXsoI93W0oz72gweSSggwMpMPgeMXU49opv9pUcUurmPawFNZl+/R
         aIsadP4o4DSbNpUn2O5XIhb9lL5omW+rppWI7lU+rGsZlGH7Uu+ocxF2VXy2COrmHgPJ
         5r3+4r3oxYSByacj3fktaoThPDHQPjsNI7XtuvW34RSmmPlIPnaavAwoBu4C3NkrdIFi
         LgbuHiDg9S6P2uQWvj+f0oGVH/w4mt4cLpdOPRemC4OkIqVdcuiTHov2JPZFfJ3o6myz
         YG/Q==
X-Gm-Message-State: APjAAAWvdsvLqrA3pQYoaR0I2k709sqa+LQCSQPRNzOJRcKuckAEMLyj
        ofdVj4hIYX6HTZBAUTroG4r8rS8ob3o=
X-Google-Smtp-Source: APXvYqxljcF1tMuGynVphKjowWMGuP81s5jvDsEGL/i5dtX29jjNpWL5Za6794ZoiZFGG8IZoSg8Mg==
X-Received: by 2002:a2e:9583:: with SMTP id w3mr1201463ljh.150.1556911156369;
        Fri, 03 May 2019 12:19:16 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g20sm173120lja.67.2019.05.03.12.19.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 12:19:16 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u27so4886300lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:19:15 -0700 (PDT)
X-Received: by 2002:a19:4f54:: with SMTP id a20mr5886095lfk.136.1556910664485;
 Fri, 03 May 2019 12:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
 <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net> <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
 <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com> <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
 <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com> <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
 <20190502150853.GA16779@gmail.com> <d64b3562d179430f9bdd8712999ff98a@AcuMS.aculab.com>
 <20190502164524.GB115950@gmail.com> <2236FBA76BA1254E88B949DDB74E612BA4C6F523@IRSMSX102.ger.corp.intel.com>
 <e4fbad8c51284a0583b98c52de4a207d@AcuMS.aculab.com>
In-Reply-To: <e4fbad8c51284a0583b98c52de4a207d@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 May 2019 12:10:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjb9c4JV5xOWp5VMGTzgCmpFCegf2MydVwbvjr5gnBV9A@mail.gmail.com>
Message-ID: <CAHk-=wjb9c4JV5xOWp5VMGTzgCmpFCegf2MydVwbvjr5gnBV9A@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     David Laight <David.Laight@aculab.com>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 9:40 AM David Laight <David.Laight@aculab.com> wrote:
>
> That gives you 10 system calls per rdrand instruction
> and mostly takes the latency out of line.

Do we really want to do this? What is the attack scenario?

With no VLA's, and the stackleak plugin, what's the upside? Are we
adding random code (literally) "just because"?

                   Linus
