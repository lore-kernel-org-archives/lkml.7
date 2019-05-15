Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8447DC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C892084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtF+5tgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfEOTcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:32:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37650 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfEOTcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:32:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id o7so1105994qtp.4;
        Wed, 15 May 2019 12:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gzpcBe/FuCRcBmmlscvWqZ1cuF+a9s/93eQ2vkoMdBg=;
        b=QtF+5tgNf9v/pOLbGmN/KkniYbjrTT3+zG+tsS6Kms+1PFJMvcfqBzH1n9jCpYjLPN
         rUJJ+CE6pK+4Csxpxh5JKbYHnYbwj2zKrcq8mt6Y+2O5wJ9y7cJ6X913mLznQu1+hmrA
         729oInNbB9ALcMRxLQigEACcaOaj0PEs9PTANqHWLj7reIDQJLX5BCeEvzKhegDNLTsd
         IjZkBfMCh9iyDLwT7Cw/hZbaIVRS61r9Hr5qf8c/gaLztb2dbtKL+YD+VxvtHaMhKSau
         IdtAJTdE3xKXUoXSUDusffpw6c8MSFgE9qgqzrMZacApD//bevsHU8IoOKtApxEzyOSb
         NXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gzpcBe/FuCRcBmmlscvWqZ1cuF+a9s/93eQ2vkoMdBg=;
        b=aNLCPIsLZXDzhdTxYCS6yPUAiB7ALABkYzif2Y9Bhw69axGVXN5ALzbrT+IFiMg6ex
         HRLIXN2XHfsZfhXsCoHf7y3XpSjM/6536rde7YPxK20xZjHXJwFMFQdYxKUxhyscKDPb
         Fo91HieR9FofiH+J7FjPM2T4IJqiCEc0vDHkD5uXI2sMCmLPA2ju2fbiWckezl9/tO43
         yg+Ie+zyCt+TM65bqDWGrIMBqQEUejfRj5rIX6RfcWP9Xd0kD5K6EWXxiFwFq1zPuRpe
         fsM7pr516JNItxN5UIPAZy7w7WYBeQuQFH5NyrTSg+1uk6QmI5fCr6CTUVoOR0Mxaw8M
         gMEw==
X-Gm-Message-State: APjAAAVsjInLD+nmAMfMAtRkbbUanB2N6usuPtuuLgj8PkTFqfPxPT97
        RpP+Rtesn/qJI/lVFxgTdX4=
X-Google-Smtp-Source: APXvYqzIAHhWJNUUfCmZY70fFSGLSaJ/WlMHpaIUQbVegDmEP+0LWpkvXn1BZFJ52H/pXcLteY5cbg==
X-Received: by 2002:ac8:610e:: with SMTP id a14mr35361096qtm.51.1557948740959;
        Wed, 15 May 2019 12:32:20 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id t2sm1426001qkm.11.2019.05.15.12.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 12:32:19 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 739F9404A1; Wed, 15 May 2019 16:32:17 -0300 (-03)
Date:   Wed, 15 May 2019 16:32:17 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf docu: Add description for stderr
Message-ID: <20190515193217.GG23162@kernel.org>
References: <20190513080220.91966-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513080220.91966-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 13, 2019 at 10:02:20AM +0200, Thomas Richter escreveu:
> Perf report displays recorded data on the screen and emits
> warnings and debug messages in the status line (last one on screen).
> Perf also supports the possibility to write all debug messages
> to stderr (instead of writing them to the status line).
> This is achieved with the following command:
> 
>  # ./perf --debug stderr=1 report -vvvvv -i ~/fast.data 2>/tmp/2
>  # ll /tmp/2
>  -rw-rw-r-- 1 tmricht tmricht 5420835 May  7 13:46 /tmp/2
>  #

Thanks, applied.

- Arnaldo
