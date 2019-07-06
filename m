Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00F9C5B57D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 02:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECDA21738
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 02:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562380801;
	bh=drtASFa2/O/JuvlRQiTyVSXk+alLojG7530iEUMd3Bk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XApcu0OCtULBPZ4gh58Ww49nU2JoJshNEGbw4MQtTVlJkgSseiDigkyZ+SLYIy4BL
	 Wb0paKLX+NSY2n5LtsiT4RDKnCf3yyPAWuLXEm4PgXgMHzQqzjse40ARmXcw3I6+C5
	 XVp+V/n5kSo7XqEhJvxI0nSZJRblrKfq6yrnyx5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfGFCkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 22:40:00 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40969 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGFCj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 22:39:59 -0400
Received: by mail-lj1-f177.google.com with SMTP id d24so1747609ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 19:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fd4Y87tY8rXvKyCsNSuOPm1j51lFjgKYC9nK5pdmnzI=;
        b=YUs/UgR/8Hp7wwsb7zpTWwyIpunZ8Ebmdz6mmomdXNFvrtT0rRerwLe2HTG10s2mHE
         lmdb6ncApNQ00nd78WB80+xcJxIJpf6hoJTJX8vUIjCCV8E+4N5q+5IkIJ6NvUbWosRq
         Wdf/Rw9vCEZYTXwhGdCGNqUuAlzpv1DIpsCBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fd4Y87tY8rXvKyCsNSuOPm1j51lFjgKYC9nK5pdmnzI=;
        b=PhiO4vGE2M8P4jOFrXjAQhfhX8cCI5i+F5+mYF+Zom7zTO8C21BYk9vsTVHABA3wtC
         Gq+PXThxyz4duxIAo9HrHLBpl5DLMNb36GGCzStlFlA6OZkqVLuR+HgrRfFSuiTZhTRk
         4ODgs+f12Paoy+xCIR7Tox+bdlGSd0DK1SD6R0wKsx/TUeNDJCEKi+ZoToiAZuummhVh
         iT07AUcFAbXqTaEjBwOC1131X8/HV8fMP0ZLyzLM1ARMYUEwgE3AjQkolNy/BvxKmzBN
         QL1oKdn6e7jWlUmC0ncmJYlPoyc5KUpMaRc43beK75zR6tITXGSQ0wadTRlhqxqE6I5a
         XutQ==
X-Gm-Message-State: APjAAAVgMNLc6Q3NsurX4IaGh1sILlnkQTpBXih7iNCwpiwd8ehVT7Ke
        aLV4B6BawWbVVuOQ+JayGkucYELl0uViJw==
X-Google-Smtp-Source: APXvYqy8Dhkjg8Cm8kFAS7kMOkOvKA90w1VnxH35cfrQnRQk779e+7ASWUzaxc7YxsLtGMtN8eqp4g==
X-Received: by 2002:a2e:b60f:: with SMTP id r15mr1894813ljn.172.1562380797203;
        Fri, 05 Jul 2019 19:39:57 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id p5sm2116165ljb.91.2019.07.05.19.39.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 19:39:55 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id v85so4462663lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 19:39:55 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr3364080lfm.170.1562380795305;
 Fri, 05 Jul 2019 19:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
 <CABXGCsNq4xTFeeLeUXBj7vXBz55aVu31W9q74r+pGM83DrPjfA@mail.gmail.com>
 <20190529180931.GI18589@dhcp22.suse.cz> <CABXGCsPrk=WJzms_H+-KuwSRqWReRTCSs-GLMDsjUG_-neYP0w@mail.gmail.com>
 <CABXGCsMjDn0VT0DmP6qeuiytce9cNBx8PywpqejiFNVhwd0UGg@mail.gmail.com>
 <ee245af2-a0ae-5c13-6f1f-2418f43d1812@suse.cz> <CABXGCsOpj_E7jL9OpMX4wZbMktiF=9WOyeTv1R-W59gFMGC7mw@mail.gmail.com>
 <CABXGCsOizgLhJYUDos+ZVPZ5iV3gDeAcSpgvg-weVchgOsTjcA@mail.gmail.com> <20190705230312.GB6485@quack2.suse.cz>
In-Reply-To: <20190705230312.GB6485@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jul 2019 19:39:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjV7HdJ-Dgv6OYJ5c9iY_pOWqryNy1BU3MdZrjsUJdVkQ@mail.gmail.com>
Message-ID: <CAHk-=wjV7HdJ-Dgv6OYJ5c9iY_pOWqryNy1BU3MdZrjsUJdVkQ@mail.gmail.com>
Subject: Re: kernel BUG at mm/swap_state.c:170!
To:     Jan Kara <jack@suse.cz>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        songliubraving@fb.com, william.kucharski@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 4:03 PM Jan Kara <jack@suse.cz> wrote:
>
> Yeah, I guess revert of 5fd4ca2d84b2 at this point is probably the best we
> can do. Let's CC Linus, Andrew, and Greg (Linus is travelling AFAIK so I'm
> not sure whether Greg won't do release for him).

I'm back home now, although possibly jetlagged.

The revert looks trivial (a conflict due to find_get_entries_tag()
having been removed in the meantime), and I guess that's the right
thing to do right now.

Matthew, comments?

               Linus
