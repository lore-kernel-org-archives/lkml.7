Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218A5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5A22087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSXG/By2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbfC0B42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:56:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38245 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfC0B42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:56:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id g37so2514685plb.5;
        Tue, 26 Mar 2019 18:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=76ANpdFQuY8fTjk/hR1fIF1endcrr/sSbGGgwVZWLIM=;
        b=vSXG/By26jRQPZGiv6iaoU9w8fWhkHp0PARzOp1QnqatmTD69OQ/1J9fuOJLD9R1jW
         dyq/m7m2tlI+eMH7hReYmImubI5sBdqwg9oOkROvExtX4pCwVu4ZVckUsM4OF3dUpIV1
         +/DpBCsIFtgwjRW2/eLmXjA6plHtb5XyCetrUIENHt1UFegx4itHhmF2q69nvMHMAlKB
         gbL/4cypdJ2u+5BEe9fwMnJg2Ti0flM95afmlSa8z5qNYHczN5gMTZQR7r1ThKQy6tas
         0iIP+BwoKLhZtF+Qfvjq6FK0g6azOZu48ogdAiFk7TOPDQdzzlPu5XClMUgWcnix0kst
         b/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=76ANpdFQuY8fTjk/hR1fIF1endcrr/sSbGGgwVZWLIM=;
        b=mXCRRVGHKYx5FtNcH3Vvl03stxDoxbDLE5KsTHJ2eI/ZeKcrRuGZl1cCFty1oE+/xz
         59NjEt0N8uwGg1rC/c/WvO30mqm2MUu5gL5vKkejUU23Xv56qBgO3EdhS3f8XvM8Lo+J
         vDlUfQ9OqZPnoMQcSNmIwtXlSrCGKlcfQQATPJDMblXh9n11hG7fcN+YYirJqv69zZiF
         WhCoCG2Qc21gzpAXEhoKZz3qcv5pTfC/0zCwto2LaSabavaXNm6wIsl0XftMrhNUJbOt
         kpMMVoDai8EWXNrzKSW10J5IZu1yXqcShp+tdOuFzqiWuIgAWE5HHlbdCzTSaGrJ359N
         1LoQ==
X-Gm-Message-State: APjAAAXSRmvovG75dY8h8KmGLSR/R/aLkqVHqohiPNkAnhEFqDmV5N94
        BjyXlf+YqAGOK8J33nwMvPg=
X-Google-Smtp-Source: APXvYqwpruaC9ExQVtgEOH/znNUi6+tPF16FnbULu328hEGkVr4Z/SaLCizzf8offMnAb3BsW4OpIg==
X-Received: by 2002:a17:902:28e6:: with SMTP id f93mr34428552plb.264.1553651787286;
        Tue, 26 Mar 2019 18:56:27 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::1:f1fc])
        by smtp.gmail.com with ESMTPSA id 139sm25424498pfw.98.2019.03.26.18.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 18:56:26 -0700 (PDT)
Date:   Tue, 26 Mar 2019 18:56:25 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Boccassi <bluca@debian.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the net tree
Message-ID: <20190327015623.ur46t5gdmraagi2q@ast-mbp>
References: <20190327091437.68ec6903@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327091437.68ec6903@canb.auug.org.au>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 09:14:37AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>   tools/lib/bpf/Makefile
> 
> between commit:
> 
>   1d382264d911 ("bpf, libbpf: fix version info and add it to shared object")
> 
> from the net tree and commit:
> 
>   60e4786e229d ("tools/bpf: generate pkg-config file for libbpf")
> 
> from the bpf-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

argh. that's a heavy conflict.
Since that patch was at the top of the bpf-next I removed it for now
and will re-apply when bpf-next gets merged cleanly into net-next and
we bring back net changes into bpf-next. Sorry Luca.

