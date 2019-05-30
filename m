Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4756BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C3921670
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEkYKR3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfE3M6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:58:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44549 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfE3M6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:58:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id g18so5460045otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xtj26eS6VSA28N6pJF40jIB52D/4p8VvWoFMN8kmTto=;
        b=gEkYKR3eOQ7KZl5uQnNYgFRumtLun0ACBfXduK4oHrRcgWCyVGlvMXW7FfqSYHctQi
         /mjV/Ut3fgbU9a5DFDasyQBLj8Awej+i8PygRIljiAnORYlaXkFD943Syfmdy4icSiVM
         j9DCeXHIHTFtkwbEX2UrsVUXJ/z6HSc4xudXsd7XhBGZfgRfalgwWHsdeGCcrzjCiSOF
         zBiC3BQVgW0qAuRHwRkFoHxE+9rstBQ++Z0sdAUSQeFRVi5JYjUzox+UymPLv7E79TMx
         Ps7TUMNBFWYfapKeJXK1oGRf3K0kiczitP8HgSXf9APQCdwNok2ASABerxMnw00thhSV
         /XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xtj26eS6VSA28N6pJF40jIB52D/4p8VvWoFMN8kmTto=;
        b=Y4glO90Y95SRf61NEUAVM701PDtOSjRO3hGTtXaojF7Ks+4zi0deZdHg/hMZei71Bt
         3py7386kAxTFuYBUOk4QVBNDNQevKxsjy6kpVd7xksaOAvyc5esTEgzn+rpGc18a9WR4
         aeuVebtkMjrSRHw5dmYwYYcHaIu93vjKk4PcrQjH6p7vYm4nnqq8LUXHK/7Y68HyPq0q
         xtsn4yjTCGHdaDw3+4Z2v7LvNbVsrGLc+dE0gplNCz0kYp6d0hyUJPxuNOZ3TXCtXrjw
         ICjlZRdNxVh9gOkPLF9gnatKbqdTk9PP41XMBsG/4YUaZ27OHdQMNzJD3HCDr6GA3BJO
         HoAw==
X-Gm-Message-State: APjAAAWw4mGaxDPzSz/h/pcoNCqDng1l75Jr7/2MuX8jC2L9oQy6u67l
        m4EBQjwMSUexIzpaEr8wnhBMJw==
X-Google-Smtp-Source: APXvYqxFhmDlPzIwjL/pN4OQ2ZZlrSzuFeHJEPPgkIPMQXw5dm1SUGB/4xexszLTzjydWrHWi3IiIg==
X-Received: by 2002:a9d:7d13:: with SMTP id v19mr2354403otn.234.1559221111220;
        Thu, 30 May 2019 05:58:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id j62sm1050197otc.31.2019.05.30.05.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 05:58:30 -0700 (PDT)
Date:   Thu, 30 May 2019 20:58:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf symbols: Remove unused variable 'err'
Message-ID: <20190530125825.GC5927@leoy-ThinkPad-X240s>
References: <20190530093801.20510-1-leo.yan@linaro.org>
 <20190530124302.GA21962@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530124302.GA21962@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 09:43:02AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 30, 2019 at 05:38:01PM +0800, Leo Yan escreveu:
> > Variable 'err' is defined but never used in function symsrc__init(),
> > remove it and directly return -1 at the end of the function.
> 
> Thanks, applied.

Thanks, Arnaldo.
