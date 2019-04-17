Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46CDC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8359E20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfFXEsl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbfDQRhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:37:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42973 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQRhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:37:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id b74so14852429qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6/4BtlTJLa8Zvlk+i9ij0ya4oUngxJe3lXv6hSoAHJk=;
        b=UfFXEsl5Gzm8+f4XLCekIRFrMWqIyqDbVu++s7rASqAVSrphl8wZ6NK6oajXw+iIcd
         b4+BxA8DF8Ucp/k8s/W6GwtUef6DjEVzxLM/HIePDTLyp/YRIIoCJ4EJIqi1bnVwzZ46
         ebzfFWVhDh1nj74rHbzpG77dnYLORcxKp72kR44eqzTY/7ULPYFx7QeiUq5WYn4GaYWc
         l1AGmk5IMQD4MuYvDkvaspwaIO1HuX94lY1rjs8OHRqjPfQ+BTuXacWxrI7p5GEa99dW
         Of6SVMmWxn2uaX67HtiEX3lWD5j291CD8/NOCavtaUmvd50ZjB0QBV6okJye/508roIE
         5dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6/4BtlTJLa8Zvlk+i9ij0ya4oUngxJe3lXv6hSoAHJk=;
        b=gN0B9JSjS6oN75O7alF/C0fPY/CH+wxlgAt5b21ecZ8VyfkpI04qfOxnILueBzjnpG
         ZdgFaXUa/6PGFFiB1qVq0bXtbdvJCE0dwJpeoY35T0XdMkmXoJThd0iKMXx7qS6wItRG
         SMH2gF3qRSiGhMXhEVWlLG5py1+e31k1osTdnTNIxiLhffwMb+9UKKe8nmtz2xdD5CJ7
         o2O7JimnPBjJqoEzypGVCEBYAlxpBtbQiLu8ocGxA0E/T6fSH+D8REetW+tpwjJths2W
         qjTsB2p6ni5EN93gVDo/t2Jcmqg9Jzpeq0t94B8FWHx3VOe8ofDfAZoXRlv10vmrXNNW
         AJXQ==
X-Gm-Message-State: APjAAAUaSP01MnoDPswKyZN9KaMeJr2cJlejbOdLBY641wFIgJJNJYXt
        PiyYk5dGYONTjNrD0e/BqlU=
X-Google-Smtp-Source: APXvYqy/ed9pf1Gt4XRJjfnn1kCU0gSjSyfBvHghPuvo6NgP4XbaQ0vEWDHGzCVXrydTnLhsqNEsVg==
X-Received: by 2002:a37:b303:: with SMTP id c3mr71001043qkf.154.1555522654671;
        Wed, 17 Apr 2019 10:37:34 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id s12sm33072772qke.36.2019.04.17.10.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 10:37:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3E55340521; Wed, 17 Apr 2019 14:37:31 -0300 (-03)
Date:   Wed, 17 Apr 2019 14:37:31 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf bpf: Return NULL when RB tree lookup fails in
 perf_env__find_btf()
Message-ID: <20190417173731.GC5246@kernel.org>
References: <20190417145539.11669-1-jolsa@kernel.org>
 <A3C4DDC9-8E20-488C-A273-E3AE163A9774@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A3C4DDC9-8E20-488C-A273-E3AE163A9774@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 17, 2019 at 04:49:13PM +0000, Song Liu escreveu:
> > On Apr 17, 2019, at 7:55 AM, Jiri Olsa <jolsa@kernel.org> wrote:
> > 
> > We currently don't return NULL in case we don't find the
> > bpf_prog_info_node, fixing that.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Song Liu <songliubraving@fb.com>
> > Fixes: 3792cb2ff43b ("perf bpf: Save BTF in a rbtree in perf_env")
> > Link: http://lkml.kernel.org/n/tip-99g9rg4p20a1o99vr0nkjhq8@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Acked-by: Song Liu <songliubraving@fb.com>

Thanks, applied.

- Arnaldo
