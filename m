Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F9AC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09D42081C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556753631;
	bh=UQ03RoUVgEqrh24m1ibWvm3BQ70ctrej1g8FlyRCbUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OlVndVWsvFarTi3ISh0zc8flEQWSrmr0mvdGwsY4MXAnTc5QguCll23IRiySNTvUC
	 4kYhwt4SQKKDW/qBVhf9tDsHSmYR8F1vz+nx0FsY79epdZPvD+iwUwMQth01DiTJD1
	 1/IkilSTayojWYuuSs1gEMt9zQx2obENqc4apefo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfEAXdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 19:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfEAXdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 19:33:50 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2C1121783
        for <linux-kernel@vger.kernel.org>; Wed,  1 May 2019 23:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556753628;
        bh=UQ03RoUVgEqrh24m1ibWvm3BQ70ctrej1g8FlyRCbUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u/0c+KuVBUG5WeZTCWcOhcZoPGxsnZH1n8O333AVJBL1xvQaxjnzaAT1VFaLZIzmG
         ldgZ7PChxp8fVfst7G6uIsNSYIshYptv7boi+gwVtzkmo+fHmVb3rfaXbWOtKZqm2V
         I5BfoVcJt0/2MdXqc2QwtyaI7tOrHyjPUfZnhai8=
Received: by mail-wr1-f50.google.com with SMTP id e9so653279wrc.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 16:33:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWmZor7vBQoYbLs1OnqV3INj27MB2Hv6d8/IRJePSQBjw0V8Us+
        KgYQQXPq+GeA/BSSaZMBhZm53QVIFAwuBHRCwpAUUg==
X-Google-Smtp-Source: APXvYqyeDPaEKJWIVdSsQa8ssu/spC/1Vo4v4BXrY0/UmVS9TH9Usb5cgGcb5aNntQqgdOGpAdU1WvcOFqQNH6Mag6I=
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr381220wru.199.1556753627151;
 Wed, 01 May 2019 16:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net> <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu> <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
 <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com> <20190417151555.GG4686@mit.edu>
 <99e045427125403ba2b90c2707d74e02@AcuMS.aculab.com> <2236FBA76BA1254E88B949DDB74E612BA4C5E473@IRSMSX102.ger.corp.intel.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
 <20190426140102.GA4922@mit.edu> <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
 <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net> <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
 <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
In-Reply-To: <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 1 May 2019 16:33:35 -0700
X-Gmail-Original-Message-ID: <CALCETrW93mtF+Q=A=t2OkAN3dTFonrZRMUzQhQ+2gkS3o1W1ZA@mail.gmail.com>
Message-ID: <CALCETrW93mtF+Q=A=t2OkAN3dTFonrZRMUzQhQ+2gkS3o1W1ZA@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     David Laight <David.Laight@aculab.com>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 1:42 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Reshetova, Elena
> > Sent: 30 April 2019 18:51
> ...
> > +unsigned char random_get_byte(void)
> > +{
> > +    struct rnd_buffer *buffer = &get_cpu_var(stack_rand_offset);
> > +    unsigned char res;
> > +
> > +    if (buffer->byte_counter >= RANDOM_BUFFER_SIZE) {
> > +        get_random_bytes(&(buffer->buffer), sizeof(buffer->buffer));
> > +        buffer->byte_counter = 0;
> > +    }
> > +
> > +    res = buffer->buffer[buffer->byte_counter];
> > +    buffer->buffer[buffer->byte_counter] = 0;
>
> If is really worth dirtying a cache line to zero data we've used?
> The unused bytes following are much more interesting.
>

For this particular use case, zeroing is probably worthless.  But, for
the general case of get_random_bytes(), we need to zero, and I would
argue that get_random_bytes() should be doing exactly this in general.
