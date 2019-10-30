Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245B4CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC49205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kVXUCm5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfJ3UdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 16:33:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46203 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfJ3UdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 16:33:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id w8so4121880lji.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZw4hUcpDDeEECYWt5oKzqEsWCt5if9tCmjtkMvGZZc=;
        b=kVXUCm5X6CCOwy3PrkvG8ynq72GLC65upZkmDyjLUB02BH0FDQdUbgOtudVOF7kWIU
         /yYbkuNCFW9ggROV0FS4Q5s91jSFfgDgeUErkMGCEN1ZwREfMy1NCtZTH2euSXS+bXAI
         +0Pxezte5/LmQNgNAvq/jBGkxT9+cx+7WYa0ZTyeDmyNP47fS+iCQoIgRM9dcOmAoOfB
         ow38H55a7FOBuTU984DCypUFmnLIxSjK1Uda+b4SYvQqXY5oRtoC2hMOz+Hbrce3JWLS
         3tXmml2BE/xG70rKxHcQQodoA1dieVC//O/kr9sd8uyOrOR+hPJs9AB9O7oTR39zsD8t
         GH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZw4hUcpDDeEECYWt5oKzqEsWCt5if9tCmjtkMvGZZc=;
        b=d4gtzGB3QBGbVoZAN8qBQ9i7DtAFu656o6gNwatebqMZXTTYHq4LQV7KjGw+Rg99LV
         QlE0tV3sL4nnSDkcGmb/ir4LYt3waXuR470dpt/ZtrSqWp8edjW8J9axwTxq75b1SOoQ
         aJFA60JWMS0+HVsR/OBw3Vx2z/4X5iCOZKcqc3gevAGDCnSG/fUJLLjl8hFq7IyREnVV
         yIf8Onr03yLrvRjB2EzaMn452TbqKJQu1dc4T931YeH/8yxa1qCooxbu0F/9rHJaWA6T
         MBHr0By0mJwzuv3Y5sp91jCvWqOlFQEr6J2AGXuQajm+569dQvIJ5VLqrWRa5uqfJelq
         kHiw==
X-Gm-Message-State: APjAAAUkBHEVyY6cpOgvxv3Zm5lJIPqwNC2IwBSHHndXwlZo6wEQwGPo
        0f0V3ZSjNiRO9uNLWVs0TSn5/+683k5SV1lfgNDf
X-Google-Smtp-Source: APXvYqyiyj85p5hWvRdH63/Hex6oBbr4Qp3fVRiaxpwF74z1TwPKum1fWCiiIky+FvzFDsHURjcemP+RjH0Szm1Yw/g=
X-Received: by 2002:a2e:8987:: with SMTP id c7mr1107993lji.225.1572467585472;
 Wed, 30 Oct 2019 13:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <16abf1b2aafeb5f1b8dae20b9a4836e54f959ca5.1568834524.git.rgb@redhat.com>
 <CAHC9VhSRmn46DcazH4Q35vOSxVoEu8PsX79aurkHkFymRoMwag@mail.gmail.com> <20191024220814.pid5ql6kvyr4ianb@madcap2.tricolour.ca>
In-Reply-To: <20191024220814.pid5ql6kvyr4ianb@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Oct 2019 16:32:54 -0400
Message-ID: <CAHC9VhTEpVLgKk1FpFqaXH-B1jUvfRyaGffHwFrHbi3MjbRrUA@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 14/21] audit: contid check descendancy and nesting
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 6:08 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-10-10 20:40, Paul Moore wrote:
> > On Wed, Sep 18, 2019 at 9:26 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > ?fixup! audit: convert to contid list to check for orch/engine ownership
> >
> > ?
> >
> > > Require the target task to be a descendant of the container
> > > orchestrator/engine.
> > >
> > > You would only change the audit container ID from one set or inherited
> > > value to another if you were nesting containers.
> > >
> > > If changing the contid, the container orchestrator/engine must be a
> > > descendant and not same orchestrator as the one that set it so it is not
> > > possible to change the contid of another orchestrator's container.
> >
> > Did you mean to say that the container orchestrator must be an
> > ancestor of the target, and the same orchestrator as the one that set
> > the target process' audit container ID?
>
> Not quite, the first half yes, but the second half: if it was already
> set by that orchestrator, it can't be set again.  If it is a different
> orchestrator that is a descendant of the orchestrator that set it, then
> allow the action.
>
> > Or maybe I'm missing something about what you are trying to do?
>
> Does that help clarify it?

I think so, it's pretty much as you stated originally: "Require the
target task to be a descendant of the container orchestrator/engine".
It's possible I misread something in the patch, or got lost in all the
?fixup! patching.  I'll take a closer look at the next revision of the
patchset to make sure the code makes sense to me, but the logic seems
reasonable.

-- 
paul moore
www.paul-moore.com
