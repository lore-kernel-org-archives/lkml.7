Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0EC206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1lIcDN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfCKSRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:17:30 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40494 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCKSR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:17:29 -0400
Received: by mail-qk1-f196.google.com with SMTP id h28so3297569qkk.7;
        Mon, 11 Mar 2019 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=etZJriD3PeivOCYKmhhwVNUC+UxpgKf3v+fm/BPssXI=;
        b=G1lIcDN/q+QCGmZUhDtB2f3wuD9YJddY4GGjadpi5d6/jiEHH4P/gP/XZ+Sj7kokj1
         rVoP24rMxpyP3SInOtjK0OL7rgey+4DnZaSvtmKBjnxW40TGmwyUKwl76bhYDzf/Ayr2
         8bsLPRlZbG4WXW7V7//7g/mIgWzfW6ZyB43tBobVoK2UwnN8r08980sj9yx9A8DhzDBk
         KnhiFCCtb6Wli+AbTGXBjfgvW6oiulUZbDdhRJGcUWG78gUntr0q25DBq1WcHpZZSUJw
         IYEH6nqjG+TXr4wDUuiBtPQaUpXmaWCQB6EsmoZdOSsaGenqCNmO24Fwvz9xEB3XZEnj
         geCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=etZJriD3PeivOCYKmhhwVNUC+UxpgKf3v+fm/BPssXI=;
        b=hCEReWfdCeS5Ub8q3w6g5ifVyv3Kn7LoU0ItD5Fz9Qd5vN1lBTkUXnOz2hSvUal5ij
         tjhVCOcP4Zs70GOlagSCh5NT+rNLIigHkRAhFU5qyk6Z4FYsZJiRnCfMg2jjqqBQJ6Ir
         dPPRpNsr/TjTpR341elFCbCpncb1Op9bdwkZe9QoQr5PCzyyTlooy7hpUcUW+2q55x4K
         1XS8PxLa4zojdGZPUAZY7JLPKQ50ZTgyGba5ts+mkpiwCwQeSUeCEtO2mCgf/hjqlXoT
         4qRdHjOIZGgy8CNwDRkR2Isn2UWmVJctPRDHkpV1dJvEUvTbVl1XGIu/mdCldcFtRHJ0
         4Zeg==
X-Gm-Message-State: APjAAAWn94dJh0VMhaLtoB0koMRWLLm13yLxRD4drX/gJdyIrJPrcPzE
        efN61UBPqkLSrtn+KyFGh2Ikz+Pa
X-Google-Smtp-Source: APXvYqwryzX33cl90KADZtbGGooZ6Y2iVXaQCkxLkDWk43RVVl0mC0A2I2YenAoNP7ML3xmXjlilpA==
X-Received: by 2002:a37:360a:: with SMTP id d10mr24694045qka.83.1552328248346;
        Mon, 11 Mar 2019 11:17:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.162.132.204])
        by smtp.gmail.com with ESMTPSA id n3sm3662771qkf.93.2019.03.11.11.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 11:17:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4E9AA4039C; Mon, 11 Mar 2019 15:17:24 -0300 (-03)
Date:   Mon, 11 Mar 2019 15:17:24 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 11/11] perf tools ui: Fix ui popup browser for many
 entries
Message-ID: <20190311181724.GU10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-12-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-12-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 07:45:02AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Fix the argv ui browser code to correctly display more entries
> than fit on the screen without crashing. The problem was some type
> confusion with pointer types in the ->seek function. Do
> the argv arithmetic correctly with char ** pointers. Also
> add some asserts to find overruns and limit the display function
> correctly.
> 
> Then finally remove a workaround for this in the res sample
> browser.

Applied and added this, please do so next time:

Committer testing:

1) Resize the x terminal to have just some 5 lines

2) Use 'perf report --samples 1' to activate the sample browser options
   in the menu

3) Press ENTER, this will cause the crash:

  # perf report --samples 1
  perf: Segmentation fault
  -------- backtrace --------
  perf[0x5a514a]
  /lib64/libc.so.6(+0x385bf)[0x7f27281b55bf]
  /lib64/libc.so.6(+0x161a67)[0x7f27282dea67]
  /lib64/libslang.so.2(SLsmg_write_wrapped_string+0x82)[0x7f272874a0b2]
  perf(ui_browser__argv_refresh+0x77)[0x5939a7]
  perf[0x5924cc]
  perf(ui_browser__run+0x39)[0x593449]
  perf(ui__popup_menu+0x83)[0x5a5263]
  perf[0x59f421]
  perf(perf_evlist__tui_browse_hists+0x3a0)[0x5a3780]
  perf(cmd_report+0x2746)[0x447136]
  perf[0x4a95fe]
  perf(main+0x61c)[0x42dc6c]
  /lib64/libc.so.6(__libc_start_main+0xf2)[0x7f27281a1412]
  perf(_start+0x2d)[0x42de9d]
  #

After applying this patch no crash takes place in such situation.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
