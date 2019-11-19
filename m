Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9E2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E666E2241E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="sQhEDOK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKSTCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:02:52 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34618 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfKSTCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:02:52 -0500
Received: by mail-qk1-f196.google.com with SMTP id 205so18873214qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 11:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nOtlx8W5kFFOHYOOqCInicVcS9VMgxzZJDB6vPZYj8Y=;
        b=sQhEDOK4h+CjNaAZJ9SFqIFRU0lboojWtdHt3nnRoeYgfxiMCtz9gtLqjnu3lw3Rfx
         qgeYu1QBVnZIytPjZBXhr9qU3GO+4sKhsDZg7xFANVamLGatVP/HrFrh1MKqnZooAnFA
         hm1/LCDx1vxUMZEbMG3d+Hwj+JIU4g2ie4V6LqnKMULSN1r2g0v2f5e2DL/X3gOxZvgl
         mXkIk/zjztybwsp0TuSuWidAjNSc7nI7lD5OUOpCASUZ/8uACLWmbFS4otqJCIK21c+i
         etNf14xwCT/4kJ787XpYK/YYl17I6F4BNO1Z+hK0y33+kQmz8JWW5AfhCBdLVfTA6blx
         qseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nOtlx8W5kFFOHYOOqCInicVcS9VMgxzZJDB6vPZYj8Y=;
        b=oOXLMyN6mdGYaPrxg/yIBC/7PUzq7xLiB1aZCUaDMU5lEVhlwgEBvlbEaYAvoz720T
         NQMq1xOj64xse+hllYaQ/vx9nJFV2Xq7bvFVK+/I/nSWZRat8ReinPlOO2biO8CBjCHA
         aAeYkuQlc855y1UjYC3ch6e1sS1XggqFJT/n2Dw63jD55wxCDYZco5qtIw2OcEle3Pto
         TvGzZ/gpuFlq81Pv7yjfuvyqtlhZ256FUTuoNscqy1maJtoVxzub3J2FZ7yTs0GsxpOd
         E4WAWGTd+apt3nOiug/yAeoi3QKPB0oovFakwMYF5TonQ7cERLOyl6RdiDlrApdVntPA
         bfwg==
X-Gm-Message-State: APjAAAW64TmM3dHeom5NlhopiCSsCMo32w6scKBV8gvGRWOkpZoHNHNd
        xKhyKqdBPMFPBMcDe8yajy5MJw==
X-Google-Smtp-Source: APXvYqyD2BKIzD//N3zQpcyJ1rmzra5E3wCaew6QFo/eNzHpGF9HocziQ4dVo4GzBFaAv8YiYlh/eA==
X-Received: by 2002:a37:6643:: with SMTP id a64mr31950602qkc.144.1574190171109;
        Tue, 19 Nov 2019 11:02:51 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w5sm10384776qkf.43.2019.11.19.11.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 11:02:50 -0800 (PST)
Message-ID: <1574190168.9585.4.camel@lca.pw>
Subject: Re: linux-next: Tree for Nov 19 (kcsan)
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Date:   Tue, 19 Nov 2019 14:02:48 -0500
In-Reply-To: <20191119183407.GA68739@google.com>
References: <20191119194658.39af50d0@canb.auug.org.au>
         <e75be639-110a-c615-3ec7-a107318b7746@infradead.org>
         <CANpmjNMpnY54kDdGwOPOD84UDf=Fzqtu62ifTds2vZn4t4YigQ@mail.gmail.com>
         <fb7e25d8-aba4-3dcf-7761-cb7ecb3ebb71@infradead.org>
         <20191119183407.GA68739@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-19 at 19:34 +0100, 'Marco Elver' via kasan-dev wrote:
> On Tue, 19 Nov 2019, Randy Dunlap wrote:
> 
> > On 11/19/19 8:12 AM, Marco Elver wrote:
> > > On Tue, 19 Nov 2019 at 16:11, Randy Dunlap <rdunlap@infradead.org> wrote:
> > > > 
> > > > On 11/19/19 12:46 AM, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > > 
> > > > > Changes since 20191118:
> > > > > 
> > > > 
> > > > on x86_64:
> > > > 
> > > > It seems that this function can already be known by the compiler as a
> > > > builtin:
> > > > 
> > > > ../kernel/kcsan/core.c:619:6: warning: conflicting types for built-in function ‘__tsan_func_exit’ [-Wbuiltin-declaration-mismatch]
> > > >  void __tsan_func_exit(void)
> > > >       ^~~~~~~~~~~~~~~~
> > > > 
> > > > 
> > > > $ gcc --version
> > > > gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407]
> > > 
> > > Interesting. Could you share the .config? So far I haven't been able
> > > to reproduce.
> > 
> > Sure, it's attached.
> 
> Thanks, the config did the trick, even for gcc 9.0.0.
> 
> The problem is CONFIG_UBSAN=y. We haven't explicitly disallowed it like
> with KASAN. In principle there should be nothing wrong with KCSAN+UBSAN.
> 
> There are 3 options:
> 1. Just disable UBSAN for KCSAN, and also disable KCSAN for UBSAN.
> 2. Restrict the config to not allow combining KCSAN and UBSAN.
> 3. Leave things as-is.
> 
> Option 1 probably makes most sense, and I'll send a patch for that
> unless there are major objections.

Both option #1 and #2 sounds quite unfortunate, as UBSAN is quite valuable for
debugging. Hence, it is desire to make both work at the same time.
