Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90AECA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 01:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8652089E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 01:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U24ilZxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfJVBPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 21:15:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35099 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJVBPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 21:15:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id c8so4074289pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 18:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPmdbVnkXBdcuF2g6zsawysDd6Gfy8LkQCCWQO/3l40=;
        b=U24ilZxZ9Bo3Zx1yLdQAYg2irQA8n9O+WueP3mmZO8+FpM6jWhkQNwN2/GZ1QnLhnh
         vxeBV7f9VucO/cdQosz3rdV2GSUcYLoiiUAztExEHK3YarZUcXbA+sPQ5JCkbzEDtK8a
         zniQKjEeQj/BHCC5PPN2GtAeTquwylZkyts31Rz9kWj+ek+txWi7aFgp/PHxvFprjLuy
         J7pgtPeLMfdNeZkXXlPZMHu4pT+tHFGo/uXhgMamuQdmyidmwwMUCTgEGvhAStD1wZmj
         S6W+MxYgojX5byXhCGbJEYmqxvic58NSgWKzkU5P7BDUpq1k13/rcSvZQIwuWQMlLDtr
         BYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPmdbVnkXBdcuF2g6zsawysDd6Gfy8LkQCCWQO/3l40=;
        b=nxHDu6mryyFMSp/ER1rklQhAXRtVBDOAl/Lmx12ZkOYsa2Ue39YrF0TD9cPhbMLF2t
         kP0kPTpCQ6PdGBq75aCW8AYW35SEnXV8RxASRsvlaOOROrgXfcFD1MwrBvilqZ/8BwxJ
         mjfjoyIgcLpOvOI9kQsiNXl66exSGWL6ko2h3IVQ8QhTrPV/wFAPLq73Rs2H2TdjcWup
         XRIx0QGp6INNrp41wsNzCQFfjANab5U+D1St9Ke7Pfa3pXDLKijdgY9mhT0QlWX+j7JL
         AUT0VABps48+ITPJ8IfNydfVfyMLkmv/0k5qRYeb2B1reOm+ov5Mz3o+qV1Dv3b11bwr
         TCMQ==
X-Gm-Message-State: APjAAAUJBHqDVqFrd/xjo1O602h7Vdi95G+f8wOuzt13hS6gpDVp8YrH
        9LUEBK3rtr0lHlcJm7ho6uG1u0g694FScbm+h5lMvA==
X-Google-Smtp-Source: APXvYqxqileGL9IAimD9SCzpiYufUF1W0QkGwwfdMGRt9c5M8/7kLWXYT7DOcpmijBzX4BOkqsRvWdbaQkxZDrLX1QY=
X-Received: by 2002:a17:90a:c48:: with SMTP id u8mr1333271pje.16.1571706945651;
 Mon, 21 Oct 2019 18:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190904211456.31204-1-xiyou.wangcong@gmail.com>
 <CAM_iQpUiOi8JDBqAtMHii5UHK3D6WQkk_G5DriJ9Y0yTYbWf3Q@mail.gmail.com>
 <CAM_iQpU3dqvUR0Qp6ZdZrAiyT_t_uFk4K79vcT2Q_-EjqBCGbw@mail.gmail.com> <20191021192146.0d651ce2@oasis.local.home>
In-Reply-To: <20191021192146.0d651ce2@oasis.local.home>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 21 Oct 2019 18:15:34 -0700
Message-ID: <CAM_iQpUe2HD-x9btYBJpL+O+1coRuLBX36qQm5bVwxmYWg8Y_g@mail.gmail.com>
Subject: Re: [PATCH v3] tracing: Introduce trace event injection
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 4:21 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 21 Oct 2019 13:41:51 -0700
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> > On Mon, Sep 23, 2019 at 2:13 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > >
> > > Hi, Steven
> > >
> > > Any reviews for V3? I've addressed your concern about Kconfig.
> > >
> >
> > Ping..
>
> Sorry, I still haven't forgotten about you. Just trying to deal with
> other fires at the moment.

Ok. Thanks!
