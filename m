Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C057AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957B421783
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofTo4Fcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfI0G5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 02:57:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42449 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfI0G5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 02:57:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so1365276wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 23:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u2P8AbN7Weo/sHgPPISeZwn+7KOvEl8QMm31QIQuXF8=;
        b=ofTo4FcsEy51qA0Sl11NYFJXHXvI71yAmWnKYefWox3Bmloa6xkhV3dttDo7xMOSKS
         7KpZ/7Jj+93HLqaFXUJEqjfVczDN5/JOMcg76+KEIFjpKg2iVAPH2Y2bTW1FYtuYzGAB
         m8aAbBSw2IdOsoqL8uHcOiqmHTQSfdvf87yCTSiQbUIsDAR+1Gld1Ro6CN48jQ32GTow
         bIqcmZQqz7lbCZ3R8FgCWvw4BeWIHE65RetlmE769+rs+IOxWvjaN3PcYJhBrzTM+xpX
         2cdn7pCVgXWf3tjdSmTCwJRuepHfJ+xS60KFNbW7pjqQeSR+N8aSVjVOGr5ucLz3Bg92
         3lvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u2P8AbN7Weo/sHgPPISeZwn+7KOvEl8QMm31QIQuXF8=;
        b=M7LlDa1SXPLVZ1q0lFiZ585wLRISxI9EBH6w/1z5UQenZVcN4Jo8s7S3It3cm6ktJH
         eqlVPIsBIcYVCNTSw8crRnhkc71PYXmtGof4Uw868fOL/8gMVmaVayv+nYmUYPQyK72a
         SFPYkGFlAgH1qVdqMrRNLqt6gLiPSv88rDO3Us2Rjd3E8pbhcKYqsOACRzw/4BkM39Z7
         35kQQUR5gXgJho9aNf2QMnKb7EuQ/hJRabyeGgKFyu3XjFc45xX5KPxcSaj5UhXTsSIt
         faX0qxb12ejkW88hweX8XdS+PqI+QBXrOyNsF++vy0L+6LFD+ItY+/s5lydwvozUF8NB
         ra3g==
X-Gm-Message-State: APjAAAWBe3x68Vu6k9J3//sruRbxSTLSJuKinmq5BbcnoRIrPQlLgNSf
        QeD1fmCstK6tXLGwu21Lsg==
X-Google-Smtp-Source: APXvYqwSKfzPAVpPpD1887r09lrL9k621UTDLWQfyMKnW+uf2J8eQfr8IH1PA/rNfcCix9Gfq8r10A==
X-Received: by 2002:adf:ea10:: with SMTP id q16mr1727843wrm.356.1569567423533;
        Thu, 26 Sep 2019 23:57:03 -0700 (PDT)
Received: from avx2 ([46.53.252.76])
        by smtp.gmail.com with ESMTPSA id y3sm17525896wmg.2.2019.09.26.23.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 23:57:02 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:57:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [GIT PULL] treewide conversion to sizeof_member() for v5.4-rc1
Message-ID: <20190927065700.GA2215@avx2>
References: <201909261026.6E3381876C@keescook>
 <CAHk-=wg8+eNK+SK1Ekqm0qNQHVM6e6YOdZx3yhsX6Ajo3gEupg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8+eNK+SK1Ekqm0qNQHVM6e6YOdZx3yhsX6Ajo3gEupg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 01:06:01PM -0700, Linus Torvalds wrote:
> On Thu, Sep 26, 2019 at 10:33 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Please pull this mostly mechanical treewide conversion to the single and
> > more accurately named sizeof_member() macro for the end of v5.4-rc1. This
> > replaces 3 macros of the same behavior (FIELD_SIZEOF(), SIZEOF_FIELD(),
> > and sizeof_field()). The last patch in the series has a script in the
> > commit log to do the conversion, if you want to compare the results
> > (they remained identical today when I checked).
> 
> Honestly, I'm not sure why "sizeof_field()" wasn't just picked when we
> already had it. Making a new macro for the exact same thing seems
> somewhat questionable.
> 
> Yes, yes, the C standard calls them "members". Except when it doesn't,
> and they are members of a bit type, and it calls them bit-fields.

It does, but neither typeof nor sizeof work on bitfields.
