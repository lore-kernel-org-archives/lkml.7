Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B775C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E243920830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557163727;
	bh=4Xyrs4vgCPFnFUYqPlSemw1UZavjDIoyo1DsYaWMs/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ef9NEwNVihDO8v1o8lY+SOoOuyyhdxcUfwaF22vGums1yu7j3yA1Rg9plirIdC3WR
	 9zyI0312MuS9nJWyY8c4c8rxKvUyOiTsrOVtYeMSQYaNK/0xRSDd5RIb3W6eIp2V2A
	 MW/2PfRZspKWGn5fuZh0pCAtm5hSqEiMnrExqV1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfEFR2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:28:45 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39381 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEFR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:28:43 -0400
Received: by mail-ed1-f44.google.com with SMTP id e24so16092342edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 10:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjygrUhkEPXk15pLulFNm9hvbV7SxD0hUbgG2Pi4ZZk=;
        b=YAGWCe1LHPcC5xX5SKiWYEKZXAg1XakEFhtm6y98HsA5zhSOAborSNFc0EFnz0JyUX
         v2uQckv5YZyv4+ZQ5BSsoddaOSei3nFGIUsFkcBUlG9AcE4FXgz5sVfLoH4vs7ETLE9e
         KkU/IM7y4Yc/m1GsdyjmvGmoHIdYePoG1p47mvSZ/8H2+UY9pOJgWKkTXr90LdxxVEgH
         6l2rlEqo49DTW63maUZeQoDoMFFSu4woq4YeTUT+tq1APquHf3U6TRbxrN+wyBfRsHY0
         XTY0tJVdLHnOr2wC+/VEiyKfGpkBPCsXK0PmClaAa3+eXaZUuOikgLNwJr77NdP7vKtr
         PVAQ==
X-Gm-Message-State: APjAAAWYbyr9CRxFjSBukzekrX52GmTPKJLat8k5okszSZtfJ0I6bT47
        jPazyqBtbg5X1TmFz6AzPBbvB+S3rFtAmISPNJtUsg==
X-Google-Smtp-Source: APXvYqzM2xj1p3guKWEZzV5uymPRPT4ZpcFbyLCKl9NpxRQJXb/wbaZjKCBhjiVb7xp5aAnoeiQn7dy9QL19rJ8GjgA=
X-Received: by 2002:a50:b513:: with SMTP id y19mr28019435edd.100.1557163722765;
 Mon, 06 May 2019 10:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
 <da7518106ce152367457c014bc91281925ee9576.1556657368.git.len.brown@intel.com> <20190506114819.GA24079@gmail.com>
In-Reply-To: <20190506114819.GA24079@gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 6 May 2019 13:28:31 -0400
Message-ID: <CAJvTdKnZhyk_aWjQP_dtnNjvV75MvXBEmXUjH=K0hu2Kb77pYQ@mail.gmail.com>
Subject: Re: [PATCH 17/18] perf/x86/intel/rapl: Support multi-die/package
To:     Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 7:48 AM Ingo Molnar <mingo@kernel.org> wrote:

> > -     unsigned int pkgid = topology_logical_package_id(cpu);
> > +     unsigned int pkgid = topology_logical_die_id(cpu);

> There's many such instances left in this series, please review the whole
> patchset for such problems.

I agree, the legacy names make the code read as if it were a bug, even
when it is correct.
I'll refresh the series with some re-names to make the end result ready clearly.

thanks!
Len Brown, Intel Open Source Technology Center
