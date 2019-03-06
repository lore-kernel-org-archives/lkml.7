Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6276C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A6520663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaVzluur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCFVHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:07:54 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42401 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfCFVHx (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:07:53 -0500
Received: by mail-qk1-f194.google.com with SMTP id y140so7718541qkb.9
        for <Linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 13:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0yhpOODBxY4dT6+OF0c0Z1tmwQN7zY3pqeTaj6SoLWo=;
        b=SaVzluur8CAnee8X7Jo3GBaYSypZtvBeEu3r1PjslbpwFINNMFxOnDAJlPUMHHkbry
         QddO9MdqqCxMVFmmDV7HDJCT9/TI1neB6XxpNMj+HhRPZhnZiCNg7P2JXUydw4Oampin
         clomfwVboZQM/pTBQxdRqBaF+VLS7KunEVnNCf+BZHCavQxlEsU3+85iJ7U34j3SBQCY
         q8ZPI+jlpiuGkghne2cO7XFrsx+vR1KOluzSieixRUiB22jzrX3pA/yNhWfgk2VQFlsS
         xFl5AEShokQuJoar7tT04tpyu4LJ5X737W0097SRMPp31W/L+jltjZhRcdeiMPKVTqJn
         eAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0yhpOODBxY4dT6+OF0c0Z1tmwQN7zY3pqeTaj6SoLWo=;
        b=XevGpXBPHbul+JAcTaQcLSRm+3yRsqjAAx4UefhA+qIXlu95bbvkqU/IMLkiuxyvT1
         iobVlKovphdSyB5lRlAqPjpdwDfWIBr1dnBbtjttWx1NYCkbQ6TrbdBU1/KuLh/brUaw
         qSgerS75ZUCMcV1rT2tGveL9E2JO7Ee0+TSjoWI9KIXcU6Tubqo7oesrnIEPm0Vi2uP+
         B4sgGcbjmXzyaEj2zLnZEpqCUW/4B31VtzJVPmxy8ACD13J66HPMQmJ24q/wPdzA4dcF
         M0J4OQp5anJjtwg8pfTr8Gc5k/0g2L4gEiCCHtME+9NOQxteiwBZVSuSP09oREyMwr95
         I5Tw==
X-Gm-Message-State: APjAAAWHFaO0xo0tqEhduKGZadTeluZ43DFx7kd7U8x8nJJMVZskW/Zf
        GSAH+MBo8K+sdU7GzvUlVqA=
X-Google-Smtp-Source: APXvYqysuzB6t4soIJQtCf08eGwn7aKbfMsGMeqn5mZyrQQz0qSzZIfVc853EthD1nt/oFxS0OhSvA==
X-Received: by 2002:a37:9a08:: with SMTP id c8mr7357929qke.224.1551906472265;
        Wed, 06 Mar 2019 13:07:52 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id r9sm1630850qkl.1.2019.03.06.13.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 13:07:51 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0E9B94039C; Wed,  6 Mar 2019 18:07:49 -0300 (-03)
Date:   Wed, 6 Mar 2019 18:07:49 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 0/3] perf diff: Add new filter options
Message-ID: <20190306210749.GL30734@kernel.org>
References: <1551791143-10334-1-git-send-email-yao.jin@linux.intel.com>
 <20190305123423.GA4533@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305123423.GA4533@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 05, 2019 at 01:34:23PM +0100, Jiri Olsa escreveu:
> On Tue, Mar 05, 2019 at 09:05:40PM +0800, Jin Yao wrote:
> > Jin Yao (3):
> >   perf diff: Support --time filter option
> >   perf diff: Support --cpu filter option
> >   perf diff: Support --pid/--tid filter options
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
