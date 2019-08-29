Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3770C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AA92173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qm/Qj3Yo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfH2Ptj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:49:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47033 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfH2Pti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:49:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id p13so3313278qkg.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kTnRGX4CQHJiBll95P9hsE05TNbCN+WdIg3CKHOfsDg=;
        b=qm/Qj3YohE6wjpRilEMsaI2q+P/lO35PVoGesy5vfaQXFcwRMGzYsqRwoa430LXpvX
         3QV4iYeCG6YZ5cDaSnxa9pMCR+DUcsI6rdoXhLtxE/K8A9QvXFHbWJKCVWyQkufhXpR8
         0177AdJr63KOaPZIsPQXWq4+un3J3YDj4P+RCkoNn1jsukWEaodrAPnVf7tfbqt95Q20
         io/vWONCnA5Xv+xMrlu2PbWtqgQ8wE9V5/em/+wopCDa6gto03UZNgVqkadTwOP2QeJa
         LOszYzAf1thEx7OVMYLQQUbCkMGcIvUUIRIfAHVtjDlSSpEqfBatgMEQ1m8w8vgU8mlt
         8TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kTnRGX4CQHJiBll95P9hsE05TNbCN+WdIg3CKHOfsDg=;
        b=rE5Q59dKp86w4V8vU+zy6hVBLm0Oo+hprbu4R535q8gAWlLaphj2ZnicvKxR24yLjy
         X+ydj3vZJtQnSJ+MzRTo8Ozv1RCSnRpxIFHeIoRw7AzeyFbqji6aqWqT59Uw+gp7nlJx
         qh3DIoyh/YlJYIeCBjKgogMO0kUJnlK96cxNETq+FJkDZRbg/CGjgDtdCJXGbIMvckxJ
         GKe3BZLzzuGcK9wWVcFZ96lIcYaV4mrLTUQV6rf2pdPEcmXDCBeFv3AOs2NtGHq2lUXP
         om4E+AwjRQSIwmb8EOjLLepSJfA8SNCu48SkRsTyBo7EBNaKB2F90pyn/Bl0qfBZHcbl
         ZDgg==
X-Gm-Message-State: APjAAAWcS/echuBg0oxJ+P42ZLe/iFryhIhjgeFWnu+G/ov/QHZ8sMz/
        Lf43RNbsu1ACLsruVABVTZ8=
X-Google-Smtp-Source: APXvYqyBEmnzZEin+yH2bUzFqUlYH9v1QzYHsw0GupMhNyMnWuIsC6/oQmRvuFLFxg0qAKt4zNZMFg==
X-Received: by 2002:a05:620a:14bc:: with SMTP id x28mr9953515qkj.116.1567093777400;
        Thu, 29 Aug 2019 08:49:37 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id z72sm872092qka.115.2019.08.29.08.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:49:36 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC75F41146; Thu, 29 Aug 2019 12:49:33 -0300 (-03)
Date:   Thu, 29 Aug 2019 12:49:33 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Kyle Meyer <meyerk@hpe.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Russ Anderson <russ.anderson@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH v4 1/7] perf: Refactor svg_build_topology_map
Message-ID: <20190829154933.GA27286@kernel.org>
References: <20190827214352.94272-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
 <20190827214352.94272-2-meyerk@stormcage.eag.rdlabs.hpecorp.net>
 <20190829091122.GA10127@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829091122.GA10127@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 29, 2019 at 11:11:22AM +0200, Jiri Olsa escreveu:
> On Tue, Aug 27, 2019 at 04:43:46PM -0500, Kyle Meyer wrote:
> > Exchange the parameters of svg_build_topology_map with struct perf_env
> > *env and adjust the function accordingly. This patch should not change any
> > behavior, it is merely refactoring for the following patch.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Russ Anderson <russ.anderson@hpe.com>
> > Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> 
> for the patchset:
> 
> Reviewed-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied to perf/core.

- Arnaldo
