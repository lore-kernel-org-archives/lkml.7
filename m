Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D9FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B415D20835
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="G1okhweJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfCUBSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:18:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34750 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUBSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:18:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id j89so3975785ljb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7QnHzTZmrLKVe8LTttzGCXr1M69dafHz/4F1PR1odM=;
        b=G1okhweJQVAmoxRLJ7Qv4HGR3pbgwy6PZNkye21wNe6Seu8u+LB67mIQTKG2IVZycK
         hSiltSsSgsfYgU03Q4ieYa5IfudDlguhcr+FXF+aSEfYcp/cFSAEqu0yTDeYU2CwVdr+
         z8gj9GYcjSzq37SmDXlyT2QE2TLdXut93AJSyY7OCsnPDxDp8d7lFR810zVOdtYOdrSj
         IpApFGJepJw2RzLo6iX1YPbyu+QmbAsJx4g53vc4qZNFqz18MLuhfEEtXMUAXSKaWvW9
         lBkJGfHoJd4BMMOvaN4MynUqnVlgn+fvFn7bhVAaaAjqHw1B6x0Kfa3pUh4zPOGr8XHi
         Q1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7QnHzTZmrLKVe8LTttzGCXr1M69dafHz/4F1PR1odM=;
        b=oH8hyjbyh1/rxO/RIeLtPPv+guexhTiwHj4X4VqWCgR3uM9TVFZ6flB9lr+884tVK0
         E9plmrXlw5RpDMHzKZuzEpw2ot/hx1eYhtX4lruO6jeV8lumkNeMIqoHRvZQo6Kvj/8n
         IftVUBxbzkOaPOjmpaCZrVCpbGXIdOns1vBvAS2lW4fdvAR0hV8/I9s/qUwFaf71d81G
         99UGJBQuCRp4D1uvlulqbv3DK1MIN8b8UYkkE5RWMH4fqleExskVi+scwjWEoDAOKmlC
         RTNIY3I9I8Bv4JLUu2OM442nMXG1pwl81pJd1aWdiQjGOJt3vpoSorgQ0uwN8BBodNZp
         At1Q==
X-Gm-Message-State: APjAAAWV7Pj/RFIdTEpTOpOQUTaxQiw6vAB+leiQPkJalU17VniFG1Qf
        +4mEYOz8l818jtjp81V0YTU8CjmGzpph+CMm4tic
X-Google-Smtp-Source: APXvYqy9KHfvAtM6PDWxAbRRAf9gWvVRAVrDTaqC7eqp8en4BqbAX0tBUsjTqG2/v+TuUG3D8BQ2K0HKE+hM2j6h/cQ=
X-Received: by 2002:a05:651c:d7:: with SMTP id 23mr489811ljr.5.1553131078513;
 Wed, 20 Mar 2019 18:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190317232839.GB16301@altlinux.org>
In-Reply-To: <20190317232839.GB16301@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:17:47 -0400
Message-ID: <CAHC9VhSWrSsykMm+or6gpMYJQ7WuiNEEmmsCQnQ+KMyR=W8p+w@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] Move EM_ARCOMPACT and EM_ARCV2 to uapi/linux/elf-em.h
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:28 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> These should never have been defined in the arch tree to begin with, and
> now uapi/linux/audit.h header is going to use EM_ARCOMPACT and EM_ARCV2
> in order to define AUDIT_ARCH_ARCOMPACT and AUDIT_ARCH_ARCV2 which are
> needed to implement syscall_get_arch() which in turn is required to
> extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Acked-by: Vineet Gupta <vgupta@synopsys.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: unchanged
>
>  arch/arc/include/asm/elf.h  | 6 +-----
>  include/uapi/linux/elf-em.h | 2 ++
>  2 files changed, 3 insertions(+), 5 deletions(-)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
