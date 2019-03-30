Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2046CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 19:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46242184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 19:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auAXiptZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfC3Tr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 15:47:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35135 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730917AbfC3TrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 15:47:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id s39so4842946edb.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nKa67LWTPWocUepnhGkFzFeiEdcOUiMiwS8lY32fIMM=;
        b=auAXiptZJLUV9qTK52GPUAtChEhVii/EmCsMRqd3MH4OQeZFiZ6ddCOToNW6ag337G
         jR3gG9tj5fjohOQ4cNAxzZcolcMsTVcGCkm8s5bIlAk4F5AA6wGW0YbS5/0bZJA7h0QR
         EwNeAPIn1Tbxug44zwqZL9jK+ouP1yl9ckFGHcMw6MFLkimcWoD7U8423ch/DNCPb08A
         GVxVTTEYCOL/zjbQlnQxsrij3MuKRe6OaM5qbJ7LK8mUVqfRi2mfSxQsN4BUYDJTgyV+
         ivIoddCGiXo8hmxDPOAx9w4bN3op+lz0B/Dx/tKWhp8ipw8alx+foiGtqL/Y00xhY/LA
         2CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nKa67LWTPWocUepnhGkFzFeiEdcOUiMiwS8lY32fIMM=;
        b=mq17XmjqEsnQABORzoHpDIdyGNzXrrhxJ05cMXoffqQCNXeC+F2+g9EHwXmZcYSpoD
         4Ck+7J3zIL6tZemqVsiYmCcgsm7tFYPbpYirP75kIO7/nuAuXlfYCdy0EY2kSnLGSaIP
         t6/fgzVEau4/av1bg9dQtkIuwbbKK5mwwK3A+d4nC717VvTwPNkicHhBVnU8Ym7d5JAH
         Tts162ParYXWrOa0cYkKibztzQlYqIMGRdftRu+qIaAuBb0g9mR5sU2uVWfYV8TcA0H4
         urqJ+Y/A0BkFOwNKlUpT3DURxn1vOfCHm2Tae+7B4JpLfsbT/f08zP479K5KXyQGhNTd
         W87w==
X-Gm-Message-State: APjAAAWo4JbIRPguRIsCFnQo8IYRJCIVwUrM9hCyHqkALKBdg4OB1nNF
        16cyM+J//UPTY2hDi+1sLD0=
X-Google-Smtp-Source: APXvYqxRFK6duJH9fMIfZzJn3IC9tBEW0JLyDWrXFAuFAr/LXM5SwKbDuKw/WxyuNTsz9u8rhYUvmw==
X-Received: by 2002:a50:e61a:: with SMTP id y26mr15364661edm.157.1553975244220;
        Sat, 30 Mar 2019 12:47:24 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4079:2f00:189c:4b38:83dd:60c6])
        by smtp.gmail.com with ESMTPSA id f58sm1726986edd.42.2019.03.30.12.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 12:47:23 -0700 (PDT)
Date:   Sat, 30 Mar 2019 20:47:22 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, roopa@cumulusnetworks.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] trace: events: fix error directive in argument list
Message-ID: <20190330194721.5v3r6txftc2zbla5@ltop.local>
References: <20190330181823.GA16263@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330181823.GA16263@hari-Inspiron-1545>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 11:48:23PM +0530, Hariprasad Kelam wrote:
> This patch fixes below spare errors.
> 
> Sparse error:
> make C=2 CF=-D__CHECK_ENDIAN__ M=net/core
> ./include/trace/events/neigh.h:73:1: error: directive in argument list
> ./include/trace/events/neigh.h:78:1: error: directive in argument list
> ./include/trace/events/neigh.h:150:1: error: directive in argument list
> ./include/trace/events/neigh.h:155:1: error: directive in argument list
> 
> Changes below two lines to signle line to avoid sparse error
>                if (n->tbl->family == AF_INET6) {
> to if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Thanks,

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

-- Luc
