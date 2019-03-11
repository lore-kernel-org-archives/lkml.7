Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FBB214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAqmkhvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfCKVS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:18:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43729 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfCKVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:18:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id d16so224138qtn.10;
        Mon, 11 Mar 2019 14:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a1CkLVQN7fsFZjnCZ7nbjyE056wbgyuDJaErJU2QKR8=;
        b=bAqmkhvcW35zJBGK/0PHnXmIh5MvXEULQmAjEAlQQVBlzGVKRxlh6SZHzOk44RbbMD
         Avd72XGmbUQZ7ax6yP9gmQDO7DhQVa8ee1RjqOtjlm5mILOhr4CRHN7z+UNPDrI4cjht
         5oP+3CclJgGiCzvh8UGgsDzKJ30lwv9d8XFYmtP9md1VjoCn0zdf9/+N83sAk2RTiASI
         HQ5Bo2HscQExi6bn0ww5PlnrTWcGA6FLX7zn1JoI0k9HUrrDeqTa8Shdm9OHn424+WIw
         oiPb4vjwr7JzVOU7zMgMBOlDnr4Xpdw+V29qYotdfACXzB/8JwBAb3z9uv17SbRwYSwK
         JQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a1CkLVQN7fsFZjnCZ7nbjyE056wbgyuDJaErJU2QKR8=;
        b=JcrtxjA5Xzxp1q39Ew+JTQ/uyoWh+zR9iYWEpNj93SxcteulATK+NlKh96x7jL8RKi
         MR9q4gd2QBIcuvC81KQ+2yO21a7ApWj6w9UJuSAfi2WtGCo0mi8T6SXqOTVJdeuFLRzD
         xMwpsReeP7npCjqbVqfSWDx4ME88OIfk23nQSZ46WwrKWXExuqy66UTQ6UxQB/KZQx/x
         gczOYJWNs22hzA5pJPMx4resr/ThgCpbEC49lDuTWHAiY4YJCVVWLGTEcGiS/D3K46g9
         w4WGC6q1ZQBLd6FBQOrlK4f7ZZcy0w99F0toODROadDmf7kVVDS6Jm/Vo24VoE/Io59C
         toTw==
X-Gm-Message-State: APjAAAVTWA6s6hmYXaAc3Q6/wRC6n74yG46qmzzR2Iax8Xrt2t3Q1VhF
        VRMS5srbjKtM7mIHZ+y/giI=
X-Google-Smtp-Source: APXvYqwBCfZzfB18McHfYqXnc9wR7UzqJZbmNlvoG3jH9/bKXBNcxrIzl4ErYBRZdCCLU+WJ7wGHJg==
X-Received: by 2002:ac8:2a82:: with SMTP id b2mr27463197qta.375.1552339135340;
        Mon, 11 Mar 2019 14:18:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id j34sm4079738qte.49.2019.03.11.14.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 14:18:54 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0EAE14039C; Mon, 11 Mar 2019 18:18:52 -0300 (-03)
Date:   Mon, 11 Mar 2019 18:18:51 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v8 perf,bpf 00/15] perf annotation of BPF programs
Message-ID: <20190311211851.GB4939@kernel.org>
References: <20190311195555.889995-1-songliubraving@fb.com>
 <20190311202414.GA3078@redhat.com>
 <B72EC7B0-6B8B-4739-87A0-15364D3DE44F@fb.com>
 <20190311210507.GF10690@kernel.org>
 <944EE4E6-FD71-4D41-ABE1-279C6950EB11@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <944EE4E6-FD71-4D41-ABE1-279C6950EB11@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 09:08:31PM +0000, Song Liu escreveu:
> > On Mar 11, 2019, at 2:05 PM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Em Mon, Mar 11, 2019 at 09:01:48PM +0000, Song Liu escreveu:
> >>> On Mar 11, 2019, at 1:24 PM, Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
> >>> These csets are already upstream, i.e. already hit torvalds/master, i.e.
> >>> will be in 5.1, can you check that we still need doing this
> >>> cherry-picking?

> >> I just checked that 02-15 of the set could apply to torvalds/master (with 
> >> some minor conflicts), and it works as expected. 

> > So no need to cherrypick, just use torvalds/master as a base, ok.
 
> Do you want me to resend the set with the conflict resolved? 

No need for today, I think Jiri is looking at that branch I saw you guys
chatting today, so if he has some new comments, you can then address and
repost, fixing the conflicts then.

- Arnaldo
