Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635EEC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33ED82082C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPrkHRbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfIKV1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 17:27:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42725 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfIKV1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 17:27:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so21543982lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocuE3lfB2VdShvrv8Jjt67rALqQRW9A8FCccv4uW2jU=;
        b=nPrkHRbEe39Ut8LbfUOvs+n30/TRBBN1ha3AI0Mq451uupxo+Z9PsodnAo+7WAUnwY
         TzQTRvOSeaBEa2ILoogE17VovuByTCrht84YLuMohbpfqgfNy35M16SjIpsizhTRMa+f
         FX147dvhOQIwqqpY4kDR7DumqPtbbFW/jmvGHVR+FUtN484bJUiAg5PY9F3xNKw24VWB
         gsLIWtXT9kgSrYIEULalHDY35ahjdC/uGO4JQLbTgbYOkMf7hYyP1rdT7M9cpiG3SNgn
         qVOf0SFg9MxeX2Lak5X5pT/HJnR+3FM+ifhkDMwqjpwgBuA90mkgTaUXBnvoiAiNSOcf
         I2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocuE3lfB2VdShvrv8Jjt67rALqQRW9A8FCccv4uW2jU=;
        b=TaxhSEELD76ix2TGoUWX1bwg5adExIjWhoWzMYOL83ZAVy2TbyQCRwbAOO64nuPjAO
         oeByXsPLiyLvftPjy6sCzRSMH5wiIuQUghl3p7K7kIAm+pabtrpFGRCxIpqbjZv5wew+
         e/5W7HGsynIBlMJXrfk8iZs5cXp+gNgY1J6cBngC9sGwdu9Xx8OQq7YqTFGRQMMgPclf
         5KuaA6+QLF33u1DATo6DKeaBL4CNdtbFmdONIr5sLGp7ztDJluLPyK9cOoq5jk9tljQw
         MoWnB6OGho2Qe8d0wgIbUrnLzhKijS+nhrMgsguBabNPSSyHsRA9IBGCpgASFUTyM3ZV
         9Uqg==
X-Gm-Message-State: APjAAAX6s6dkq2begaZC095S5NAmkQXrKWHvFUr5OaIelo4hKGQL8rUO
        OV0Sfe0DHe+9gPDVgrBbfYPTqGlL66sI9P4ugw==
X-Google-Smtp-Source: APXvYqybZ7v0olv+TJL6fPlc9Hrf+slZdTLE9RxLUHYs7RPHVK+boyb65eLJG+B2yfuSpIUNw6bsRq/4qiLRI0gaX/I=
X-Received: by 2002:a2e:861a:: with SMTP id a26mr18956406lji.163.1568237242901;
 Wed, 11 Sep 2019 14:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkgivvhQ=tOOuLjY=iwBVCKQhmmjpfNDa1yJ5SreNQubw6Q@mail.gmail.com>
 <4581016e-b421-e794-e603-807d37aa1bf3@grimberg.me> <CAEJqkghexeFHwaGkNUp+SmdhtU6Mf8cZ=Kn9pfrUkX3hEz-MOg@mail.gmail.com>
In-Reply-To: <CAEJqkghexeFHwaGkNUp+SmdhtU6Mf8cZ=Kn9pfrUkX3hEz-MOg@mail.gmail.com>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Wed, 11 Sep 2019 23:26:56 +0200
Message-ID: <CAEJqkggdu8FD6D4CL+4TwzfeMrLY+DY+qfHN0o7mQbbPdGvRsg@mail.gmail.com>
Subject: Re: [PATCH] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi., 11. Sept. 2019 um 19:39 Uhr schrieb Gabriel C <nix.or.die@gmail.com>:
>
> Am Mi., 11. Sept. 2019 um 19:21 Uhr schrieb Sagi Grimberg <sagi@grimberg.me>:
> >
> > This does not apply on nvme-5.4, can you please respin a patch
> > that cleanly applies?
>
> Sure , just tell me from where to pull nvme-5.4 tree.
> My match was against current Linus tree.

I send out a v2 against nvme-5.4 branch.
http://lists.infradead.org/pipermail/linux-nvme/2019-September/027144.html
