Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5576C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A872053B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557315166;
	bh=t35deMfxEsBHDBEJ8drawqptDN3rUTqsdKCQYiyYYKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sdJJmPvDS3J/hqeUzq51JyaBTKkDzqbl38VJXLa/t7nJLG2gdQwrZJrWuUCS9iVe/
	 OrNPR9R7+YHRYid/z7jJHyDxGForuohWZ5YlxFRWLFVrNZA2yQq+nEbqCstBfqDELm
	 i7U9E/uSZYx3ZAp5nSkgsoTKZvay1loB2nPOHmVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfEHLcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:32:45 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:36343 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfEHLco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:32:44 -0400
Received: by mail-wm1-f50.google.com with SMTP id j187so2819964wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IMVKRPD91r9MIGHIcHDIHWSb1J68VUuJeZtvfzj/19g=;
        b=I10wVl1CdPh7kWFokwuyovaZ+UmagWP7YD/Dhe10KeZFPR0qRjqJeYYC86o1Xjjs4L
         9yy8m7YhmNeK8rSM2gYAZQAxMjOda8oY/PPBrFxi6QI4J3LLfM0QJ2paFmkFh6kCfAbc
         ehdgU1WtY17SjggNXUZkhKRGCo7ulImbzxVCBbB5hFHNt6g55qyYId9LkGrYORDt/VVO
         Rb83SKJ3OHckwj2Vl5NeTcTymjgI0SGTeRAHkejU/Pg9jvEKAurI1tkOfYhlunywwZgY
         UsTc2WZVXYDowmBZH9Laz1c6jJsyjMdZqsz8ACixPGjqUml9VHlOrSg6IIS3BtsoxfQL
         d02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IMVKRPD91r9MIGHIcHDIHWSb1J68VUuJeZtvfzj/19g=;
        b=aScstWvVF/dmrL+xHP7R+zEcTmUBFTHX4S0KsCR1qk+ypXE+gQuBRgUhH6XR7Xw95p
         VdMSb9XDU8f+PkshftlhCdZEoWtHH0QVMhH5VNBPN6m+2GPAsXeGWARGCP1oYO9z4nLV
         4od7fq8CN73M4+xyLabaV09RXK8/QrYRnwgevVEP68h5ZXX/kaokAR6tOEP5YkO1Tg0o
         uBL5xsPoFmfbQsvRMFnoitidgmx6cEF/WMjuXFZiHAYXWCEBktz+YEXgs09sRAc4OyIs
         23V74Npz1PBgPYg9jRTks4oNIEWExp7amkm8j4xnLpmS3zadoajDzy8HjpLjadgQWyZo
         HILA==
X-Gm-Message-State: APjAAAXi5TLbBcBShNgQetHp14QKWKb8H0oSznwAQ0UPh4a+dlhQuVAV
        qCSuBZu6BuBU69E5p6jTmOI=
X-Google-Smtp-Source: APXvYqw2LBPCAHYIqpNhHHo5kr+IpuYVL75X2TT63GOSjrSZFBZo/7nAvyTEDfLPhBaeOsJ/3J0icg==
X-Received: by 2002:a1c:9ec7:: with SMTP id h190mr2868289wme.105.1557315162937;
        Wed, 08 May 2019 04:32:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m6sm2926767wmc.32.2019.05.08.04.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:32:42 -0700 (PDT)
Date:   Wed, 8 May 2019 13:32:39 +0200
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
Message-ID: <20190508113239.GA33324@gmail.com>
References: <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
 <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com>
 <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
 <20190502150853.GA16779@gmail.com>
 <d64b3562d179430f9bdd8712999ff98a@AcuMS.aculab.com>
 <20190502164524.GB115950@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6F523@IRSMSX102.ger.corp.intel.com>
 <e4fbad8c51284a0583b98c52de4a207d@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C760A7@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C760A7@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Reshetova, Elena <elena.reshetova@intel.com> wrote:

> CONFIG_PAGE_TABLE_ISOLATION=n:
> 
> base:                                  Simple syscall: 0.0510 microseconds
> get_random_bytes(4096 bytes buffer):   Simple syscall: 0.0597 microseconds
> 
> So, pure speed wise get_random_bytes() with 1 page per-cpu buffer wins. 

It still adds +17% overhead to the system call path, which is sad.
Why is it so expensive?

Thanks,

	Ingo
