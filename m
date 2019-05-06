Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88967C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE542087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557128911;
	bh=iQO0ec/SG8F94JY1m2ekvJVK/YDQDW2J6E5HGRzg3Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZhoNEk6Tc8ftS+lYu2VN/HDKCc6cjoG4uilBJoDVx2yYk5YFy5LwzsOW2W/eAVWqB
	 cz3JkuEcymCLDH2/xMBA/r/u0x4vOiYT5pazf2+mD/eVdELsICupfcpDJPUwy0sj6X
	 5u83i/6Aca/8gUZow4r1XfQGSpwSndnEdb5DC4G4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfEFHsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:48:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38812 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfEFHs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:48:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id f2so8999243wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lOMmC2TdPGvudZ5zd3K88q7Hkn2nNBdEod9TPs+T1As=;
        b=Slaf58rRFMPspfJPXpmTfLlvwHidotLOMxhyQjova1O4DpsmA/t1EGlinnwrWNjZEa
         WGXX51gARplly5SfcaxFi1xynREwymrx2nkYqsnw8tXplC1Jed+eZEL89EAMgspKPkx4
         VMPvROYT21z9Gfa2hf4YEkbEZMzU64Pnrvx0w/E2NvCgLPuXS/Ce2M5vuYhuVd2j+r4u
         wKFhmjQwd8VN5pi1cR7+4kAfj/k4clFbyCNw4CyQnrW+2UniB1kSivgEVBjU7pyF37Mw
         fisW2RubkyT9oK8pxfLjs06SlLs2nGZsRfxwfbOxUCSoy1gKnwLXV46GP1FupbieOKBi
         gikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lOMmC2TdPGvudZ5zd3K88q7Hkn2nNBdEod9TPs+T1As=;
        b=JMiROAXIpqN116FgQYW3sOd9Jc+AlzrpCbhsquEUmWoTjBVnHxWr34+3u8TdCiRcgw
         Dt23TdjFSFBUH2Mu76eawRiOXzyQxS/wn84gpR9yLvZrGDWgESThYmjosloSsV9P6ppB
         scZn7YcQh0SZj5e++iK8Vb6DCmQUwIrRbV9D38FszuOf2rOtXvMIcp2psmMltKIkcKrl
         VBTLJcaUN3esYEnC+7Iol1b6xFqsadGy1aOqsa6Mc+xGqXdhtW3+ZpFZIKPjAvaxni/S
         DQn5cYdh67eRv3WKVl+G/uj1mMJxpZiltcklyyvVbWMe6viw3Pc/46348Y/M7SQXTTKK
         WTZg==
X-Gm-Message-State: APjAAAWgXZOJzXazibBWgbHna81klJ04GzoQCpr5v11eWuUuGAF7k+qP
        bBza2c+CqXmMi+EShWXsgks=
X-Google-Smtp-Source: APXvYqyxnM3H0RW7VAjyrnVoeQuJS4dJsfRQz2+6D0KPmo/7z1/mSm31TtogRWgjeRvZ41viotGPaw==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr15129112wma.120.1557128907723;
        Mon, 06 May 2019 00:48:27 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u11sm16796834wrg.35.2019.05.06.00.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 00:48:27 -0700 (PDT)
Date:   Mon, 6 May 2019 09:48:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 00/10] implement DYNAMIC_DEBUG_RELATIVE_POINTERS
Message-ID: <20190506074824.GA40476@gmail.com>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
 <1afb0702-3cc5-ba4f-2bdd-604d9da2b846@rasmusvillemoes.dk>
 <20190506070544.GA66463@gmail.com>
 <25dfde77-fdad-0b99-75ec-4ba480058970@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25dfde77-fdad-0b99-75ec-4ba480058970@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> I _am_ bending the C rules a bit with the "extern some_var; asm 
> volatile(".section some_section\nsome_var: blabla");". I should 
> probably ask on the gcc list whether this way of defining a local 
> symbol in inline assembly and referring to it from C is supposed to 
> work, or it just happens to work by chance.

Doing that would be rather useful I think.

Thanks,

	Ingo
