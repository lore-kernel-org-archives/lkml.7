Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DDAC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FD6217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKUagXxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbfKFUEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:04:11 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:36429 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfKFUEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:04:10 -0500
Received: by mail-qt1-f174.google.com with SMTP id y10so28311887qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 12:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Syvd9OtNpcXiNUdc2Ks9QJdKdCRXCjH9isxgWic1uto=;
        b=SKUagXxE3aHtk6zXf03B6K9HgYRdjVe27Aj68kyYDQALM45zhfcD8mP1NABiAZCoDm
         LdyANegIr7Uua4/fB8Xz6qdpk2ik8QSkT9UIIwtiGPLzMwG3f3LPLVGoQ/7pJdSPi4bH
         w0mYwWNOLcvNyTRaIPa9RLXJ3oZIZHCAI9TFK85ZdD8TeP2txhm1cfZoazJLKmUYokY3
         xkpMfxQHEWFZqIBWlK+wE8wBKwCuRwt4yV5B7eGYkk/aDM+EvtUaPbWg+uuaeZdXk55l
         ZPWFtigum1Xvc4myBZRW+dFXYDgXUEhC9vZVz4875W2aDqbJ4CDnePdjhsoILz0Csvfa
         +ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Syvd9OtNpcXiNUdc2Ks9QJdKdCRXCjH9isxgWic1uto=;
        b=eDpM/fY89gZkjSkp6tb1DIWWIkreohmKov/I2mfDf6QgbB4NY9BHLlvD7MicfgnbKT
         /pcilnZ6ULiQYGd5J7I3Q48OTb1KqZG0cITYUI5qtiw5o4FgviMxDfHki9u2TI16ym/g
         pR/6LTYdbL3vw5i37jQq+1uFS0beZeeI/q1L9LfYHnb4S3/0I8sFxjNf6ZaG5vE+w12i
         LIBaam19mYIQBGU2yvCrvOQKbxTjYOsZeZKcFxNe5rpYJYl+u6JFMPcXnZXaQqG+li7C
         y8jv2Qvd9CEjfAmJ3HplESb8jlfCRce/0irZd8jXxAbqM2UHw1Srg4TroIpB2q8ul6HB
         NnUw==
X-Gm-Message-State: APjAAAWqZpRpRZujmogkooHQ4RfiNg+NV0OromZYdrwaCpJMJrABWomv
        /6ACzwnmKmwVJ0nBSrkMpLM=
X-Google-Smtp-Source: APXvYqxE8neSG3qy+YpgpyQUKpHWzoIuV5JYwTwYaNO1iBJb69vcybbOqfBa2f9eH6tOapNfyzz8Vw==
X-Received: by 2002:ac8:51d6:: with SMTP id d22mr4287228qtn.102.1573070649831;
        Wed, 06 Nov 2019 12:04:09 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-100-98.3g.claro.net.br. [187.26.100.98])
        by smtp.gmail.com with ESMTPSA id r80sm5832652qke.121.2019.11.06.12.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 12:04:09 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9B21040B1D; Wed,  6 Nov 2019 17:04:01 -0300 (-03)
Date:   Wed, 6 Nov 2019 17:04:01 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 1/4] perf probe: Skip end-of-sequence and non
 statement lines
Message-ID: <20191106200401.GB13829@kernel.org>
References: <157241935028.32002.10228194508152968737.stgit@devnote2>
 <157241936090.32002.12156347518596111660.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157241936090.32002.12156347518596111660.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 30, 2019 at 04:09:21PM +0900, Masami Hiramatsu escreveu:
> Skip end-of-sequence and non-statement lines while walking
> through lines list.
> 
> The "end-of-sequence" line information means
>  "the current address is that of the first byte after the
>   end of a sequence of target machine instructions."
>  (DWARF version 4 spec 6.2.2)
> This actually means out of scope and we can not probe on it.

Thanks, tested before and after and applied,

- Arnaldo
