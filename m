Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DA1C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6DD21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPwgbuv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfJHOVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:21:50 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42935 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfJHOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:21:50 -0400
Received: by mail-oi1-f196.google.com with SMTP id i185so14882357oif.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MA85NocqHsE0pV0WfruagTwcSPZ20OKA7j0BxtbfiKg=;
        b=kPwgbuv4SZyOXa0VVd9PS9lv1q4g0p3gD2oqmeLiueLI2DbgKdwfPbfzH4pTCEopYB
         9buGDhEoq2K4C/Yw2E0U3aAFxVD7aLRefWrB36OLxiETjmGIsDzr5Rk1VU2vNDz9EoRD
         EKiEmRQx7/m2707sy1vkdtlvzY1h5eP+tPomtD9Yqqe1HCwpA4TCjlkB7PyFhlivKltZ
         VFjGKXbPvPNqkdqk6XJZ+3OQgsHjcXbVuM8EsQG4HefArMnpTQzjMHA04jz7TF6rWJtL
         zTcBYEaeqx7aMxygbS07rBNSTW8RyGmFwTaEwnpq3lP4CYWj1G5tRCCxxZ4vB2w3AP9y
         L8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MA85NocqHsE0pV0WfruagTwcSPZ20OKA7j0BxtbfiKg=;
        b=Oscou09YYndxX3lhs2w9DMXZJIOQ7gj8a3DIFOkuCWGh3pYW7o+4Djex4QDdNlYxzA
         /q1hvRgTNHpk5HXmSpdktIirsrxeeB4XL/XLJBMcGT/Q2qruevyUgqo8njdBD1vLuwwM
         qIWntlsSjn000/LdFkG+GaLZVMASA0JTacmr2zOpO0ZFhpz2xaOViAcMuLDCsuzfQrSZ
         cKWFGTIlz/J7QpN541DaTeAPZjloB/RV8cZYhnrlvyYFLkZjLgd09XWtmphv2KTuxcs9
         HMlrSzvjhG/+xIF8uM7vjfhSwSVfpZxkg7dURi+I5TkbpNxlrIRzIheRmWXEYBk7BqrU
         +MtQ==
X-Gm-Message-State: APjAAAWjy3/tfBUagdsU8pgxdtBEznxg/PeDX23+5922VSQUzl+sG78O
        cKx76XnEa9CBq6atWxL+hykreARMzZ3CbxI2C08=
X-Google-Smtp-Source: APXvYqwbOXJQBSQzyqHrkkq9QPraEKF9kIEK+PuMw7Wmluq/cUmot0rXXoSPY/Vp/T+6R4vHL4wlRBxK5y1qx7cAvvc=
X-Received: by 2002:a05:6808:9b6:: with SMTP id e22mr3925086oig.51.1570544509753;
 Tue, 08 Oct 2019 07:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <1569241648-26908-1-git-send-email-lpf.vector@gmail.com> <20191002160649.9ab76eabaf5900548c455b02@linux-foundation.org>
In-Reply-To: <20191002160649.9ab76eabaf5900548c455b02@linux-foundation.org>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Tue, 8 Oct 2019 22:21:38 +0800
Message-ID: <CAD7_sbFvsXMMa9zHiV9SvaXYnrX6zoo9X5e09ToLupcx1=U8=Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] mm, slab: Make kmalloc_info[] contain all types of names
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christopher Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 7:06 AM Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>
> On Mon, 23 Sep 2019 20:27:25 +0800 Pengfei Li <lpf.vector@gmail.com> wrot=
e:
>
> > Changes in v6
> > --
> > 1. abandon patch 4-7 (Because there is not enough reason to explain
> > that they are beneficial)
>
> So http://lkml.kernel.org/r/20190923004022.GC15734@shao2-debian can no
> longer occur?
>

Sorry for such a late reply.

Yes, it=E2=80=98s caused by [patch v5 5/7]. So do not occur in v6.

> > Changes in v5
> > --
> > 1. patch 1/7:
> >     - rename SET_KMALLOC_SIZE to INIT_KMALLOC_INFO
> > 2. patch 5/7:
> >     - fix build errors (Reported-by: kbuild test robot)
> >     - make all_kmalloc_info[] static (Reported-by: kbuild test robot)
> > 3. patch 6/7:
> >     - for robustness, determine kmalloc_cache is !NULL in
> >       new_kmalloc_cache()
> > 4. add ack tag from David Rientjes
> >
>
>
>
