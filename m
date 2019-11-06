Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8673BC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503D42084D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek6Fpn7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfKFUIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:08:51 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46282 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfKFUIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:08:51 -0500
Received: by mail-qk1-f196.google.com with SMTP id h15so16106278qka.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 12:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fCV9fU/zI8CntGQaweBtFBlHytmapihw/wx6LSgjul4=;
        b=Ek6Fpn7uwlOTTDjhaVIEYQ6AOJRzgs7/jBbNHcTE1Imx3sXrMq3GyyIO7P1dSAHs5i
         p8w/jkICNkmX5xWnzlr9Jhkh/dg4lI0dPRFqZb1t5PsjUoSnnOvn9H/5zH5TUKQlxVlk
         9IEDYk133ddzAZkvHS4BB75cg5Pfb29N/ohcUyElEzo9VNHezp4I3CuJcvXSOcrzVC6i
         CQHzqF3B5OG+JDyccjqaeXCGrHJwCP4DGpzu8CaAwd9bYx1+YiPbYwkFIRgzX6QhMdvt
         wtZ/xBJRy31szOVNIc568j4NY1Z7cvM037V2xDCZBAvQkJ6VbkMHu+nAxk1M/hFtfg8l
         q5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fCV9fU/zI8CntGQaweBtFBlHytmapihw/wx6LSgjul4=;
        b=JY82+i/Ry2RLnx5JVqbbAMOkG3jD9OFtFrR4FuC0NHUn5VQc+/rMik17bls5+jB5Ll
         MS9x+lu1KkDgQycfboYLBwkX645koyBjQw6+zZqtiG/rf5zJkqhZ7L/fDaKe4EmeYIZW
         tbjVt9r+D2qWDbY0YEP/q1Ar0TY+PGkS3uHsvfNWG0PenJzvSH4+M21ejVRV+VOJ5VE2
         tniA40FwTga4jgc7UPf8qmjAdZ8DOhi2ixeSPlyFHY36sY6KoJEcCY3F6lPrOTmWdyr+
         FcPZ+j3i9GQTqCucAcZ/GP3ZQmtVQy6uoLfOydSM6ruMi4Dgcf0NtMHlmT5/f17rge0d
         Azxg==
X-Gm-Message-State: APjAAAUG/8gkGAJ9QR24rjG+GzYnro4pMrsjVChAo/UW/mMzCJERp/aY
        DWTqoNpJZjDqInKw63JaMag=
X-Google-Smtp-Source: APXvYqx+YRFqBtfh6yr+KC5YmUGYecZNLTD0oxwbsnmQseABm2Agt7rEBeeXtTDNKhVt5XS4q4uUZA==
X-Received: by 2002:ae9:ef4a:: with SMTP id d71mr3798351qkg.257.1573070928437;
        Wed, 06 Nov 2019 12:08:48 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-100-98.3g.claro.net.br. [187.26.100.98])
        by smtp.gmail.com with ESMTPSA id x11sm12618104qtk.93.2019.11.06.12.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 12:08:47 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2AC4B40B1D; Wed,  6 Nov 2019 17:08:43 -0300 (-03)
Date:   Wed, 6 Nov 2019 17:08:43 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 3/4] perf probe: Fix to show calling lines of
 inlined functions
Message-ID: <20191106200843.GD13829@kernel.org>
References: <157241935028.32002.10228194508152968737.stgit@devnote2>
 <157241937995.32002.17899884017011512577.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157241937995.32002.17899884017011512577.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 30, 2019 at 04:09:40PM +0900, Masami Hiramatsu escreveu:
> Fix to show calling lines of inlined functions (where an
> inline function is called).
> 
> die_walk_lines() filtered out the lines inside inlined functions
> based on the address. However this also filtered out the lines
> which call those inlined functions from the target function.
> 
> To solve this issue, check the call_file and call_line attributes
> and do not filter out if it matches to the line information.
> 
> Without this fix, perf probe -L doesn't show some lines correctly.
> (don't see the lines after 17)

Thanks, tested before and after and applied,

- Arnaldo
