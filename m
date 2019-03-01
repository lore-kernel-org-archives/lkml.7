Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEB0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C5F20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551458508;
	bh=Yv4mG1OD16hCaOCzeiOwdhrBxvbWOaERd/aASzr5CAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RrQwRzAwFTquVonFUhPCeC/SmpRi+vI91jbVJzhgQUCj1oaZsIL2dxDz8QDcofMAG
	 N12AmUlmniqJ4h9wObEY7pg5Ri0pUe91sk3SZdPloeTN9fsHLPVyFXzzz179jCLqlI
	 jv6NJCdeKvdYtjVJ4FpGqk1wuqidpWY8yPrGsXYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389121AbfCAQlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:41:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41390 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbfCAQlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:41:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id y7so3787955lfg.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Qze9L+97yo9+sIrq364mZS3RTYwTWHJrLWfBOMmKqw=;
        b=Kx/LW5yOpYV1tHBgFl/aGS9vRC04gqZVqlqsK8RzeW2PjBACDe6Kf/S0/6AVSn//ui
         8mfgKwDTazY5fi78YCixgNnpldW8Ub9kX6XzcXUKJ+XThOrpLAqWhBJLHipm10JWq16Y
         oGEt/RqeqkcMQuIMxb0hFc6R25anCnw12ZtK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Qze9L+97yo9+sIrq364mZS3RTYwTWHJrLWfBOMmKqw=;
        b=R6I7j7ZrKKg8os5nYBP0bFkh2uS/dd2nJxWoKScrSmvdf/GUVpiaVC+tccPAezGr3r
         ZwxuGJJ4wIqou6HLHPV1zNfMM9eXJlS17jUaosPVNn/qu+4Bus/+faW9tSVtLXN8GU04
         abD2Dwmhakh7TrtrtZ2G4XLdQrsZAQmeDaV2ndnap+MWo5+KR+ic2pjaM2u5PW77mInJ
         R94Tz6y1dQBaf6xZfdGFNVI3c8937Ghe7Bf4AteLPbIIhcbISLKfCQb6GOtHrduRNBGf
         x/lPEgBpJUDa4MaDOBRkgMm3b6wVV+iq+WYshXX3+Tl4e5eUMdOp3werC3btWHtPHz9R
         Z6cQ==
X-Gm-Message-State: APjAAAV5p12gSAosLjNqX9Y+fhxmHP45/LU9Bg96UDPIkIf8lPxexsMB
        Ywprbxas1p5V1imeh675RaxL2qP/nxA=
X-Google-Smtp-Source: APXvYqwJTUiqlkY9/WEzNJI/uSvk024pTHtjWOiN7nNPybZaznnspwKtIMOXw7+c/p9QkZiVP4C49Q==
X-Received: by 2002:a19:7919:: with SMTP id u25mr3481613lfc.87.1551458502672;
        Fri, 01 Mar 2019 08:41:42 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id q15sm4768335lje.89.2019.03.01.08.41.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 08:41:41 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id g12so18446436lfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:41:41 -0800 (PST)
X-Received: by 2002:a19:c744:: with SMTP id x65mr3539303lff.148.1551458500748;
 Fri, 01 Mar 2019 08:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20190301140348.25175-1-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-1-will.deacon@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Mar 2019 08:41:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wio4duTk=dPJZ+yW-Y-65Q4O8Hc09bexAqs4OQV1R3WhQ@mail.gmail.com>
Message-ID: <CAHk-=wio4duTk=dPJZ+yW-Y-65Q4O8Hc09bexAqs4OQV1R3WhQ@mail.gmail.com>
Subject: Re: [PATCH 00/20] Remove Mysterious Macro Intended to Obscure Weird
 Behaviours (mmiowb())
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Love the acronym, and the series looks good to me.

Michael - can you check (or maybe you already did?) that this works
for ppc too, and doesn't have any gotcha's?

                      Linus
