Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E09BC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C2A2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/51q0uH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441963AbfIXTsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:48:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40061 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfIXTsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:48:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id x5so3640573qtr.7;
        Tue, 24 Sep 2019 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SPba5f00bA5Cimvn7A4kcbHStjN/1bS/+JpQIlkNV5E=;
        b=i/51q0uHFXqzYFHL8RpIDws0mGFVQqDH212em5fsSMh7i8zQmln4RPc6v1mN0EI+i4
         NoYtV+27LFjKhkSZ5a50HqeubPQ44YIW9kpr3N34QuViDvzuQ7Cml/Q6QPGvY26DkPTT
         +TBNJ3+l3UY2cXL5UjTprril7ZZoUrGTUyy2us7NlJjfZTbeTHoG/LiLVhC4I4f0Dx5m
         BxTivPTxvZ0cQJrcUvIE5sqJYEn+Hss/mt6L4proUHhaKUYyxZ4C39ldyn/+J151UirE
         3wAyQrlzxDrQhlvJ/L4eEi/YB7CQhlljoeyY5uwJN3eA+qEOcb+aBTZlTOumTYk0C0qR
         vbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SPba5f00bA5Cimvn7A4kcbHStjN/1bS/+JpQIlkNV5E=;
        b=URNY8SoXBkoPBqDOkjRSJivjQFNUm+bJBRCtefiua+LRu7lgkzlh1M7R52yaeO46XD
         L7WcTUq65CqbiXiBvrpiRP6JiyTY1aJYQXwxsemtdKfSmCA4wNkh8jJPI1HVkNkdW/xi
         EVRy8dJ+G4xHTx4Gd6weDgUyEU1xISZBbNjdkTtbX5EWBegf11flqlMnWCU8jNy3o8qk
         2WH6KN0+Mmxdg1fJ9P3VYO4cnlbWvhxVW0eO37YNPhYnY551hOcdjZa0Ca7lPGUDLJSM
         hN+tFCCpmcsp12LpaWcBsVP1lM+sT2fJ7mXqGeNFRQCwWWgCJyjhGKW6NyZ/ntKvDtcP
         Cu+A==
X-Gm-Message-State: APjAAAWA2p12WBR4gdjF23y7JU2BtHpT2gWYxyEU246fYboq2tQgQrOF
        tqbJVSL3HeZe5CLWFvtXrAd4lA34
X-Google-Smtp-Source: APXvYqxRg+k+BBrk0alJEtKwkHqj/ZlH7lqrlG5spyoE6IXKupitKQIEy8kNt97dhl8PhQmLr0rhvQ==
X-Received: by 2002:a0c:cc14:: with SMTP id r20mr4083479qvk.61.1569354518038;
        Tue, 24 Sep 2019 12:48:38 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.210.60])
        by smtp.gmail.com with ESMTPSA id v85sm1391118qkb.25.2019.09.24.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 12:48:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E134D41105; Tue, 24 Sep 2019 16:48:31 -0300 (-03)
Date:   Tue, 24 Sep 2019 16:48:31 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.ibm.com, gor@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 3/3] perf/java: Add detection of java-11-openjdk-devel
 package
Message-ID: <20190924194831.GC20773@kernel.org>
References: <20190909114116.50469-1-tmricht@linux.ibm.com>
 <20190909114116.50469-4-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909114116.50469-4-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 09, 2019 at 01:41:16PM +0200, Thomas Richter escreveu:
> With Java 11 there is no seperate JRE anymore.
> Details: https://coderanch.com/t/701603/java/JRE-JDK
> Therefore the detection of the JRE needs to be adapted.
> 
> This change works for s390 and x86.
> I have not tested other platforms.

    Committer testing:

    Continues to work with the OpenJDK 8:

      $ rm -f ~acme/lib64/libperf-jvmti.so
      $ rpm -qa | grep jdk-devel
      java-1.8.0-openjdk-devel-1.8.0.222.b10-0.fc30.x86_64
      $ git log --oneline -1
      a51937170f33 (HEAD -> perf/core) perf build: Add detection of java-11-openjdk-devel package
      $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ; make -C tools/perf O=/tmp/build/perf install > /dev/null 2>1
      $ ls -la ~acme/lib64/libperf-jvmti.so
      -rwxr-xr-x. 1 acme acme 230744 Sep 24 16:46 /home/acme/lib64/libperf-jvmti.so
      $


Thanks, applied.

- Arnaldo
 
> Suggested-by: Andreas Krebbel <krebbel@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 89ac5a1f1550..3da374911852 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -908,7 +908,7 @@ ifndef NO_JVMTI
>      JDIR=$(shell /usr/sbin/update-java-alternatives -l | head -1 | awk '{print $$3}')
>    else
>      ifneq (,$(wildcard /usr/sbin/alternatives))
> -      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed 's%/jre/bin/java.%%g')
> +      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed -e 's%/jre/bin/java.%%g' -e 's%/bin/java.%%g')
>      endif
>    endif
>    ifndef JDIR
> -- 
> 2.21.0

-- 

- Arnaldo
