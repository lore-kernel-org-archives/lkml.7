Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9C6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0E22075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu3ieVgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfCLPAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:00:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35638 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfCLPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:00:29 -0400
Received: by mail-qt1-f196.google.com with SMTP id h39so2909679qte.2;
        Tue, 12 Mar 2019 08:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X2/EtAFo2VJfnmQkl9CSEk0lNeGx53bt/5upUTpJsv4=;
        b=Tu3ieVgS6OhWqT1MH/shGwcNnkbHwcKH6E8tbskUyNPyvcE5JkyZbqyDc1dd8FnFiS
         npi8i30YKwF7dHQsfjrKGsIgrigDMRoxLEI792YQexfS1yq9lAmdR/BxXhU03k3xGLSU
         ioFUlhu6bHI/rDF0/qxHqJvikVlEW98WKIAkjhps1zM/xGQnr1713u/nLrrK1ddAgpks
         6xDVQuEy7nQO+3A5iIFrywxwbBG7WoXws6GlY01bLxBpgkZZVpQ9q0vpZHEXdS8cTp6U
         EYWO54RE7SeaYaH47gU28+ZBBIb1X0R91SnNPZUx3u9ihB02P9E6qNzMkOVUqG4+Mu2g
         DNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X2/EtAFo2VJfnmQkl9CSEk0lNeGx53bt/5upUTpJsv4=;
        b=VaLY/uLkmxymOJjeU01OaouIqEkwxUj+U3vyU59HNQHyGt3pJ2XsmyQYJfj3wtFIfr
         bvBYB48SBoqIJgfFYHv8hqExay3rben9PS3B59CKA2qyG5Cqa/omkRjP5SGAnqEiDowo
         2wuACvYsY0ulrL+H+79285Lqsu6KsBzu1PILbhiJql/+mWROCzw8bldUiQqJodazJKnQ
         JHh1QmHNm5F9VcWb//r2uuQ230XbotaQy0oop+rh/5bu9aRvzBZM/roWlRoTOM2HBGUn
         F3d+r23OX0/5qt88Ln+K/Zu4/xZ2XIlejfA1c/fd63DgeSGaU+oswO2by2WeVcAa6P3E
         qilg==
X-Gm-Message-State: APjAAAUlOuykSTPNCSlwOfO/kWG8yqZN1xi8GiIz3WyCVIPOdQCKosKV
        SbOj9q5E2QoIAbkj8xGzCsw=
X-Google-Smtp-Source: APXvYqyVlawSPL7xNVJQXKr3w0UGJ8zAHQw4MkE3YF2d5EOOEK6byCpg7YTYjZpch/MEh4xTbCjzuQ==
X-Received: by 2002:a0c:be91:: with SMTP id n17mr30605360qvi.32.1552402828339;
        Tue, 12 Mar 2019 08:00:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net (177-59-123-113.3g.claro.net.br. [177.59.123.113])
        by smtp.gmail.com with ESMTPSA id 3sm4312168qtv.79.2019.03.12.08.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 08:00:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3EBFE4039C; Tue, 12 Mar 2019 12:00:24 -0300 (-03)
Date:   Tue, 12 Mar 2019 12:00:24 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 08/15] perf, bpf: save btf in a rbtree in
 perf_env
Message-ID: <20190312150024.GF4939@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-9-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312053051.2690567-9-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 10:30:44PM -0700, Song Liu escreveu:
>  static void perf_env__purge_bpf(struct perf_env *env)
>  {
> @@ -83,6 +135,19 @@ static void perf_env__purge_bpf(struct perf_env *env)
>  		rb_erase(&node->rb_node, root);
>  		free(node);
>  	}
> +
> +	root = &env->bpf_progs.btfs;
> +	next = rb_first(root);
> +
> +	while (next) {
> +		struct btf_node *node;
> +
> +		node = rb_entry(next, struct btf_node, rb_node);
> +		next = rb_next(&node->rb_node);
> +		rb_erase(&node->rb_node, root);
> +		free(node);
> +	}

Added this as well:

	env->bpf_progs.btfs_cnt = 0;

> +
>  	up_write(&env->bpf_progs.lock);
>  }
