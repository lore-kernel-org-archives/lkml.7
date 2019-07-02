Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DA7C06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A4020989
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrW1tDHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfGBPvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:51:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39097 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfGBPvp (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:51:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id i125so14495032qkd.6
        for <Linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mIWxYRc22+ugt+mOFaGt8B3CI/ZTBy55XFxSUnaUbpU=;
        b=SrW1tDHkt1EmmC9FfGAf47t51HUD1VVyjv7HBLv1c7zUOIYjubM3QYyqpWV+SkbZ39
         j7Ug9Rd5u6/FyzY3AOmMDb96rUxwOV7f/biUn+PUYZqVfSx2njY1W5/mcVge4GqefvwC
         C1FvnBvaB98dIQFwuveo/ODlJ91YF6zIu3y7g+UaOxwdYmhRuFqSogF6Msb0nv8TfVRt
         eNAFa9I6CK0QpkVe17VGKcajWFagv8g/pkx4Ph9dyjWGefaJUuMNrTFmOCEY8MXuXyii
         Z1UO18knRVpq2AVdi9AM+eLsylqHgN39s8dMiHtKqBqVux1nTfTaZosECmizLV7LD6sF
         yTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mIWxYRc22+ugt+mOFaGt8B3CI/ZTBy55XFxSUnaUbpU=;
        b=mJ7Yf0k7wxMO0jZyYinz7Ni83xuRf3OBDuN6/3/2Hc0p5Eer4sR+kYc3OfdeHlsRjV
         yZCCBUzEfwKMo0YNGeuZY02u1sZvj2zDfJFubX1gZJM35hakvVFSqkj5poAjgKzHq/Z3
         mg0duHQ2C7qZk2AYOTMnopVwX5g4ax3vTp1UeFClYPoEqiKxfwk3bIwCVwhUX2/CJD4n
         zlLkx+PUviLfPyWto7edbb4CU6ILJOOHRp/Qxl41IViyXQ9H7QZx7xhefm0XlN3oevYM
         Vbfaw2ZJoVdjc8sJfnPYGrqe43INVZpgJnnZxEv6MEAb6W8kzVBBUsntc/NAXIy76GZ+
         NCLQ==
X-Gm-Message-State: APjAAAURyY493G3p32MiOXOMzcUZg0AUrq/ny4Zfg3DcQYNHqdgPMli9
        algqGBqLxvoQIBqnNxE6Juw=
X-Google-Smtp-Source: APXvYqwhkQLuFLGmhGuf9I43Lq7LpibYaGe0QFBn0FZo9zBkZy5J6FNAtylba/DPo/zrKoc2VPQcyQ==
X-Received: by 2002:a37:9a96:: with SMTP id c144mr24614572qke.468.1562082704405;
        Tue, 02 Jul 2019 08:51:44 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id s44sm8346934qtc.8.2019.07.02.08.51.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 08:51:44 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BBEA241153; Tue,  2 Jul 2019 12:51:38 -0300 (-03)
Date:   Tue, 2 Jul 2019 12:51:38 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 0/7] perf diff: diff cycles at basic block level
Message-ID: <20190702155138.GD15462@kernel.org>
References: <1561713784-30533-1-git-send-email-yao.jin@linux.intel.com>
 <20190628080255.GA3427@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628080255.GA3427@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 28, 2019 at 10:02:55AM +0200, Jiri Olsa escreveu:
> On Fri, Jun 28, 2019 at 05:22:57PM +0800, Jin Yao wrote:
> > In some cases small changes in hot loops can show big differences.
> > But it's difficult to identify these differences.
> > 
> > perf diff currently can only diff symbols (functions). We can also expand
> > it to diff cycles of individual programs blocks as reported by timed LBR.
> > This would allow to identify changes in specific code accurately.
> > 
> > With this patch set, for example,
> > 
> >  $ perf record -b ./div
> >  $ perf record -b ./div
> >  $ perf diff -c cycles
> > 
> >  # Event 'cycles'
> >  #
> >  # Baseline                                       [Program Block Range] Cycles Diff  Shared Object     Symbol
> >  # ........  ......................................................................  ................  ..................................
> >  #
> >      48.75%                                             [div.c:42 -> div.c:45]  147  div               [.] main
> >      48.75%                                             [div.c:31 -> div.c:40]    4  div               [.] main
> >      48.75%                                             [div.c:40 -> div.c:40]    0  div               [.] main
> >      48.75%                                             [div.c:42 -> div.c:42]    0  div               [.] main
> >      48.75%                                             [div.c:42 -> div.c:44]    0  div               [.] main
> >      19.02%                                 [random_r.c:357 -> random_r.c:360]    0  libc-2.23.so      [.] __random_r
 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>

Looks really nice, thanks, applied.

- Arnaldo
