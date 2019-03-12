Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93383C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE1E2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vkv2ID2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfCLOeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:34:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46806 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfCLOeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:34:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id z25so2700376qti.13;
        Tue, 12 Mar 2019 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FVv+o7DqfKzJrx4w1CC3UvFpUfwchNmos/cdS+aoglg=;
        b=Vkv2ID2xNdPqVxq4HGCoThXR1ABkvQRqcUTrsGX0bMcI5SMi+DIpLfpU1+2OAr1KF4
         0x8AUumAyXTRMFwJVHlLf3uGN2weTREeBDHxZNh6oSoJJaMLGcOKdPscgW+MjltkJeBC
         CKaXKZpMBBvnt7UCjOGtbGohrx49pf7QyMmbf2F5YG4PQ2+tExtRIIB8huzzCdNNEzx1
         51YgYoI7/Fp0UX+UxzQNv0M/ZF6s3Jn0A8Mp0fnXOfe3PDQJUPNU+YqfxJIdHO/QMOD3
         TrqSeaCAbPOnH3XOBzjc2SFiRH5LdUl4pzglIk541/lkvEbFsPHGBJmUcBCSgdMPMh3b
         5Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FVv+o7DqfKzJrx4w1CC3UvFpUfwchNmos/cdS+aoglg=;
        b=o0GnONuXeAATxtFeXQpSvAakbbOZrJP086I05O15ECaqi6aDQNIrExZZVvJnIJj4JF
         XXuDQy454FqxxHcCaa8qOgnYlnayMXCwoNuhAMMhh+Lh2v7qKpDEufG0tfYfL7oBi2TQ
         QEVElNZmq0QYGsfV5ab48Am8pD6yODi2oz/M3DQ6b80DHL/9sWd9inz0v5Ik7tUkrGSj
         xY2krSzJPu8aFXY+zHGazGikzL1HzJtz2JLdHQ9FOpWassODSCq3mtTy4MmpPj1IetpG
         AqGemyGm3D5Jf8YVWAHXIwsnKb9yQYguJNiOhiM6keJOgApcmAgkcNfC9l/Dy/NEmTFd
         1cpA==
X-Gm-Message-State: APjAAAWRPirWUQx3lWzuQAC88DZtiG+iLqU+fxZmrJFBx/xS4/i5oapD
        JwbF6OoqvjLtuWSKFwTry8A=
X-Google-Smtp-Source: APXvYqxOxx9jvtAEvElLFG8JmwKgcXclXJi5Xfm0avThEgPNhEJItNbG4bxTMKHW1v3p5v2pUgP4iw==
X-Received: by 2002:a0c:80a8:: with SMTP id 37mr2991767qvb.138.1552401256353;
        Tue, 12 Mar 2019 07:34:16 -0700 (PDT)
Received: from quaco.ghostprotocols.net (177-59-123-113.3g.claro.net.br. [177.59.123.113])
        by smtp.gmail.com with ESMTPSA id w33sm5751122qth.34.2019.03.12.07.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 07:34:14 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 230904039C; Tue, 12 Mar 2019 11:34:11 -0300 (-03)
Date:   Tue, 12 Mar 2019 11:34:11 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, sdf@fomichev.me,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v9 perf,bpf 06/15] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Message-ID: <20190312143411.GD4939@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-7-songliubraving@fb.com>
 <20190312131033.GB3034@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312131033.GB3034@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 12, 2019 at 02:10:33PM +0100, Jiri Olsa escreveu:
> On Mon, Mar 11, 2019 at 10:30:42PM -0700, Song Liu wrote:
> 
> SNIP
> 
> > +/* purge data in bpf_progs.infos tree */
> > +static void perf_env__purge_bpf(struct perf_env *env)
> > +{
> > +	struct rb_root *root;
> > +	struct rb_node *next;
> > +
> > +	down_write(&env->bpf_progs.lock);
> > +
> > +	root = &env->bpf_progs.infos;
> > +	next = rb_first(root);
> > +
> > +	while (next) {
> > +		struct bpf_prog_info_node *node;
> > +
> > +		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
> > +		next = rb_next(&node->rb_node);
> > +		rb_erase(&node->rb_node, root);
> > +		free(node);
> > +	}
> 
> 	env->bpf_progs.infos_cnt = 0;  ?
> 
> but it's probably not needed given the current usage

Better be safe than sorry, see the Andi's "perf, tools, stat: Avoid
memory overrun with -r" :-)

I'll add the infos_cnt = 0 here.
 
> jirka
> 
> > +	up_write(&env->bpf_progs.lock);
> > +}
> 
> SNIP

-- 

- Arnaldo
