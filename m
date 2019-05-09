Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C3AC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87BC21479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557391439;
	bh=j1YnXyjICPhbLslCFd7x0HibtkN89AY+RtNaWmJfcMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RwDJUtRsyzqt9KK9rnoQeTRGOPH1mqDF2yCQpO7Vqmh++vRanTzGu9ITW4DaupCmU
	 D9eQrXALe5bM7U8eZg7WVg478G784MV8+eD23xrXTtJVqnoZHMMXFSFpTFkqgM+x+w
	 zv4pYbcaJmtR2bqd6nNpYUEHFW6WogRyc8NYCHrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEIIn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 04:43:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50508 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfEIIn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:43:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id y17so1187681wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 01:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b8KF4mdAGxKEusWlC4USzdTdaf7B1lwWHoLhbn/+MSc=;
        b=QWp3vbz6LQ0TQFBfNDWHqVxk84FoMnhzjM5MNhxDlvmpF58WJ+2QeFC7YWtOrfeuz5
         sZ03dzEeBvvqqN72H6cQT5LktZpXKHv6OAQ2nSa7cg00Ztfnf6BqkY7wU2XrLTPz827q
         7eyTq7M1IDBubn/LRtghh1+QPqHliEF+IfAY7P8okI1Z/6DJLV6GYcACaCi7doAZGMw9
         /dyIHtvKj75ocqdUfqA6evD3kzI7d60lz96N6l80oCjsCkwInFo3s+FTiRBF0b6R4k/Z
         q0/GKwtraN//gURCFQVsmP6WprOmuLoxNgpKV/e1h9zG6bazrklMRdd5G1GOhEmqCKbY
         qMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=b8KF4mdAGxKEusWlC4USzdTdaf7B1lwWHoLhbn/+MSc=;
        b=N7qx51lOrJcmPPcoAYF2C4QuaQyuf+qn6jcUI4mDCjQ7OtTzfBpFXDo33NfdBSy6KL
         w9fpZ2pHB31wg3VrJGmv+3XMzxpQTreE+56xAh4yC6aZsWyPfgCNh7K2Zv6v9Qjbq/jx
         SwvLmlwUvtsQOf1xSA+qDsXCJDxoA8fkJhXbzTProPIwPCRCxA71g4SHftPXkODEX8PK
         G/iDRNM6b7IDUF6oXcpgwfMK8QmBjlXv6zJ23YSkPBmBSMXV7QvcWJx6zPi1RuH44gJN
         5U1s56nBwROzMzhhu9O/RXfpoqgFKgcnq3zSDr6FpNN7Byd1OgJc6cJD/u6j14Pu9++M
         saaw==
X-Gm-Message-State: APjAAAUWSjT8fo8cGXJlqSDs1G5XiIAmNbFqVhtfg2lVaPWQ+6moVZpk
        77Y/amf+o8zMngwslrd3vwk=
X-Google-Smtp-Source: APXvYqwPCLmwERJGm0GgOzGN4iYF3cgpTmSB9jlMHIwT3WhfPaclWLymsXpEdZKNIssjPaOjlsz3nQ==
X-Received: by 2002:a1c:ca0b:: with SMTP id a11mr1963575wmg.52.1557391435976;
        Thu, 09 May 2019 01:43:55 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y3sm1042661wrh.90.2019.05.09.01.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 01:43:55 -0700 (PDT)
Date:   Thu, 9 May 2019 10:43:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <20190509084352.GA96236@gmail.com>
References: <20190502150853.GA16779@gmail.com>
 <d64b3562d179430f9bdd8712999ff98a@AcuMS.aculab.com>
 <20190502164524.GB115950@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6F523@IRSMSX102.ger.corp.intel.com>
 <e4fbad8c51284a0583b98c52de4a207d@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C760A7@IRSMSX102.ger.corp.intel.com>
 <20190508113239.GA33324@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C762F7@IRSMSX102.ger.corp.intel.com>
 <20190509055915.GA58462@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C7741F@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C7741F@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Reshetova, Elena <elena.reshetova@intel.com> wrote:

> > I find it ridiculous that even with 4K blocked get_random_bytes(), 
> > which gives us 32k bits, which with 5 bits should amortize the RNG 
> > call to something like "once per 6553 calls", we still see 17% 
> > overhead? It's either a measurement artifact, or something doesn't 
> > compute.
> 
> If you check what happens underneath of get_random_bytes(), there is a 
> fair amount of stuff that is going on, including reseeding CRNG if 
> reseeding interval has passed (see _extract_crng()). It also even 
> attempts to stir in more entropy from rdrand if avalaible:
> 
> I will look into this whole construction slowly now to investigate. I 
> did't optimize anything yet also (I take 8 bits at the time for 
> offset), but these small optimization won't make performance impact 
> from 17% --> 2%, so pointless for now, need a more radical shift.

So assuming that the 17% overhead primarily comes from get_random_bytes() 
(does it? I don't know), that's incredibly slow for something like the 
system call entry path, even if it's batched.

If so then maybe we have to find something else? RDRAND was just my 
desperate suggestion to find something faster, I assumed a modern chip 
would find no trouble finding plenty of source of quantum randomness, 
given how much it has to fight it just to keep working - but that 
assumption was apparently wrong. ;-)

Is there no cryptographically robust yet fast (pseudo-)random sequence 
generator that is unlikely to be cracked real-time?

The performance bar that such a feature has to cross should be very high, 
given how the whole threat model and justification is dubious to begin 
with.

Or just give up on the whole notion if it cannot be done? ;-)

Thanks,

	Ingo
