Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C167C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED165205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZ5UgVsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfEBNNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 09:13:16 -0400
Received: from mail-yw1-f50.google.com ([209.85.161.50]:46050 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBNNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 09:13:14 -0400
Received: by mail-yw1-f50.google.com with SMTP id w18so1472099ywa.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pViPqJDl70Zz0sv9Tghpz5k7qN5ZAN+M/zCPCxRvjXM=;
        b=uZ5UgVsnGuD1YcajKed+YGLrlU/9Gy/HtRzyydbNnBS0nx2QtcOWBRebc9YEaSFJ2S
         tRTuthzdcHvU0iMnIZOf4687EK3yObRQD6Mtt3sW9sMhKg52/uFRpz1IA6sH0seaCX/S
         BdF9RyrVBIybgkD5aT6JHWN4GqJu5thrcIkOZ8berYia9FRbSr0cBf+YMtcY6uvBkiQo
         s17QKA6JJTnEyUwuZTXQFQtFScteQ4rqL9xSJnO69miNljs4QdV6u37AYJ4wDBz4qB+B
         vkBW4EJYDpoAVCgUr9u1cdctNo1FOqYU9PbKkiWvHXGt2I7AZNdGF0abIAaUVHSEj3n0
         P91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pViPqJDl70Zz0sv9Tghpz5k7qN5ZAN+M/zCPCxRvjXM=;
        b=Yjz4Oh73mWNHOnIKx3pIwGUjUHsgg+AYzbbU2MRyOoSUTP2S4fpyIuWdroA6bt5rqJ
         S8mH6lKLm3MnIrFluOA8IoKX98oR4MOYlhn2NK7XRlnITKCQ0yuvOtzzbEYYZSXtmaYR
         2YpAhw68NTM0oVBhTsfzkgO32GB3n8jCeoK9XX5BividNr+hElvfd1cABzU6khvZi1zn
         htSvUugwcoZgVj+1X40COGts2ORoRkjviHmpPX36itZ30+rpiV2iU8K1p8SH6jTwheb3
         B5F+JkoaeLmFeV4YLSGc2fHyW0G95YTJOby6Fsi/T9vDMYIah1aEcCOcR7TO6J8UDNnw
         bbRA==
X-Gm-Message-State: APjAAAWGxkcg8rzamQWtJsiytvMQ0d1/168zEhSPrlEi4ctX9ZnHYQD9
        1trzQ0wX/yTgWSFVM4O5TJ8=
X-Google-Smtp-Source: APXvYqyWUSGVi0iRqzUPNuLad811CF2v27gK1kap8qv72f01T40LwPNZg7n2CAqubuyIqOaF4SwaiA==
X-Received: by 2002:a25:e687:: with SMTP id d129mr2834387ybh.475.1556802793355;
        Thu, 02 May 2019 06:13:13 -0700 (PDT)
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id e75sm3585229ywe.101.2019.05.02.06.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 06:13:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 036CE4111F; Thu,  2 May 2019 09:13:10 -0400 (EDT)
Date:   Thu, 2 May 2019 09:13:10 -0400
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Speed up report for perf compiled with
 linwunwind
Message-ID: <20190502131310.GG21436@kernel.org>
References: <20190426073804.17238-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426073804.17238-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 26, 2019 at 09:38:04AM +0200, Jiri Olsa escreveu:
> When compiled with libunwind, perf does some preparatory work
> when processing side-band events. This is not needed when report
> actually don't unwind dwarf callchains, so it's disabled with
> dwarf_callchain_users bool.
> 
> However we could move that check to higher level and shield more
> unwanted code for normal report processing, giving us following
> speed up on kernel build profile:

Thanks, applied to perf/core.

- Arnaldo
