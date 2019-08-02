Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E96C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FD420657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="O9OEH6Bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404057AbfHBNCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:02:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35083 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389446AbfHBNCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:02:37 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so152014770ioo.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IycbSoYk5b7V8lkB9aLkTECX3VyEXPgVPC8ebdeRhy0=;
        b=O9OEH6Bj8CYMK7KM0KFs9tyA/P2LHpHF145h8wg5UV6I+lz/xNUlahcLEl3i29vheB
         XlslpLIaML9ispCXTHDW9rbYCVW5/B0a2gzhW96VOI4ROcUsSlV1QFKWoEU6eQFIrfMR
         KrU2iSbjlkzoDypAzcBkgMjJ3IEso02pgaeLTOuRfHWSqmEm7LN8py9NtPf53nzPDnV0
         UYFbSnXpX1U9cDRRxqh7g7LTzfnnDZUP8dCoveEoEdWp5+lGHEDkWkCmqrKzsSwwTEKQ
         oryhwelZaPoP9hDjYI3FGtTdMSnIndCb2OdAPGmHhOWS1fA/FIajP/p5JlEMM5JNVRRK
         TZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IycbSoYk5b7V8lkB9aLkTECX3VyEXPgVPC8ebdeRhy0=;
        b=nR64wZjY+P0Uj8zSJjPhqzKbXSe88xpSHuhTx299qXFnz5wdT7I/7TxRVLIM35PRXn
         J0dtOshHDEwhP9xS47jWomtzw3pMIoF2FQAxQw1o7184o1PuX/aDy4dsaBqbEYqlt+k0
         RBCRDNU/RGIE8TL6Tithuh3nWL85OzHfZQnDLEMlwURNeeRcLGU8bgWITS66Hbfkqm+X
         ke1Yej6sq5n6aqel1/Ui/F1zlLkBNBPj6Qt2wyjFJGJZ5T9MUf+VuZNd0Hsl+FrTAnGV
         rrsc7IMGIvp8g+rtM7XOF4bTD5sTGEwypKvuIHTlZYHtXHrLBBV0j4HeuPFIRXaicHMY
         +JPw==
X-Gm-Message-State: APjAAAWdmfhNFKPB/7iOSmY2367Zcj0paOLp5ApFabM4DYA47g2adS5S
        YF5f+Ci3WxG3ODlUv2ljDpo=
X-Google-Smtp-Source: APXvYqxPv1Y+mJuGVcmS9DJBaVp1FVjlGTDK7Rek0XCeDHrJYqTzYwAk5RMYRCbvqzjuTFNkFx3cTw==
X-Received: by 2002:a5d:8890:: with SMTP id d16mr76293890ioo.274.1564750956954;
        Fri, 02 Aug 2019 06:02:36 -0700 (PDT)
Received: from brauner.io ([162.223.5.78])
        by smtp.gmail.com with ESMTPSA id u17sm66939463iob.57.2019.08.02.06.02.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 06:02:36 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date:   Fri, 2 Aug 2019 15:02:35 +0200
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v2 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190802130214.l6vporvni7nnbnif@brauner.io>
References: <20190731161223.2928-1-areber@redhat.com>
 <20190731174135.GA30225@redhat.com>
 <20190802072511.GD18263@dcbz.redhat.com>
 <20190802124738.GC20111@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190802124738.GC20111@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 02:47:38PM +0200, Oleg Nesterov wrote:
> On 08/02, Adrian Reber wrote:
> >
> > On Wed, Jul 31, 2019 at 07:41:36PM +0200, Oleg Nesterov wrote:
> > > But the main question is how it can really help if ns->level > 0, unlikely
> > > CRIU will ever need to clone the process with the same pid_nr == set_tid
> > > in the ns->parent chain.
> >
> > Not sure I understand what you mean. For CRIU only the PID in the PID
> > namespace is relevant.
> 
> If it runs "inside" this namespace. But in this case alloc_pid() should
> use nr == set_tid only once in the main loop, when i == ns->level.
> 
> It doesn't need to have the same pid_nr in the parent pid namespace.
> 
> And in fact we should not allow criu (or anything else) to control the child's
> pid_nr in the parent(s) namespace.

This should definitely not be possible!

> 
> Right?
> 
> > > So may be kernel_clone_args->set_tid should be pid_t __user *set_tid_array?
> > > Or I missed something ?
> >
> > Not sure why and how an array would be needed. Could you give me some
> > more details why you think this is needed.
> 
> IIURC, criu can restore the process tree along with nested pid namespaces.

Hm, I'm not a fan of this array approach...

> 
> how can this patch help in this case?
> 
> But again, perhaps I missed something. I forgot everything about criu.
> 
> Oleg.
> 
