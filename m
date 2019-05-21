Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8D8C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CE4216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558437871;
	bh=LPz/8bnSOocyng6G1JsrkcWmG8OLv9Hua93ZPja6LPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hGcVwi6neKNONE1iPwxT+LwuoHhBQr2gyrii8tQyHtTFAT89dx4/qUIzGn/Wd7e5l
	 C9YQ4zXQTvu6VVEfMDuKep6j0FUUFIkf65wev/Jg9n6xnVqeFIkKVuE0HOp/aRGWZ6
	 GaUTuR4AOQYkOx8jLsFEcQHifFDPDxanjsdJrr1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfEULYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:24:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37935 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfEULYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:24:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so8448627pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 04:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=19lOUlmB0BXO2qy5+86EiFCLj8kI8GOhTNcbKNP7IO4=;
        b=P6sVSJ8VYNp1+Lx4Dxzurk25CX9vkVoXH08GrauyQziSWr+fupC7M+k6u4UTyrGsbY
         jBDI1AiX+THg04/RNegnkFskFWc2Hde+r/6tC2DP+zcvIs4X2lQyrOQ2m6quf3I3IrDK
         7n5vzbRA0a6/LqCBIQsIMR/vnOEKPgxN7hl3hjGnf6LP0JrsutNyi9WSvdtj+Jw6mZQG
         MwxVmfse/1ttaoz24+lxlrWvFBtGZK+tuT51jRdv/4s+Uwa881cOKdhgis/0g1V47XZI
         RbKI0PyKuB5zZ1JKkzFhG9SfJxo2OfzwDIt009bJF5uw3P2FiSKwodIxOuirOUnvDbcO
         A2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=19lOUlmB0BXO2qy5+86EiFCLj8kI8GOhTNcbKNP7IO4=;
        b=S1A49C+HintLz0B+SoljY1DZ+r/eIEs4KFC28suXS3959nT/6EWXp4DI2Hc+Tlen8S
         vB+Qbpsv2m5qgoK8CmilOeTDl8V6y9hbS4CItRdQtUmjRDMklWE23CCYc/0peS+xw6+Y
         cnkJOjOcCPgHD2SboZUNH2YsKQGSFeNtzSDHGRf76hqRxwrK4u1xD2aU/DTQHelRa57l
         BLGQK5JNVAwyZQ0HLm4LO0V7qyiFOLynSszkeDhbIiLPW8XQO0skywk3p3ztbc7FsVAM
         KpukQKuW1LrrRVbM/UXWBtKLOH70x7UncQ55LJ1dMTNyuWiD2Li+Dqgxj1piX/e4sg2B
         hNvQ==
X-Gm-Message-State: APjAAAUi/s5FKMFHDKpuEd8ryHPTOVYfUt0Pf++8RNZ9GS1Grc5EYT7n
        CZfGU9hpvxiNGRd/PN7fsyQ=
X-Google-Smtp-Source: APXvYqzO8k/cpniPZ4As3COPVMn1h85852mwAsWD2KOvHeEb0TcpcFBsTAgm3gjNSBmuXcimHbfaBA==
X-Received: by 2002:a63:1657:: with SMTP id 23mr30125895pgw.98.1558437869394;
        Tue, 21 May 2019 04:24:29 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id k13sm17361700pgr.90.2019.05.21.04.24.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 04:24:28 -0700 (PDT)
Date:   Tue, 21 May 2019 20:24:23 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 4/7] mm: factor out madvise's core functionality
Message-ID: <20190521112423.GH219653@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-5-minchan@kernel.org>
 <20190520142633.x5d27gk454qruc4o@butterfly.localdomain>
 <20190521012649.GE10039@google.com>
 <20190521063628.x2npirvs75jxjilx@butterfly.localdomain>
 <20190521065000.GH32329@dhcp22.suse.cz>
 <20190521070638.yhn3w4lpohwcqbl3@butterfly.localdomain>
 <20190521105256.GF219653@google.com>
 <20190521110030.GR32329@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521110030.GR32329@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:00:30PM +0200, Michal Hocko wrote:
> On Tue 21-05-19 19:52:56, Minchan Kim wrote:
> > On Tue, May 21, 2019 at 09:06:38AM +0200, Oleksandr Natalenko wrote:
> > > Hi.
> > > 
> > > On Tue, May 21, 2019 at 08:50:00AM +0200, Michal Hocko wrote:
> > > > On Tue 21-05-19 08:36:28, Oleksandr Natalenko wrote:
> > > > [...]
> > > > > Regarding restricting the hints, I'm definitely interested in having
> > > > > remote MADV_MERGEABLE/MADV_UNMERGEABLE. But, OTOH, doing it via remote
> > > > > madvise() introduces another issue with traversing remote VMAs reliably.
> > > > > IIUC, one can do this via userspace by parsing [s]maps file only, which
> > > > > is not very consistent, and once some range is parsed, and then it is
> > > > > immediately gone, a wrong hint will be sent.
> > > > > 
> > > > > Isn't this a problem we should worry about?
> > > > 
> > > > See http://lkml.kernel.org/r/20190520091829.GY6836@dhcp22.suse.cz
> > > 
> > > Oh, thanks for the pointer.
> > > 
> > > Indeed, for my specific task with remote KSM I'd go with map_files
> > > instead. This doesn't solve the task completely in case of traversal
> > > through all the VMAs in one pass, but makes it easier comparing to a
> > > remote syscall.
> > 
> > I'm wondering how map_files can solve your concern exactly if you have
> > a concern about the race of vma unmap/remap even there are anonymous
> > vma which map_files doesn't support.
> 
> See http://lkml.kernel.org/r/20190521105503.GQ32329@dhcp22.suse.cz

Question is how it works for anonymous vma which don't have backing
file.

> 
> -- 
> Michal Hocko
> SUSE Labs
