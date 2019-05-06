Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE2FC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9812082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557182367;
	bh=JQoMa7RCDkHbE8FXdHuB1lKZCoVy/Vrl4mbSx9qoV6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MV85JQlLiZEMtr1DyUaeyhVlsVbVUvhqJ81E29m9CCssfuDCGy7nsOfLd42tWzvnJ
	 4FD/Mun7PMHhPoEZ+Gzxlr9IebPtONlfVh0pdoj+EQN6DyK3PfMm34OAD9luCXF2v+
	 Biaefk2U7XRT6ex9tEW1Ie6WWgkIr3uif/tVYT2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfEFWjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:39:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40908 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEFWjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:39:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so115680wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ka4yFFMac0PKY8hCqrqpr9qdj7uVcx8s9jTtvQbtmvk=;
        b=ptyrulA9+0duqyRvzyJjqKTxB+iSavktL9QPAPulrRlmj1JX3gSRXD6U0jxL8XLuXj
         BR+yMnjJPjckPI/r7S/J+sx6fCeul892FYVE3lBOCzaNu/jafLxhyE6EYCjb8Gx7d5cT
         Z+COa5m6TXiwV6I9WIWBeS1RYMYBloEvGglgDfHcfgHMXkwz/BlU58YiumK96GA0pBeJ
         fAG9UBLM/5QUZolP4J6i3lAWXO5nGLeY7BjjSFaXY6sJj60NOtD9JFHCrpuW02OOp6A9
         bTeKU6U+G/nPb/RVbAmt124ndHM8IJ3xpjSUjHWOcDWiMz+pwLdvWZ/zBhp4k06Lmixh
         +DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ka4yFFMac0PKY8hCqrqpr9qdj7uVcx8s9jTtvQbtmvk=;
        b=B4q5y9BmJTqaUw8ZpxWAx1zZqOcaKNcxZNhayumKz7eb0BnGVt+B5ZEVqldrqfIDST
         WobnakFU5zrBff3p6PGyDeoYKlMS6u9C5O7B+AoGl1IadLok430oDnHFSyl2sHKTPsmR
         HGm2HpvmuVLHDDcb8zjH3WIhoX3nmoF9mHE2wvhd7/uMsh3kpsdEN4DUJDyIfq+TAR7Z
         wN9OPQI5Jdd9LNt9KAlKwosq0/7ZD12NjSkLplw2IzeXZwhdunpV73JxVM52batuuyQC
         F+NAH7IMnIVo2kwTmuWzCMWCROXB/JeNfE1287iY3fQYNO0p+42mbmQ/UR2n12FBL0XQ
         GDwQ==
X-Gm-Message-State: APjAAAVt6F2V00nWVFwPmZ9ZT2DVs8mGMI7yXqJ6psFDp6CfRdZF8hKz
        bvUH2pWs/Yla7BQPKaPBNro=
X-Google-Smtp-Source: APXvYqzWHG43MauN9xGbJvJZ4RUx2zBGw12t182kzLsgEFKpzi+8oz0LwMu32l9RE8z2t5rFS7zp+w==
X-Received: by 2002:a5d:67cb:: with SMTP id n11mr19788029wrw.3.1557182363991;
        Mon, 06 May 2019 15:39:23 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k67sm16977088wmb.34.2019.05.06.15.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 15:39:23 -0700 (PDT)
Date:   Tue, 7 May 2019 00:39:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman9394@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] locking changes for v5.2
Message-ID: <20190506223920.GA21667@gmail.com>
References: <20190506085014.GA130963@gmail.com>
 <a5ee37fe-bdcf-2da7-4f02-6d64b4dcd2d3@gmail.com>
 <20190506194339.GA20938@gmail.com>
 <CAHk-=wifHYK-NKCTbT3_iHpy3QeK7H+=RLbFUaFpPziPn3O8Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wifHYK-NKCTbT3_iHpy3QeK7H+=RLbFUaFpPziPn3O8Ng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, May 6, 2019 at 12:43 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Sure - how close is this to a straight:
> >
> >         git revert 70800c3c0cc5
> 
> It's not really a revert. The code is different (and better) from the 
> straight revert, but perhaps equally importantly it also ends up with a 
> big comment about what's going on that made the original commit wrong.
> 
> So I'd suggest just taking the patch as-is, and not calling it a 
> revert. It may revert to the original _model_ of wakup list traversal, 
> but it does so differently enough that the patch itself is not a 
> revert.

Ok, will do this tomorrow!

Thanks,

	Ingo
