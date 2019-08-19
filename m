Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AF9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E27214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVBvYX/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfHSS7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:59:10 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39728 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfHSS7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:59:10 -0400
Received: by mail-vk1-f193.google.com with SMTP id x20so689205vkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fXNOphaX+y8oyFeRNQ0wqgARKD5Ut7+H76ilztOg7So=;
        b=LVBvYX/gcgWw5amonPy2m92xaFUOHzEiygj1Vd6/QCdl8ZTOYR2UsUxGcWGTKlTPlY
         pd8NlXPHdiic+ao0+120qLLkSpaAh1zRE6T2IGM/uEL1LJTFMALZJdAKBpJ3R3OpONK5
         MEdgjjDJznjB9o3R6z4y/srChFlOlMJsggvtMBlrCb/3nDGxtu5Vj5rmqBVSx/OmHkD2
         f/N0u7VU2YzfOIvlpmJJikwII6AakgoON9SxddFz8qML14bOVjfOVinzxDh6FTlbpJpl
         dH8u+p9S2A+JOh4YWQ7zsrTSclw6BKJ7/TR+P9hF0DZar/Bky+Qw85hwtNR+JKsbunuM
         D3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXNOphaX+y8oyFeRNQ0wqgARKD5Ut7+H76ilztOg7So=;
        b=ejCPlLMIEkDob6xeQI/E5j931VIiDjgfrmPa803H5sbHZntkA4lXjPo1URRXWEKiyf
         s/Y7y07kuuPS5uI6jVCfdZ19DpenLW8+J7ReNYu/rxBMOcP6wPQFcKYJn7q09OLUQUAP
         JZB2jcn7FqG1/ye5BYk69S8cMXpqkNVkn6KOhbBbLwXEfMXpVpYHcCcysd7p8KUK74xr
         Zc8gp6xn5X9lOHHeXY+vDxY0t0a/LzBQyypWaD6LuVcIsh5HH9gT3aEFsfYFHNIkFvn7
         GdTXF2BvE8sgNC0qDGCPbPO2sncxggD1DJFgNLQED1U1Kwuk0zaZrXXpcNcZo8b/bcO3
         x0SQ==
X-Gm-Message-State: APjAAAUnkDxBFNqsCeFYDSBBDwRsM0gGyU7LfdfxPpOwxiwM/U4AT79P
        N7vCTAhAeZWU2KNWd85fxHXqucIjj9k=
X-Google-Smtp-Source: APXvYqzHU6ucERBErz5EtBBX63jd3J6DoCua7Eqt4bNOZ+HjirAEW6nz7+gJscCtjWR6qB5l0ZNcDg==
X-Received: by 2002:a0c:fac3:: with SMTP id p3mr11824021qvo.237.1566240658181;
        Mon, 19 Aug 2019 11:50:58 -0700 (PDT)
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br. [177.206.236.100])
        by smtp.gmail.com with ESMTPSA id j78sm7288915qke.102.2019.08.19.11.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 11:50:57 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C8D2B40340; Mon, 19 Aug 2019 15:50:54 -0300 (-03)
Date:   Mon, 19 Aug 2019 15:50:54 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH 1/2] perf cs-etm: Support sample flags 'insn' and
 'insnlen'
Message-ID: <20190819185054.GB3929@kernel.org>
References: <20190815082854.18191-1-leo.yan@linaro.org>
 <CANLsYkx5TanDyztpceZvwf4pZSgoqRMOBgiHcdJxxpnGA9-h-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkx5TanDyztpceZvwf4pZSgoqRMOBgiHcdJxxpnGA9-h-Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 19, 2019 at 12:08:26PM -0600, Mathieu Poirier escreveu:
> On Thu, 15 Aug 2019 at 02:30, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > The synthetic branch and instruction samples are missed to set
> > instruction related info, thus perf tool fails to display samples with
> > flags '-F,+insn,+insnlen'.
> >
> > CoreSight trace decoder has provided sufficient information to decide
> > the instruction size based on the isa type: A64/A32 instruction are
> > 32-bit size, but one exception is the T32 instruction size, which might
> > be 32-bit or 16-bit.
> >
> > This patch handles for these cases and it reads the instruction values
> > from DSO file; thus can support flags '-F,+insn,+insnlen'.
 
> The code seems to be correct.  I have also tested this patch.
 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks, applied.

- Arnaldo
