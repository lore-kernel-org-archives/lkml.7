Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD32C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780822083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa85VrM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfFFSPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:15:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32967 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfFFSPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:15:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so2094441qkc.0;
        Thu, 06 Jun 2019 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5nO5rDa4yPixLM7AgPgljt35haBAK4Y1r/YbjeXL5Ys=;
        b=Pa85VrM31VYTWou0JhaPWxjocxeOkzivc8rROxURx3CJLn4R3eJF7pspjJmQXBuhhr
         sGxxYN2RVkfTx6RRyVrLHz/MW4EBp6BeTB5x0cOXeyL8vw+DYfD7J77hXV63FjIAO6Qs
         l3lisnLzne6zQt9fIEWpycxMHq4O2Z7zAN4hfcvnF/2rqPQQSI5KAu0xQ7cUYaI2+zeu
         cu+tCVR5uqrg5UrQhtVje7Lduq9Rf53THJF/bA9XQV3ejL1slA08Jsm/9cf2uTNrE9Lh
         bcz6nze/mF4RSphjrPeDUzDAK86hQdV4EyEYslrvJtaJKEZzIMY41qBPe97CYgryOwVm
         rhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5nO5rDa4yPixLM7AgPgljt35haBAK4Y1r/YbjeXL5Ys=;
        b=PWQWvGIHgxddodxwssLDAxGykAKKeVbOh3S3FF7VwiNncnp69gHqRg0n/b4mbJfZR1
         /UwyEZ6ZH4DIaM23X/bT12dLLQyaMjEEkdjot58jBH0Jr/aBalGmt0Gfrthp4NvOld//
         FBO6Gqr9sQrP+SNvSSxjgpgUXZR4mNBBVEKiEKp1AlzrJcVn7QdRFR1eoRYJvV6dGV5Y
         kaOSTKysk+KhZPE2wK4/UtmIhMylyAu4jSiOITXhCZ7Fhr2Lmq9lHeNbstGjZ69ogCyA
         MAs9o9sXwqjsAR+2slyD/r2++umbCqi9eYdsjs62TdazR0ppYm8JF6UIVZH/IOxQKeDq
         /wRg==
X-Gm-Message-State: APjAAAVFebeQQibec4A7uP1MVQrKt2ZMcC8ly8yMXQj30MSctuASm6tQ
        6Y5wiYZHokIQzwfjvCUtn04=
X-Google-Smtp-Source: APXvYqxRhNUcViEr9CRDA6L3nKw+GFozx37HXZkZ0om/iM3cT1tjpIcbNNTGYy/tqoATZ0FVZ8g13Q==
X-Received: by 2002:a37:bc03:: with SMTP id m3mr20969854qkf.199.1559844910462;
        Thu, 06 Jun 2019 11:15:10 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.209.167])
        by smtp.gmail.com with ESMTPSA id v41sm1666766qta.78.2019.06.06.11.15.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 11:15:09 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F9DA41149; Thu,  6 Jun 2019 15:15:04 -0300 (-03)
Date:   Thu, 6 Jun 2019 15:15:04 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     ufo19890607 <ufo19890607@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org,
        milian.wolff@kdab.com, arnaldo.melo@gmail.com,
        yuzhoujian@didichuxing.com, adrian.hunter@intel.com,
        wangnan0@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com
Subject: Re: [PATCH] perf record: Add support to collect callchains from
 kernel or user space only.
Message-ID: <20190606181504.GD21245@kernel.org>
References: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
 <20190606142644.GA21245@kernel.org>
 <20190606144614.GC12056@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606144614.GC12056@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 06, 2019 at 04:46:14PM +0200, Jiri Olsa escreveu:
> On Thu, Jun 06, 2019 at 11:26:44AM -0300, Arnaldo Carvalho de Melo wrote:
> > So that the user don't try using:

> >     pref record --user-callchains --kernel-callchains

> > expecting to get both user and kernel callchains and instead gets
> > nothing.
 
> good catch.. we should add the logic to keep both (default)
> in this case.. so do nothing ;-)

Yeah, not using both or using both should amount to the same behaviour.

Can be done with a patch on top of what I have in my tree now.

- Arnaldo
