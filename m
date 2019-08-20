Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D13C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30B622CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbUe+GUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbfHTPbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:31:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46803 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbfHTPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:31:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id p13so4825550qkg.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=guwoATrhCzu2kgTL0+ayX7AjtEtN2NwXWclpihL9QXg=;
        b=BbUe+GUqQK3jNUaNRR9xdpfdI7gWivNWupHz1VdWz9isY6Gw7EF7RQvFVTjjvlxKr9
         L2oBKR5MaZw5eZxE4TE0LsCnrKcnm5PWVkZjGfzJLIOZPYM9XIuf8tck3ehYLlbDNLL6
         65DLtFBDeANB8mrbGgPbFKTfT1i/g5fqHWmdguiAs5bvKr1FdnBI5dW2nx/0eyjFDl0J
         xMqv5uPZqzx3rvjSvitQ2JTWe60z/Mlw9HAS5waRmNDv9JJ63r72yz7hVWBEk7U/RsZE
         YIrETffD2uJVgyqbJZM6vjUMkMaIreqNrrcF0RCY2Pe92uHfHTpOkNP8dXnByRuZJfHx
         +klQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=guwoATrhCzu2kgTL0+ayX7AjtEtN2NwXWclpihL9QXg=;
        b=BdD6SKF1dZL2ICr7UljK7tQrnDNRkq19q4sjuc7e48Cx9NaocV8DOhvfLvde2HPXL4
         fMaUms7wdvqorMV0eNu2UjhIYUlAyMrrcNnfR7CnZ66a6jp5FbLPUmcr8vSn+SXg1IJN
         W7kpFkiG7mvgXs+d+cZuq+ZVwbD0r8APEaBgFr3X0rKvZIKe29n4RWynsEvl/KKvKd75
         v2jXUMP4pgjhy3ywShgTeSl8nDocQCebGAd4PC2y/gC90GLiWUQL7gycnzrRNX3bWryF
         krnVZgt0qC8qnI2pf0TH+ivjwZ1pUEYcbqocfn19LND1J0hvYzCx6GHMRedB+HOmxH2o
         kcGA==
X-Gm-Message-State: APjAAAUsAJwbSNz9E7M3HBhDilAz2BSspJBYCrBlkHJRxOlSaNU84m2n
        lxofgzX4DGw5VnZGUWoWp4c=
X-Google-Smtp-Source: APXvYqzCCXZZeyN7Q8h0LZP/CP1tHqwPZlo0nEe/zK0GHsR+RBveUkMqM8oaCY7cEbmb0d1x18knRA==
X-Received: by 2002:a37:6248:: with SMTP id w69mr26409174qkb.225.1566315096105;
        Tue, 20 Aug 2019 08:31:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p3sm10115313qta.12.2019.08.20.08.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 08:31:34 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6329640340; Tue, 20 Aug 2019 12:31:32 -0300 (-03)
Date:   Tue, 20 Aug 2019 12:31:32 -0300
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] libperf: Fix arch include paths
Message-ID: <20190820153132.GH24428@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-29-jolsa@kernel.org>
 <20190818140436.GA21854@roeck-us.net>
 <20190818194032.GA10666@krava>
 <20190818212816.GA23921@roeck-us.net>
 <20190819082137.GA9637@krava>
 <20190820124624.GG24105@krava>
 <8e018cb7-db37-45cc-832a-1f3b499895fb@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e018cb7-db37-45cc-832a-1f3b499895fb@roeck-us.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 20, 2019 at 08:26:45AM -0700, Guenter Roeck escreveu:
> On 8/20/19 5:46 AM, Jiri Olsa wrote:
> > version) and we don't get the proper include path.
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Link: http://lkml.kernel.org/n/tip-408wq8mtajlvs9iir7qo9c84@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks, and added:

    Fixes: 314350491810 ("libperf: Make libperf.a part of the perf build")

- Arnaldo
