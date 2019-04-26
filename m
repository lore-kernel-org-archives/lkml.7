Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48725C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEB1206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmtpikDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfDZOJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:09:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42301 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfDZOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:09:15 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so4181346qtc.9;
        Fri, 26 Apr 2019 07:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B5mTZcFcdM8rgguEU2ihFFpW8m9VvBsN84vvt4fsh3U=;
        b=ZmtpikDWJ3nAxEr7DLj5gNW2YQzGQFQN9aN980LBq++W4UHaUNZzvxBECpi3GewySp
         D9gs8IDe3vFJeOm/Wr7WvuMj2WMYhRl+sVfMNVPI5ZDUlbYb0R30DfCtOE6G++LfAWKs
         gIO3ClrevQYXpgc2LlW60FH/yqB1cdQOeuFIwUBQaM5ZjuhoVrlCSpG1PHXRSTO4SnUn
         V3Y0glCgaAjVLm5e9Y/jdMJIQNA78oNODV+O2KX5c70po0iWtaOgXlEpegbC1t7buPSf
         2EAm6AdSS2EINSDuWMW3QcQ1zkynIkevvvbg/XCtDuMC1TBJb5n5EmE3JcVhRbH4g1jJ
         hOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B5mTZcFcdM8rgguEU2ihFFpW8m9VvBsN84vvt4fsh3U=;
        b=q0fx5iFr9Tk8bhkB+eVwnpLC1QkJkGqHVmsfuNz/MvTS35eDaCUWsGnIL8vvsyjv4/
         yEt0VSa1ch6izt/CpwK1nwksawHuraH4kFr4Wbl3vUmsRqzl8vy8e3x9/7jUQ3e+x/Vb
         /QCIribHDADzD+CAwd01GBT7L59RNiU+57Cs6T8u9dSxadkH7w6gntA/589KsjGgu1/v
         FF0RwpHtJztC2MsLxj7GNpnfQB+2KymO/7xx51nXs4ZVgyZhJWjVoCcSS8h3TL942u+m
         FJe6+bI8ayoRdeAvHn59krgSDzVNu7yWXg/KE8jAfG3AdMPvUmc6iWAkxkfK9To4LlMA
         Qf1w==
X-Gm-Message-State: APjAAAUvUAHjsxS5bAHC+6bIDXCOEdbX3RLXXo2OXMHeKa/15fv6E4SY
        wJ/QkM1z3VrQsfS/fmZFfNk=
X-Google-Smtp-Source: APXvYqziaw7BpxBBKxCagCyelVZt/sw43wtVSzs/dtD4jG+Np5hBekOWtpDwMIW+HTvLZxLz0pe9gQ==
X-Received: by 2002:a0c:819d:: with SMTP id 29mr10936628qvd.73.1556287754242;
        Fri, 26 Apr 2019 07:09:14 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.182.215.10])
        by smtp.gmail.com with ESMTPSA id k36sm960266qtc.52.2019.04.26.07.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:09:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 976784111F; Fri, 26 Apr 2019 11:09:07 -0300 (-03)
Date:   Fri, 26 Apr 2019 11:09:07 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jolsa@redhat.com
Subject: Re: [PATCH] perf/report: Report OOM in perf report status line
Message-ID: <20190426140907.GB22086@kernel.org>
References: <20190423105303.61683-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423105303.61683-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 23, 2019 at 12:53:03PM +0200, Thomas Richter escreveu:
> An -ENOMEM error is not reported in the GTK GUI.
> Instead this error message pops up on the screen:
> 
> [root@m35lp76 perf]# ./perf  report -i perf.data.error68-1
> 
> 	Processing events... [974K/3M]
> 	Error:failed to process sample
> 
> 	0xf4198 [0x8]: failed to process type: 68

Thanks, applied to perf/urgent.

- Arnaldo
