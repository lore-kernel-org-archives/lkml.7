Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDCAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC6F222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuAiRWty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfKRWDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:03:09 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33196 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRWDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:03:09 -0500
Received: by mail-qk1-f195.google.com with SMTP id 71so15974418qkl.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 14:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qX5DH9AG2LN1bN8jEt/hCStpS53kFph8AgR49AHtTDk=;
        b=QuAiRWty2/dKXCHJe+/MvPCgjosZ+7oTjeYbpDI+6hZm/rRt3bgwphWgk7F8s65kgi
         RA+8EBBcN7AIK1cJrc8xyF6ConUVr+wBZtaJEFEERjgjDvgfSDMIRs7mAGueRpXHt+eM
         O2ejatO0sboGxlUIHwOknYFySmDnC+dBPZ0E5c3Fi++xMohjx6N4ypOd7CpZv+mKFUj6
         F9VZJIIQAa3TmBWCu8IS3QlE/Oe/TV7ttGUIhL38v9Jrv5mKitzm+zsDbgcGQGO0AMQQ
         XuYn9xVa2xPG3ivfR2PazuFTgnUzYec6VgfTE9maC621Ev7sIKBJE6/f8bLhRSDO2u34
         sTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qX5DH9AG2LN1bN8jEt/hCStpS53kFph8AgR49AHtTDk=;
        b=SQRdKx3Atwn/2qyHfnXM9iG4KujJ8infqV4Sxc0/iGOQ/baKyVvGQC+iL3kYCGTaJP
         97vSGgPEDvZRi5Zb4tQ7E4MON71QVuKWdjpcL+6XGGmIyLXzF9l8SjS8ksws0vME5U69
         ZsXTWPzjNutyVCTh6y5jFrBhlQz1htBpVKyD3C/z12DlVq+9ea8voK49dlngkNUtPv/5
         jEOQ3fVcR7T3Q3xv2dD6fZDW8nOIha2bA35IUN0XtG98y52BK7lPQMiGlXc6+IVTR4PF
         JLy8m+CcC1Q9H5fb2QQ4gMJoCijwuA7wnviJhy2SlAoX9lxOOyXmPsKFtHjbhotp/ndd
         kuWQ==
X-Gm-Message-State: APjAAAVclBJ60hlybt5iuQ9i+oh3TBWoRg7zgXss5x7K0BbQLPWfRX27
        OwQZLkTJbVyplsJnEFvWhj0VddSg9V0=
X-Google-Smtp-Source: APXvYqxAf6mAEjqtl3meItTFoMIUhc+//pKRtngoDbZBTFACBYCNLEdye/mbfBlIMRIDgR4fxUx7Fw==
X-Received: by 2002:a37:624f:: with SMTP id w76mr16173898qkb.50.1574114586903;
        Mon, 18 Nov 2019 14:03:06 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id y24sm9089711qki.104.2019.11.18.14.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 14:03:06 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 85C8940D3E; Mon, 18 Nov 2019 19:03:04 -0300 (-03)
Date:   Mon, 18 Nov 2019 19:03:04 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 4/7] perf probe: Generate event name with line number
Message-ID: <20191118220304.GE20465@kernel.org>
References: <157406469983.24476.13195800716161845227.stgit@devnote2>
 <157406474026.24476.2828897745502059569.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157406474026.24476.2828897745502059569.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 18, 2019 at 05:12:20PM +0900, Masami Hiramatsu escreveu:
> Generate event name from function name with line number
> as <function>_L<line_number>. Note that this is only for
> the new event which is defined by the line number of
> function (except for line 0).
> 
> If there is another event on same line, you have to use
> "-f" option. In that case, the new event has "_1" suffix.
> 
>  e.g.
>   # perf probe -a kernel_read:2
>   Added new event:
>     probe:kernel_read_L2 (on kernel_read:2)
> 
>   You can now use it in all perf tools, such as:
> 
>   	perf record -e probe:kernel_read_L2 -aR sleep 1
> 
> 
> But if we omit the line number or 0th line, it will
> have no suffix.
> 
>   # perf probe -a kernel_read:0
>   Added new event:
>     probe:kernel_read (on kernel_read)
> 
>   You can now use it in all perf tools, such as:
> 
>   	perf record -e probe:kernel_read -aR sleep 1
> 
> # perf probe -l
>   probe:kernel_read    (on kernel_read@linux-5.0.0/fs/read_write.c)
>   probe:kernel_read_L2 (on kernel_read:2@linux-5.0.0/fs/read_write.c)

Thanks, tested and applied.

- Arnaldo
