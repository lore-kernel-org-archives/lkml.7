Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3E0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 01:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E973204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 01:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCjYjmya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfHMBG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 21:06:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43137 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfHMBG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 21:06:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id h13so2616996edq.10;
        Mon, 12 Aug 2019 18:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=j4lyVR+ucz/sNBr6Uuq/ocVwe18iA7ulKcx4G6tyoUE=;
        b=aCjYjmyaMNiomMMaGaGZsCa62g2hyeAOyf4+2CRXxLKdO598HULUn8YNFrJTTUGusc
         kXW87UlSSFlzLpCEV51d+04lZjFLfEBKoyqi3lu6ksn4d2VjzF5Kb11SF2pdO8VeJdR2
         4BMbp58YdFPYsKOJWfrJ80BVjhpJr49nM9GyBIdgB94I3PVPNf23Ks9MSEXz9+vP2lKq
         nm3YiOXFHkvcK9yem2tMkAuvQi1nLZ7fh64Tgz6sLH159VIieKLvlSSzZwr3mC2EEvdw
         Ep93Kgjgepi5Iw3o52lvnHdOLcBzSaBtPU3bEFjC4IltK5Z6YeeqS3Q/dK2yDtzpJ+SE
         BDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=j4lyVR+ucz/sNBr6Uuq/ocVwe18iA7ulKcx4G6tyoUE=;
        b=erus9ZTDuhnWofiVq1iBTU2/LX1oWHOEkn25vy8zzhbk18YY3Q0RycpIIcfDd0a068
         lNH8L09sEdPb/jvI9JE1Mb3iaSQxIZrvpsYvzC1S+9k3Z7IrwrmbFBdFONtcoEuVXDo8
         sWPtCT2sZNHr4hQ/+1WjDmOdyY0k6FQ+JeWVO3svJ8cySaHARMeEwXfST3zj5DZIdv0Z
         x9aNk2lcuusxm5LxUKPCyGoPAyTN8mdg46JAffWXcQGDy/V7LkCRCQJm+dE5it/JZgFw
         iGAYeZKQjUgRW0yTPZo4g2eURnsIsOYPUdVoHkcDI0wViqVagrDeXBd/8O+Hv4f0SUlV
         yotQ==
X-Gm-Message-State: APjAAAUGOHqwZDcekS2CNzG6w6eVUi/EBaMLn+0heDvq5nQ9kwXCRh53
        W5iv+fpVt1ZFsrh+BXw+GJbSHkCA2xvJRH1udxUZKA==
X-Google-Smtp-Source: APXvYqxsCrHWWrWMc4dJWpWtHfMOKBXzWhxk9gpd3SLhKDy3qkruMVroVvkOqFD5XJJ7cCViAlN4JWxSZi5PS7T4pm4=
X-Received: by 2002:a50:8687:: with SMTP id r7mr21038172eda.137.1565658385191;
 Mon, 12 Aug 2019 18:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <1565158960-12240-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565158960-12240-1-git-send-email-bmeng.cn@gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 13 Aug 2019 09:06:14 +0800
Message-ID: <CAEUhbmVo9vNsKBD9oA3XtA07jr24PqKFYsEmGeKwLH6WaQdgsQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: sifive: Add missing "clock-frequency" to
 cpu0/cpu1 nodes
To:     Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 2:22 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Add the missing "clock-frequency" property to the cpu0/cpu1 nodes
> for consistency with other cpu nodes.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>

ping
