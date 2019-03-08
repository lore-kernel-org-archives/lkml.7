Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDDDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6F62081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSl510lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCHQ1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:27:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41585 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHQ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:27:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id x7so16863914eds.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDfjrwg75YR9Z83PlwiJKxEdJg7htxsYg+OzHK9l1UA=;
        b=JSl510lZaTZdoWEZeKs13cdg+xWLOUiNXtcro1BCnvTN9fM7lElEKk5D0ps5FsLUFe
         5rMhjVq1G7tVo9LbURDZya+Rz4h49M80QxYq6ZVav2XAHmoO6PXs+Zzgwt40v3HcieBf
         d63gi/fmDWdlRf7Q4NIv/QmWUMjIsT8KlYIVSwMdOEe67io8kdiWJ10lT10R2eQdVs/M
         /cIbv6Ma7yN4W1henWpBrA9+baQRiDkPFGIuRXfklJRojeWefvXmrURoZ3BhObPLf0rq
         IMdV5Hcy9KsbqsQefdjmNLjsb7J/P0ElZfxF7YOXS3XoRBO8NQRSgXjdFJLOM3aJ+tJL
         LWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDfjrwg75YR9Z83PlwiJKxEdJg7htxsYg+OzHK9l1UA=;
        b=dNo3tXw8gbnH96QCN+l0YNh+CTKZHjO1FH0kgaOzWRfhx5mZ4vQc+QmRYrfJJzrHkz
         OKWV9ney/JAAzp1JiI58D0s2IKAxguOsxY/Gd8Qy1eqqxS8UCothyPjOVtr54z7SDwPP
         WB7lnt6cG/SdnEM61YbaouKTXOFAppRCw33AQAd7lH/Q6uwO2Me9Yf5NEVQCZSbjV5p+
         3givaetRz0wMiKULrbXWPQAMz5Z59WfXYWuZxMZYNZyBlQsGlbsPhAZ67Xau1IaB6Kpn
         fb9ZkFeQ3L8lwLYOCX3DtKxfGfmnpacNcUTgMQ0GnELxv2tWpDP+tWcp+1IH1f5jjGZj
         F+qg==
X-Gm-Message-State: APjAAAUjPH8PnzPnvExfS7kciPDeDKsnbbJtIZvMLLL9L77IH09eVezl
        xJu4FcpUrYhbMrJ6PiHnoLc9wTVi0iArkxrMT9c=
X-Google-Smtp-Source: APXvYqwkWV/VUWoRj3xtWAMxTMnooHzdbzSpn7i5oP6eYmsc9yJcd78hGVU/pWm8Hq3N00daip30JPv0uqTisnmhyPg=
X-Received: by 2002:a50:d8ce:: with SMTP id y14mr33032341edj.101.1552062438308;
 Fri, 08 Mar 2019 08:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20190308160933.29899-1-daniel.baluta@nxp.com> <CAOMZO5CLjZ7W0Z4ZHbx1YXMxjH5RzjEQPxPtP4Sd+ANF_eyG+g@mail.gmail.com>
In-Reply-To: <CAOMZO5CLjZ7W0Z4ZHbx1YXMxjH5RzjEQPxPtP4Sd+ANF_eyG+g@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 8 Mar 2019 18:27:06 +0200
Message-ID: <CAEnQRZAZ-8JYjJ0KRzbObYm_p7bfTacv5L2QoDXNmVsWbTjLNg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: sai: Reduce underrun when stream starts
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 6:16 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Daniel,
>
> On Fri, Mar 8, 2019 at 1:09 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > Write initial words into SAI FIFO to reduce the underrun
> > error.
>
> Please provide a better explanation.

Hi Fabio,

Fair enough, will try to provide a better description in v2
that will also address your questions below.

>
> Why does performing these writes help?
>
> Also, the commit message says "reduce", so it seems this is a
> workaround instead of a proper fix?
