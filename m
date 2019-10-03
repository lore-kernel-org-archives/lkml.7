Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EB2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC03207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArVSWikM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfJCOMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:12:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35544 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbfJCOMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:12:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so3800611qtq.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GAXwKmJVlFM3nofz1SY4eFcik+zJYFJoa54xFISWulU=;
        b=ArVSWikMnrWcNsGfIhq8DSmkOBG68eLsO0RSwddcl/DB705piIXeHNyHF6PrJooYez
         h8IVriT415m7cBrQX4yCiOS8dnXXXHRQI1KnDTkWvnviXERHE13EEn03S98jjvsN728C
         DvRk7DSPjnNbYzpSGedP0hWi6Z5ZIRm6s40hgXjrJ/Rp12dUWA5A9N3+0+BCuyajKzbm
         k4/ZVsdwkJL4cVfib9m5TGd545QKZ3rUfFFLIYlbidsgKyf7k7n/PIJpFzCyQw7inO5c
         NOKeYOQDwLqKtjOLPAILqdGPX66iSXbHxjNJ2C62cQpE3WxrIU/ZaQrZVdOdQrV9W+nF
         Ts4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GAXwKmJVlFM3nofz1SY4eFcik+zJYFJoa54xFISWulU=;
        b=tgDoeuI5629vyaEt2HsEEyx4D9a5+IDEJu3Dnv6ggrIAsnRSaZQZB098u3OQIjgjq8
         G4UY4S57CmZ3tv2xi7NwP8spDTZjKzT7x7IhfK1LkLWa2sHUS45cRhiCG+p0ERvwNRwV
         RDjksqS0bg0NcnTgDLxass1LFn1yGXkrfdC9SSMhVtt44TE6vPPQ6sGMv0EiEkI2o1x6
         tcd21KSsMq78/VXP+qfTBaidF7AvSS1vaTMT6KiYbiCT9tIp7zurDPssWEp8WA9tyBLd
         MI+ztgGK/G7y+qFcYG/HU34QDN2AbA9D935Lq0GITj84KPiWd0ACw4KkjtApwrrOKdmA
         MMFg==
X-Gm-Message-State: APjAAAV845glWi55eeABhc0TuW0Xnk9fNAgzAyQOunHHOQG7Nuh2LkRT
        Kz12TJVfkbg0gKw1n66bNdc7zyCO
X-Google-Smtp-Source: APXvYqxqsnO6PM2vcL2CVFvSJuUsci4hI4yN0Qudwgxaz1V2MiMrglYmsJfBAeZy1OZeD0Ox/5OL8A==
X-Received: by 2002:ac8:5181:: with SMTP id c1mr10355387qtn.29.1570111949755;
        Thu, 03 Oct 2019 07:12:29 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 44sm1880699qtt.13.2019.10.03.07.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 07:12:28 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7864440DD3; Thu,  3 Oct 2019 11:12:26 -0300 (-03)
Date:   Thu, 3 Oct 2019 11:12:26 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf script: Allow --time with --reltime
Message-ID: <20191003141226.GC18973@kernel.org>
References: <20191002164642.1719-1-andi@firstfloor.org>
 <20191003101827.GA23291@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003101827.GA23291@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 03, 2019 at 12:18:27PM +0200, Jiri Olsa escreveu:
> On Wed, Oct 02, 2019 at 09:46:42AM -0700, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > The original --reltime patch forbid --time with --reltime.
> > 
> > But it turns out --time doesn't really care about --reltime, because
> > the relative time is only used at final output, while
> > the time filtering always works earlier on absolute time.
> > 
> > So just remove the check and allow combining the two options.
> > 
> > Fixes: 90b10f47c0ee ("perf script: Support relative time")
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
