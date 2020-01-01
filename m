Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F47C2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 23:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891CA206E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 23:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmlprpRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgAAXIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 18:08:49 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39811 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgAAXIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 18:08:49 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so33675814qtm.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 15:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ucE5SIm4FyKUxsYMdfEgxaw57ndeqmqrFP4FIZf3o6U=;
        b=FmlprpRtU7bYRycWCucZwYGTb/NCwTV+Z6GqQe2uTnHVueuosK2E2IFOaG6QtykmYm
         gEq/iFRhzaWZI6FbPM0E7VtZGQycUBsNDv31cPsVjNS91H9DlChsZJH6f1lb9096TDsZ
         oY55dBwH+yzm7ZFoCoejW0eZWre/OCqiaPgL2y7RdJqMCMJYN8vPtm2GfQxsFVnwFZrT
         KgdVikmBsIs6aa5gmZUIzaPRM4mM6jq9+2GfvYjONm0mPVZ9uy9Cgl5O8md9+2Sxh6g1
         X3FIcE5zkr/KSbqRgVRTnNczr1WewUSu4l0NRi1+yr8mg60S5dcAI22RvrTZhZ9UNNZa
         OwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ucE5SIm4FyKUxsYMdfEgxaw57ndeqmqrFP4FIZf3o6U=;
        b=s55wi1+01aZ+mPVz/am+7kIoyclhBgxD2pvZTMJ2HqhfpXh3YEkspKN3WZAiN3d7eI
         bAMLRtPBytvsGUMywoHs8Lb2DfGuX8/p3T15VZhXkV/vQOAk4D+KZa1TXC77IsAgZdxl
         yjgn3UFzY2JSRkVkFYEHK1lKM1tltYSYro2Vk/kh4gXaljbduajAorGsuyXFfYtp+ztJ
         FfZ9N7nXoIBcKM9WsOECLN7vWdES4IM1xuJ8z2s7vznfJorRX9uReN1ee5g036ChloA7
         F8fyLofoyecVzYm5yK1OPV23PSPt8RvyNuhYjElWHCrEU+ELAcXEyonpXAsxPW+O6qe6
         mzRg==
X-Gm-Message-State: APjAAAU+1VWr9J1p1RHPT243GgyZ7qoApJhKKG7i6H7xPgJjUn11UJyT
        1J5S7c9z0d/UPNnhmbpfH3s=
X-Google-Smtp-Source: APXvYqww5y1IhMNo7wxOmJDJT4kNfU50NrIT0d2TaeF70sfaGob1kzCHq6B4h9WF4xAyucOnR7omqA==
X-Received: by 2002:ac8:242f:: with SMTP id c44mr58437600qtc.346.1577920128300;
        Wed, 01 Jan 2020 15:08:48 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l33sm16497258qtf.79.2020.01.01.15.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 15:08:47 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 1 Jan 2020 18:08:46 -0500
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        youling 257 <youling257@gmail.com>
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
Message-ID: <20200101230845.GA454720@rani.riverdale.lan>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan>
 <20200101183243.GB183871@rani.riverdale.lan>
 <CAHk-=whzgLPi4szh8xOKysuS9CKaQESngc=n0omBVpwdQ822aw@mail.gmail.com>
 <20200101225049.GB438328@rani.riverdale.lan>
 <CAHk-=wgHg8z5WQBoypjyi0VPp3E44oO_Szuvk9f6v1mGMqsSZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgHg8z5WQBoypjyi0VPp3E44oO_Szuvk9f6v1mGMqsSZg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 03:01:12PM -0800, Linus Torvalds wrote:
> On Wed, Jan 1, 2020 at 2:50 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Shouldn't that only affect init though? The getty's it spawns should be
> > in their own sessions.
> 
> They *should* be in their own sessions, and clearly this problem
> doesn't seem to really affect much anybody else.
> 
> But I think youling has some limited and/or odd init userspace, and I
> think it gets confused.
> 
> So my theory is that because of the file descriptor leak, that "forget
> the old controlling tty" doesn't happen, and then subsequent tty opens
> don't do the right thing.
> 
> Maybe.
> 
> But it's the only real semantic change I can see in that whole patch.
> 
>                  Linus

Ok. If you do end up going with this rather than the revert, one minor
nit with the patch -- if somehow the filp_open succeeds but one of the
f_dupfd's fails, you still need to do an fput to avoid leaking the
reference.
