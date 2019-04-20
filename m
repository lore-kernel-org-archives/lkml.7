Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E0C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E8E20833
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJd3d3Y9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfDTSS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 14:18:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43907 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfDTSS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 14:18:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so3959822plp.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kidv6qiLoczvxz2U/7ftzZU0wU9KupIfm3B94JIjFHI=;
        b=MJd3d3Y9mpB2sWqX0+DXlgykeb1FD1RTpbcE1CLQ5HSrKNcWYVPvWb0WBic/bQM4G1
         oKTYi3B7IAzTeMiiC2fjmrKPt6Vald+a0oa3T03Xysor6ftp2ANo78W4n9CKUonB5T40
         NDpPcceR56amwwuEfsmrIVH6hfthaiwABwGMTkfuoMsfGa3msYwX+sGo3SNYxHvq3kKF
         M9JNOK6QEn8bwTyRZsO7HYP4c5Cih7aKmO6iFE9ehK9Hhil5qP7oHk6A41Xa+zMKr0Ss
         u9GkoOC9b2DVJyexptlJGCJ+7WviGiMb3ZF8vQWWNjlMGpF4lHMeJmWaCDz1YhI9d5X7
         UZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kidv6qiLoczvxz2U/7ftzZU0wU9KupIfm3B94JIjFHI=;
        b=tFU23eXBrJz39XW594GMOPSMZ8dPLN9kCDI92jro1CAjNAhVa+fnGDX1QeKnRbBNrR
         MwpuCocvhu+xDpsV4flPNOmtlmtalsSbvQdG5d7S9iEERsJsbdLZ3zxns4cJ7kPuHM5g
         xD15k72OcA1YRIw1sfgSXz9LFUA7iENu77xTubVjmkZlF+aYoTM0pN2rU9AYZCjxj1J4
         teG0lfYGzhbAR5tLiMKsHi2MAXgjEz0Mj6OYfwfRKZW5393s/HNiClChUjbje088k0Er
         8Bm9kjtUp1XdgEnzON7GAgVW9BeV2xnzciMJxgvtSLxd9v1M01o2TuPPsqAimLkT+ruy
         N+TA==
X-Gm-Message-State: APjAAAVej9igYsaYkHi4M0gfp0D5NrTT5U1mYFqAkf2zz/th5iOtheGY
        XCbRxiOU3f5UEuvWkgRcaTMa9o4DIvntXBStNbM6Wq7O
X-Google-Smtp-Source: APXvYqw9rn4eYdWAh9GV0h/miIcY+00Nn8aQCDeVE2y7LUjw9Q78vVM5B3C7/60LX/2AXvW7VcqkhhtAmjotRZ4i/II=
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr10823545plp.165.1555784337275;
 Sat, 20 Apr 2019 11:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190418220229.32133-1-tony.luck@intel.com> <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic> <CAM_iQpVWvg-U6hzKsCPXdObiwKJhQ=BkGDDeP+p671cCWK7QFA@mail.gmail.com>
 <20190419002645.GA559@zn.tnic> <CAM_iQpVk564gCu_FBKvYVQjA1hGZ4YXB6ogrSFt=qZwiWen2tw@mail.gmail.com>
 <20190420091313.GA29704@zn.tnic>
In-Reply-To: <20190420091313.GA29704@zn.tnic>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sat, 20 Apr 2019 11:18:46 -0700
Message-ID: <CAM_iQpUaBOS92u7K+hzzRX5hw0Kbrp-0o0DSfLwSGBhenntVjA@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 2:13 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Apr 19, 2019 at 10:43:03PM -0700, Cong Wang wrote:
> > With this change, although not even compiled, mcelog should still
> > receive correctable memory errors like before, even when we have
> > CONFIG_RAS_CEC=y.
> >
> > Does this make any sense to you?
>
> Yes, the answer is in the mail you snipped. Did you read it?

I read it, all of your response is based on your speculation that I
don't have CONFIG_X86_MCELOG_LEGACY=y, which is clearly
a misunderstanding.

You didn't answer my question here, because I asked you whether
the following change (PoC only) makes sense:

@ -567,12 +567,12 @@ static int mce_first_notifier(struct
notifier_block *nb, unsigned long val,
                              void *data)
 {
        struct mce *m = (struct mce *)data;
+       bool consumed;

        if (!m)
                return NOTIFY_DONE;

-       if (cec_add_mce(m))
-               return NOTIFY_STOP;
+       consumed = cec_add_mce(m);

        /* Emit the trace record: */
        trace_mce_record(m);
@@ -581,7 +581,7 @@ static int mce_first_notifier(struct
notifier_block *nb, unsigned long val,

        mce_notify_irq();

-       return NOTIFY_DONE;
+       return consumed ? NOTIFY_STOP : NOTIFY_DONE;
 }


>
> Hint: disable CONFIG_RAS_CEC.

I knew disabling it could cure the problem from the beginning, please
save your own time by not repeating things we both already knew. :)

Once again, I still don't think it is the right answer, which is also why I
keep finding different solutions. I know you disagree, but you never explain
why you disagree, you speculated CONFIG_X86_MCELOG_LEGACY,
which is completely a misunderstanding.

I brought up CONFIG_X86_MCELOG_LEGACY simply to show you
how we could break mcelog _LOUDLY_ if we really decide to break it,
currently it just breaks silently. You misinterpret it as if I understand
CONFIG_RAS as a replacement for CONFIG_X86_MCELOG_LEGACY,
which is a very sad misunderstanding.

Thanks.
