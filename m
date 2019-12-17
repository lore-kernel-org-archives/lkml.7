Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33DCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FF220684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576605890;
	bh=ugbTCckW3QlSEQJ9VwsVhkwK1HQTUPIk/akAjyiczGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KxSX9bdDWANBWZ4E4kopN3R3xesStYbaJZA3wknN2PJ7RIxffOcAJ3YXiTtzSVzRh
	 AJrn1q044KG9pH26qQH/dFu6bVGdJFltPk4I7/RVk/zYow/oodDxUaZKiv1ovMel4X
	 zH0IVrK8jykSoJYU5Kh9Yu+FQpM66sjxD8zraJhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfLQSEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:04:49 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36187 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfLQSEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:04:49 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so12006229ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 10:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lR1SiqLK9KEC99vqrA+L06g5eY9Mbqq1o4Gp42LpZMk=;
        b=FK7jv4qNRsEY58xZMc+UmIyte9eMcd0a4A+t48QkMIcc8UodbMREUJO3iZzA7AKpln
         03BKAH+vqDBR3VhNEzal6BtSu2hnn/lsLynWDxYrv66nuQYJnVSbzh2V+rbyH0fyrq1C
         njp7EPb9EhK3H7gTZQ8M3AOVEH2nTx7zrpL6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lR1SiqLK9KEC99vqrA+L06g5eY9Mbqq1o4Gp42LpZMk=;
        b=EeEjIcNdWQIQlesoYDIb7BBFB4ariMe3M6ULV39QgGaM+7hZbgsvtRJHvxvtH8cnPS
         qg0HJVXwAaDLhkBt7GdW5ou3Q6SZT97XGvxHjRU3MHZ9w8wcKppGODiJGRLTF5AmCK0s
         1lwQbByOqHH7fFYQwJpJcTH59x6l6p7kKf/tUMI93cnWqE7nfAOGbywwyUTx1bXrH/Ji
         Y8RRsLoxoyQi0KGVQTyGhAxRyBLUiURATHmR7HOu1zrVriMEA00Y+tcMvcjA/bJTcH1Q
         BT8L8QDQbP/mMrffk2ktt9SxDklWoeqgsxh5MtyfbstNoysc+cPLYuNFw4Ka1OkRHUcV
         rxlg==
X-Gm-Message-State: APjAAAXhxRrOxZkHa/h9oIsMA3H+JdV9eCYutASUnkCixilA14LYvs2j
        uwc0rQepSvtfxZUXtGkCUsPjWqiotNk=
X-Google-Smtp-Source: APXvYqwabSD72Rv/Y69lh1m5NRQl1usBC3TsBnWQ1FpK7fpQR/wxt0NkK+YV8JHC59unK3ozHOswDw==
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr4183179lji.256.1576605886878;
        Tue, 17 Dec 2019 10:04:46 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id g24sm5992009lfb.85.2019.12.17.10.04.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 10:04:45 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id m6so12008149ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 10:04:45 -0800 (PST)
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr4244505ljj.1.1576605885112;
 Tue, 17 Dec 2019 10:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <20191217170719.GA869@willie-the-truck>
In-Reply-To: <20191217170719.GA869@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 10:04:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
Message-ID: <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 9:07 AM Will Deacon <will@kernel.org> wrote:
>
> However, I'm really banging my head against the compiler trying to get
> your trick above to work for pointer types when the pointed-to-type is
> not defined.

You are right, of course. The trick works fine with arithmetic types,
but since it does use arithmetic, it requires that pointer types be
not only declared, but defined. The addition wants the size of the
underlying type (even though with an addition of zero it wouldn't be
required - but that's not how C works).

Let me think about it.

             Linus
