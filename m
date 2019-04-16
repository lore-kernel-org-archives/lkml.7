Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13DDC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6866620684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag5rZQih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfDPOhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:37:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43671 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDPOhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:37:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id v32so23486960qtc.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r/6rLux7hOcO/LuZkFSRcW3MyPz0cEd7w+P+PSZ6LBE=;
        b=Ag5rZQihSSWyc2Zo+6Wp6Z8WtujlZUI7MHmw5mESa4pLcMQN4kHV7yI0JCZux22VJa
         xg1b1x4+QhqfFqbAC+rKcRo/7Zyk/RgBpQvKA/TVtuiI1D6V+g8wXtwcuExF1zKZsOsn
         RUjNaYqz8o5XcDpoZcLaXsnTo58zOV94QEpex55O3tX9dYn3Rmb6PrMXwVE2kL3HjnoT
         YQENscv6R1F3uSJWQ/KdiXvw+506ylYAG5Wi0ueKzQAaC/LSP9qh4hXGAmmMuI+ZXUcp
         LdERmGu3dFiYmlRumlaXTTB+QPpQ5dPLtqiLNb+JBBVb92yd2CowOof8d+OIBcoq065J
         VrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/6rLux7hOcO/LuZkFSRcW3MyPz0cEd7w+P+PSZ6LBE=;
        b=RU2OOUo/qJRMf2scRLMSOOBxz19Z8N3ePdv8piRFiBTXC1AFsoPHrc9NkkIJB7y+Vf
         MNiAzrzX0Dm8cChfACkUCzr+Qiim/UOmCNRmqVv7PAN4QGzG/bqueNtvNVbBLSKwCEvf
         VBnPms3Rxju0DMg4I2HgLa1K/xvDZuWi1xX/VEy+tKA+4E07WIxKGUpDcsP0sX6VBVCS
         uQufmZbNuuZ+sTWGBtOoz1dwUAoIPH2NqPzu3q8UcDFvCZiovtxOmTVOJ4lvJdmvHrA6
         FDHXIHMNVz4eWxOud9rR0Ug8DzezZlgxWvpRIPEGp+EqROy4B37+4vEVHK7sIl6JmIpM
         GVDQ==
X-Gm-Message-State: APjAAAXkufQvVMRShr03yEZ6CV0VdaZ4NsTY24DzmFXQORsmljLwOkXM
        +47AHu0ryy7Wb2Bg1xlCuwo=
X-Google-Smtp-Source: APXvYqwN/QxNoHVC8Vq0j7vnvJRZzhaAzeS82KzVqg8tCdqeAJLovHG1hW8VZcZY6Li4MNzK8xXOEA==
X-Received: by 2002:ac8:1b38:: with SMTP id y53mr63634327qtj.130.1555425472540;
        Tue, 16 Apr 2019 07:37:52 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id q75sm29711387qke.17.2019.04.16.07.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 07:37:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E4EB44039C; Tue, 16 Apr 2019 11:37:48 -0300 (-03)
Date:   Tue, 16 Apr 2019 11:37:48 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Fix perf_env__find_bpf_prog_info rb tree
 lookup
Message-ID: <20190416143748.GC2459@kernel.org>
References: <20190416134151.15282-1-jolsa@kernel.org>
 <20190416142028.GH11294@kernel.org>
 <20190416143452.GB10125@krava>
 <20190416143554.GB2459@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416143554.GB2459@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 16, 2019 at 11:35:54AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Apr 16, 2019 at 04:34:52PM +0200, Jiri Olsa escreveu:
> > On Tue, Apr 16, 2019 at 11:20:28AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Apr 16, 2019 at 03:41:51PM +0200, Jiri Olsa escreveu:
> > > > We currently don't return NULL in case we don't find
> > > > the bpf_prog_info_node, fixing that.
> > > 
> > > Can you please try to figure out what was the changeset that introduced
> > > this problem so that we can have a Fixes: tag that helps me determine if
> > > this should go to perf/urgent (likely) or (perf/core) and to help the
> > > stable guys as well?
> > 
> > sry, I keep forgetting this..
> > 
> > Fixes: e4378f0cb90b ("perf bpf: Save bpf_prog_info in a rbtree in perf_env")
> 
> I had just added:
> 
> Fixes: e4378f0cb90b ("perf bpf: Save bpf_prog_info in a rbtree in perf_env")
> 
> matches, good :-)
> 
> At firts I thought hey the look checks for NULL, then, hey, different
> variable... good catch!

Ah, I also changed the summary from:

   "perf tools: Fix perf_env__find_bpf_prog_info rb tree"

to:

  perf bpf: Return NULL when RB tree lookup fails in perf_env__find_bpf_prog_info()

Thanks,

- Arnaldo
