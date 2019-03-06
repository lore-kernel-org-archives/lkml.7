Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5603EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC8220840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551895790;
	bh=mG8Ol7ljLNQE6W/C+S3ABlrqeAyPoGfVnUQycpWn/ck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RPq6jQObZfoujJbE8n8jOHa9D+KKcAFGrbo1IsrjDchpNGqtTCEAAFpQECy46snvA
	 oLvuK1LN0v7e2v+i/2oCiG8g5UfotjcQfI1j5JGkqmtllY6WMB5M6QptCXWfqiepiZ
	 wLUO5NtVVtPy9lTpMD9IGfRPFNK02sAyS45sKBj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfCFSJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:09:48 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34508 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730692AbfCFSJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:09:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id d26so9628044lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqENTigMVpqokXQYBvjmbeb87ie0t/LErN2uBF+bhNo=;
        b=Y36XKvYYQIN0WwOOn+NwQLbSl+MyaFJXdu01gzS8fnVzNY7/hzIR73eCHS52CLjC4/
         LOI8GWKFQKBM4wISrp61jZeGiKoUhSi2JdK3aJh3wSJGah4DKMT7eAg5SNooZ5HfzTXb
         ZzYeeqvYMtwKxo2Hdaa8Ma3/eAabeldQhIrbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqENTigMVpqokXQYBvjmbeb87ie0t/LErN2uBF+bhNo=;
        b=RN8VR/Ut2r7W0A1CFuwfaKyXLPguLYJ3mDwEi+r3XAxG+xRsqbwyfHBYSb9KHm2vLA
         AoHHGLSUlMvoLXNuxTimtlhAv5bPMSlRsxFZQWrNVYakhy++2lfCtWwc98q4pgMTRCwh
         +IxLCy8JvHynCpXj7ry67vVj7bwYDpV20Altzw08P9coU+fK0JTToO/7oJ/fBHt4tVTX
         POySbr4/XKf+ETDns3iGkCNSXEt62GA0T4G58F45zaDj3HMGqTYbMpcZlKwU/GPNkeHY
         xHWH+DGXGlmj0pWnxmJ8CrKK27NEtaa+jXsvoCmElxYcQKaXNpjw0BrKuD2dYiI2bq1O
         cqmA==
X-Gm-Message-State: APjAAAWm4Xm4Poy9zXGd2eEvlFdeMwKV3dX0v22JKHn/EB39o7PTrYX0
        RsRe5Id6IdivDwsuZrzPSXGSO3mRklM=
X-Google-Smtp-Source: APXvYqxY81S9ngL3YOolrUDBPo7bwMKVqx8W4JpHK/eQ+QpRzZSKTAdn0pbKeDUl85v8dwjkrwCiBw==
X-Received: by 2002:ac2:424e:: with SMTP id m14mr4632519lfl.4.1551895785795;
        Wed, 06 Mar 2019 10:09:45 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id q1sm426561lfe.12.2019.03.06.10.09.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 10:09:45 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id t13so11774548lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:09:44 -0800 (PST)
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr3262457ljc.22.1551895784512;
 Wed, 06 Mar 2019 10:09:44 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
 <CAK8P3a1-j-rr1MKnVqD8__YnqPsP8y4S_TWr+TRJScRvkrFymA@mail.gmail.com>
In-Reply-To: <CAK8P3a1-j-rr1MKnVqD8__YnqPsP8y4S_TWr+TRJScRvkrFymA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Mar 2019 10:09:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdJKaDt=Dp_DS+LL3bzRZUo2VHHMZU_VUMukSPzRJPUw@mail.gmail.com>
Message-ID: <CAHk-=wgdJKaDt=Dp_DS+LL3bzRZUo2VHHMZU_VUMukSPzRJPUw@mail.gmail.com>
Subject: Re: [GIT PULL 3/6] ARM: SoC driver updates for 5.1
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 7:34 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers

This caused a surprising number of kernel file rebuilds for me, and
the reason was

>  include/linux/mod_devicetable.h                                     |   9 +

It turns out that the above is indirectly included from a _lot_ of
code device header files.

The reason seems to be the various 'struct *_device_id' declarations,
that then all the different header files want.

So a tiny change in an oddball header file causes a lot of recompiles.

Oh well. I don't know if there is anything to be done, but I did react
to how some surprising changes cause a lot of build activity, and it's
not always obvious.

                Linus
