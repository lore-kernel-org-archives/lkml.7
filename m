Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E292CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F5F20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571640424;
	bh=B0++ZDtqoJsF2Tj6FUADVng8YZr4RUtRYgBIksFI5bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v+VdBT9MBaPorhxBoi9rVBdnVxU9VEXkpyPd1TVrIbBSJXPB4+edpgpK3rYp2IlZS
	 qoaXp8/FVaoHW5DHL4LCPMh9N2FCVpMIJqssGWTyonHG4SGEx3xMC2gafyLKeIR6oF
	 F7bbQkkm+UTpsdBb3CuOocme7DTyhcPCuslaGzMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfJUGrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:47:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38247 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJUGrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:47:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so11496213wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 23:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tlPpIwBKusc44G2y1sU81Lo8USWJFG7wCEpznib6Of4=;
        b=XvP2c167j/bu1sR1aTy73khqK0+zMbnPKpw+4XQkCMuxs0J1YijwuODFl/A1T3GZyu
         pSHm6k1kOfu1NzqvsKCrDdYIP2rp7FnEiIi3aHVZIcYEl8C2QRvjuF7213XmnyDU4J6T
         7KEAbumBOwN5Ker4JqeuqmNXnPSlD86UM60oC/nt1LxqwtR2M2ghnCiQs88EgCMrQMoQ
         J8LwTHTaeeJhdWX8cD47HjAokZAWrD49xTOE2DOxekcuqaVv6y8lDefJ1cu2mqPMwNaM
         Mi9xgFpQMxuLQHVMoYcT9JEqe2ejivQbSW78h6+I7iZxagT0D4mQ6B+s9rndXZve9sbV
         KCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tlPpIwBKusc44G2y1sU81Lo8USWJFG7wCEpznib6Of4=;
        b=K9G9/3GfusOEZUMfE8fgkJdGX180vc/KWcnf1Tci3UWatWOszdoyfHL5tVT95ayzVw
         2RfAdbAkT0PDy/FpH23invGYJe+MCBRhwAw2G19kq2KzN4Y/efMG6NJejOlhEkPywn/z
         voWgu9Xw62Lyu3DGk7vwfqtvbhlaYekMXU0aio3qRu99syN/dSJQoPKl2n1OgYza/LjV
         UP2UKytPEcKkmPdlKFHHqI4Qvjd/lNOQLsxncy+49gjm6j11XjSKuHyeevn7y77pYsXy
         QgI7Lw5++DPn2N5XMrMlBws+iq9cdzQBjzP7Jls8BYyd6p4+DCtqy7ACOBw/VVHfJiup
         Meqw==
X-Gm-Message-State: APjAAAVx3iaTXV0Pyp5eepplqk+trkJfXagaaDovA+hGWlomQBf1jWG6
        cOxqBZfVfqt/RNn06oWjsTE=
X-Google-Smtp-Source: APXvYqwbXfC4Yy97gxWjM38ERhzCRYCmSb222GCRiSXKVlql0F4+vbUyDMowjfvMQ/NyV7/zx0w/BA==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr4411635wml.26.1571640421191;
        Sun, 20 Oct 2019 23:47:01 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d4sm12918196wrq.22.2019.10.20.23.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 23:47:00 -0700 (PDT)
Date:   Mon, 21 Oct 2019 08:46:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] arm64: Fixes for -rc4
Message-ID: <20191021064658.GB22042@gmail.com>
References: <20191017234348.wcbbo2njexn7ixpk@willie-the-truck>
 <CAHk-=wjPZYxiTs3F0Vbrd3kRizJGq-rQ_jqH1+8XR9Ai_kBoXg@mail.gmail.com>
 <20191018174153.slpmkvsz45hb6cts@willie-the-truck>
 <CAHk-=whmtB98b8=YL2b8HzPKRadk2A9pL0aasmvgebhePrDP9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whmtB98b8=YL2b8HzPKRadk2A9pL0aasmvgebhePrDP9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> What you doing the merge does is to turn the multiple merge bases into
> just one point: the thing you merged against now becomes the common
> merge point, and now you have a "two endpoints" for the diffstat: the
> thing you merged against, and your end result are now the two points
> that you can diff against.
> 
> But the shortlog is always correct, because it just doesn't even care
> about that whole issue.

FWIW I regularly ran into this problem too and resolved it manually by 
'emulating' your merge. (Once every 20-30 pull requests or so. Finally 
ended up scripting around request-pull altogether.)

I think at least once I ran into that and sent you a 'slightly wrong' 
diffstat - and maybe there's also been a few cases where you noticed 
diffstats that didn't match your merge result, double checked it yourself 
and didn't complain about it because you knew that this is a "git 
request-pull" artifact?

Most of the time I notice it like Will did because the diffstat is 
obviously weird and it's good to check pull requests a second (and a 
third :-) time as well, but it's possible to have relatively small 
distances between the merge bases where the diffstat doesn't look 
'obviously' bogus and mistakes can slip through.

Anyway, a small Git feature request: it would be super useful if "git 
request-pull" output was a bit more dependable and at least warned about 
this and didn't include what is, from the viewpoint of the person doing 
the merge, a bogus diffstat. (Generating the correct diffstat is probably 
beyond request-pull's abilities: it would require changing the working 
tree to actually perform the merge - while request-pull is a read-only 
operation right now. But detecting the condition and warning about it 
should be possible?)

Thanks,

	Ingo
