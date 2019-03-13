Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5DAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9C62146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkBIUkIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfCMTGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:06:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46015 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMTGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:06:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id z76so1789397qkb.12;
        Wed, 13 Mar 2019 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j7m09hVPcTEk7DJmTmBML57FUVbr8hKQD4+hOJ9aui8=;
        b=kkBIUkIWCeVkZXr5FLa5TbTzz5ZlrztnNFBQEizZwevDRM1PpO2gVbJ8C4GvKCRGIa
         orH3EPn86CcJDuyzCgzL4Oby93K91GAX1b3QFxYFY52xO8HxzqHdkOrH2opiXpBpx7wQ
         qKF0JgoQ8rAL8AKM66D946MSL+fwxpIKIbOKR+xI084vqDv1Y3DH2Z1gfjZnkf+KdInd
         zePv/L3sm6w3mXynXxEqSXiNySyaikYqPgr+vulzVe7/MODaBsewLdCkfma+NZoiVIto
         6zjEUUZhjj2DUsWwGvdo308a3BEPnIFZX3zm5SNwybyLRukE/NEM6AaM2K5id/XMYf1u
         1tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j7m09hVPcTEk7DJmTmBML57FUVbr8hKQD4+hOJ9aui8=;
        b=WKKrZ7on+Fsvw0jKtJS3tiFJhj/cecCcEoKx0CiiaFCd78BunCRX7ziQQSXrhXNKFG
         VfERjXrwCDD9abtX1iziprfaADTlwmrJVxzzT4DMypjjaLelLF12OLxH1V/FnlEhIFm7
         oid0LQXaDvDET4hAANprAn0uZuBmkqdGHewa8IHovnuh0jvFgpUR9ecZ+n5+96+RMim2
         iCnmPobKDpRc4kD9kVI+oG0YVqj3ckYqbcBE74veDXMi03o8d+iqjCvpTzT5teFhueJ8
         jD6q54lqCExG2C+3iW7LErCi7r7MAwRWzGl2GIDMJOT3TIP6+RAlZ3txEuf2PyAcruhR
         UsmA==
X-Gm-Message-State: APjAAAW7g5pwE+F03XidAv4Qrtr2ik/cBB18KS/mt+/wzledPTycfIid
        lFwcmbD/jENUqeM4okLcX5w=
X-Google-Smtp-Source: APXvYqxAmaDKvsFYu4+7h482+Qqj5FZrhTovNLrpiGWo6FuV1cauP50qfRVhEvN1PTzMPaiBM3IiNA==
X-Received: by 2002:a37:7602:: with SMTP id r2mr33709726qkc.97.1552503961457;
        Wed, 13 Mar 2019 12:06:01 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id o3sm6929943qte.55.2019.03.13.12.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 12:05:59 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B99C74039C; Wed, 13 Mar 2019 16:05:56 -0300 (-03)
Date:   Wed, 13 Mar 2019 16:05:56 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Message-ID: <20190313190556.GA4786@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-8-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312053051.2690567-8-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 10:30:43PM -0700, Song Liu escreveu:
> +static int write_bpf_prog_info(struct feat_fd *ff,
> +			       struct perf_evlist *evlist __maybe_unused)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +	struct rb_root *root;
> +	struct rb_node *next;
> +	int ret;
> +
> +	down_read(&env->bpf_progs.lock);
> +
> +	ret = do_write(ff, &env->bpf_progs.infos_cnt,
> +		       sizeof(env->bpf_progs.infos_cnt));
> +	if (ret < 0)
> +		goto out;
> +
> +	root = &env->bpf_progs.infos;
> +	next = rb_first(root);
> +	while (next) {
> +		struct bpf_prog_info_node *node;
> +		size_t len;
> +
> +		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
> +		next = rb_next(&node->rb_node);
> +		len = sizeof(struct bpf_prog_info_linear) +
> +			node->info_linear->data_len;
> +
> +		/* before writing to file, translate address to offset */
> +		bpf_program__bpil_addr_to_offs(node->info_linear);
> +		ret = do_write(ff, node->info_linear, len);
> +		/*
> +		 * translate back to address even when do_write() fails,
> +		 * so that this function never changes the data.
> +		 */
> +		bpf_program__bpil_offs_to_addr(node->info_linear);
> +		if (ret < 0)
> +			goto out;
> +	}
> +out:
> +	up_read(&env->bpf_progs.lock);
> +	return ret;
> +}

The above uses libbpf functions unconditionally, leading to build
failures when NO_LIBBPF=1 is passed or libbpf somehow is not available
or can't be built.

So I added this:

+#else // HAVE_LIBBPF_SUPPORT
+static int write_bpf_prog_info(struct feat_fd *ff __maybe_unused,
+                              struct perf_evlist *evlist __maybe_unused)
+{
+       return 0;
+}
+#endif // HAVE_LIBBPF_SUPPORT

And added this committer notes:

    Committer notes:
    
    We can't use the libbpf unconditionally, as the build may have been with
    NO_LIBBPF, when we end up with linking errors, so provide a dummy
    write_bpf_prog_info() wrapped by HAVE_LIBBPF_SUPPORT for that case.
    
    Reading and printing are not affected by this, so can continue as is.

