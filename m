Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29714C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0275F22DCC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567496843;
	bh=UskTLrDiIf44wGWn/H4c6HwOKwvjfFxZIUXf3Fd77Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i7tRL/hqTOxV9AW6YtFMMURSx0pzaFz8advhO6wLCsudNeMGKbA2+pRnd/7OAlzPA
	 tPxDWrrmLbI3jcj/R/U5tvUKtOB2Nvk/s+6wCufQrnUdDU/OHW0cILVK01odSGsgSl
	 J9Y7KHtT0hRZcejCczkahMMQlStYhYSQUwb9Ic7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfICHrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:47:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44312 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfICHrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:47:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id 30so5344889wrk.11;
        Tue, 03 Sep 2019 00:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kwp0BHhoVfTT4vyOvoyVFGJwO5w5YrMAPp4t1qkVO3w=;
        b=shbt6WkokXyf7Hw77sVZvi3Y1VrgFRV/lEMSLU2zqwUUGfKJA1m4G2VXGkqnwToauk
         HhX6gkgDDeQyZDWHSX3tFeNbr6Xa76EmLH77KlCXF/puLLvH3LhnlyMa94LNtN9gUGaV
         q/QSrwqntzGq/vFO2n4N33+ruEx5+b5W1NLVl3J5DuOpcQNkXpsQViRJ997MlZVuyDvY
         L+2rqyUSR6iCrWOGNCXjXqhOvcUZ3GAc0t2xI5t+WIye7tv/zFYVWG/9v/JtlS9fOa1B
         WlK1BnAbEKPNrHwhGw3X5KoDJZGhXyWP+mSkU87GNA2etBTD9BhHd/IeF7uHsa6gE4mf
         14gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kwp0BHhoVfTT4vyOvoyVFGJwO5w5YrMAPp4t1qkVO3w=;
        b=oDeYj1tm0uNw2dtuezCZBUdKjuRQH8cd/m3946hsjgj/z3nrVZEpxobOiM+nXfA9QA
         0+T68oE5JVv4Vf2cAcabIkTibPt+qIOTq8H8aQ2HfINpVW4xAggNr1dphkR4rk1bCgdW
         IH8hpJMGdoBkTwvBmLyhX35z77w4VSpKX4muiEXrsJpQNt7wviWWWIZWIesW5zdP4Vzc
         3W1bYw2rc7e3Sr0Nvmb4cPG6WP25OwR1edBv3uYydosM+dcu1PkbOR2hnJkC6l6BHDwM
         YJqoNmX4Rwzc2Z03syMmytFhrpfeGfpmxhIXjScl6bzL0EpHflPtlGsRgkCfAv7wP5l+
         BBkQ==
X-Gm-Message-State: APjAAAW7xnvSqjPR1OZ2/imd56uFTxneqIIbjF70wOC7f14sAMItiiKY
        goMmM1O3+mjFb4mDWX27khHCE+Li
X-Google-Smtp-Source: APXvYqzhFdth8drAAl0ulFFHjoDUSNShaJg4oGaKEmjlTozCfRseyENp3XULXQZJHhmJ9OKv0UmZEA==
X-Received: by 2002:adf:bd84:: with SMTP id l4mr41442145wrh.143.1567496839734;
        Tue, 03 Sep 2019 00:47:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 2sm18179973wmz.16.2019.09.03.00.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 00:47:19 -0700 (PDT)
Date:   Tue, 3 Sep 2019 09:47:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/8] x86/platform/UV: Update UV Hubless System Support
Message-ID: <20190903074717.GA34890@gmail.com>
References: <20190903001815.504418099@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903001815.504418099@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Travis <mike.travis@hpe.com> wrote:

> 
> These patches support upcoming UV systems that do not have a UV HUB.
> 
> 	* Save OEM_ID from ACPI MADT probe
> 	* Return UV Hubless System Type
> 	* Add return code to UV BIOS Init function
> 	* Setup UV functions for Hubless UV Systems
> 	* Add UV Hubbed/Hubless Proc FS Files
> 	* Decode UVsystab Info
> 	* Account for UV Hubless in is_uvX_hub Ops

Beyond addressing Christoph's feedback, please also make sure the series 
applies cleanly to tip:master, because right now it doesn't.

Thanks,

	Ingo
