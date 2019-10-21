Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC49CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EBB2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="O2B/I0BW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfJUUkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:40:42 -0400
Received: from mout.web.de ([217.72.192.78]:54975 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbfJUUkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571690424;
        bh=4ObFiW5TE60yeh3kt8csqTOAxv9kGWcoXP4STgxDALc=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=O2B/I0BWfks80C8OvTQ7nhAzG+1ldQ1dmBptgud6s/8+GZfWIBNd8kkK/KqktNY+4
         sF2yc9SWWPLnrjiuLQyRfg6rNZoTPTIEpkDv/Jg9pUazTLHrhgu6jC0eI/+KV3PC+W
         GvbJck79lzQ0GNSMo9kfUXrmjyrtweDznxpENqxE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.106.164]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBTQo-1iCELG1Ryw-00ASVf; Mon, 21
 Oct 2019 22:40:24 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>
References: <20191021185250.26130-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] drm/v3d: Fix memory leak in v3d_submit_cl_ioctl
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        dri-devel@lists.freedesktop.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a28f12a8-49c4-30f0-cc86-6a41ded96ab2@web.de>
Date:   Mon, 21 Oct 2019 22:40:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191021185250.26130-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+01gd9ynx1gymH7NQlk0h/6XtXzBSBIMVyyMhiE2Ri6cRR1Xt/e
 uwBuSJHolbxSClFmj8eZiMNLk8TSIL/gEwMqUwovaelj26YFLcPqGwLvkCkY4u4SpnPFSAY
 NLWGwkv6ZJGlPawUhKIq0T3uHdXOUgLc0sPbmnQAk4G2G8acvVi0eDK4+96yEJSqMnVrRsP
 J/O7NOgGfGRgtLtrTJGWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q20C1HQ9Ahk=:7CcXeV5tX5V2p60Pg5Vzj/
 6j6/ZzZQPL5bs4zIbtViUeecy06FqkjOVmUywQlcxFMUy5gY4lKvsGYjSYRmTJriCL4RDTA3Y
 I79+RWPfNu9DSHoL+ElG8nGg+2jpqT6YX78js3iTOgPqkwQPkcYGvbDzjlxCRwrRVUG1CobNX
 j8CMBhX9kdLDdJibgwCpcWSefWdLfFWAWhsAzes29hMykdCB5qi3VIZjoYpm/cOPXWSF1uf4l
 lrmkfh5kfQN+85Tclsw4DfZkxGtgW+KozUXkpQiQwydilNb4e49frGFbiHEev6HXB2SSOgYQ+
 69csjV2DTmBFDLeY2+ozTiEmJHKlJ7HqvoXN+QQN9E3GCfTYPH1aJL+vjk3iWtOcwJ27r4H1c
 ae0Y/ZKMQSrnt/uk7epO6MjwohClOvAPMb5WmmP6USoa4jh7SZXH/BtEQVTYXJKawxQRg9Xvl
 XrSpKT89IPOIo2VLFUNYGirHgC/wkwCEZ07ScNslYbrfR8g3L7ecRZORwBGee4QzQ/dAHlXcr
 m1eutYHYNxSM0ErQI9Iu+IXewdseQYBZpR1k3UogiGMK3k36OlcqOBdlov2nJ7ksVQkJXQZCo
 AjoxI+b2Vs5l0TmYLqCJFF05cUbYy7JyVOOP13a2gxK4UqCl59djkB0KVwSFKyKX4YtKRMTK1
 z8/ni4f7VFqCIxr/DYRDTPKJ8/+mogk/fsvLT7hzho/ovSHZRmQD/l63kdvWux6+jxjOKTj+m
 XoXnmi3NYPOaVTjfPUmzeAWFjvbmbkSkjib4HOHB3l025Th1+0Ey/TmslJ0bQQLOg+bfKzFvP
 zV6KOgtrTGaOrvpjECwyvOt8MBAuheAF16Cq/s51A740RN1ytmIVnsIOVttAVzfgKg/lGHyhI
 i2Z9aqRQGzuhfcxs0J0SPmoBv76GvKp3COxDClDe2yg0Ru+HDEkW/7/iJPRNZ9V4PR6xnA5NN
 wtcbVAnGAAzPGkLswOkwVtGHZc1LrHicRWxMG1a+A0i0X2ghj9iJdG6fjbM2ODYppa8JDQnGq
 jPmj25VKTmxv5g5G+3Yb0gf1kiM4BrGO7t8Z1hT8L8S654xTJgcMmpNjAggrxlEuNDuk7tVID
 VyBWumPCFO0OSA0FRjl1TPsnslMDmy9bOJZOS9kTR85ArM6SkUrP32tmN7UB5ahCk9PFetYOi
 kj30qz+0gctB94Ysygzye/0IMVrWj8CLBeCYnDRkeZ5zihYIgXyZG2TJfPzNE6slQHNScCmCZ
 0IulH1lvaOMID+xKKJDJFhLonWBAtHFCW3yvgN2zY3fiE83pzy1/NK3DsW/o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the impelementation of v3d_submit_cl_ioctl() there are two memory lea=
ks.

Please avoid another typo also in this change description.


> =E2=80=A6 If kcalloc fails to allocate memory for bin then
> render->base should be put. Also, if v3d_job_init() fails to initialize
> bin->base then allocated memory for bin should be released.

Will an =E2=80=9Cimperative mood=E2=80=9D be more appropriate for such wor=
dings?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D7d194c2100ad2a6dded545887d=
02754948ca5241#n151


=E2=80=A6
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -557,13 +557,16 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *=
data,
=E2=80=A6
>  		if (ret) {
>  			v3d_job_put(&render->base);
> +			kfree(bin);
=E2=80=A6

Can it be helpful to move the added function call before the other
in this if branch (if you prefer to avoid the addition of a jump target he=
re)?

Regards,
Markus
