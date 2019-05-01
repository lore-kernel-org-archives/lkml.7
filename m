Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A121EC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 18:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6696120675
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 18:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pgsKREkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfEASNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 14:13:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39491 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfEASNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 14:13:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so5064576pfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QjVR2bg3lSzD+1vdiSDKM7exDphVwFLvdYeDDZ13SDQ=;
        b=pgsKREkPdHanvUyiOKIS7OGkxqp1Zct7ysG5ZChSVy/BmLHOEU9//LW3HXzjXrGWWL
         ATOs+ek09DTigflog3zuMNBf5Trm/TiYLWtcdU6/FRAFBlGTEjZgQ2UTSfxMzYQ/N54z
         XGs+TQRzb8t7d8HZ7uqvwsgkITjNRL/1VYMgy9oiXFeKdsMbmTuSIb3WxgmOnsw4sRUs
         mTHNy/DnInflLneVNBHEt1z6oklY5ZZZCzkHmI/A9hPYMmhyRd/oOcuI+qOEv/p3pRQO
         jwbDmURzTawoAr5+E/l2UlR/69gTjhhpvgG0zEkClHn+a2EsiDEab3yQMN+r9AVnjXOo
         pe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjVR2bg3lSzD+1vdiSDKM7exDphVwFLvdYeDDZ13SDQ=;
        b=MFtsQ18RDg05QKCQ42Sd16RSX82xy76mGk+1WyG8x3n6iGgCiyftlJcUSSfTdcEKyi
         qczdc7p4wpZabc3xIE/eOr2qWbWdTVaxEWHHh3ZMJDNElZ+EoITTXBFiKX36/fUeVlH7
         jmFhvSUI4K5zlUHvauucwoFuq5hsVvcz4uU+yiGGlqK5xKiKMrWZwN8HrsXwF7VNuuqT
         Vx1iIFI2sLFr2h8z0nAOSvBl5djkV/jDukF+/EvhRrK99wZmweincQnexjMOQw392Oqn
         A+lqe2oSEpouhkJqirQQb6BHDIgISagvUrM15D30GX4r+Bett5wcKCjy7ESGsGy/kqY+
         984g==
X-Gm-Message-State: APjAAAWu56OwAtX+/zmcTUh7aFPaH2lMDrQz6wYpD8kr16HXY0mtTn4u
        qoC+xmEWdPvEs0L/lPAU40GuPUNZh1PydQSu0o2c9Q==
X-Google-Smtp-Source: APXvYqzX+NRNbH/ziRd4am7ygEoMzC1ex0vXZcwj82yXdcoP8C02dPXgnXc0PgYXm7Ki5p25cGPdqkFsgxE2CnUMJTw=
X-Received: by 2002:a63:f817:: with SMTP id n23mr33732919pgh.302.1556734392354;
 Wed, 01 May 2019 11:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <46b3e8edf27e4c8f98697f9e7f2117d6@AcuMS.aculab.com>
 <20190430145624.30470-1-tranmanphong@gmail.com> <CAKwvOdmvA4sO7UsXW4DapO_HKodeWFwA_5FsNe_wVjneZBYYdg@mail.gmail.com>
 <CAKwvOdntTmHBinCK0T_8OZ-2ksUHkQBvDyR8WrxZdW=+yu25dw@mail.gmail.com>
In-Reply-To: <CAKwvOdntTmHBinCK0T_8OZ-2ksUHkQBvDyR8WrxZdW=+yu25dw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 1 May 2019 11:13:01 -0700
Message-ID: <CAKwvOdnVrm9MyBkWL=yykX0td-c6uB3=Ymo0hr8wMQG1QESreg@mail.gmail.com>
Subject: Re: [PATCH V2] of: fix clang -Wunsequenced for be32_to_cpu()
To:     robh+dt@kernel.org, Frank Rowand <frowand.list@gmail.com>,
        pantelis.antoniou@konsulko.com
Cc:     David.Laight@aculab.com, hch@infradead.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Phong Tran <tranmanphong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 9:29 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Apr 30, 2019 at 9:28 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > Thanks for the patch.
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/460
> > Suggested-by: David Laight <David.Laight@ACULAB.COM>
>
> sent too soon...
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

We'll also need this for stable, can the maintainers please add the
following tag if it's not too late:

Cc: stable@vger.kernel.org

to unbreak ppc back through at least 4.14.
-- 
Thanks,
~Nick Desaulniers
