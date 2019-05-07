Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C4CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FD1205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557247873;
	bh=GI2fY+pt9dQWs4C8MjePe2IQHiA+OLGeLUvd4saOJCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TP1fSUFL0oQQWOGSWKssxX65oHX7xGaXEb/xUpjSMgGoYE/iYxHQTxOHMpXJobzwi
	 hVHXjNF5uTYY6siEBORzckShPRCl469Vb9h9blYtmOCv2ioGfR3bD49dA80Qb5qGUd
	 i1RlVe7qPG36955bL3pYFm1scdqqK3A7aEEzOLYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfEGQvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:51:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37032 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfEGQvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:51:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id 132so7227535ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JvOdwodHOTVYJ7+EHobDSJoXyA/2IRefA+hgBIaO+dI=;
        b=TR/Xs+H41+MJkfZoDS3QvaRnKQ/g/aV8B8CcLFu7NSmvalIZMpHgldvoVhvFAQWvJv
         6nl9q4q1e1O09qZYjSX8DYPCKpQIHf0ugzOG6HjVOxJ3jM8B5tGB1rixMuYMwT8a5WVn
         OXpYD75kQFmL1W4AwtTiKcN+UF6bsE/Un6etg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JvOdwodHOTVYJ7+EHobDSJoXyA/2IRefA+hgBIaO+dI=;
        b=pVT+ZIunWFCUQCjWcGm+4zoNTuh5dVCVdVMG7PEuPTV8F6QrE49o1QVlzqA+6prO3B
         x5kMhRvfn9bjIpy5kXxTMoo5a/Di5cZxgscO3I3+lgGYgoFWDpKHzXX8qF0wdVoD10f1
         LQ+lHxnalghS1VxiT1+uq6OOrIu6QQHzBdkbGJiItberC3nw+wvTuwmELnXBu7oh11oS
         aUauX+a6HxZvESP1xmap1MRGZ6+BgkmlmmX9QXZY8qXpRlZWWVD4Q3fQFCOgz+UgVQ1L
         Xksey52qjJs/STx6c4tElX6xN7hlMrMCxP75qYT8A3DlOe8UeujP4tLP6LH7J+3YjwBz
         w1Jg==
X-Gm-Message-State: APjAAAWI3XEvw/XSxLZtP+RdUYXSD4VnNdtMQiJP1NRXEt6rpP2DTEp3
        hnR5X1acdYedwj1FksmgpNYstfI1RbY=
X-Google-Smtp-Source: APXvYqxJynm+grIKFTAef7gamu27mn8Td8vxIkFOWKydGrFwBoLc3u6S83geiXESKZNcNK6mtuX+3Q==
X-Received: by 2002:a2e:93c7:: with SMTP id p7mr18380788ljh.32.1557247868770;
        Tue, 07 May 2019 09:51:08 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id k11sm3104339ljk.92.2019.05.07.09.51.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 09:51:07 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id m20so5745359lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:51:07 -0700 (PDT)
X-Received: by 2002:a2e:801a:: with SMTP id j26mr8701955ljg.2.1557247866889;
 Tue, 07 May 2019 09:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190507053826.31622-1-sashal@kernel.org> <20190507053826.31622-62-sashal@kernel.org>
 <CAKgT0Uc8ywg8zrqyM9G+Ws==+yOfxbk6FOMHstO8qsizt8mqXA@mail.gmail.com>
In-Reply-To: <CAKgT0Uc8ywg8zrqyM9G+Ws==+yOfxbk6FOMHstO8qsizt8mqXA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 09:50:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=win03Q09XEpYmk51VTdoQJTitrr8ON9vgajrLxV8QHk2A@mail.gmail.com>
Message-ID: <CAHk-=win03Q09XEpYmk51VTdoQJTitrr8ON9vgajrLxV8QHk2A@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 62/95] mm, memory_hotplug: initialize struct
 pages for the full memory section
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 9:31 AM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> Wasn't this patch reverted in Linus's tree for causing a regression on
> some platforms? If so I'm not sure we should pull this in as a
> candidate for stable should we, or am I missing something?

Good catch. It was reverted in commit 4aa9fc2a435a ("Revert "mm,
memory_hotplug: initialize struct pages for the full memory
section"").

We ended up with efad4e475c31 ("mm, memory_hotplug:
is_mem_section_removable do not pass the end of a zone") instead (and
possibly others - this was just from looking for commit messages that
mentioned that reverted commit).

              Linus
